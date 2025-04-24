package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RentPayService implements IRentPayService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public MyPayDTO getMyPayInfo(int storenId, int user_code, String transactionType) {

        // 로그 추가
        System.out.println("storenId: " + storenId);
        System.out.println("user_code: " + user_code);

        // dao 생성
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IEquipmentDAO equipmentDAO = sqlSession.getMapper(IEquipmentDAO.class);
        IMatchingRequestDAO matchingRequestDAO = sqlSession.getMapper(IMatchingRequestDAO.class);
        ICouponDAO couponDAO = sqlSession.getMapper(ICouponDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        //사용자 유저 정보
        UserDTO userDTO = userDAO.getUserByUserCode(user_code);

        //장비 정보(렌탈거래 렌탈비 결제까지 한다면 transactionType에 따라 분기하기)
        StorenDTO storenDTO = storenDAO.getStorenByStorenId(storenId);
        // 해당 스토렌에 장비정보 넣어주기
        storenDTO.setEquipmentDTO(equipmentDAO.getEquipmentByEquipCode(storenDTO.getEquip_code()));
        // 장비 사진 넣어주기
        List<AttachmentDTO> attachmentDTOList = attachmentDAO.listAttachmentByEquipCode(storenDTO.getEquip_code());
        if (attachmentDTOList != null && !attachmentDTOList.isEmpty()) {
            storenDTO.getEquipmentDTO().setAttachments(attachmentDTOList);
        }

        //매칭 정보
        MatchingRequestDTO matchingRequestDTO = matchingRequestDAO.getMatchingByStorenAndUser(storenId, user_code);
        // matchingRequestDTO가 null인지 확인
        if (matchingRequestDTO == null) {
            System.out.println("매칭 정보가 없습니다.");
        } else {
            System.out.println("매칭 정보 있음: " + matchingRequestDTO.getMatching_req_id());
        }
        //쿠폰 정보
        List<CouponDTO> couponList = couponDAO.listValidCouponByUserCode(user_code);

        //최종 반환할 dto
        MyPayDTO myPayDTO = new MyPayDTO(userDTO, couponList, storenDTO, matchingRequestDTO);

        return myPayDTO;
    }

    //결제하기 (결제 후 해당 PAY_ID 반환 -> 반환값이 -1이 아니고 0보다 커야만 결제가 제대로 이루어진 것)
    @Override
    public Integer insertPay(String methodName, int requestId, int amount, Integer couponId, String payType) {
        IAdminPaymentDAO adminPaymentDAO = sqlSession.getMapper(IAdminPaymentDAO.class);

        //프로시저의 매개변수로 보낼 파라미터 맵 구성
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("methodName", methodName);
        paramMap.put("requestId", requestId);
        paramMap.put("amount", amount);

        // couponId가 null이 아닐 때만 넣기
        if (couponId != null) {
            paramMap.put("couponId", couponId);
        } else {
            paramMap.put("couponId", null); // 명시적으로 null 넣어줌 (안 넣으면 MyBatis에서 IN 파라미터 바인딩 에러 날 수도 있음)
        }

        paramMap.put("payType", payType);
        paramMap.put("result", -1);          //프로시저의 OUT 파라미터에 초기값 0 지정

        //프로시저 호출
        adminPaymentDAO.insertPayment(paramMap);

        // OUT 파라미터 결과 확인
        Integer result = (Integer) paramMap.get("result");
        System.out.println("result of insertPayment() call : payId = " + result);

        return result;
    }


    // 결제 결과 페이지를 위한 정보 획득 메소드
    @Override
    public MyPayDTO getMyPayResultInfo(int payId, int requestId) {
        MyPayDTO myPayDTO = new MyPayDTO();

        IAdminPaymentDAO adminPaymentDAO = sqlSession.getMapper(IAdminPaymentDAO.class);
        IMatchingRequestDAO matchingRequestDAO = sqlSession.getMapper(IMatchingRequestDAO.class);

        AdminPaymentDTO adminPaymentDTO = adminPaymentDAO.getPaymentById(payId);
        MatchingRequestDTO MatchingRequestDTO = matchingRequestDAO.getMatchingRequestById(requestId);

        if (adminPaymentDTO != null && MatchingRequestDTO != null) {
            myPayDTO.setMatching_request(MatchingRequestDTO);
            myPayDTO.setAdmin_payment(adminPaymentDTO);
        }
        return myPayDTO;
    }

    @Override
    public boolean insertAddress(int requestId, String zipCode, String address1, String address2) {
        // requestId로 userCode 얻어오기
        IMatchingRequestDAO matchingRequestDAO = sqlSession.getMapper(IMatchingRequestDAO.class);
        MatchingRequestDTO matchingRequestDTO =  matchingRequestDAO.getMatchingRequestById(requestId);

        // 주소 수정을 위한 dao 객체
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
        if (matchingRequestDTO != null) {
            int result = userDAO.insertAddress(matchingRequestDTO.getUser_code(), zipCode, address1, address2);
            if (result == 1) {
                return true;
            }
        }
        return false;
    }
}
