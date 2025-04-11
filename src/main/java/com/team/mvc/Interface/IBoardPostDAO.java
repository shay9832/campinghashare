package com.team.mvc.Interface;

import com.team.mvc.DTO.BoardPostDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IBoardPostDAO {

    // 일반 게시물 리스트 조회
    List<BoardPostDTO> listPostList(BoardPostDTO dto);

    // 전체 인기글 조회
    List<BoardPostDTO> listTotalHotPost(BoardPostDTO dto);

    // 공지사항 조회 (최대 3개)
    List<BoardPostDTO> listNotice();

    // 인기글 조회 (최대 3개)
    List<BoardPostDTO> listHotPost(int boardId);

    // 게시물 총 개수 조회
    int getTotalPostCount(BoardPostDTO dto);

    // 게시물 등록
    int insertPost(BoardPostDTO dto);

    // 게시물 수정
    int updatePost(BoardPostDTO dto);

    // 게시물 삭제
    int deletePost(BoardPostDTO dto);

    // 게시물 조회
    BoardPostDTO getPostById(BoardPostDTO dto);

}
