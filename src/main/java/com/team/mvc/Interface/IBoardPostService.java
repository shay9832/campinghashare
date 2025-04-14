package com.team.mvc.Interface;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.BoardDTO;
import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.ReplyDTO;

import java.util.List;

public interface IBoardPostService {
    List<BoardPostDTO> listPostList(BoardPostDTO dto);
    List<BoardPostDTO> listNotice();
    List<BoardPostDTO> listTotalHotPost(BoardPostDTO dto);
    int getTotalPostCount(BoardPostDTO dto);
    int insertPost(BoardPostDTO dto);
    int updatePost(BoardPostDTO dto);
    int deletePost(BoardPostDTO dto);
    BoardPostDTO getPostById(BoardPostDTO dto);
    BoardDTO getBoardByName(String boardName);
    int getTotalHotPostCount(BoardPostDTO dto);
    List<BoardPostDTO> listHotPostsWithRownum(BoardPostDTO dto);
    BoardDTO getBoardById(int boardId);

    // 게시글 조회수 증가
    int increaseViewCount(int postId);

    // 게시글 첨부파일 조회
    List<AttachmentDTO> getAttachmentsByPostId(int postId);

    // 게시글의 댓글 목록 조회
    List<ReplyDTO> getRepliesByPostId(int postId);

    // 이전 게시글 ID 조회
    int getPrevPostId(int postId, int boardId);

    // 다음 게시글 ID 조회
    int getNextPostId(int postId, int boardId);

    List<BoardPostDTO> listBestPosts(int limit);
    List<BoardPostDTO> listBoardHotPosts(int boardId, int limit);
    List<BoardDTO> getBoardsByCategoryId(int boardCateId);
}
