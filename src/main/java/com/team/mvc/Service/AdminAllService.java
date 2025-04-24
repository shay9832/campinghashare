package com.team.mvc.Service;

import com.team.mvc.DTO.AdminMainDTO;
import com.team.mvc.DTO.AdminUserReportDTO;
import com.team.mvc.Interface.IAdminAllService;
import com.team.mvc.Interface.IAdminMainDAO;
import com.team.mvc.Interface.IAdminUserReportDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminAllService implements IAdminAllService {

    @Autowired
    private SqlSession sqlSession;


    @Override
    public List<AdminUserReportDTO> getList() {
        IAdminUserReportDAO dao = sqlSession.getMapper(IAdminUserReportDAO.class);
        return dao.getList();
    }

    @Override
    public AdminMainDTO count() {
        IAdminMainDAO dao = sqlSession.getMapper(IAdminMainDAO.class);
        return dao.count();
    }




}
