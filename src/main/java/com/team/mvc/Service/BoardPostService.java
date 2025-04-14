package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.IBoardPostDAO;
import com.team.mvc.Interface.IBoardPostService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public List<BoardPostDTO> listTotalHotPost(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listTotalHotPost(dto);
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

    @Override
    public List<BoardPostDTO> listBestPosts(int limit) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        Map<String, Object> params = new HashMap<>();
        params.put("limit", limit);
        return dao.listBestPosts(params);
    }

    @Override
    public List<BoardPostDTO> listBoardHotPosts(int boardId, int limit) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        Map<String, Object> params = new HashMap<>();
        params.put("boardId", boardId);
        params.put("limit", limit);
        return dao.listBoardHotPosts(params);
    }

    @Override
    public List<BoardDTO> getBoardsByCategoryId(int boardCateId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getBoardsByCategoryId(boardCateId);
    }

    @Override
    public BoardDTO getBoardByName(String boardName) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getBoardByName(boardName);
    }

    @Override
    public int getTotalHotPostCount(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getTotalHotPostCount(dto);
    }

    @Override
    public List<BoardPostDTO> listHotPostsWithRownum(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listHotPostsWithRownum(dto);
    }

    @Override
    public BoardDTO getBoardById(int boardId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getBoardById(boardId);
    }

    @Override
    public int increaseViewCount(int postId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);

        // 게시글 조회수 증가 로그 추가
        PostViewLogDTO viewLog = new PostViewLogDTO();
        viewLog.setPostId(postId);
        viewLog.setUserCode(1); // 임시값, 실제로는 세션에서 가져와야 함

        return dao.insertPostViewLog(viewLog);
    }

    @Override
    public List<AttachmentDTO> getAttachmentsByPostId(int postId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getAttachmentsByPostId(postId);
    }

    @Override
    public List<ReplyDTO> getRepliesByPostId(int postId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getRepliesByPostId(postId);
    }

    @Override
    public int getPrevPostId(int postId, int boardId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);

        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("boardId", boardId);

        Integer prevPostId = dao.getPrevPostId(params);
        return prevPostId != null ? prevPostId : 0;
    }

    @Override
    public int getNextPostId(int postId, int boardId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);

        Map<String, Object> params = new HashMap<>();
        params.put("postId", postId);
        params.put("boardId", boardId);

        Integer nextPostId = dao.getNextPostId(params);
        return nextPostId != null ? nextPostId : 0;
    }
}
