package com.team.mvc.Service;

import com.team.mvc.DTO.AdminDTO;
import com.team.mvc.Interface.IAdminDAO;
import com.team.mvc.Interface.IAdminService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService implements IAdminService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public AdminDTO getAdminById(String adminId) {
        IAdminDAO dao = sqlSession.getMapper(IAdminDAO.class);
        return dao.getAdminById(adminId);
    }
}
