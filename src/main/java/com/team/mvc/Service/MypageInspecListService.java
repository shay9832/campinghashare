package com.team.mvc.Service;

import com.team.mvc.DTO.DeliveryDTO;
import com.team.mvc.DTO.MypageInspecListDTO;
import com.team.mvc.Interface.IDeliveryDAO;
import com.team.mvc.Interface.IMypageInspecListDAO;
import com.team.mvc.Interface.IMypageInspecListService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageInspecListService implements IMypageInspecListService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<MypageInspecListDTO> listStorenStoreInspec(int user_code) {
        IMypageInspecListDAO dao = sqlSession.getMapper(IMypageInspecListDAO.class);
        List<MypageInspecListDTO> list = dao.listStorenStoreByUserCode(user_code);
        return list;
    }

    @Override
    public List<MypageInspecListDTO> listStorenReturnInspec(int user_code) {
        IMypageInspecListDAO dao = sqlSession.getMapper(IMypageInspecListDAO.class);
        List<MypageInspecListDTO> list = dao.listStorenReturnByUserCode(user_code);
        return list;
    }

    @Override
    public List<MypageInspecListDTO> listStorageStoreInspec(int user_code) {
        IMypageInspecListDAO dao = sqlSession.getMapper(IMypageInspecListDAO.class);
        List<MypageInspecListDTO> list = dao.listStorageStoreByUserCode(user_code);
        return list;
    }
}
