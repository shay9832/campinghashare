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


    @RequestMapping(value="/admin-deliveryUpdate.action",method = RequestMethod.POST)
    public String updateShippingStartDate(@RequestParam("deliveryId") int deliveryId,
                                          @RequestParam("selecteDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date selecteDate,
                                          Model model) {

        IAdminDeliveryUpdateDAO dao = sqlSession.getMapper(IAdminDeliveryUpdateDAO.class);

        int result = dao.updateShippingStartDate(deliveryId,selecteDate);

        if (result > 0) {
            model.addAttribute("message","배송 시작일이 성공적으로 업데이트되었습니다.");
        } else {
            model.addAttribute("error","선택한 날짜가 허용된 배송 기간이 아닙니다.");
        }

        return "redirect:/admin-deliveryUpdate.action";
    }
}
