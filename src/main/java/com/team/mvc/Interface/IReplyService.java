package com.team.mvc.Interface;

import com.team.mvc.DTO.ReplyDTO;

public interface IReplyService {
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
}
