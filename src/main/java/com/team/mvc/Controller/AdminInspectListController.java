package com.team.mvc.Controller;

import com.team.mvc.Interface.IAdminInspectListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class AdminInspectListController {

    @Autowired
    private SqlSession sqlSession;

    /**
     * 검수 목록 페이지 (GET 요청 처리)
     */
    @RequestMapping(value="/admin-inspectList.action", method = RequestMethod.GET)
    public String adminInspectList(Model model, RedirectAttributes redirectAttributes) {
        try {
            // MyBatis Mapper 인터페이스 가져오기
            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

            // 모든 필요한 데이터를 한 번에 모델에 추가
            model.addAttribute("list", dao.getList());
            model.addAttribute("listr", dao.getListr());
            model.addAttribute("getItemList", dao.getItemList());
            model.addAttribute("getGradeList", dao.getGradeList());
            model.addAttribute("getEquipList", dao.getEquipList());
            model.addAttribute("equipGrades", dao.getGradeList()); // 추가: 등급 정보를 모델에 직접 포함

            return "admin-inspectList";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "데이터를 가져오는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin-inspectList.action";
        }
    }

    /**
     * 검수 결과 처리 (POST 요청 처리)
     */
    @PostMapping("/admin-inspectList.action")
    public String adminInspectListAdd(
            @RequestParam(value = "platformDeliveryId", required = false) String platformDeliveryIdStr,
            @RequestParam(value = "platformDeliveryReturnId", required = false) String platformDeliveryReturnIdStr,
            @RequestParam(value = "inspecGradeId", required = false, defaultValue = "1") Integer inspecGradeId,
            @RequestParam(value = "equipGradeId", required = false, defaultValue = "0") Integer equipGradeId,
            @RequestParam(value = "inspecComment", required = false, defaultValue = "") String inspecComment,
            @RequestParam(value = "finalGrade", required = false) String finalGrade,
            RedirectAttributes redirectAttributes) {

        try {
            // 문자열에서 숫자 추출 및 변환
            Integer platformDeliveryId = null;
            Integer platformDeliveryReturnId = null;

            // 관리자 ID 기본값 설정 (로그인 없이 사용할 기본값)
            String adminId = "admin"; // 기본 관리자 ID 설정

            if (platformDeliveryIdStr != null && !platformDeliveryIdStr.isEmpty()) {
                try {
                    // "DELV-123" 형식에서 숫자만 추출
                    String numericPart = platformDeliveryIdStr.replaceAll("[^0-9]", "");
                    if (!numericPart.isEmpty()) {
                        platformDeliveryId = Integer.parseInt(numericPart);
                    }
                } catch (NumberFormatException e) {
                    redirectAttributes.addFlashAttribute("error", "배송 ID 형식이 올바르지 않습니다: " + platformDeliveryIdStr);
                    return "redirect:/admin-inspectList.action";
                }
            }

            if (platformDeliveryReturnIdStr != null && !platformDeliveryReturnIdStr.isEmpty()) {
                try {
                    // "DELV-RTN-123" 형식에서 숫자만 추출
                    String numericPart = platformDeliveryReturnIdStr.replaceAll("[^0-9]", "");
                    if (!numericPart.isEmpty()) {
                        platformDeliveryReturnId = Integer.parseInt(numericPart);
                    }
                } catch (NumberFormatException e) {
                    redirectAttributes.addFlashAttribute("error", "반환 ID 형식이 올바르지 않습니다: " + platformDeliveryReturnIdStr);
                    return "redirect:/admin-inspectList.action";
                }
            }

            // 둘 다 null인지 검증
            if (platformDeliveryId == null && platformDeliveryReturnId == null) {
                redirectAttributes.addFlashAttribute("error", "배송 ID 또는 반환 ID가 필요합니다.");
                return "redirect:/admin-inspectList.action";
            }

            // 등급 정보 업데이트 - finalGrade에 따라 equipGradeId 설정
            if (finalGrade != null) {
                switch (finalGrade) {
                    case "A":
                        equipGradeId = 1;
                        inspecGradeId = 1; // 상
                        break;
                    case "B":
                        equipGradeId = 2;
                        inspecGradeId = 1; // 상
                        break;
                    case "C":
                        equipGradeId = 3;
                        inspecGradeId = 2; // 중
                        break;
                    case "D":
                        equipGradeId = 4;
                        inspecGradeId = 2; // 중
                        break;
                    case "E":
                        equipGradeId = 5;
                        inspecGradeId = 3; // 하
                        break;
                    case "F":
                        equipGradeId = 6;
                        inspecGradeId = 3; // 하
                        break;
                }
            }

            // 디버깅 로그 추가
            System.out.println("프로시저 호출 정보: delivery=" + platformDeliveryId
                    + ", return=" + platformDeliveryReturnId
                    + ", grade=" + equipGradeId
                    + ", inspecGradeId=" + inspecGradeId
                    + ", adminId=" + adminId
                    + ", finalGrade=" + finalGrade
                    + ", comment=" + inspecComment);

            // MyBatis Mapper 인터페이스 가져오기
            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

            // 확장된 프로시저 호출 메소드 사용
            dao.callINSPECT_RESULT(platformDeliveryId, platformDeliveryReturnId,
                    inspecGradeId, equipGradeId, adminId, inspecComment);

            // 성공 메시지 설정
            redirectAttributes.addFlashAttribute("message", "검수 결과가 성공적으로 등록되었습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "검수 결과 등록 중 오류가 발생했습니다: " + e.getMessage());
        }

        return "redirect:/admin-inspectList.action";
    }

}