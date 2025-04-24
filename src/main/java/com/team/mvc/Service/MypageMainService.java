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
    @Autowired
    MypageMyEquipService myEquipService;
    @Autowired
    MypageWishlistService mypageWishlistService;

    @Override
    public UserDTO getUserDTO(int userCode) {
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        return userDAO.getUserByUserCodeForMain(userCode);
    }

    @Override
    public LinkedHashMap<String, Object> getMyEquipmentMap(int userCode) {
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
                // key 값을 그냥 "general"이라고만 하면 같은 key일 경우 덮어씌워지므로 고유한 key를 정해준다.
                result.put("general_" + equipment.getEquip_code(), equipment);
                System.out.println(equipment.getEquip_code());
            }
            else {
                // 스토렌이라면 -> 스토렌으로 등록된 장비.
                // 스토렌에 equipmentDTO 넣어주기
                storenDTO.setEquipmentDTO(equipment);
                result.put("storen_" + equipment.getEquip_code(), storenDTO);
                System.out.println(equipment.getEquip_code());
            }
        }
        System.out.println("result size : " + result.size());
        return result;
    }

    @Override
    public LinkedHashMap<String, Object> getRentEquipmentMap(int userCode) {
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
                    // 해당 스토렌에 matchingRequestDTO 넣어주기
                    storenDTO.setMatchingDTO(matchingRequestDTO);
                    // 첨부파일 있든 없든 일단 해당 스토렌은 결과반환할 map에 넣어주기
                    result.put("storen_" + storenDTO.getEquip_code(), storenDTO);
                }
            }
        }
        System.out.println("result size : " + result.size());
        return result;
    }

    @Override
    public Map<String, Object> getPostCommentMap(int userCode) {
        // dao 생성
        IBoardPostDAO boardPostDAO = sqlSession.getMapper(IBoardPostDAO.class);
        IReplyDAO replyDAO = sqlSession.getMapper(IReplyDAO.class);

        // 반환할 Map 변수 생성
        Map<String, Object> result = new LinkedHashMap<>();

        // 최근 등록한 게시물 5개까지 가져오기
        List<BoardPostDTO> postDTOList = boardPostDAO.listRecentPostByUserCode(userCode, 5);

        // 최근 등록한 댓글 5개까지 가져오기
        List<ReplyDTO> replyDTOList = replyDAO.listRecentReplyByUserCode(userCode, 5);
        for (ReplyDTO replyDTO : replyDTOList) {
            // 해당 댓글이 달린 게시물 정보 가져와서 넣어주기
            replyDTO.setReplyPostDTO(boardPostDAO.getPostByPostId(replyDTO.getPostId()));

        }

        result.put("postList", postDTOList);
        result.put("replyList", replyDTOList);

        return result;
    }

    @Override
    public Map<String, Map<String, Integer>> getMyEquipmentStatus(int userCode) {
        Map<String, Map<String, Integer>> equipmentStatus = myEquipService.getMyEquipmentStatus(userCode);
        return equipmentStatus;
    }

    @Override
    public List<StorenDTO> getMyWishlist(int userCode) {
        List<StorenDTO> wishlist = mypageWishlistService.listMyWishStoren(userCode);

        return wishlist;
    }
}
