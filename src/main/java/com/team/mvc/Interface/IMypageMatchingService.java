package com.team.mvc.Interface;

import com.team.mvc.DTO.MatchingRequestDTO;
import com.team.mvc.DTO.StorenDTO;

import java.util.List;

public interface IMypageMatchingService {
    // 스토렌-소유자 탭 눌렀을 때 매칭 신청 수가 1 이상인 스토렌 목록 조회
    List<StorenDTO> listStroenOwnerTab(int user_code);

    // 렌탈-소유자 탭 눌렀을 때 : RentalDTO 만든 뒤에 추가하기
    // List<RentalDTO> listRentalOwnerTab(int user_code);

    // 스토렌-소유자 탭에서 각 스토렌 행을 눌렀을 때 서브 테이블에 넣을 신청자 목록 조회
    List<MatchingRequestDTO> listStorenRequestTab(int transaction_id, String transaction_type);

    // 렌탈-소유자 탭에서 각 렌탈 행을 눌렀을 때 서브 테이블에 넣을 신청자 목록 조회
    //List<RentalDTO> ListRentalRequestTab(int transaction_id, String transaction_type);

    // 스토렌-사용자 탭에서 내가 신청한 스토렌 목록 조회
    List<StorenDTO> listStorenUserTab(int user_code);

    // 스토렌-사용자 탭에서 매칭승인 여부 조회
    MatchingRequestDTO getStorenUserApproved(int user_code, int transaction_id);

    //스토렌 매칭 승인
    Boolean approveMatchingRequest(int transaction_id, int request_id);

    //스토렌 매칭신청 취소
    Boolean cancleMatchingRequest(int transaction_id, int request_id);

    //id로 스토렌 검색
    StorenDTO getMatchingByStorenId(int userCode, int storenId);

}
