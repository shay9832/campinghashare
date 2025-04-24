package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;

import java.util.List;

public interface IMypageWishlistService {
    // 스토렌 찜 내역 가져오기
    List<StorenDTO> listMyWishStoren(int userCode);

    // 스토렌 찜 삭제하기
    Boolean deleteMyWishStoren(int userCode, int id, String type);
}
