package com.team.mvc.Interface;

import com.team.mvc.DTO.AttachmentDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IAttachmentDAO {
    // 첨부파일 등록
    int insertAttachment(AttachmentDTO dto);

    // 장비 코드로 첨부파일 목록 조회
    List<AttachmentDTO> listAttachmentByEquipCode(@Param("equipCode") int equipCode);


}
