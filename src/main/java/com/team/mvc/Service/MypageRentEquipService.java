package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MypageRentEquipService implements IMypageRentEquipService {

    @Autowired
    SqlSession sqlSession;

    @Override
    public MyRentEquipDTO listRentStorenInfo(int userCode) {

        // DAO 객체 생성
        IMatchingRequestDAO matchingRequestDAO = sqlSession.getMapper(IMatchingRequestDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IAdminPaymentDAO adminPaymentDAO = sqlSession.getMapper(IAdminPaymentDAO.class);

        // 결과 객체 생성
        MyRentEquipDTO rentEquipDTO = new MyRentEquipDTO(userCode);

        // 1. 사용자의 모든 매칭 요청 조회 (결제완료된 스토렌 매칭 요청)
        List<MatchingRequestDTO> matchingRequests = matchingRequestDAO.listStorenMatchingByUserCode(userCode);

        // 2. 각 매칭 요청에 대한 상세 정보 구성
        for (MatchingRequestDTO matchingRequest : matchingRequests) {
            MyRentalItemDTO rentalItem = new MyRentalItemDTO();

            // 매칭 요청 정보 설정
            rentalItem.setMatching(matchingRequest);

            // 스토렌 정보 조회 및 설정
            int storenId = matchingRequest.getTransaction_id();
            StorenDTO storen = storenDAO.getStorenByStorenId(storenId);

            // 스토렌의 equipmentDTO 속성 설정
            int equipCode = storen.getEquip_code();
            EquipmentDTO equipment = equipmentDAO.getEquipmentByEquipCode(equipCode);
            storen.setEquipmentDTO(equipment);

            rentalItem.setStoren(storen);

            // 결제 정보 조회 및 설정 (있을 경우)
            if (matchingRequest.getMatching_done_id() > 0) {
                // 결제 정보는 매칭 완료 ID로 조회
                AdminPaymentDTO payment = adminPaymentDAO.getPaymentsByTransactionId("스토렌렌탈", matchingRequest.getMatching_done_id());
                rentalItem.setPayment(payment);
            }

            // 렌탈 항목을 결과 객체에 추가
            rentEquipDTO.addRentalItem(rentalItem);
        }

        return rentEquipDTO;
    }
}
