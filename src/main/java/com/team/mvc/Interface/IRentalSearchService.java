package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;

import java.util.List;

public interface IRentalSearchService {

    // 전체 스토렌 장비 리스트 조회
    List<StorenDTO> listStoren();

    // 스토렌 장비 검색
    List<StorenDTO> searchStorenKeyword(String searchKeyword);

}
