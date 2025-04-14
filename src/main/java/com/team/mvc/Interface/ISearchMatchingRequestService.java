package com.team.mvc.Interface;

import com.team.mvc.DTO.MatchingRequestDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.DTO.StorenRequestDTO;

public interface ISearchMatchingRequestService {
    // 스토렌id의 글을 볼 때
    StorenRequestDTO getStoren(int transactionId);

    // 스토렌 매칭 신청
    boolean insertMatchingRequest(int storenId, int user_code, String rentalStartDate, String rentalEndDate);

    // 특정 스토렌id에 해당 유저가 매칭신청을 이미 했다면 해당 매칭 정보 반환
    MatchingRequestDTO getMatchingByStorenAndUser(int storenId, int user_code);
}
