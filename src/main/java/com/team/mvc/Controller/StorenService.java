package com.team.mvc.Controller;

import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;

import com.team.mvc.Interface.IStorenService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IStorenDAO;

@Service
public class StorenService implements IStorenService {

    // 자동 의존성 주입
    @Autowired
    private SqlSession sqlSession;

    @Override
    public ArrayList<StorenDTO> getStorenListWithEquipment(int userCode) {

        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // 1. 사용자의 모든 스토렌 정보 조회
        ArrayList<StorenDTO> storenList = storenDAO.listByUserCode(userCode);

        // 2. 사용자의 모든 장비 정보 조회
        ArrayList<EquipmentDTO> equipmentList = equipDao.listByUserCode(userCode);

        // 3. equipmentList를 장비 코드로 쉽게 검색할 수 있는 Map으로 변환
        Map<Integer, EquipmentDTO> equipmentMap = equipmentList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equipment -> equipment));

        // 4. 각 storenDTO에 해당하는 equipmentDTO 설정
        for (StorenDTO storen : storenList) {
            int equipCode = storen.getEquip_code();
            EquipmentDTO equipment = equipmentMap.get(equipCode);
            storen.setEquipmentDTO(equipment);
        }

        return storenList;
    }
}