package com.team.mvc.Interface;

import com.team.mvc.DTO.PostDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IPostDAO {

    // 게시물 리스트 조회
    List<PostDTO> listPostList(PostDTO dto);

    // 게시물 등록
    int insertPost(PostDTO dto);

    // 게시물 수정
    int updatePost(PostDTO dto);

    // 게시물 삭제
    int deletePost(PostDTO dto);

    // 게시물 조회
    PostDTO getPostById(PostDTO dto);

}
