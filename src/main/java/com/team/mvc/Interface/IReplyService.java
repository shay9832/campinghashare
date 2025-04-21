package com.team.mvc.Interface;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.ReplyDTO;

import java.util.List;

public interface IReplyService {
    // 댓글 추가
    int insertReply(ReplyDTO replyDTO);

    // 댓글 삭제
    int deleteReply(int replyId);

    // 댓글 조회
    ReplyDTO getReplyById(int replyId);

    // 댓글 첨부파일 추가
    int insertReplyAttachment(AttachmentDTO dto);

    // 댓글 ID로 첨부파일 조회
    List<AttachmentDTO> getAttachmentsByReplyId(int replyId);

    // 첨부파일 삭제
    int deleteReplyAttachment(int attachmentReplyId);

    // 댓글 ID로 모든 첨부파일 삭제
    int deleteAttachmentsByReplyId(int replyId);
}
