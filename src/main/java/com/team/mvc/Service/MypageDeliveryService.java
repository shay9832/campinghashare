package com.team.mvc.Service;

import com.team.mvc.DTO.DeliveryDTO;
import com.team.mvc.Interface.IDeliveryDAO;
import com.team.mvc.Interface.IMypageDeliveryService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class MypageDeliveryService implements IMypageDeliveryService {

    // 날짜 포맷터 (시간 무시하고 yyyy-MM-dd까지만 비교)
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // 배송 상태 판단 메서드
    private String determineDeliveryStatus(String startDateStr, String endDateStr) {
        try {
            if (startDateStr != null && endDateStr != null) {
                Date startDate = dateFormat.parse(startDateStr);
                Date endDate = dateFormat.parse(endDateStr);

                Date today = dateFormat.parse(dateFormat.format(new Date())); // 오늘 날짜
                if (endDate != null) {
                    return endDate.before(today) || endDate.equals(today) ? "배송완료" : "배송중";
                } else if (startDate != null) {
                    return "배송중";
                } else {
                    return "배송준비중";
                }
            }
            else if (startDateStr != null && endDateStr == null) {
                return "배송준비중";
            }
            else return "추적불가";

        } catch (Exception e) {
            System.out.println(e.toString());
            return "추적불가";
        }
    }

    // 배송 상태 클래스 결정 메서드
    private String getStatusClass(String startDateStr, String endDateStr) {
        try{
            if (startDateStr != null && endDateStr != null) {
                Date startDate = dateFormat.parse(startDateStr);
                Date endDate = dateFormat.parse(endDateStr);

                String status = determineDeliveryStatus(startDateStr, endDateStr);
                switch (status) {
                    case "배송완료":
                        return "status-completed";
                    case "배송중":
                        return "status-progress";
                    case "배송준비중":
                        return "status-pending";
                    default:
                        return "status-unknown";
                }
            }
            else if (startDateStr != null && endDateStr == null) {
                return "status-pending";
            }
            else return "status-unknown";
        } catch (Exception e) {
            System.out.println(e.toString());
            return "status-unknown";
        }

    }

    @Autowired
    private SqlSession sqlSession;

//    @Override
//    public MyDeliveryDTO listByUserCode(int user_code) {
//        System.out.println("== MypageDelivery Service : listByUserCode : START ==");
//        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);
//
//        MyDeliveryDTO myDeliveryDTO = new MyDeliveryDTO();
//        myDeliveryDTO.setStorageDeliveries(deliveryDao.listStorageByUserCode(user_code));
//        myDeliveryDTO.setStorenOwnerDeliveries(deliveryDao.listStorenOwnerByUserCode(user_code));
//        myDeliveryDTO.setStorenUserDeliveries(deliveryDao.listStorenUserByUserCode(user_code));
//        myDeliveryDTO.setRentalDeliveries(deliveryDao.listRentalByUserCode(user_code));
//
//        System.out.println("== MypageDelivery Service : listByUserCode : END ==");
//        return myDeliveryDTO;
//    }

    // AJAX 요청을 위한 개별 메소드들 추가
    @Override
    public List<DeliveryDTO> getStorageDeliveries(int user_code) {
        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);
        List<DeliveryDTO> list = deliveryDao.listStorageByUserCode(user_code);
        for (DeliveryDTO delivery : list) {
            delivery.setStatus(determineDeliveryStatus(delivery.getStart_date(), delivery.getEnd_date()));
            delivery.setStatusClass(getStatusClass(delivery.getStart_date(), delivery.getEnd_date()));
        }
        return list;
    }

    @Override
    public List<DeliveryDTO> getStorenOwnerDeliveries(int user_code) {
        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);
        List<DeliveryDTO> list = deliveryDao.listStorenOwnerByUserCode(user_code);
        for (DeliveryDTO delivery : list) {
            delivery.setStatus(determineDeliveryStatus(delivery.getStart_date(), delivery.getEnd_date()));
            delivery.setStatusClass(getStatusClass(delivery.getStart_date(), delivery.getEnd_date()));
        }
        return list;

    }

    @Override
    public List<DeliveryDTO> getStorenUserDeliveries(int user_code) {
        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);
        List<DeliveryDTO> list = deliveryDao.listStorenUserByUserCode(user_code);
        for (DeliveryDTO delivery : list) {
            delivery.setStatus(determineDeliveryStatus(delivery.getStart_date(), delivery.getEnd_date()));
            delivery.setStatusClass(getStatusClass(delivery.getStart_date(), delivery.getEnd_date()));
        }
        return list;
    }

    @Override
    public List<DeliveryDTO> getRentalDeliveries(int user_code) {
        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);
        List<DeliveryDTO> list = deliveryDao.listRentalByUserCode(user_code);
        for (DeliveryDTO delivery : list) {
            delivery.setStatus(determineDeliveryStatus(delivery.getStart_date(), delivery.getEnd_date()));
            delivery.setStatusClass(getStatusClass(delivery.getStart_date(), delivery.getEnd_date()));
        }
        return list;
    }
    //id로 스토렌 검색
    @Override
    public List<DeliveryDTO> getDeliveryByStorenId(int userCode, int storenId) {
        IDeliveryDAO deliveryDao = sqlSession.getMapper(IDeliveryDAO.class);
        List<DeliveryDTO> list = deliveryDao.getDeliveryByStorenId(userCode, storenId);
        for (DeliveryDTO delivery : list) {
            delivery.setStatus(determineDeliveryStatus(delivery.getStart_date(), delivery.getEnd_date()));
            delivery.setStatusClass(getStatusClass(delivery.getStart_date(), delivery.getEnd_date()));
        }
        return list;
    }
}