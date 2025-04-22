package com.team.mvc.Service;

import com.team.mvc.DTO.BoardPostDTO;
import com.team.mvc.DTO.ReplyDTO;
import com.team.mvc.Interface.IBoardPostDAO;
import com.team.mvc.Interface.IMypageMypostService;
import com.team.mvc.Interface.IReplyDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageMypostService implements IMypageMypostService {

    @Autowired
    SqlSession sqlSession;

    @Override
    public int getUserPostCount(BoardPostDTO dto) {
        //dao 생성
        IBoardPostDAO boardPostDAO = sqlSession.getMapper(IBoardPostDAO.class);

        return boardPostDAO.getUserPostCount(dto);
    }

    @Override
    public List<BoardPostDTO> getUserPostList(BoardPostDTO dto) {
        //dao 생성
        IBoardPostDAO boardPostDAO = sqlSession.getMapper(IBoardPostDAO.class);

        return boardPostDAO.listUserPostByDTO(dto);
    }

    @Override
    public int getUserReplyCount(BoardPostDTO dto) {
        //dao 생성
        IReplyDAO replyDAO = sqlSession.getMapper(IReplyDAO.class);

        return replyDAO.getUserReplyCount(dto);
    }

    @Override
    public List<ReplyDTO> getUserReplyList(BoardPostDTO dto) {
        //dao 생성
        IReplyDAO replyDAO = sqlSession.getMapper(IReplyDAO.class);

        return replyDAO.listUserReplyByDTO(dto);
    }
}
