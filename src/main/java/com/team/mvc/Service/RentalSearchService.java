package com.team.mvc.Service;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IRentalSearchService;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
        IEquipmentDAO equipDAO = sqlSession.getMapper(IEquipmentDAO.class);

        List<StorenDTO> storenList = storenDAO.listStoren();
        List<EquipmentDTO> equipList = equipDAO.listEquip();

        // 장비 정보 매핑
        Map<Integer, EquipmentDTO> equipmentMap = equipList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code
                        , equip -> equip
                        , (existing, replacement) -> existing));

        for (StorenDTO dto : storenList) {
            EquipmentDTO equip = equipmentMap.get(dto.getEquip_code());
            dto.setEquipmentDTO(equip);
        }

        // 중복 제거 (STOREN_ID 기준)
        return new ArrayList<>(storenList.stream()
                .collect(Collectors.toMap(
                        StorenDTO::getStoren_id,
                        dto -> dto,
                        (existing, replacement) -> existing))
                .values());
    }

    @Override
    public List<StorenDTO> searchStorenKeyword(String searchKeyword) {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipDAO = sqlSession.getMapper(IEquipmentDAO.class);

        List<StorenDTO> storenList = storenDAO.searchStorenKeyword(searchKeyword);
        List<EquipmentDTO> equipList = equipDAO.listEquip();

        // 장비 정보 매핑
        Map<Integer, EquipmentDTO> equipmentMap = equipList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equip -> equip, (existing, replacement) -> existing));

        for (StorenDTO dto : storenList) {
            EquipmentDTO equip = equipmentMap.get(dto.getEquip_code());
            dto.setEquipmentDTO(equip);
        }

        // 중복 제거 (STOREN_ID 기준)
        return new ArrayList<>(storenList.stream()
                .collect(Collectors.toMap(
                        StorenDTO::getStoren_id,
                        dto -> dto,
                        (existing, replacement) -> existing))
                .values());
    }

}
