package com.team.mvc.Service;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IRentalSearchService;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RentalSearchService implements IRentalSearchService {

    @Autowired
    private SqlSession sqlSession;


    @Override
    public List<StorenDTO> listStoren() {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO  equipDAO = sqlSession.getMapper(IEquipmentDAO.class);

        List<EquipmentDTO> equipList = equipDAO.listEquip();

        List<StorenDTO> storenList = storenDAO.listStoren();

        Map<Integer, EquipmentDTO> equipmentMap = equipList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equip -> equip));

        for (StorenDTO dto : storenList) {
            EquipmentDTO equip = equipmentMap.get(dto.getEquip_code());
            dto.setEquipmentDTO(equip);
        }

        return storenList;
    }


    @Override
    public List<StorenDTO> searchStorenKeyword(String searchKeyword) {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipDAO = sqlSession.getMapper(IEquipmentDAO.class);

        if (searchKeyword == null) {
            searchKeyword = ""; // null 대신 빈 문자열 사용
        }

        // 스토렌 장비 검색
        List<StorenDTO> storenList = storenDAO.searchStorenKeyword(searchKeyword);

        // 장비 정보 추가
        List<EquipmentDTO> equipList = equipDAO.listEquip();
        Map<Integer, EquipmentDTO> equipmentMap = equipList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equip -> equip));

        for (StorenDTO dto : storenList) {
            EquipmentDTO equip = equipmentMap.get(dto.getEquip_code());
            dto.setEquipmentDTO(equip);
        }

        return storenList;
    }

}
