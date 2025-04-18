package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminPaymentDTO;
import com.team.mvc.Interface.IAdminPaymentDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 관리자 결제 정보 관리 컨트롤러
 */
@Controller
public class AdminPaymentController {

    @Autowired
    private SqlSession sqlSession;

    // 페이지당 표시할 항목 수
    private static final int ITEMS_PER_PAGE = 10;

    /**
     * 결제 관리 메인 페이지 (GET 요청 처리)
     * - 모든 검색 파라미터 포함
     */
    @RequestMapping(value = "/admin-payment.action", method = RequestMethod.GET)
    public String adminPayment(
            @ModelAttribute("adminId") String adminId,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "type", required = false) String type,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "paymentMethod", required = false) String paymentMethod,
            @RequestParam(value = "paymentStatus", required = false) String paymentStatus,
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // MyBatis Mapper 인터페이스 가져오기
            IAdminPaymentDAO dao = sqlSession.getMapper(IAdminPaymentDAO.class);

            // 페이징 계산
            int start = (page - 1) * ITEMS_PER_PAGE;

            List<AdminPaymentDTO> payments;
            int totalItems;
            Map<String, Object> stats;

            // 검색 조건이 있는 경우 검색 실행
            if ((searchType != null && !searchType.isEmpty()) ||
                    (paymentMethod != null && !paymentMethod.equals("all")) ||
                    (paymentStatus != null && !paymentStatus.equals("all")) ||
                    startDate != null || endDate != null ||
                    (keyword != null && !keyword.isEmpty())) {

                // 결제 방법 매핑
                String methodCode = null;
                if (paymentMethod != null && !paymentMethod.equals("all")) {
                    methodCode = mapPaymentMethod(paymentMethod);
                }

                // 검색 실행
                payments = dao.searchPayments(
                        searchType, methodCode, startDate, endDate, keyword, start, ITEMS_PER_PAGE);
                totalItems = dao.getTotalSearchResults(searchType, methodCode, startDate, endDate, keyword);

                // 모델에 검색 조건 추가
                model.addAttribute("searchType", searchType);
                model.addAttribute("paymentMethod", paymentMethod);
                model.addAttribute("paymentStatus", paymentStatus);
                model.addAttribute("startDate", startDate);
                model.addAttribute("endDate", endDate);
                model.addAttribute("keyword", keyword);

                // 전체 통계 정보
                stats = dao.getPaymentStatistics();

            }
            // 결제 유형별 필터링
            else if (type != null && !type.isEmpty() && !type.equals("all")) {
                // 한글 유형으로 변환
                String dbType = mapPaymentType(type);
                payments = dao.getPaymentsByType(dbType, start, ITEMS_PER_PAGE);
                totalItems = dao.getTotalPaymentsByType(dbType);

                // 결제 유형별 통계 정보
                stats = dao.getPaymentStatisticsByType(dbType);
            }
            // 기본 전체 결제 목록
            else {
                payments = dao.getAllPayments(start, ITEMS_PER_PAGE);
                totalItems = dao.getTotalPayments();

                // 전체 통계 정보
                stats = dao.getPaymentStatistics();
            }

            // 페이징 정보
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
            int startPage = Math.max(1, page - 4);
            int endPage = Math.min(totalPages, page + 4);

            // 모든 필요한 데이터를 한 번에 모델에 추가
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
            redirectAttributes.addFlashAttribute("error", "결제 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin-payment.action";
        }
    }

    /**
     * 결제 취소 처리 (POST 요청 처리)
     */
    @RequestMapping(value = "/admin-cancelPayUpdate.action", method = RequestMethod.POST)
    public String cancelPayment(
            @ModelAttribute("adminId") String adminId,
            @RequestParam("paymentId") int paymentId,
            @RequestParam("cancelReason") String cancelReason,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // MyBatis Mapper 인터페이스 가져오기
            IAdminPaymentDAO dao = sqlSession.getMapper(IAdminPaymentDAO.class);

            // 현재 날짜를 취소일로 사용
            Date cancelDate = new Date();

            // 결제 취소 처리
            int result = dao.updatePaymentStatus(paymentId, "결제취소", cancelDate, cancelReason);

            if (result > 0) {
                redirectAttributes.addFlashAttribute("success", "결제가 성공적으로 취소되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "결제 취소에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다: " + e.getMessage());
        }

        return "redirect:/admin-payment.action";
    }

    /**
     * 결제 상태 업데이트 (POST 요청 처리)
     */
    @RequestMapping(value = "/admin-updatePayment.action", method = RequestMethod.POST)
    public String updatePaymentStatus(
            @ModelAttribute("adminId") String adminId,
            @RequestParam("paymentId") int paymentId,
            @RequestParam("status") String status,
            @RequestParam(value = "cancelDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date cancelDate,
            @RequestParam(value = "cancelReason", required = false) String cancelReason,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // MyBatis Mapper 인터페이스 가져오기
            IAdminPaymentDAO dao = sqlSession.getMapper(IAdminPaymentDAO.class);

            // 결제취소인 경우 취소일자가 없으면 현재 날짜로 설정
            if ("결제취소".equals(status) && cancelDate == null) {
                cancelDate = new Date();
            }

            // 결제 상태 업데이트
            int result = dao.updatePaymentStatus(paymentId, status, cancelDate, cancelReason);

            if (result > 0) {
                redirectAttributes.addFlashAttribute("success", "결제 상태가 업데이트되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("error", "결제 상태 업데이트에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다: " + e.getMessage());
        }

        return "redirect:/admin-payment.action";
    }

    /**
     * 결제 방법 코드를 한글 명칭으로 매핑
     */
    private String mapPaymentMethod(String paymentMethod) {
        switch (paymentMethod) {
            case "bank":
                return "무통장입금";
            case "card":
                return "신용카드";
            case "mobile":
                return "휴대폰결제";
            case "kakao":
                return "카카오페이";
            case "naver":
                return "네이버페이";
            default:
                return paymentMethod;
        }
    }

    /**
     * 결제 유형 코드를 한글 명칭으로 매핑
     */
    private String mapPaymentType(String type) {
        switch (type.toLowerCase()) {
            case "rental":
                return "렌탈";
            case "storage":
                return "보관";
            case "storen":
                return "스토렌";
            default:
                return type;
        }
    }
}