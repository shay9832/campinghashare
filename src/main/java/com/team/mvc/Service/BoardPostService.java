package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.IBoardPostDAO;
import com.team.mvc.Interface.IBoardPostService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardPostService implements IBoardPostService {

    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private ReplyService replyService;

    @Override
    public List<BoardPostDTO> listPostList(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listPostList(dto);
    }

    @Override
    public List<BoardPostDTO> listTotalNotice() {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.listTotalNotice();
    }

    @Override
    public int getTotalNoticeCount(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getTotalNoticeCount(dto);
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
        int result = dao.insertPost(dto);
        System.out.println("서비스 계층 - 게시글 ID: " + dto.getPostId() + ", 반환 결과: " + result);
        return dto.getPostId();
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


    @Override
    public List<BoardPostDTO> getPostLabelsByBoardId(int boardId) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getPostLabelsByBoardId(boardId);
    }

    @Override
    public boolean checkRecommend(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.checkRecommend(dto);
    }

    @Override
    public int insertRecommend(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.insertRecommend(dto);
    }

    @Override
    public int getRecommendCount(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.getRecommendCount(dto);
    }

    @Override
    public int insertHotPostLog(BoardPostDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);

        // getPostById를 호출하여 최신 게시글 정보 조회
        BoardPostDTO currentPost = getPostById(dto);
        int recommendCount = currentPost.getRecommendCount();

        // 추천수가 50 이상인 경우에만 HOT_POST_LOG 테이블에 기록
        if (recommendCount >= 50) {
            return dao.insertHotPostLog(dto);
        }

        return 0; // 추천수가 50 미만이면 아무 작업도 하지 않음

    }

    // 게시글 삭제 시 댓글도 함께 삭제
    @Transactional
    public boolean deletePostWithReplies(int postId) {
        // 1. 해당 게시글의 모든 댓글 조회 및 삭제
        List<ReplyDTO> replies = getRepliesByPostId(postId);
        for (ReplyDTO reply : replies) {
            replyService.deleteReply(reply.getReplyId());
        }

        // 2. 게시글 삭제
        BoardPostDTO postDTO = new BoardPostDTO();
        postDTO.setPostId(postId);
        int result = deletePost(postDTO);

        return result > 0;
    }

    // 첨부파일 추가
    @Override
    public int insertAttachment(AttachmentDTO dto) {
        IBoardPostDAO dao = sqlSession.getMapper(IBoardPostDAO.class);
        return dao.insertAttachment(dto);
    }

}
