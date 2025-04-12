package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminInspectListDTO;
import com.team.mvc.Interface.IAdminInspectListDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
public class AdminInspectListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-inspectList.action", method = RequestMethod.GET)
    public String adminInspectList(Model model) {
        IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);
        model.addAttribute("list", dao.getList());
        model.addAttribute("listr", dao.getListr());
        model.addAttribute("getItemList", dao.getItemList());
        model.addAttribute("getGradeList", dao.getGradeList());
        model.addAttribute("getEquipList", dao.getEquipList());
        return "admin-inspectList";
    }





    /**
     * AJAX 요청에 대응하는 검수 결과 처리 메소드
     */
    @PostMapping("/admin-inspectList.action")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> adminInspectListAdd(
            @RequestParam(value = "platformDeliveryId", required = false) String platformDeliveryIdStr,
            @RequestParam(value = "platformDeliveryReturnId", required = false) String platformDeliveryReturnIdStr,
            @RequestParam(value = "inspecGradeId", required = false, defaultValue = "1") Integer inspecGradeId,
            @RequestParam(value = "equipGradeId", required = false, defaultValue = "0") Integer equipGradeId,
            @RequestParam(value = "adminId", required = false) String adminId,
            @RequestParam(value = "inspecComment", required = false, defaultValue = "") String inspecComment,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            // 문자열에서 숫자 추출 및 변환
            Integer platformDeliveryId = null;
            Integer platformDeliveryReturnId = null;

            if (platformDeliveryIdStr != null && !platformDeliveryIdStr.isEmpty()) {
                try {
                    // 세션에서 관리자 ID 가져오기 또는 기본값 사용
                    String validAdminId = "ADMIN1"; // 기본값

                    // 세션에 ID가 있으면 사용
                    if (session.getAttribute("adminId") != null) {
                        validAdminId = (String) session.getAttribute("adminId");
                    }

                    // 매개변수로 전달된 ID가 있으면 사용
                    if (adminId != null && !adminId.trim().isEmpty()) {
                        validAdminId = adminId;
                    }

                    // 디버깅 로그 추가
                    System.out.println("사용할 관리자 ID: " + validAdminId);

                    // "DELV-123" 형식에서 숫자만 추출
                    String numericPart = platformDeliveryIdStr.replaceAll("[^0-9]", "");
                    if (!numericPart.isEmpty()) {
                        platformDeliveryId = Integer.parseInt(numericPart);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("배송 ID 변환 실패: " + platformDeliveryIdStr);
                    response.put("success", false);
                    response.put("message", "배송 ID 형식이 올바르지 않습니다: " + platformDeliveryIdStr);
                    return ResponseEntity.badRequest().body(response);
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
                    System.out.println("반환 ID 변환 실패: " + platformDeliveryReturnIdStr);
                    response.put("success", false);
                    response.put("message", "반환 ID 형식이 올바르지 않습니다: " + platformDeliveryReturnIdStr);
                    return ResponseEntity.badRequest().body(response);
                }
            }

            // 둘 다 null인지 검증
            if (platformDeliveryId == null && platformDeliveryReturnId == null) {
                response.put("success", false);
                response.put("message", "배송 ID 또는 반환 ID가 필요합니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 디버깅 로그 추가
            System.out.println("프로시저 호출 정보: delivery=" + platformDeliveryId
                    + ", return=" + platformDeliveryReturnId
                    + ", grade=" + equipGradeId
                    + ", comment=" + inspecComment);

            // MyBatis Mapper 인터페이스 가져오기
            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

            // 확장된 프로시저 호출 메소드 사용
            dao.callINSPECT_RESULT_EXTENDED(platformDeliveryId, platformDeliveryReturnId,
                    inspecGradeId, equipGradeId, adminId, inspecComment);

            // 성공 응답 설정
            response.put("success", true);
            response.put("message", "검수 결과가 성공적으로 등록되었습니다.");

            // 업데이트된 데이터를 응답에 포함 (선택적)
            // response.put("updatedData", dao.getSpecificInspection(platformDeliveryId, platformDeliveryReturnId));

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "검수 결과 등록 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /**
     * 폼에서 직접 프로시저를 호출하는 핸들러 메소드 (MyBatis 사용)
     */
//    @PostMapping("/admin-inspectList.action")
//    public String adminInspectListAdd(
//            @RequestParam(value = "platformDeliveryId", required = false) String platformDeliveryIdStr,
//            @RequestParam(value = "platformDeliveryReturnId", required = false) String platformDeliveryReturnIdStr,
//            @RequestParam(value = "inspecGradeId", required = false, defaultValue = "1") Integer inspecGradeId,
//            @RequestParam(value = "equipGradeId", required = false, defaultValue = "0") Integer equipGradeId,
//            @RequestParam(value = "adminId", required = false) String adminId,
//            @RequestParam(value = "inspecComment", required = false, defaultValue = "") String inspecComment,
//            HttpSession session,
//            RedirectAttributes redirectAttributes) {
//
//        try {
//            // 문자열에서 숫자 추출 및 변환
//            Integer platformDeliveryId = null;
//            Integer platformDeliveryReturnId = null;
//
//            if (platformDeliveryIdStr != null && !platformDeliveryIdStr.isEmpty()) {
//                try {
//
//                    // 세션에서 관리자 ID 가져오기 또는 기본값 사용
//                    String validAdminId = "ADMIN1"; // 기본값
//
//                    // 세션에 ID가 있으면 사용
//                    if (session.getAttribute("adminId") != null) {
//                        validAdminId = (String) session.getAttribute("adminId");
//                    }
//
//                    // 매개변수로 전달된 ID가 있으면 사용 (파라미터 이름을 "adminId"로 수정)
//                    if (adminId != null && !adminId.trim().isEmpty()) {
//                        validAdminId = adminId;
//                    }
//
//                    // 디버깅 로그 추가
//                    System.out.println("사용할 관리자 ID: " + validAdminId);
//
//
//                    // "DELV-123" 형식에서 숫자만 추출
//                    String numericPart = platformDeliveryIdStr.replaceAll("[^0-9]", "");
//                    if (!numericPart.isEmpty()) {
//                        platformDeliveryId = Integer.parseInt(numericPart);
//                    }
//                } catch (NumberFormatException e) {
//                    System.out.println("배송 ID 변환 실패: " + platformDeliveryIdStr);
//                }
//            }
//
//            if (platformDeliveryReturnIdStr != null && !platformDeliveryReturnIdStr.isEmpty()) {
//                try {
//                    // "DELV-RTN-123" 형식에서 숫자만 추출
//                    String numericPart = platformDeliveryReturnIdStr.replaceAll("[^0-9]", "");
//                    if (!numericPart.isEmpty()) {
//                        platformDeliveryReturnId = Integer.parseInt(numericPart);
//                    }
//                } catch (NumberFormatException e) {
//                    System.out.println("반환 ID 변환 실패: " + platformDeliveryReturnIdStr);
//                }
//            }
//
//            // 둘 다 null인지 검증
//            if (platformDeliveryId == null && platformDeliveryReturnId == null) {
//                throw new IllegalArgumentException("배송 ID 또는 반환 ID가 필요합니다.");
//            }
//
//
//            // 디버깅 로그 추가
//            System.out.println("프로시저 호출 정보: delivery=" + platformDeliveryId
//                    + ", return=" + platformDeliveryReturnId
//                    + ", grade=" + equipGradeId
//                    + ", comment=" + inspecComment);
//
//            // MyBatis Mapper 인터페이스 가져오기
//            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);
//
//            // 확장된 프로시저 호출 메소드 사용
//            dao.callINSPECT_RESULT_EXTENDED(platformDeliveryId, platformDeliveryReturnId,
//                    inspecGradeId, equipGradeId, adminId, inspecComment);
//
//            redirectAttributes.addFlashAttribute("message", "검수 결과가 성공적으로 등록되었습니다.");
//
//        } catch (Exception e) {
//            redirectAttributes.addFlashAttribute("error", "검수 결과 등록 중 오류가 발생했습니다: " + e.getMessage());
//            e.printStackTrace();
//        }
//
//        return "redirect:/admin-inspectList.action";
//    }
}