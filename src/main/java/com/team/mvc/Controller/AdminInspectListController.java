package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminInspectListDTO;
import com.team.mvc.Interface.IAdminInspectListDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminInspectListController {

    @Autowired
    private SqlSession sqlSession;

    /**
     * 세션 검증 헬퍼 메소드
     */
    private boolean validateAdminSession(HttpSession session, RedirectAttributes redirectAttributes) {
        if (session == null || session.getAttribute("adminId") == null) {
            redirectAttributes.addFlashAttribute("error", "관리자 로그인이 필요합니다.");
            return false;
        }
        return true;
    }

    /**
     * 관리자 로그인 페이지
     */
    @RequestMapping("/admin-login.action")
    public String adminLogin() {
        return "admin-login"; // 로그인 페이지 JSP
    }

    /**
     * 관리자 로그인 처리
     */
    @PostMapping("/admin-login.action")
    public String processLogin(@RequestParam("adminId") String adminId,
                               @RequestParam("password") String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {

        // 실제 환경에서는 데이터베이스에서 관리자 정보 확인
        // 여기서는 간단한 예시로 구현
        if (adminId != null && !adminId.isEmpty() && password != null && !password.isEmpty()) {
            // 로그인 성공 처리
            session.setAttribute("adminId", adminId);
            return "redirect:/admin-inspectList.action";
        } else {
            // 로그인 실패 처리
            redirectAttributes.addFlashAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/admin-login.action";
        }
    }

    /**
     * 로그아웃 처리
     */
    @GetMapping("/admin-logout.action")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin-login.action";
    }

    /**
     * 검수 목록 페이지 (GET 요청 처리)
     */
    @RequestMapping(value="/admin-inspectList.action", method = RequestMethod.GET)
    public String adminInspectList(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        // 세션 검증
        if (session.getAttribute("adminId") == null) {
            redirectAttributes.addFlashAttribute("error", "관리자 로그인이 필요합니다.");
            return "redirect:/admin-login.action";
        }

        try {
            // MyBatis Mapper 인터페이스 가져오기
            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

            // 모든 필요한 데이터를 한 번에 모델에 추가
            model.addAttribute("list", dao.getList());
            model.addAttribute("listr", dao.getListr());
            model.addAttribute("getItemList", dao.getItemList());
            model.addAttribute("getGradeList", dao.getGradeList());
            model.addAttribute("getEquipList", dao.getEquipList());
            model.addAttribute("equipGrades", dao.getGradeLists()); // 추가: 등급 정보를 모델에 직접 포함

            return "admin-inspectList";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "데이터를 가져오는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin-login.action";
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
            @RequestParam(value = "adminId", required = false) String adminId,
            @RequestParam(value = "inspecComment", required = false, defaultValue = "") String inspecComment,
            @RequestParam(value = "finalGrade", required = false) String finalGrade,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // 세션 검증
        if (session.getAttribute("adminId") == null) {
            redirectAttributes.addFlashAttribute("error", "관리자 로그인이 필요합니다.");
            return "redirect:/admin-login.action";
        }

        try {
            // 문자열에서 숫자 추출 및 변환
            Integer platformDeliveryId = null;
            Integer platformDeliveryReturnId = null;

            if (platformDeliveryIdStr != null && !platformDeliveryIdStr.isEmpty()) {
                try {
                    // 세션에서 관리자 ID 가져오기
                    String validAdminId = (String) session.getAttribute("adminId");

                    // 매개변수로 전달된 ID가 있으면 사용
                    if (adminId != null && !adminId.trim().isEmpty()) {
                        // 실제 환경에서는 권한 검증 로직 추가
                        validAdminId = adminId;
                    } else {
                        // adminId가 제공되지 않은 경우 세션의 ID 사용
                        adminId = validAdminId;
                    }

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
            dao.callINSPECT_RESULT_EXTENDED(platformDeliveryId, platformDeliveryReturnId,
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