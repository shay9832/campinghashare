package com.team.mvc.Interface;

import com.team.mvc.DTO.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface IBoardPostDAO {
    // 일반 게시물 리스트 조회
    List<BoardPostDTO> listPostList(BoardPostDTO dto);

    // 전체 인기글 리스트 조회
    List<BoardPostDTO> listTotalHotPost(BoardPostDTO dto);

    // 전체 인기글 중 최신 N개 조회
    List<BoardPostDTO> listBestPosts(Map<String, Object> params);

    // 특정 게시판 인기글 중 최신 N개 조회 (이미지 포함)
    List<BoardPostDTO> listBoardHotPosts(Map<String, Object> params);

    // 게시판 카테고리별 게시판 조회
    List<BoardDTO> getBoardsByCategoryId(int boardCateId);

    // 게시판별 말머리 목록 조회
    List<BoardPostDTO> getPostLabelsByBoardId(int boardId);

    // 전체 공지사항 조회
    List<BoardPostDTO> listTotalNotice();

    // 공지사항 조회 (최대 3개)
    List<BoardPostDTO> listNotice();

    // 공지사항 총 개수 조회
    int getTotalNoticeCount(BoardPostDTO dto);

    //인기글 목록을 원본 글번호와 함께 조회
    List<BoardPostDTO> listHotPostsWithRownum(BoardPostDTO dto);

    // 게시물 총 개수 조회
    int getTotalPostCount(BoardPostDTO dto);

    //인기글 총 개수 조회
    int getTotalHotPostCount(BoardPostDTO dto);

    //게시판 ID로 게시판 정보 조회
    BoardDTO getBoardById(int boardId);

    // 게시글 조회수 증가 로그 추가
    int insertPostViewLog(PostViewLogDTO viewLog);

    // 게시글의 첨부파일 목록 조회
    List<AttachmentDTO> getAttachmentsByPostId(int postId);

    // 게시글의 댓글 목록 조회
    List<ReplyDTO> getRepliesByPostId(int postId);

    // 이전 게시글 ID 조회
    Integer getPrevPostId(Map<String, Object> params);

    // 다음 게시글 ID 조회
    Integer getNextPostId(Map<String, Object> params);

    // 게시물 등록
    int insertPost(BoardPostDTO dto);

    // 게시물 수정
    int updatePost(BoardPostDTO dto);

    // 게시물 삭제
    int deletePost(BoardPostDTO dto);

    // 게시물 조회
    BoardPostDTO getPostById(BoardPostDTO dto);

    // 게시판 이름으로 게시판 정보 조회
    BoardDTO getBoardByName(String boardName);

    // 추천 여부 확인
    boolean checkRecommend(BoardPostDTO dto);

    // 추천 추가
    int insertRecommend(BoardPostDTO dto);

    // 추천 수
    int getRecommendCount(BoardPostDTO dto);

    // 인기글 지정
    int insertHotPostLog(BoardPostDTO dto);

    // 첨부파일 추가
    int insertAttachment(AttachmentDTO dto);

    // 북마크 여부 확인
    boolean checkBookmark(BoardPostDTO dto);

    // 북마크 추가
    int insertBookmark(BoardPostDTO dto);

    // 북마크 제거
    int deleteBookmark(BoardPostDTO dto);

    // 게시글 ID로 북마크 삭제
    int deleteBookmarksByPostId(int postId);

    // 게시글 ID로 추천 삭제
    int deleteRecommendsByPostId(int postId);
}
