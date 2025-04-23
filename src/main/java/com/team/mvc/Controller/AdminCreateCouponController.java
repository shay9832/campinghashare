package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminCreateCouponDTO;
import com.team.mvc.Interface.IAdminCreateCouponDAO;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class AdminCreateCouponController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-createCoupon.action", method = RequestMethod.GET)
    public String adminCreateCouponForm(Model model) {
        // 쿠폰 타입 목록 가져오기
        IAdminCreateCouponDAO dao = sqlSession.getMapper(IAdminCreateCouponDAO.class);
        List<AdminCreateCouponDTO> couponTypeList = dao.getList();

        // 디버깅 로그 추가
        System.out.println("===== 쿠폰 타입 목록 =====");
        if (couponTypeList == null || couponTypeList.isEmpty()) {
            System.out.println("쿠폰 타입 목록이 비어있습니다.");
        } else {
            for (AdminCreateCouponDTO type : couponTypeList) {
                System.out.println("ID: " + type.getCouponTypeId() + ", 이름: " + type.getCouponTypeName());
            }
        }
        System.out.println("=======================");

        // 모델에 쿠폰 타입 목록 추가
        model.addAttribute("couponTypeList", couponTypeList);

        return "admin-createCoupon";
    }

    @RequestMapping(value="/admin-createCoupon.action", method = RequestMethod.POST)
    public String adminCreateCoupon(
            @RequestParam(value="couponName", required=false) String couponName,
            @RequestParam(value="couponDiscount", required=false) Integer couponDiscount,
            @RequestParam(value="couponMonth", required=false) String couponMonth,
            @RequestParam(value="couponTypeId", required=false) Integer couponTypeId,
            @RequestParam(value="adminId", required=false) String adminId,
            HttpServletRequest request,
            Model model) {

        // 디버깅을 위해 모든 파라미터 출력
        System.out.println("===== 요청 파라미터 =====");
        Map<String, String[]> paramMap = request.getParameterMap();
        for (String key : paramMap.keySet()) {
            System.out.println(key + " : " + String.join(", ", paramMap.get(key)));
        }
        System.out.println("=======================");

        IAdminCreateCouponDAO dao = sqlSession.getMapper(IAdminCreateCouponDAO.class);

        try {
            // DTO 객체 생성하고 값 설정하기
            AdminCreateCouponDTO dto = new AdminCreateCouponDTO();
            dto.setAdminId(adminId);
            dto.setCouponName(couponName);
            dto.setCouponDiscount(couponDiscount);
            dto.setCouponMonth(couponMonth);
            dto.setCouponTypeId(couponTypeId);

            // 쿠폰 저장 - DTO 객체 전달
            dao.setCoupon(dto);

            // 성공 메시지 설정
            model.addAttribute("message", "쿠폰이 성공적으로 생성되었습니다.");
            model.addAttribute("redirectUrl", "/admin-couponList.action");

            return "admin-createCoupon";

        } catch (Exception e) {
            // 오류 처리
            model.addAttribute("errorMessage", "쿠폰 생성 중 오류가 발생했습니다: " + e.getMessage());

            // 쿠폰 타입 목록 다시 가져오기
            List<AdminCreateCouponDTO> couponTypeList = dao.getList();
            model.addAttribute("couponTypeList", couponTypeList);

            return "admin-createCoupon";
        }
    }
}