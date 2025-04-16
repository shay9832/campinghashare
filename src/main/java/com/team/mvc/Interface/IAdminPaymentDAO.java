package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminPaymentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 관리자 결제 정보 DAO 인터페이스
 */
@Mapper
public interface IAdminPaymentDAO {

    /**
     * 모든 결제 정보 조회
     */
    List<AdminPaymentDTO> getAllPayments(
            @Param("start") int start,
            @Param("limit") int limit
    );

    /**
     * 결제 유형별 조회 (렌탈, 보관, 스토렌)
     */
    List<AdminPaymentDTO> getPaymentsByType(
            @Param("type") String type,
            @Param("start") int start,
            @Param("limit") int limit
    );

    /**
     * 검색 조건에 따른 결제 정보 조회
     */
    List<AdminPaymentDTO> searchPayments(
            @Param("searchType") String searchType,
            @Param("paymentMethod") String paymentMethod,
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate,
            @Param("keyword") String keyword,
            @Param("start") int start,
            @Param("limit") int limit
    );

    /**
     * 결제 ID로 상세 정보 조회
     */
    AdminPaymentDTO getPaymentById(@Param("paymentId") int paymentId);

    /**
     * 결제 유형별 총 결제 건수 조회
     */
    int getTotalPaymentsByType(@Param("type") String type);

    /**
     * 결제 통계 정보 조회
     */
    Map<String, Object> getPaymentStatistics();

    /**
     * 결제 유형별 통계 정보 조회
     */
    Map<String, Object> getPaymentStatisticsByType(@Param("type") String type);

    /**
     * 결제 상태 업데이트
     */
    int updatePaymentStatus(
            @Param("paymentId") int paymentId,
            @Param("status") String status,
            @Param("cancelDate") Date cancelDate,
            @Param("cancelReason") String cancelReason
    );

    /**
     * 총 결제 건수 조회
     */
    int getTotalPayments();

    /**
     * 검색 조건에 따른 총 결제 건수 조회
     */
    int getTotalSearchResults(
            @Param("searchType") String searchType,
            @Param("paymentMethod") String paymentMethod,
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate,
            @Param("keyword") String keyword
    );

    //결제하기
    void insertPayment(Map<String, Object> paramMap);
}