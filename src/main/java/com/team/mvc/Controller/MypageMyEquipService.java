package com.team.mvc.Controller;

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
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 사용자의 해당 장비의 모든 스토렌 정보 리스트
        Map<Integer, List<StorenDTO>> storenMap = new HashMap<>();
        // 사용자의 첫등록 스토렌 정보 리스트
        List<StorenDTO> firstStorenList = new ArrayList<StorenDTO>();
        // 사용자의 모든 스토렌 정보 조회
        List<StorenDTO> storenList = storenDAO.listByUserCode(user_code);
        // 사용자의 모든 장비 정보 조회
        List<EquipmentDTO> equipmentList = equipDao.listByUserCode(user_code);

        for (EquipmentDTO equipment : equipmentList) {
            firstStorenList.add(storenDAO.getStorenByEquipCode(user_code, equipment.getEquip_code()));
        }

        //equipmentList를 장비 코드로 쉽게 검색할 수 있는 Map으로 변환
        Map<Integer, EquipmentDTO> equipmentMap = equipmentList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equipment -> equipment));

        // 각 storenDTO에 해당하는 equipmentDTO 설정
        for (int i = 0; i < storenList.size(); i++) {
            firstStorenList.add(storenDAO.getStorenByEquipCode(user_code, storenList.get(i).getEquip_code()));
            EquipmentDTO equipment = equipmentMap.get(firstStorenList.get(i).getEquip_code());
            firstStorenList.get(i).setEquipmentDTO(equipment);
            storenMap.put(firstStorenList.get(i).getEquip_code(), storenDAO.listByUserCodeEquipCode(user_code, firstStorenList.get(i).getEquip_code()));
        }

        return new MyEquipDTO(equipmentList, storenMap, firstStorenList);
    }
}
