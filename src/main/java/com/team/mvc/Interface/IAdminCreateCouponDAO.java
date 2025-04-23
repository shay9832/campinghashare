package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminCreateCouponDTO;
import java.util.List;

public interface IAdminCreateCouponDAO {
    // 쿠폰 타입 목록 조회
    List<AdminCreateCouponDTO> getList();

    // 쿠폰 생성 - DTO 객체를 파라미터로 사용
    void setCoupon(AdminCreateCouponDTO dto);
}