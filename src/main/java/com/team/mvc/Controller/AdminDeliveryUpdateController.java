package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminDeliveryUpdateDTO;
import com.team.mvc.Interface.IAdminDeliveryUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.*;

/**
 * 배송 정보 조회를 위한 컨트롤러 (SqlSession 방식)
 */
@Controller
public class AdminDeliveryUpdateController {

    private final SqlSession sqlSession;

    @Autowired
    public AdminDeliveryUpdateController(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @RequestMapping(value = "/admin-deliveryUpdate.action", method = RequestMethod.GET)
    public String getAllDeliveries(Model model) {
        // SqlSession을 통해 매퍼 인터페이스 직접 호출
        IAdminDeliveryUpdateDAO dao = sqlSession.getMapper(IAdminDeliveryUpdateDAO.class);
        List<AdminDeliveryUpdateDTO> allDeliveries = dao.getAllDeliveries();

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
        int completedCount = totalCount;
        int ongoingCount = 0;

        Map<String, Integer> summary = new HashMap<>();
        summary.put("totalCount", totalCount);
        summary.put("ongoingCount", ongoingCount);
        summary.put("completedCount", completedCount);
        model.addAttribute("shippingSummary", summary);

        return "/admin-deliveryUpdate";
    }

    // 여기에 새로운 POST 메서드 추가
    @RequestMapping(value="/admin-deliveryUpdate.action", method=RequestMethod.POST)
    public String updateDelivery(
            @RequestParam(value="calculatedDeliveryStartDate", required=false) String calculatedDeliveryStartDate,
            @RequestParam(value="calculatedDeliveryEndDate", required=false) String calculatedDeliveryEndDate,
            AdminDeliveryUpdateDTO dto,
            Model model) {

        try {
            // 계산된 배송 시작일과 종료일이 있으면 DTO에 설정
            if (calculatedDeliveryStartDate != null && !calculatedDeliveryStartDate.isEmpty()) {
                // LocalDateTime으로 변환 (컨트롤러가 LocalDateTime을 사용하고 있음)
                LocalDateTime startDate = LocalDateTime.parse(calculatedDeliveryStartDate + "T00:00:00");
                dto.setDeliveryStartDate(startDate);
            }

            if (calculatedDeliveryEndDate != null && !calculatedDeliveryEndDate.isEmpty()) {
                LocalDateTime endDate = LocalDateTime.parse(calculatedDeliveryEndDate + "T00:00:00");
                dto.setDeliveryEndDate(endDate);
            }

            // DAO를 통해 DB 업데이트
            IAdminDeliveryUpdateDAO dao = sqlSession.getMapper(IAdminDeliveryUpdateDAO.class);

            // DAO에 업데이트 메서드가 있는지 확인
            // 메서드 명은 DAO 인터페이스에 정의된 대로 사용
            dao.updateDelivery(dto);

        } catch (Exception e) {
            e.printStackTrace();
            // 오류 처리 로직
        }

        return "redirect:/admin-deliveryUpdate.action";
    }

    private Map<String, List<AdminDeliveryUpdateDTO>> categorizeDeliveries(List<AdminDeliveryUpdateDTO> allDeliveries) {
        Map<String, List<AdminDeliveryUpdateDTO>> result = new HashMap<>();
        result.put("platform", new ArrayList<>());
        result.put("platformReturn", new ArrayList<>());
        result.put("user", new ArrayList<>());
        result.put("userReturn", new ArrayList<>());
        result.put("storageReturn", new ArrayList<>());
        result.put("storenReturn", new ArrayList<>());

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