package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminCouponListDTO;

import java.util.List;

public interface IAdminCouponListDAO {

    // 쿠폰 리스트를 불러오는 메소드
    List<AdminCouponListDTO> getList();


    //쿠폰 타입을 불러오는 메소드
    List<AdminCouponListDTO> getTypes();
}
