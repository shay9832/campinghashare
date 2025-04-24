package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

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

            // 사진 넣어주기
            List<AttachmentDTO> attachmentDTOList = attachmentDAO.listAttachmentByEquipCode(equipCode);
            if (attachmentDTOList != null && !attachmentDTOList.isEmpty()) {
                equipment.setAttachments(attachmentDTOList);
            }

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

    @Override
    public Map<String, Map<String, Integer>> getRentEquipmentStatus(int userCode) {
        System.out.println("== MypageMyEquip Service : getMyEquipmentStatus : START ==");

        // DAO 생성
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 최종 결과 변수
        Map<String, Map<String, Integer>> equipmentStatus = new HashMap<>();

        // 스토렌의 매칭상태 현황 가져오기
        Map<String, Object> storenStatusRaw = storenDAO.getStorenMatchingStatus(userCode);
        Map<String, Integer> storenStatus = new LinkedHashMap<>();

        // 원하는 순서대로 키 배열 정의
        String[] orderedKeys = {
                "매칭중", "매칭승인대기", "렌탈비결제전",
                "렌탈비결제완료", "배송중", "대여중", "반납일임박",
                "반납중", "검수중", "거래완료", "추가비용결제필요", "상태불명"
        };

        // 정의된 순서대로 맵에 삽입
        for (String key : orderedKeys) {
            Object value = storenStatusRaw.get(key);
            System.out.println(key + " : " + value);
            int count = (value instanceof BigDecimal) ? ((BigDecimal) value).intValue() : 0;
            storenStatus.put(key, count);
        }

        equipmentStatus.put("storen", storenStatus);

        //System.out.println(storenStatus.getOrDefault("강제 반환", 0));

        // 즉시 확인 필요 상태 현황 만들기
        Map<String, Integer> emergencyStatus = new HashMap<>();
        emergencyStatus.put("렌탈비 결제 필요", storenStatus.getOrDefault("렌탈비결제전", 0));
        emergencyStatus.put("추가 비용 결제 필요", storenStatus.getOrDefault("추가비용결제필요", 0));
        emergencyStatus.put("문제 상황 발생", storenStatus.getOrDefault("상태불명", 0));

        equipmentStatus.put("emergency", emergencyStatus);

        // 총 개수 만들기
        int storenTotal = 0;
        for (Integer value : storenStatus.values()) {
            storenTotal += value;
        }
        Map<String, Integer> storenCountMap = new HashMap<>();
        storenCountMap.put("storen", storenTotal);
        equipmentStatus.put("count", storenCountMap);

        System.out.println("== MypageMyEquip Service : getMyEquipmentStatus : END ==");
        return equipmentStatus;
    }
}
