package com.team.mvc.Interface;

import com.team.mvc.DTO.BoardPostDTO;

import java.util.List;

public interface IBoardPostService {
    List<BoardPostDTO> listPostList(BoardPostDTO dto);
    List<BoardPostDTO> listNotice();
    List<BoardPostDTO> listHotPost(int boardId);
    List<BoardPostDTO> listTotalHotPost(BoardPostDTO dto);
    int getTotalPostCount(BoardPostDTO dto);
    int insertPost(BoardPostDTO dto);
    int updatePost(BoardPostDTO dto);
    int deletePost(BoardPostDTO dto);
    BoardPostDTO getPostById(BoardPostDTO dto);
}
