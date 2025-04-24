package com.team.mvc.Service;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IRentalSearchService;
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
public class RentalSearchService implements IRentalSearchService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<StorenDTO> listStoren() {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        List<StorenDTO> storenList = storenDAO.listStoren();
        List<EquipmentDTO> equipList = equipDAO.listEquip();

        // 장비 정보 매핑
        Map<Integer, EquipmentDTO> equipmentMap = equipList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equip -> equip, (existing, replacement) -> existing));

        for (StorenDTO dto : storenList) {
            EquipmentDTO equip = equipmentMap.get(dto.getEquip_code());
            if (equip != null) {
                // 첨부파일 가져오기
                List<AttachmentDTO> attachments = attachmentDAO.listAttachmentByEquipCode(equip.getEquip_code());
                if (!attachments.isEmpty()) {
                    equip.setAttachments(attachments);
                }
                dto.setEquipmentDTO(equip);
            }
        }

        // 중복 제거 (STOREN_ID 기준)
        return storenList.stream()
                .collect(Collectors.toMap(
                        StorenDTO::getStoren_id,
                        dto -> dto,
                        (existing, replacement) -> existing))
                .values()
                .stream()
                .collect(Collectors.toList());
    }

    @Override
    public List<StorenDTO> searchStoren(String searchKeyword, int minPrice, int maxPrice, String startDate, String endDate) {
        // dao 생성
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        
        // dao에 넘겨줄 매개변수 맵 구성
        Map<String, Object> params = new HashMap<>();
        params.put("searchKeyword", searchKeyword);
        params.put("minPrice", minPrice);
        params.put("maxPrice", maxPrice);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        System.out.println("검색 파라미터: " + params);
        List<StorenDTO> results = storenDAO.searchStoren(params);
        System.out.println("검색 결과 개수: " + results.size());

        for (StorenDTO dto : results) {
            try {
                EquipmentDTO equip = equipmentDAO.getEquipmentByEquipCode(dto.getEquip_code());
                if (equip != null) {
                    // 첨부파일 가져오기
                    List<AttachmentDTO> attachments = null;
                    try {
                        attachments = attachmentDAO.listAttachmentByEquipCode(equip.getEquip_code());
                    } catch (Exception e) {
                        System.out.println("첨부파일 조회 오류: " + e.getMessage());
                        attachments = new ArrayList<>();
                    }

                    // null 체크
                    if (attachments == null) {
                        attachments = new ArrayList<>();
                    }

                    equip.setAttachments(attachments);
                    dto.setEquipmentDTO(equip);
                }
            } catch (Exception e) {
                System.out.println("장비 정보 처리 오류: " + dto.getEquip_code() + ", " + e.getMessage());
            }
        }

        // 중복 제거(스토렌 id 기준)
        return results.stream()
                .collect(Collectors.toMap(
                        StorenDTO::getStoren_id,
                        dto -> dto,
                        (existing, replacement) -> existing))
                .values()
                .stream()
                .collect(Collectors.toList());
    }

    @Override
    public List<StorenDTO> searchStorenKeyword(String searchKeyword) {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        List<StorenDTO> storenList = storenDAO.searchStorenKeyword(searchKeyword);
        List<EquipmentDTO> equipList = equipDAO.listEquip();

        // 장비 정보 매핑
        Map<Integer, EquipmentDTO> equipmentMap = equipList.stream()
                .collect(Collectors.toMap(EquipmentDTO::getEquip_code, equip -> equip, (existing, replacement) -> existing));

        for (StorenDTO dto : storenList) {
            EquipmentDTO equip = equipmentMap.get(dto.getEquip_code());
            if (equip != null) {
                // 첨부파일 가져오기
                List<AttachmentDTO> attachments = attachmentDAO.listAttachmentByEquipCode(equip.getEquip_code());
                if (!attachments.isEmpty()) {
                    equip.setAttachments(attachments);
                }
                dto.setEquipmentDTO(equip);
            }

        }

        // 중복 제거 (STOREN_ID 기준)
        return storenList.stream()
                .collect(Collectors.toMap(
                        StorenDTO::getStoren_id,
                        dto -> dto,
                        (existing, replacement) -> existing))
                .values()
                .stream()
                .collect(Collectors.toList());
    }

}
