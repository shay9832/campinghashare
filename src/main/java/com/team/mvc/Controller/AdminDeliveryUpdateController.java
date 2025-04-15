package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminDeliveryUpdateDTO;
import com.team.mvc.Interface.IAdminDeliveryUpdateDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 배송 정보 조회를 위한 컨트롤러
 */
@Controller
public class AdminDeliveryUpdateController {

    private final IAdminDeliveryUpdateDAO adminDeliveryUpdateDAO;

    @Autowired
    public AdminDeliveryUpdateController(IAdminDeliveryUpdateDAO adminDeliveryUpdateDAO) {
        this.adminDeliveryUpdateDAO = adminDeliveryUpdateDAO;
    }

    /**
     * 배송 정보 조회 - 배송 관리 페이지
     *
     * @param model 뷰에 전달할 모델
     * @return 배송 관리 페이지
     */
    @GetMapping("/admin-deliveryUpdate.action")
    public String getAllDeliveries(Model model) {
        List<AdminDeliveryUpdateDTO> allDeliveries = adminDeliveryUpdateDAO.getAllDeliveries();

        // 배송 유형별로 리스트 분류
        Map<String, List<AdminDeliveryUpdateDTO>> deliveryMap = categorizeDeliveries(allDeliveries);

        // 모델에 각 배송 유형별 리스트 추가
        model.addAttribute("platformShippingList", deliveryMap.get("platform"));
        model.addAttribute("platformReturnShippingList", deliveryMap.get("platformReturn"));
        model.addAttribute("userShippingList", deliveryMap.get("user"));
        model.addAttribute("userReturnShippingList", deliveryMap.get("userReturn"));
        model.addAttribute("storageReturnShippingList", deliveryMap.get("storageReturn"));
        model.addAttribute("storenReturnShippingList", deliveryMap.get("storenReturn"));

        // 배송 요약 정보 계산
        int totalCount = allDeliveries.size();
        int completedCount = totalCount; // 여기서는 모든 배송을 완료 상태로 가정
        int ongoingCount = 0;

        // 배송 요약 정보 모델에 추가
        Map<String, Integer> summary = new HashMap<>();
        summary.put("totalCount", totalCount);
        summary.put("ongoingCount", ongoingCount);
        summary.put("completedCount", completedCount);
        model.addAttribute("shippingSummary", summary);

        return "/admin-deliveryUpdate";
    }

    /**
     * 배송 유형별로 배송 정보 분류
     *
     * @param allDeliveries 모든 배송 정보 목록
     * @return 유형별로 분류된 배송 정보 맵
     */
    private Map<String, List<AdminDeliveryUpdateDTO>> categorizeDeliveries(List<AdminDeliveryUpdateDTO> allDeliveries) {
        Map<String, List<AdminDeliveryUpdateDTO>> result = new HashMap<>();

        // 각 카테고리별 리스트 초기화
        result.put("platform", new ArrayList<>());
        result.put("platformReturn", new ArrayList<>());
        result.put("user", new ArrayList<>());
        result.put("userReturn", new ArrayList<>());
        result.put("storageReturn", new ArrayList<>());
        result.put("storenReturn", new ArrayList<>());

        // 배송 유형에 따라 분류
        for (AdminDeliveryUpdateDTO delivery : allDeliveries) {
            String type = delivery.getDeliveryType();

            if ("스토렌_최초입고".equals(type) || "보관_최초입고".equals(type) || "스토렌_매칭발송".equals(type)) {
                result.get("platform").add(delivery);
            } else if ("스토렌_매칭반납".equals(type)) {
                result.get("platformReturn").add(delivery);
            } else if ("렌탈_발송".equals(type)) {
                result.get("user").add(delivery);
            } else if ("렌탈_반납".equals(type)) {
                result.get("userReturn").add(delivery);
            } else if ("보관_최종반환".equals(type)) {
                result.get("storageReturn").add(delivery);
            } else if ("스토렌_최종반환".equals(type)) {
                result.get("storenReturn").add(delivery);
            }
        }

        return result;
    }
}