package com.team.mvc.Service;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.MatchingRequestDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IMatchingRequestDAO;
import com.team.mvc.Interface.IMypageMatchingService;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@Service
public class MypageMatchingService implements IMypageMatchingService {

    @Autowired
    private SqlSession sqlSession;

    // 스토렌 소유자 탭(상세페이지 아니라 소유한 스토렌 장비 중 매칭신청이 들어온 장비만 조회)
    @Override
    public List<StorenDTO> listStroenOwnerTab(int user_code) {
        System.out.println("== MypageMatching Service : listStroenOwnerTab : START ==");

        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> equipmentList = equipDao.listByUserCode(user_code);
        // 사용자의 모든 스토렌 정보 중 매칭 신청이 들어온 스토렌 정보만 리스트 조회
        List<StorenDTO> storenList = storenDAO.listMatchingStorenByUserCode(user_code);

        //equipmentList를 장비 코드로 쉽게 검색할 수 있는 Map으로 변환
        Map<Integer, EquipmentDTO> equipmentMap = equipmentList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equipment -> equipment));

        // 스토렌 리스트의 각 storenDTO에 해당하는 equipmentDTO 설정
        for (StorenDTO storen : storenList) {
            EquipmentDTO equipment = equipmentMap.get(storen.getEquip_code());
            storen.setEquipmentDTO(equipment);
        }

        System.out.println("== MypageMatching Service : listStroenOwnerTab : END ==");

        return storenList;
    }

    // 스토렌 소유자 탭 - 상세 정보 테이블(매칭 신청한 신청자의 정보 자세히 보기)
    @Override
    public List<MatchingRequestDTO> listStorenRequestTab(int transaction_id, String transaction_type) {
        System.out.println("== MypageMatching Service : listStorenRequestTab : START ==");
        try {
            // dao객체 생성
            IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);

            System.out.println("거래 ID: " + transaction_id);
            System.out.println("거래 타입: " + transaction_type);

            List<MatchingRequestDTO> matchingList = matchingDao.listRequestByTransactionIdType(transaction_id, transaction_type);

            System.out.println("조회된 매칭 수: " + (matchingList != null ? matchingList.size() : 0));
            System.out.println("== MypageMatching Service : listStorenRequestTab : END ==");

            return matchingList;
        } catch (Exception e) {
            System.out.println("오류 발생: " + e.getMessage());
            e.printStackTrace();
            System.out.println("== MypageMatching Service : listStorenRequestTab : END ==");
            return new ArrayList<>();
        }
    }

    // 스토렌 사용자 탭(상세페이지 아니라 내가 매칭신청한 스토렌 장비 리스트 조회)
    @Override
    public List<StorenDTO> listStorenUserTab(int user_code) {
        System.out.println("== MypageMatching Service : listStorenUserTab : START ==");
        try {
            // dao객체 생성
            IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
            IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

            // 사용자가 신청한 모든 스토렌 정보 조회
            List<StorenDTO> storenList = storenDAO.listMyStorenApplicationsByUserCode(user_code);

            System.out.println("storenList size : " + storenList.size());

            // 각 스토렌에 장비 정보 설정
            if (storenList != null) {
                for (StorenDTO storen : storenList) {
                    // NullPointerException 방지
                    if (storen != null && storen.getEquip_code() != 0) {
                        EquipmentDTO equipment = equipDao.getEquipmentByEquipCode(storen.getEquip_code());
                        storen.setEquipmentDTO(equipment);
                    }
                }
            }

            System.out.println("== MypageMatching Service : listStorenUserTab : END ==");
            return storenList != null ? storenList : new ArrayList<>();
        } catch (Exception e) {
            System.err.println("스토렌 유저 탭 데이터 로드 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>(); // 빈 리스트 반환
        }
    }

    // 스토렌 사용자 탭 - 상세정보 테이블(매칭 승인된 내 신청 정보 조회)
    @Override
    public MatchingRequestDTO getStorenUserApproved(int user_code, int transaction_id) {
        System.out.println("== MypageMatching Service : getStorenUserApproved : START ==");

        IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);

        // 리스트로 반환하지만, 해당 스토렌id에 신청승인되는 건은 하나밖에 없으므로 인덱스는 [0]밖에 없을 것이다.
        List<MatchingRequestDTO> matchingList = matchingDao.listRequestByTransactionIdType(transaction_id, "스토렌_매칭완료");

        for (int i = 0; i < matchingList.size(); i++) {
            if (matchingList.get(i).getUser_code() == user_code) {
                System.out.println("== MypageMatching Service : getStorenUserApproved : END ==");
                return matchingList.get(i);
            }
        }

        System.out.println("== MypageMatching Service : getStorenUserApproved : END ==");
        return null;
    }

    // 스토렌 소유자 탭 - 상세정보 테이블 - 매칭 승인
    @Transactional // 트랜잭션 처리
    @Override
    public Boolean approveMatchingRequest(int transaction_id, int request_id) {
        System.out.println("== MypageMatching Service : approveMatchingRequest : START ==");

        IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);
        try {
            // 1. 선택된 매칭 정보를 완료 테이블에 삽입
            int insertResult = matchingDao.insertStorenMatchingDone(request_id);

            if (insertResult <= 0) {
                return false; // 매칭 정보 삽입 실패
            }

            // 2. 다른 매칭 요청 삭제 (결과 값은 삭제된 행의 수이므로 0일 수도 있음)
            matchingDao.deleteOtherStorenRequests(transaction_id, request_id);

            System.out.println("== MypageMatching Service : approveMatchingRequest : END ==");

            return true; // 모든 작업 성공
        } catch (Exception e) {
            System.out.println("매칭 승인 처리 중 오류 발생: " + e.getMessage());
            // 예외 발생 시 롤백 (Spring의 @Transactional에 의해 자동 처리)
            throw e;
        }
    }

    // 스토렌 사용자 탭 - 상세정보 테이블 - 매칭 신청 취소(매칭승인대기 단계에서만 활성화되는 버튼)
    @Override
    public Boolean cancleMatchingRequest(int transaction_id, int request_id) {
        System.out.println("== MypageMatching Service : cancleMatchingRequest : START ==");

        IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);
        try {
            // 취소할 매칭 정보를 테이블에서 삭제
            matchingDao.deleteStorenMatchingRequest(transaction_id, request_id);
            System.out.println("== MypageMatching Service : cancleMatchingRequest : EMD ==");
            return true; // 모든 작업 성공
        } catch (Exception e) {
            System.out.println("매칭 승인 처리 중 오류 발생: " + e.getMessage());
            return false;
        }
    }
}
