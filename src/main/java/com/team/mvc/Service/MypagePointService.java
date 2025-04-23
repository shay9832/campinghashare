package com.team.mvc.Service;

import com.team.mvc.DTO.MyPointDTO;
import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.IMyPointDAO;
import com.team.mvc.Interface.IMypagePointService;
import com.team.mvc.Interface.IUserDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypagePointService implements IMypagePointService {

    @Autowired
    SqlSession sqlSession;

    @Override
    public List<MyPointDTO> listMyPointHistory(int userCode) {
        // dao 생성
        IMyPointDAO myPointDAO = sqlSession.getMapper(IMyPointDAO.class);

        return myPointDAO.listMyPoint(userCode);
    }

    @Override
    public UserDTO getMyPointInfo(int userCode) {
        // dao 생성
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);

        return userDAO.getUserByUserCode(userCode);
    }
}
