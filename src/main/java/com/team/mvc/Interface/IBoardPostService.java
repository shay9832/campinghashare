package com.team.mvc.Interface;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.BoardDTO;
import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.ReplyDTO;

import java.util.List;
import java.util.Map;

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

    // 전체 공지사항 조회
    List<BoardPostDTO> listTotalNotice();

    // 공지사항 총 개수 조회
    int getTotalNoticeCount(BoardPostDTO dto);

    // 게시판별 말머리 목록 조회
    List<BoardPostDTO> getPostLabelsByBoardId(int boardId);

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


    // 추천 여부 확인
    boolean checkRecommend(BoardPostDTO dto);

    // 추천 추가
    int insertRecommend(BoardPostDTO dto);

    // 추천 수
    int getRecommendCount(BoardPostDTO dto);

    // 인기글 지정
    int insertHotPostLog(BoardPostDTO dto);

    // 게시글 삭제시 댓글 삭제
    boolean deletePostWithReplies(int postId);

    // 첨부파일 추가
    int insertAttachment(AttachmentDTO dto);

    // 첨부파일 제거
    int deleteAttachment(int attachmentId);

    // 북마크 여부 확인
    boolean checkBookmark(BoardPostDTO dto);

    // 북마크 추가
    int insertBookmark(BoardPostDTO dto);

    // 북마크 제거
    int deleteBookmark(BoardPostDTO dto);
}
