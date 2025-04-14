package com.team.mvc.Interface;

import com.team.mvc.DTO.MatchingRequestDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMatchingRequestDAO {
    // 거래 id와 거래유형으로 해당 거래 id에 매칭신청한 사용자 목록을 불러오는 메소드(transaction_type이 '스토렌_매칭신청' 또는 '렌탈_매칭신청')
    List<MatchingRequestDTO> listRequestByTransactionIdType(@Param("transaction_id") int transaction_id, @Param("transaction_type") String transaction_type);

    // 스토렌 매칭 신청(insert)
    int insertStorenMatchingRequest(MatchingRequestDTO matchingRequestDTO);

    // 스토렌id에 해당 유저가 매칭했다면 매칭 정보 반환하는 메소드
    MatchingRequestDTO getMatchingByStorenAndUser(@Param("storenId") int storenId, @Param("user_code")int user_code);

    // 스토렌 매칭 승인(1. 매칭 완료 테이블에 insert)
    int insertStorenMatchingDone(@Param("requestId") int requestId);

    // 해당 스토렌ID의 다른 매칭 요청 삭제(2. 매칭 신청 테이블에서 delete)
    int deleteOtherStorenRequests(@Param("storenId") int storenId, @Param("requestId") int requestId);
}
