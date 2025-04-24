package com.team.mvc.Service;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.ReplyDTO;
import com.team.mvc.Interface.IReplyDAO;
import com.team.mvc.Interface.IReplyService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    @Override
    public int insertReplyAttachment(AttachmentDTO dto) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.insertReplyAttachment(dto);
    }

    @Override
    public List<AttachmentDTO> getAttachmentsByReplyId(int replyId) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.getAttachmentsByReplyId(replyId);
    }

    @Override
    public int deleteReplyAttachment(int attachmentReplyId) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.deleteReplyAttachment(attachmentReplyId);
    }

    @Override
    public int deleteAttachmentsByReplyId(int replyId) {
        IReplyDAO dao = sqlSession.getMapper(IReplyDAO.class);
        return dao.deleteAttachmentsByReplyId(replyId);
    }

}
