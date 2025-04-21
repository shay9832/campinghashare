package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class MypageMainService implements IMypageMainService {

    @Autowired
    SqlSession sqlSession;

    @Override
    public UserDTO getUserDTO(int userCode) {
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        return userDAO.getUserByUserCode(userCode);
    }

    @Override
    public Map<String, Object> getMyEquipmentMap(int userCode) {
        // 최근 등록 장비 3건(일반장비+스토렌)
        // 추후 렌탈과 보관 장비 추가 필요.

        // dao 생성
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        // 반환할 LinkedHashMap 변수 생성(순서 유지 위해)
        LinkedHashMap<String, Object> result = new LinkedHashMap<>();

        /* 최근 등록 장비 3건(일반장비+스토렌) */
        List<EquipmentDTO> recentEquip = equipmentDAO.listRecentEquipmentByUserCode(userCode, 3);
        for (EquipmentDTO equipment : recentEquip) {
            // 일단 첨부파일 넣어주기
            List<AttachmentDTO> attachmentDAOList = attachmentDAO.listAttachmentByEquipCode(equipment.getEquip_code());
            if (!attachmentDAOList.isEmpty()) {
                equipment.setAttachments(attachmentDAOList);
            }
            // 해당 장비가 스토렌인지 (최근 스토렌) 검색
            StorenDTO storenDTO = storenDAO.getStorenByEquipCode(userCode, equipment.getEquip_code());
            if (storenDTO == null) {
                // 스토렌이 아니라면 -> 스토렌으로 등록되지 않은 일반장비.
                result.put("general", equipment);
            }
            else {
                // 스토렌이라면 -> 스토렌으로 등록된 장비.
                // 스토렌에 equipmentDTO 넣어주기
                storenDTO.setEquipmentDTO(equipment);
                result.put("storen", storenDTO);
            }
        }

        return result;
    }

    @Override
    public Map<String, Object> getRentEquipmentMap(int userCode) {
        //  최근 대여 장비 3건(스토렌)만 조회.
        // 추후 렌탈 장비 추가 필요. (렌탈 추가 고려해 반환형을 Map으로 설정)

        // dao 생성
        IMatchingRequestDAO matchingRequestDAO = sqlSession.getMapper(IMatchingRequestDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        // 반환할 LinkedHashMap 변수 생성(순서 유지 위해)
        LinkedHashMap<String, Object> result = new LinkedHashMap<>();

        /* 최근 대여 장비 3건(스토렌) */
        // 최근 대여 정보 먼저 구하기(userCode로 매칭승인되었으며, 결제대기/결제완료 상태인 대여 정보 중 최근 3건)
        List<MatchingRequestDTO> matchingRequestDTOList = matchingRequestDAO.listRecentStorenMatchingByUserCode(userCode, 3);
        for (MatchingRequestDTO matchingRequestDTO : matchingRequestDTOList) {
            // 최근 대여한 스토렌id를 통해 스토렌 장비 정보 얻어오기
            StorenDTO storenDTO = storenDAO.getStorenByStorenId(matchingRequestDTO.getTransaction_id());
            if (storenDTO != null) {
                // 해당 스토렌의 equipmentDTO 찾기
                EquipmentDTO equip = equipmentDAO.getEquipmentByEquipCode(storenDTO.getEquip_code());
                if (equip != null) {
                    // 첨부파일 넣어주기
                    List<AttachmentDTO> attachmentDTOList = attachmentDAO.listAttachmentByEquipCode(equip.getEquip_code());
                    if (!attachmentDTOList.isEmpty()) {
                        equip.setAttachments(attachmentDTOList);
                    }
                    // 해당 스토렌에 equipmentDTO 넣어주기
                    storenDTO.setEquipmentDTO(equip);
                    // 첨부파일 있든 없든 일단 해당 스토렌은 결과반환할 map에 넣어주기
                    result.put("storen", storenDTO);
                }
            }
        }
        return result;
    }

    @Override
    public Map<String, Object> getPostCommentMap(int userCode) {
        return Map.of();
    }

    @Override
    public Map<String, Map<String, Object>> getMyEquipmentStatus(int userCode) {
        return Map.of();
    }

    @Override
    public List<StorenDTO> getMyWishlist(int userCode) {
        return List.of();
    }
}
