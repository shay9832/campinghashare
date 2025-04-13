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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@Service
public class MypageMatchingService implements IMypageMatchingService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<StorenDTO> listStroenOwnerTab(int user_code) {
        System.out.println("== MypageMatching Service : listStroenOwnerTab : START ==");

        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> equipmentList = equipDao.listByUserCode(user_code);
        // 사용자의 모든 스토렌 정보 조회
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

    @Override
    public List<StorenDTO> listStorenUserTab(int user_code) {
        System.out.println("== MypageMatching Service : listStorenUserTab : START ==");

        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> equipmentList = equipDao.listByUserCode(user_code);
        // 사용자의 모든 스토렌 정보 조회
        List<StorenDTO> storenList = storenDAO.listMyStorenApplicationsByUserCode(user_code);

        //equipmentList를 장비 코드로 쉽게 검색할 수 있는 Map으로 변환
        Map<Integer, EquipmentDTO> equipmentMap = equipmentList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equipment -> equipment));

        // 스토렌 리스트의 각 storenDTO에 해당하는 equipmentDTO 설정
        for (StorenDTO storen : storenList) {
            EquipmentDTO equipment = equipmentMap.get(storen.getEquip_code());
            storen.setEquipmentDTO(equipment);
        }

        System.out.println("== MypageMatching Service : listStorenUserTab : END ==");

        return storenList;
    }

    @Override
    public MatchingRequestDTO getStorenUserApproved(int user_code, int transaction_id) {
        System.out.println("== MypageMatching Service : getStorenUserApproved : START ==");

        IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);

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
}
