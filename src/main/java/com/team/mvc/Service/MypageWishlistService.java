package com.team.mvc.Service;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IMypageWishlistService;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageWishlistService implements IMypageWishlistService {

    @Autowired
    SqlSession sqlSession;

    @Override
    public List<StorenDTO> listMyWishStoren(int userCode) {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        // 나의 찜 목록 만들기(스토렌)
        List<StorenDTO> storenList = storenDAO.listMyWishByUserCode(userCode);

        //System.out.println("storenList: " + storenList);

        // 해당 스토렌에 equipmentDTO와 사진(첨부파일) 세팅해주기
        for (StorenDTO storenDTO : storenList) {
            EquipmentDTO equipmentDTO = equipmentDAO.getEquipmentByEquipCode(storenDTO.getEquip_code());
            if (equipmentDTO != null) {
                List<AttachmentDTO> attachments = attachmentDAO.listAttachmentByEquipCode(equipmentDTO.getEquip_code());
                if (!attachments.isEmpty()) {
                    equipmentDTO.setAttachments(attachments);
                }
                storenDTO.setEquipmentDTO(equipmentDTO);
            }
        }
        return storenList;
    }

    @Override
    public Boolean deleteMyWishStoren(int userCode, int id, String type) {
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        if (type.equals("storen")) {
            // 삭제 메소드
            storenDAO.deleteMyWishByUserCodeStorenId(userCode, id);
            return true;
        }
        else    //렌탈의 경우는 추후 추가 예정
        {
            return false;
        }
    }
}
