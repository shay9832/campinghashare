package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IRentalSearchService {

    // 전체 스토렌 장비 리스트 조회
    List<StorenDTO> listStoren();

    // 스토렌 장비 검색(키워드)
    List<StorenDTO> searchStorenKeyword(@Param("searchKeyword") String searchKeyword);

    // 스토렌 장비 검색(키워드, 가격 범위, 날짜 범위)
    List<StorenDTO> searchStoren(@Param("searchKeyword") String searchKeyword
                                , @Param("minPrice") int minPrice, @Param("maxPrice") int maxPrice
                                , @Param("startDate") String startDate, @Param("endDate") String endDate);
}
