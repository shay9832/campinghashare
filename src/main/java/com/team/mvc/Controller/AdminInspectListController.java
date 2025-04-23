package com.team.mvc.Controller;

import jakarta.servlet.http.HttpServletRequest;
import com.team.mvc.DTO.AdminInspectListDTO;
import com.team.mvc.Interface.IAdminInspectListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;


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

            // 상단 통계 데이터 동적 변환
            model.addAttribute("totalCount", dao.getTotalInspectionCount());
            model.addAttribute("completedCount", dao.getCompletedInspectionCount());
            model.addAttribute("returnedCount", dao.getReturnedInspectionCount());
            model.addAttribute("pendingCount", dao.getPendingInspectionCount());

            return "admin-inspectList";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "데이터를 가져오는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin-inspectList.action";
        }
    }

    // 검수 항목별 결과 조회
    @GetMapping("/admin-inspectItemResults.action")
    @ResponseBody
    public List<AdminInspectListDTO> getInspectionItemResults(
            @RequestParam(value = "platformDeliveryId", required = false) Integer platformDeliveryId,
            @RequestParam(value = "platformDeliveryReturnId", required = false) Integer platformDeliveryReturnId) {

        IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);
        return dao.getInspectionItemResults(platformDeliveryId, platformDeliveryReturnId);
    }

    /**
     * 검수 결과 처리 (POST 요청 처리) - 항목별 상(1), 중(2), 하(3) 값을 처리하도록 수정
     */
    @PostMapping("/admin-inspectList.action")
    @Transactional
    public String adminInspectListAdd(
            @ModelAttribute("adminId") String adminId,
            @RequestParam(value = "platformDeliveryId", required = false) String platformDeliveryIdStr,
            @RequestParam(value = "platformDeliveryReturnId", required = false) String platformDeliveryReturnIdStr,
            @RequestParam(value = "inspecGradeId", required = false, defaultValue = "1") Integer inspecGradeId,
            @RequestParam(value = "equipGradeId", required = false, defaultValue = "0") Integer equipGradeId,
            @RequestParam(value = "inspecComment", required = false, defaultValue = "") String inspecComment,
            @RequestParam(value = "finalGrade", required = false) String finalGrade,
            @RequestParam(value = "totalScore", required = false) String totalScore,
            @RequestParam Map<String, String> paramMap,
            RedirectAttributes redirectAttributes) {

        try {
            // 문자열에서 숫자 추출 및 변환
            Integer platformDeliveryId = null;
            Integer platformDeliveryReturnId = null;

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

                        // 여기에 반환 ID에 해당하는 원래 배송 ID를 찾는 로직 추가
                        if (platformDeliveryId == null) {
                            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);
                            platformDeliveryId = dao.getDeliveryIdFromReturnId(platformDeliveryReturnId);

                            if (platformDeliveryId == null) {
                                redirectAttributes.addFlashAttribute("error", "반환 ID에 해당하는 원래 배송 ID를 찾을 수 없습니다.");
                                return "redirect:/admin-inspectList.action";
                            }
                        }
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
                    + ", comment=" + inspecComment
                    + ", totalScore=" + totalScore);

            // MyBatis Mapper 인터페이스 가져오기
            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

            // 1. JSP에서 전송된 항목별 코멘트와 등급 정보 처리 - 순서 변경
            // 항목 수 파악 (itemCount 파라미터가 있다면 사용)
            int itemCount = 5; // 기본값으로 5개 설정
            if (paramMap.containsKey("itemCount")) {
                try {
                    itemCount = Integer.parseInt(paramMap.get("itemCount"));
                } catch (NumberFormatException e) {
                    // 오류 시 기본값 유지
                }
            }

            // 전송된 항목별 등급 처리 (숫자 값으로 처리)
            for (int i = 0; i < itemCount; i++) {
                // 항목 ID와 등급 값 가져오기
                String itemIdKey = "itemIds[" + i + "]";
                String gradeValueKey = "itemGrades[" + i + "]";
                String commentKey = "comment_" + paramMap.get(itemIdKey); // 항목 ID를 이용한 코멘트 키

                String itemIdStr = paramMap.get(itemIdKey);
                String gradeValueStr = paramMap.get(gradeValueKey);
                String itemComment = paramMap.get(commentKey);

                // 필수 값이 없으면 해당 항목 건너뛰기
                if (itemIdStr == null || gradeValueStr == null) {
                    continue;
                }

                try {
                    Integer itemId = Integer.parseInt(itemIdStr);
                    Integer gradeValue = Integer.parseInt(gradeValueStr);

                    // 등급 값이 0이면 미선택이므로 건너뛰기
                    if (gradeValue == 0) {
                        continue;
                    }

                    // 코멘트가 없는 경우 기본값 설정
                    if (itemComment == null || itemComment.trim().isEmpty()) {
                        itemComment = "항목 " + (i + 1) + " 검수 완료";
                    }

                    System.out.println("항목 " + itemId + " 처리: 등급값=" + gradeValue + ", 코멘트=" + itemComment);

                    // 항목별 검수 결과 저장
                    dao.insertInspecListItem(
                            platformDeliveryId,
                            platformDeliveryReturnId,
                            itemId, // 카테고리 검수 항목 ID
                            itemComment, // 항목별 코멘트
                            adminId,
                            gradeValue // 항목별 등급 값 (1: 상, 2: 중, 3: 하)
                    );

                    System.out.println("항목 " + itemId + " 검수 결과 저장 완료");
                } catch (NumberFormatException e) {
                    System.out.println("항목 " + itemIdStr + " 처리 중 숫자 변환 오류: " + e.getMessage());
                    // 오류가 있어도 계속 진행
                }
            }

            // 2. 기존 프로시저 호출 (INSPEC_RESULT 생성)
            dao.callINSPECT_RESULT(platformDeliveryId, platformDeliveryReturnId,
                    inspecGradeId, equipGradeId, adminId);

            // 성공 메시지 설정
            String successMessage = "검수 결과가 성공적으로 등록되었습니다.";

            // F 등급인 경우만 메시지 변경
            if ("F".equals(finalGrade)) {
                successMessage = "검수 결과가 등록되었습니다. 등급 F로 사용자반납 처리되었습니다.";
            }

            redirectAttributes.addFlashAttribute("message", successMessage);

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "검수 결과 등록 중 오류가 발생했습니다: " + e.getMessage());
        }

        return "redirect:/admin-inspectList.action";
    }
}