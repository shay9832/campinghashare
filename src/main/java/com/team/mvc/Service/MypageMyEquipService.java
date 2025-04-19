package com.team.mvc.Service;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.MyEquipDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IMypageMyEquipService;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MypageMyEquipService implements IMypageMyEquipService {

    @Autowired
    private SqlSession sqlSession;

    // 일반 장비 리스트만 반환
    @Override
    public List<EquipmentDTO> listMyGeneral(int userCode) {
        System.out.println("== MypageMyEquip Service : listMyGeneral : START ==");
        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 일반 장비 탭 (스토렌으로 등록되지 않은 장비만)=======================================================================
        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> allEquipmentList = equipDao.listByUserCode(userCode);
        // 사용자가 가진 스토렌의 장비코드 조회(중복없이)
        List<Integer> storenEquipCodes = storenDAO.listStorenEquipCodes(userCode);

        // 일반 장비 목록에서 스토렌에 등록된 장비를 제외
        //filter()는 스트림 요소를 특정 조건에 해당하는 것만 남기고 나머지는 걸러내는 메소드
        List<EquipmentDTO> equipmentList = allEquipmentList.stream()
                .filter(equip -> !storenEquipCodes.contains(equip.getEquip_code()))
                .toList();              //중복 제거 필요x, 순서 유지 위해 toList()로 모으기

        System.out.println("== MypageMyEquip Service : listMyGeneral : END ==");

        // ===================================================================================================일반 장비 탭
        return equipmentList;
    }

    // 장비 상태 현황 반환(화살표)
    public Map<String, Map<String, Integer>> getMyEquipmentStatus(int userCode) {
        System.out.println("== MypageMyEquip Service : getMyEquipmentStatus : START ==");

        // DAO 생성
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 최종 결과 변수
        Map<String, Map<String, Integer>> equipmentStatus = new HashMap<>();

        // 스토렌 상태 현황 가져오기
        Map<String, Object> storenStatusRaw = storenDAO.getStorenStatus(userCode);
        Map<String, Integer> storenStatus = new LinkedHashMap<>();

        // 원하는 순서대로 키 배열 정의
        String[] orderedKeys = {
                "보관비 결제 대기", "배송 대기", "배송 중", "검수 중",
                "보관 중", "강제 반환", "승인 대기", "결제 대기",
                "렌탈 중", "반납 중", "거래 완료", "최종 반환", "상태 불명"
        };

        // 정의된 순서대로 맵에 삽입
        for (String key : orderedKeys) {
            Object value = storenStatusRaw.get(key);
            int count = (value instanceof BigDecimal) ? ((BigDecimal) value).intValue() : 0;
            storenStatus.put(key, count);
        }

        equipmentStatus.put("storen", storenStatus);

        //System.out.println(storenStatus.getOrDefault("강제 반환", 0));

        // 즉시 확인 필요 상태 현황 만들기
        Map<String, Integer> emergencyStatus = new HashMap<>();
        emergencyStatus.put("보관비 결제 대기", storenStatus.getOrDefault("보관비 결제 대기", 0));
        emergencyStatus.put("검수 결과 확인(입고/반환)", storenStatus.getOrDefault("보관 중", 0)
                                            + storenStatus.getOrDefault("강제 반환", 0));
        emergencyStatus.put("매칭 승인 대기", storenStatus.getOrDefault("승인 대기", 0));
        emergencyStatus.put("문제 상황 발생", storenStatus.getOrDefault("상태 불명", 0));

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

    @Override
    public List<StorenDTO> listMyStoren(int userCode) {
        System.out.println("== MypageMyEquip Service : listMyStoren : START ==");
        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> allEquipmentList = equipDao.listByUserCode(userCode);

        // 사용자의 첫등록 스토렌 정보 리스트
        List<StorenDTO> firstStorenList = new ArrayList<StorenDTO>();

        // 첫등록 스토렌 찾아서 넣어주기
        for (EquipmentDTO equipmentDTO : allEquipmentList) {
            StorenDTO firstStoren = storenDAO.getStorenByEquipCode(userCode, equipmentDTO.getEquip_code());
            if (firstStoren != null) {
                firstStoren.setEquipmentDTO(equipmentDTO);
                firstStorenList.add(firstStoren);
            }
        }

        System.out.println("== MypageMyEquip Service : listMyStoren : END ==");
        return firstStorenList;
    }

    @Override
    public MyEquipDTO listMyEquip(int userCode) {

        System.out.println("== MypageMyEquip Service : listMyEquip : START ==");
        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 일반 장비 탭 (스토렌으로 등록되지 않은 장비만)=======================================================================
        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> allEquipmentList = equipDao.listByUserCode(userCode);
        // 사용자의 모든 스토렌 정보 조회
        List<StorenDTO> storenList = storenDAO.listByUserCode(userCode);

        // 스토렌에 등록된 장비 코드 목록 생성
        /*
        Set<Integer> storenEquipCodes = new HashSet<>();
        for (StorenDTO s : storenList)
        { storenEquipCodes.add(s.getEquip_code()); }
        */
        Set<Integer> storenEquipCodes = storenList.stream() //리스트를 스트림 객체로 변환(리스트 안의 각 요소 처리 위해)
                .map(StorenDTO::getEquip_code)              //*자료구조 Map이 아니다. map()은 스트림 각 요소를 다른 형태로 변환하는 메소드. 각 스토렌DTO 객체에서 equip_code를 추출(equip_code만 가지는 스트림이 됨)
                .collect(Collectors.toSet());               //collect()는 스트림을 모아줌. set은 중복허용X, 스토렌으로 등록된 장비 중 중복없는 equip_code를 Set으로 얻어냄

        // 일반 장비 목록에서 스토렌에 등록된 장비를 제외
                                                            //filter()는 스트림 요소를 특정 조건에 해당하는 것만 남기고 나머지는 걸러내는 메소드
        List<EquipmentDTO> equipmentList = allEquipmentList.stream()
                .filter(equip -> !storenEquipCodes.contains(equip.getEquip_code()))
                .collect(Collectors.toList());              //중복 제거 필요x, 순서 유지 위해 toList()로 모으기

        // ===================================================================================================일반 장비 탭
        // 스토렌 장비 탭 =================================================================================================
        // 사용자의 해당 장비의 모든 스토렌 정보 리스트
        Map<Integer, List<StorenDTO>> storenMap = new HashMap<>();
        // 사용자의 첫등록 스토렌 정보 리스트
        List<StorenDTO> firstStorenList = new ArrayList<StorenDTO>();

        // 디버깅 콘솔체크
        System.out.println("모든 장비 리스트 : " + allEquipmentList.size());
        System.out.println("스토렌 제외 장비 리스트 : " + equipmentList.size());
        System.out.println("storenList : " + storenList.size());

        // 사용자가 등록한 일반 장비 개수만큼 첫등록 스토렌 리스트 만들기
        for (EquipmentDTO equipment : allEquipmentList) {
            StorenDTO firstStoren = storenDAO.getStorenByEquipCode(userCode, equipment.getEquip_code());

            // Null이 아닐 때만 리스트에 추가
            if (firstStoren != null) {
                firstStorenList.add(firstStoren);
            }
        }

        //allEquipmentList를 장비 코드로 쉽게 검색할 수 있는 Map으로 변환
        Map<Integer, EquipmentDTO> equipmentMap = allEquipmentList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equipment -> equipment));

        // 첫등록 스토렌 리스트의 각 storenDTO에 해당하는 equipmentDTO 설정
        for (StorenDTO firstStoren : firstStorenList) {
            if (firstStoren != null) { // Null 체크 추가
                EquipmentDTO equipment = equipmentMap.get(firstStoren.getEquip_code());
                firstStoren.setEquipmentDTO(equipment);
            }
        }

        // equip_code에 따라 여러개의 storenId를 넣어주는 map 만들기
        for (int i = 0; i < storenList.size(); i++) {
            storenMap.put(storenList.get(i).getEquip_code(), storenDAO.listByUserCodeEquipCode(userCode, storenList.get(i).getEquip_code()));
        }

        // 디버깅 콘솔체크(둘의 size가 일치해야함)
        System.out.println("firstStorenList : " + firstStorenList.size());
        System.out.println("storenMap : " + storenMap.size());

        // 디버깅 콘솔체크
        for (int key : storenMap.keySet()) {
            List<StorenDTO> valueList = storenMap.get(key);
            int size = (valueList != null) ? valueList.size() : 0;
            System.out.println("ㄴ Key: " + key + ", value list size: " + size);
        }

        // =================================================================================================스토렌 장비 탭

        System.out.println("== MypageMyEquip Service : listMyEquip : END ==");

        return new MyEquipDTO(equipmentList, storenMap, firstStorenList);

    }
}
