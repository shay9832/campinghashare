package com.team.mvc.Interface;

import com.team.mvc.DTO.CouponDTO;

import java.util.List;

public interface ICouponDAO {
    //user_code로 해당 유저가 가진 쿠폰 리스트 전체 조회(사용만료일 임박순)
    List<CouponDTO> listCouponByUserCode(int user_code);
    
    //user_code로 해당 유저가 가진 쿠폰 리스트 중 날짜 유효한 리스트만 조회(사용만료일 임박순)
    List<CouponDTO> listValidCouponByUserCode(int user_code);

    //해당 유저가 가진 유효한 쿠폰 개수
    int countValidCouponByUserCode(int user_code);
}
