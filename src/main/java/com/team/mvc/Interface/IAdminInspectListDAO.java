package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminInspectListDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IAdminInspectListDAO {

    // 검수 목록 조회
    List<AdminInspectListDTO> list();

    // 반품 검수 목록 조회
    List<AdminInspectListDTO> listr();

    // 검수 결과 추가 - DTO 사용
    void add(AdminInspectListDTO dto);

    // 프로시저 호출 메소드 - @Param 어노테이션 사용
    void callINSPECT_RESULT(
            @Param("platformDeliveryId") Integer platformDeliveryId,
            @Param("platformDeliveryReturnId") Integer platformDeliveryReturnId,
            @Param("equipGradeId") Integer equipGradeId
    );
}