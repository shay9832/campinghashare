package com.team.mvc.Interface;

import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.ReplyDTO;
import org.apache.ibatis.annotations.Param;
import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.ReplyDTO;

import java.util.List;

public interface IReplyDAO {
    /**
     * 댓글 추가
     * @param replyDTO 댓글 정보
     * @return 처리 결과
     */
    int insertReply(ReplyDTO replyDTO);

    /**
     * 댓글 삭제
     * @param replyId 댓글 ID
     * @return 처리 결과
     */
    int deleteReply(int replyId);

    /**
     * 댓글 조회
     * @param replyId 댓글 ID
     * @return 댓글 정보
     */
    ReplyDTO getReplyById(int replyId);

    // 댓글 첨부파일 추가
    int insertReplyAttachment(AttachmentDTO dto);

    // 댓글 ID로 첨부파일 조회
    List<AttachmentDTO> getAttachmentsByReplyId(int replyId);

    // 첨부파일 삭제
    int deleteReplyAttachment(int attachmentReplyId);

    // 댓글 ID로 모든 첨부파일 삭제
    int deleteAttachmentsByReplyId(int replyId);

    // 회원코드로 해당 유저가 남긴 댓글 리스트(최근 등록일순으로 count건 수 조회)
    List<ReplyDTO> listRecentReplyByUserCode(@Param("userCode") int userCode, @Param("count") int count);

    // 사용자가 작성한 댓글 전체 수 조회
    int getUserReplyCount(BoardPostDTO dto);

    // 사용자가 작성한 댓글 목록 조회 (페이징 처리)
    List<ReplyDTO> listUserReplyByDTO(BoardPostDTO dto);
}
