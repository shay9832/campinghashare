package com.team.mvc.Interface;

import com.team.mvc.DTO.ReplyDTO;
import org.apache.ibatis.annotations.Param;

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


    // 회원코드로 해당 유저가 남긴 댓글 리스트(최근 등록일순으로 count건 수 조회)
    List<ReplyDTO> listRecentReplyByUserCode(@Param("userCode") int userCode, @Param("count") int count);
}
