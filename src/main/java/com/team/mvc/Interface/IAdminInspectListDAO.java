package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminInspectListDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface IAdminInspectListDAO {

    // 검수 목록 조회
    List<AdminInspectListDTO> getList();

    // 반품 검수 목록 조회
    List<AdminInspectListDTO> getListr();

    // 검수 항목 테이블 조회
    List<AdminInspectListDTO> getItemList();

    // 검수항목_등급 테이블 조회
    List<AdminInspectListDTO> getGradeList();

    //장비 등급 테이블 조회
    List<AdminInspectListDTO> getEquipList();

    //반환 ID에 해당하는 원래 배송 ID를 찾는 메소드
    Integer getDeliveryIdFromReturnId(Integer returnId);

    // 추가된 메서드: 검수 결과 상세 조회
    AdminInspectListDTO getInspectionResult(Integer platformDeliveryId, Integer platformDeliveryReturnId);

    // 검수 결과 추가 - DTO 사용
    void add(AdminInspectListDTO dto);

    // 확장된 프로시저 호출 메소드
    void callINSPECT_RESULT(
            @Param("platformDeliveryId") Integer platformDeliveryId,
            @Param("platformDeliveryReturnId") Integer platformDeliveryReturnId,
            @Param("inspecGradeId") Integer inspecGradeId,
            @Param("equipGradeId") Integer equipGradeId,
            @Param("adminId") String adminId,
            @Param("inspecComment") String inspecComment
    );
}