package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminPaymentDTO;
import com.team.mvc.Interface.IAdminPaymentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 결제 정보 관리 컨트롤러
 */
@Controller
public class AdminPaymentController {

    @Autowired
    private IAdminPaymentDAO adminPaymentDAO;

    // 페이지당 표시할 항목 수
    private static final int ITEMS_PER_PAGE = 10;

    /**
     * 결제 관리 메인 페이지
     */
    @RequestMapping("/admin-payment.action")
    public String paymentManagement(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "type", required = false) String type,
            Model model
    ) {
        try {
            // 페이징 계산
            int start = (page - 1) * ITEMS_PER_PAGE;

            List<AdminPaymentDTO> payments;
            int totalItems;

            // 결제 유형 필터 적용
            if (type != null && !type.isEmpty() && !type.equals("all")) {
                payments = adminPaymentDAO.getPaymentsByType(type, start, ITEMS_PER_PAGE);
                // 결제 유형별 통계 정보
                Map<String, Object> statistics = adminPaymentDAO.getPaymentStatisticsByType(type);
                model.addAttribute("statistics", statistics);
            } else {
                payments = adminPaymentDAO.getAllPayments(start, ITEMS_PER_PAGE);
                // 전체 통계 정보
                Map<String, Object> statistics = adminPaymentDAO.getPaymentStatistics();
                model.addAttribute("statistics", statistics);
            }

            totalItems = adminPaymentDAO.getTotalPayments();

            // 페이징 정보
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
            int startPage = Math.max(1, page - 4);
            int endPage = Math.min(totalPages, page + 4);

            // 결제 통계 정보 추가
            Map<String, Object> stats = adminPaymentDAO.getPaymentStatistics();

            model.addAttribute("paymentList", payments);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("type", type);

            // 통계 정보 모델에 추가
            model.addAttribute("totalPayments", stats.get("totalCount"));
            model.addAttribute("totalAmount", stats.get("totalAmount"));
            model.addAttribute("rentalPayments", stats.get("rentalCount"));
            model.addAttribute("rentalAmount", stats.get("rentalAmount"));
            model.addAttribute("storagePayments", stats.get("storageCount"));
            model.addAttribute("storageAmount", stats.get("storageAmount"));
            model.addAttribute("storenPayments", stats.get("storenCount"));
            model.addAttribute("storenAmount", stats.get("storenAmount"));

            return "admin-payment";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "결제 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage());
            return "admin-payment";
        }
    }

    /**
     * 결제 정보 검색
     */
    @RequestMapping("/admin-searchPayments.action")
    @ResponseBody
    public Map<String, Object> searchPayments(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "paymentMethod", required = false) String paymentMethod,
            @RequestParam(value = "paymentStatus", required = false) String paymentStatus,
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
            @RequestParam(value = "keyword", required = false) String keyword
    ) {
        Map<String, Object> response = new HashMap<>();

        try {
            int start = (page - 1) * ITEMS_PER_PAGE;

            // 결제 방법 매핑 (클라이언트 코드에 맞춤)
            if (paymentMethod != null && !paymentMethod.equals("all")) {
                switch (paymentMethod) {
                    case "bank":
                        paymentMethod = "무통장입금";
                        break;
                    case "card":
                        paymentMethod = "신용카드";
                        break;
                    case "mobile":
                        paymentMethod = "휴대폰결제";
                        break;
                    case "kakao":
                        paymentMethod = "카카오페이";
                        break;
                    case "naver":
                        paymentMethod = "네이버페이";
                        break;
                }
            }

            // 검색 로직
            List<AdminPaymentDTO> payments = adminPaymentDAO.searchPayments(
                    searchType, paymentMethod, startDate, endDate, keyword, start, ITEMS_PER_PAGE);

            // 관련 통계 정보 가져오기
            Map<String, Object> stats = adminPaymentDAO.getPaymentStatistics();

            response.put("payments", payments);
            response.put("stats", stats);
            response.put("success", true);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "결제 정보 검색 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 결제 유형별 결제 목록 (AJAX)
     */
    @RequestMapping("/admin-getPaymentsByType.action")
    @ResponseBody
    public Map<String, Object> getPaymentsByType(
            @RequestParam("type") String type,
            @RequestParam(value = "page", defaultValue = "1") int page
    ) {
        Map<String, Object> response = new HashMap<>();

        try {
            int start = (page - 1) * ITEMS_PER_PAGE;

            // "all" 처리
            if ("all".equals(type)) {
                List<AdminPaymentDTO> payments = adminPaymentDAO.getAllPayments(start, ITEMS_PER_PAGE);
                Map<String, Object> stats = adminPaymentDAO.getPaymentStatistics();

                response.put("payments", payments);
                response.put("stats", stats);
            } else {
                // 유형 매핑
                String dbType = type;
                switch (type.toLowerCase()) {
                    case "rental":
                        dbType = "렌탈";
                        break;
                    case "storage":
                        dbType = "보관";
                        break;
                    case "storen":
                        dbType = "스토렌";
                        break;
                }

                List<AdminPaymentDTO> payments = adminPaymentDAO.getPaymentsByType(dbType, start, ITEMS_PER_PAGE);
                Map<String, Object> stats = adminPaymentDAO.getPaymentStatisticsByType(dbType);

                response.put("payments", payments);
                response.put("stats", stats);
            }

            response.put("success", true);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "결제 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 결제 취소 처리 (AJAX)
     */
    @RequestMapping(value = "/admin-cancelPayUpdate.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> cancelPayment(
            @RequestParam("paymentId") int paymentId,
            @RequestParam("cancelReason") String cancelReason
    ) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 현재 날짜를 취소일로 사용
            Date cancelDate = new Date();

            int result = adminPaymentDAO.updatePaymentStatus(paymentId, "결제취소", cancelDate, cancelReason);

            if (result > 0) {
                response.put("success", true);
                response.put("message", "결제가 성공적으로 취소되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "결제 취소에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 결제 상태 업데이트 (AJAX)
     */
    @RequestMapping(value = "/admin-updatePayment.action", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updatePaymentStatus(
            @RequestParam("paymentId") int paymentId,
            @RequestParam("status") String status,
            @RequestParam(value = "cancelDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date cancelDate,
            @RequestParam(value = "cancelReason", required = false) String cancelReason
    ) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 결제취소인 경우 취소일자가 없으면 현재 날짜로 설정
            if ("결제취소".equals(status) && cancelDate == null) {
                cancelDate = new Date();
            }

            int result = adminPaymentDAO.updatePaymentStatus(paymentId, status, cancelDate, cancelReason);

            if (result > 0) {
                response.put("success", true);
                response.put("message", "결제 상태가 업데이트되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "결제 상태 업데이트에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }
}