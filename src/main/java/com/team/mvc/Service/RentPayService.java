package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RentPayService implements IRentPayService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public MyPayDTO getMyPayInfo(int transactionId, int user_code, String transactionType) {

        // dao 생성
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IMatchingRequestDAO matchingRequestDAO = sqlSession.getMapper(IMatchingRequestDAO.class);
        ICouponDAO couponDAO = sqlSession.getMapper(ICouponDAO.class);

        //사용자 유저 정보
        UserDTO userDTO = userDAO.getUserByUserCode(user_code);

        //장비 정보(렌탈거래 렌탈비 결제까지 한다면 transactionType에 따라 분기하기)
        StorenDTO storenDTO = storenDAO.getStorenByStorenId(transactionId);
        // 해당 스토렌에 장비정보 넣어주기
        storenDTO.setEquipmentDTO(equipmentDAO.getEquipmentByEquipCode(storenDTO.getEquip_code()));

        //매칭 정보
        MatchingRequestDTO MatchingRequestDTO = matchingRequestDAO.getMatchingByStorenAndUser(transactionId, user_code);
        //쿠폰 정보
        List<CouponDTO> couponList = couponDAO.listValidCouponByUserCode(user_code);

        //최종 반환할 dto
        MyPayDTO myPayDTO = new MyPayDTO(userDTO, couponList, storenDTO, MatchingRequestDTO);

        return myPayDTO;
    }

    @Override
    public boolean payResult(int pay_method_id, int transaction_id, int pay_amount) {
        IAdminPaymentDAO adminPaymentDAO = sqlSession.getMapper(IAdminPaymentDAO.class);

        int result = adminPaymentDAO.insertPayment(pay_method_id, transaction_id, pay_amount);

        if (result == 1) {return true;}
        else {return false;}
    }
}
