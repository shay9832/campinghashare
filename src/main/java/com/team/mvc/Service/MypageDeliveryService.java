package com.team.mvc.Service;

import com.team.mvc.DTO.DeliveryDTO;
import com.team.mvc.Interface.IDeliveryDAO;
import com.team.mvc.Interface.IEquipmentDAO;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;

public class MypageDeliveryService implements IDeliveryDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public ArrayList<DeliveryDTO> listByUserCode(int user_code) {

        System.out.println("== MypageDelivery Service : listByUserCode : START ==");
        // dao객체 생성
        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);

        System.out.println("== MypageDelivery Service : listByUserCode : END ==");
        return deliveryDao.listByUserCode(user_code);
    }
}
