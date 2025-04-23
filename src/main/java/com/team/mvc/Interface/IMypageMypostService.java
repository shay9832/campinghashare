package com.team.mvc.Interface;

import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.ReplyDTO;

import java.util.List;

public interface IMypageMypostService {

    //사용자가 작성한 게시글 수 조회
    int getUserPostCount(BoardPostDTO dto);

    //사용자가 작성한 게시글 목록 조회
    List<BoardPostDTO> getUserPostList(BoardPostDTO dto);

    //사용자가 작성한 댓글 수 조회
    int getUserReplyCount(BoardPostDTO dto);

    //사용자가 작성한 댓글 목록 조회
    List<ReplyDTO> getUserReplyList(BoardPostDTO dto);
}
