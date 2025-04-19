package com.team.mvc.Service;

import com.team.mvc.DTO.ReplyDTO;
import com.team.mvc.Interface.IReplyDAO;
import com.team.mvc.Interface.IReplyService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService implements IReplyService {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public int insertReply(ReplyDTO replyDTO) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.insertReply(replyDTO);
    }

    @Override
    public int deleteReply(int replyId) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.deleteReply(replyId);
    }

    @Override
    public ReplyDTO getReplyById(int replyId) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.getReplyById(replyId);
    }
}
