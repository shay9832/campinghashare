package com.team.mvc.Service;

import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.Interface.IBoardPostDAO;
import com.team.mvc.Interface.IBoardPostService;
import com.team.mvc.Interface.ICategoryDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardPostService implements IBoardPostService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<BoardPostDTO> listPostList(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listPostList(dto);
    }

    @Override
    public List<BoardPostDTO> listNotice() {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listNotice();
    }

    @Override
    public List<BoardPostDTO> listHotPost(int boardId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listHotPost(boardId);
    }

    @Override
    public int getTotalPostCount (BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getTotalPostCount(dto);
    }

    @Override
    public int insertPost(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.insertPost(dto);
    }

    @Override
    public int updatePost(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.updatePost(dto);
    }

    @Override
    public int deletePost(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.deletePost(dto);
    }

    @Override
    public BoardPostDTO getPostById (BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getPostById(dto);
    }
}
