package com.team.mvc.Service;

import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.IMypageInfoEditService;
import com.team.mvc.Interface.IUserDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MypageInfoEditService implements IMypageInfoEditService {
    @Autowired
    SqlSession sqlSession;

    @Override
    public String getUserIdByUserCode(int UserCode) {
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        return userDAO.getUserIdByUserCode(UserCode);
    }

    @Override
    public boolean checkPassword(int UserCode, String inputPassword) {
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        String userPw = userDAO.getUserPwByUserCode(UserCode);
        return inputPassword.equals(userPw);
    }

    @Override
    public UserDTO getUserInfoByUserCode(int UserCode) {
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        return userDAO.getUserByUserCode(UserCode);
    }

    @Override
    public void updateMemberInfo(int UserCode, String newNickname, String newEmail) {

    }
}
