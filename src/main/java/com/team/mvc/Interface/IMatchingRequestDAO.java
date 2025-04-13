package com.team.mvc.Interface;

import com.team.mvc.DTO.MatchingRequestDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMatchingRequestDAO {
    // 거래 id와 거래유형으로 해당 거래 id에 매칭신청한 사용자 목록을 불러오는 메소드(transaction_type이 '스토렌_매칭신청' 또는 '렌탈_매칭신청')
    List<MatchingRequestDTO> listRequestByTransactionIdType(@Param("transaction_id") int transaction_id, @Param("transaction_type") String transaction_type);
}
