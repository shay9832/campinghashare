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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class MypageMyEquipService implements IMypageMyEquipService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public MyEquipDTO listMyEquip(int user_code) {

        System.out.println("== MypageMyEquip Service : listMyEquip : START ==");
        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 일반 장비 탭===================================================================================================
        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> equipmentList = equipDao.listByUserCode(user_code);
        // ===================================================================================================일반 장비 탭

        // 스토렌 장비 탭=================================================================================================
        // 사용자의 모든 스토렌 정보 조회
        List<StorenDTO> storenList = storenDAO.listByUserCode(user_code);

        // 사용자의 해당 장비의 모든 스토렌 정보 리스트
        Map<Integer, List<StorenDTO>> storenMap = new HashMap<>();
        // 사용자의 첫등록 스토렌 정보 리스트
        List<StorenDTO> firstStorenList = new ArrayList<StorenDTO>();

        // 디버깅 콘솔체크
        System.out.println("equipmentList : " + equipmentList.size());
        System.out.println("storenList : " + storenList.size());

        // 사용자가 등록한 일반 장비 개수만큼 첫등록 스토렌 리스트 만들기
        for (EquipmentDTO equipment : equipmentList) {
            firstStorenList.add(storenDAO.getStorenByEquipCode(user_code, equipment.getEquip_code()));
        }

        //equipmentList를 장비 코드로 쉽게 검색할 수 있는 Map으로 변환
        Map<Integer, EquipmentDTO> equipmentMap = equipmentList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equipment -> equipment));

        // 첫등록 스토렌 리스트의 각 storenDTO에 해당하는 equipmentDTO 설정
        for (StorenDTO firstStoren : firstStorenList) {
            EquipmentDTO equipment = equipmentMap.get(firstStoren.getEquip_code());
            firstStoren.setEquipmentDTO(equipment);
        }

        // equip_code에 따라 여러개의 storenId를 넣어주는 map 만들기
        for (int i = 0; i < storenList.size(); i++) {
            storenMap.put(storenList.get(i).getEquip_code(), storenDAO.listByUserCodeEquipCode(user_code, storenList.get(i).getEquip_code()));
        }

        // 디버깅 콘솔체크
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
