package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminDeliveryUpdateDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 배송 정보 조회 인터페이스
 */
public interface IAdminDeliveryUpdateDAO {

    /**
     * 전체 배송 정보 조회
     *
     * @return 모든 배송 정보 목록
     */
    List<AdminDeliveryUpdateDTO> getAllDeliveries();

    /**
     * 배송 종류별 배송 정보 조회
     *
     * @param deliveryType 배송 종류 (스토렌_최초입고, 보관_최초입고 등)
     * @return 지정된 배송 종류의 배송 정보 목록
     */
    List<AdminDeliveryUpdateDTO> getDeliveriesByType(String deliveryType);

    /**
     * 특정 ID의 배송 정보 조회
     *
     * @param deliveryId 배송 ID
     * @return 해당 ID의 배송 정보
     */
    AdminDeliveryUpdateDTO getDeliveryById(Long deliveryId);

    // 렌탈 시작일과 렌탈 종료일에 따른 배송일자 업데이트를 위한
    void updateDelivery(AdminDeliveryUpdateDTO dto);


    List<AdminDeliveryUpdateDTO> getPendingDeliveries();  // 배송 대기 중인 항목을 조회
    void createDelivery(AdminDeliveryUpdateDTO dto);      // 새 배송을 생성


}