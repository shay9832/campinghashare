package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminDeliveryUpdateDTO;
import com.team.mvc.Interface.IAdminDeliveryUpdateDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.*;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    public String getAllDeliveries(@ModelAttribute("adminId") String adminId, Model model) {
        // SqlSession을 통해 매퍼 인터페이스 직접 호출
        IAdminDeliveryUpdateDAO dao = sqlSession.getMapper(IAdminDeliveryUpdateDAO.class);

        // 기존 배송 리스트 조회
        List<AdminDeliveryUpdateDTO> allDeliveries = dao.getAllDeliveries();

        // 배송 대기 중인 항목도 가져오기
        List<AdminDeliveryUpdateDTO> pendingDeliveries = dao.getPendingDeliveries();

        // 모든 배송 항목 합치기
        allDeliveries.addAll(pendingDeliveries);

        // 배송 유형별로 리스트 분류
        Map<String, List<AdminDeliveryUpdateDTO>> deliveryMap = categorizeDeliveries(allDeliveries);

        // 모델에 각 배송 유형별 리스트 추가
        model.addAttribute("platformShippingList", deliveryMap.get("platform"));
        model.addAttribute("platformReturnShippingList", deliveryMap.get("platformReturn"));
        model.addAttribute("userShippingList", deliveryMap.get("user"));
        model.addAttribute("userReturnShippingList", deliveryMap.get("userReturn"));
        model.addAttribute("storageReturnShippingList", deliveryMap.get("storageReturn"));
        model.addAttribute("storenReturnShippingList", deliveryMap.get("storenReturn"));
        model.addAttribute("pendingDeliveryList", deliveryMap.get("pending"));

        // 배송 요약 정보 계산
        int totalCount = allDeliveries.size();
        int completedCount = (int) allDeliveries.stream()
                .filter(d -> d.getDeliveryEndDate() != null)
                .count();
        int ongoingCount = (int) allDeliveries.stream()
                .filter(d -> d.getDeliveryStartDate() != null && d.getDeliveryEndDate() == null)
                .count();
        int pendingCount = (int) pendingDeliveries.size();

        Map<String, Integer> summary = new HashMap<>();
        summary.put("totalCount", totalCount);
        summary.put("ongoingCount", ongoingCount);
        summary.put("completedCount", completedCount);
        summary.put("pendingCount", pendingCount);
        model.addAttribute("shippingSummary", summary);

        return "/admin-deliveryUpdate";
    }

    // 배송 업데이트 POST 메서드
    @RequestMapping(value="/admin-deliveryUpdate.action", method=RequestMethod.POST)
    public String updateDelivery(@ModelAttribute("adminId") String adminId,
            @RequestParam(value="newDeliveryStartDate", required=false) String newDeliveryStartDate,
            @RequestParam(value="deliveryEndDate", required=false) String deliveryEndDate,
            @RequestParam(value="deliveryId", required=false) Long deliveryId,
            @RequestParam(value="deliveryType", required=false) String deliveryType,
            @RequestParam(value="payId", required=false) Integer payId,
            @RequestParam(value="waybillNumber", required=false) String waybillNumber,
            AdminDeliveryUpdateDTO dto,
            Model model) {

        try {
            IAdminDeliveryUpdateDAO dao = sqlSession.getMapper(IAdminDeliveryUpdateDAO.class);

            System.out.println(payId);

            // 운송장 번호 로깅
            System.out.println("요청된 운송장 번호: " + waybillNumber);

            // 운송장 번호 설정
            if (waybillNumber != null && !waybillNumber.isEmpty()) {
                dto.setWaybillNumber(waybillNumber);
            }

            // 요청 파라미터 로깅
                    System.out.println("요청 파라미터: deliveryId=" + deliveryId +
                    ", deliveryType=" + deliveryType +
                    ", deliveryEndDate=" + deliveryEndDate);

            // NULL 체크 및 기본값 설정
            if (deliveryId == null) {
                // === 새 배송 생성 로직 ===

                // deliveryType이 없으면 오류
                if (deliveryType == null || deliveryType.isEmpty()) {
                    System.err.println("배송 타입이 없습니다. 생성할 수 없습니다.");
                    return "redirect:/admin-deliveryUpdate.action";
                }

                if (payId == null) {
                    System.err.println("결제 정보가 없습니다 !!");
                    return "redirect:/admin-deliveryUpdate.action";
                }

                dto.setPayId(payId);

                // 시작일이 비어 있으면 현재 시간 사용
                if (newDeliveryStartDate != null && !newDeliveryStartDate.isEmpty()) {
                    dto.setDeliveryStartDate(newDeliveryStartDate + " 00:00:00");
                } else {
                    dto.setDeliveryStartDate(String.valueOf(LocalDateTime.now()));
                }

                // 기본값 설정
                dto.setDeliveryType(deliveryType);
                dto.setPlatformDeliveryId(0);
                dto.setPlatformDeliveryReturnId(0);

                // DB에 insert
                dao.createDelivery(dto);
                System.out.println("새 배송이 생성되었습니다.");
                return "redirect:/admin-deliveryUpdate.action";
            }

            dto.setDeliveryId(deliveryId);

            // deliveryType null 체크
            if (deliveryType == null || deliveryType.isEmpty()) {
                System.err.println("deliveryType이 null이거나 비어 있습니다.");
                return "redirect:/admin-deliveryUpdate.action";
            }
            dto.setDeliveryType(deliveryType);



            // 배송 유형에 따라 ID 설정
            if ("platform".equals(deliveryType)) {
                // platformDeliveryId 가져오기 전에 null 체크
                Integer platformDeliveryId = null;
                try {
                    platformDeliveryId = dao.getPlatformDeliveryId(deliveryId);
                } catch (Exception e) {
                    System.err.println("getPlatformDeliveryId 오류: " + e.getMessage());
                }
                dto.setPlatformDeliveryId(platformDeliveryId != null ? platformDeliveryId : 0);
                dto.setPlatformDeliveryReturnId(0); // 기본값 설정
            } else if ("platform-return".equals(deliveryType)) {
                // platformDeliveryReturnId 가져오기 전에 null 체크
                Integer platformDeliveryReturnId = null;
                try {
                    platformDeliveryReturnId = dao.getPlatformDeliveryReturnId(deliveryId);
                } catch (Exception e) {
                    System.err.println("getPlatformDeliveryReturnId 오류: " + e.getMessage());
                }
                dto.setPlatformDeliveryReturnId(platformDeliveryReturnId != null ? platformDeliveryReturnId : 0);
                dto.setPlatformDeliveryId(0); // 기본값 설정
            } else {
                // 다른 타입의 경우 기본값 설정
                dto.setPlatformDeliveryId(0);
                dto.setPlatformDeliveryReturnId(0);
            }



            // 날짜 처리
            if (newDeliveryStartDate != null && !newDeliveryStartDate.isEmpty()) {
                dto.setNewDeliveryStartDate(newDeliveryStartDate + " 00:00:00");
            } else {
                dto.setNewDeliveryStartDate(null); // 명시적으로 null 설정
            }

            if (deliveryEndDate != null && !deliveryEndDate.isEmpty()) {
                dto.setDeliveryEndDate(deliveryEndDate + " 00:00:00");
            } else {
                dto.setDeliveryEndDate(null); // 명시적으로 null 설정
            }




            // 업데이트 실행
            dao.updateDelivery(dto);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("배송 업데이트 중 오류 발생: " + e.getMessage());
        }

        return "redirect:/admin-deliveryUpdate.action";
    }

    // 새 배송 생성 메서드
    @RequestMapping(value="/admin-createDelivery.action", method=RequestMethod.POST)
    public String createDelivery(@ModelAttribute("adminId") String adminId,
            @RequestParam(value="newDeliveryStartDate", required=false) String newDeliveryStartDate,
            @RequestParam(value="deliveryEndDate", required=false) String deliveryEndDate,
            @RequestParam(value="payId", required=false) Integer payId,
            AdminDeliveryUpdateDTO dto,
            Model model) {
        try {
            // 새 배송 시작일이 있으면 DTO에 설정
            if (newDeliveryStartDate != null && !newDeliveryStartDate.isEmpty()) {
                String startDate = newDeliveryStartDate + " 00:00:00";
                dto.setDeliveryStartDate(startDate);
            } else {
                // 기본값으로 현재 시간 설정
                dto.setDeliveryStartDate(
                        LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
                );
            }

            // 배송 종료일 설정
            if (deliveryEndDate != null && !deliveryEndDate.isEmpty()) {
                String endDate = deliveryEndDate + " 00:00:00";
                dto.setDeliveryEndDate(endDate);
            }

            // Pay_id 설정
            dto.setPayId(payId);

            // DAO를 통해 DB에 새 배송 생성
            IAdminDeliveryUpdateDAO dao = sqlSession.getMapper(IAdminDeliveryUpdateDAO.class);
            dao.createDelivery(dto);

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
        result.put("pending", new ArrayList<>()); // 배송 대기 항목용 리스트 추가

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
            } else if ("스토렌_배송대기".equals(type) || "보관_배송대기".equals(type)) {
                result.get("pending").add(delivery);
            }
        }

        return result;
    }

    //@InitBinder로 빈 문자열 무시
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Long.class, new CustomNumberEditor(Long.class, true));
        binder.registerCustomEditor(Integer.class, new CustomNumberEditor(Integer.class, true));

        // LocalDateTime 변환을 위한 날짜 포맷 등록
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        binder.registerCustomEditor(LocalDateTime.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                if (text == null || text.isEmpty()) {
                    setValue(null);
                } else {
                    // 시간이 없는 날짜 문자열을 LocalDateTime으로 변환
                    LocalDate date = LocalDate.parse(text, formatter);
                    setValue(date.atStartOfDay());
                }
            }
        });
    }
}