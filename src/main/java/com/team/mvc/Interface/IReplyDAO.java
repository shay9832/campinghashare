package com.team.mvc.Interface;

import org.apache.ibatis.annotations.Param;
import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.ReplyDTO;

import java.util.List;

public interface IReplyDAO {
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




    // (250422 은솔) 임시 : 통합 후 컴파일 오류 제거 위해 임시 삽입 ★★★★★
    // 최근 댓글 조회
    List<ReplyDTO> listRecentReplyByUserCode(@Param("userCode") int userCode, @Param("limit") int limit);

}
