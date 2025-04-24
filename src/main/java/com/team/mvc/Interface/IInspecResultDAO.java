package com.team.mvc.Interface;

import com.team.mvc.DTO.InspecResultDTO;
import com.team.mvc.DTO.InspecResultDTO.InspecItemDetail;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface IInspecResultDAO {
    InspecResultDTO getInspectResultByDeliveryId(int platformDeliveryId);
    InspecResultDTO getInspectResultByReturnDeliveryId(int platformDeliveryReturnId);
    List<InspecItemDetail> getItemListByDeliveryId(int platformDeliveryId);
    List<InspecItemDetail> getItemListByReturnDeliveryId(int platformDeliveryReturnId);

    Integer getDeliveryIdByStorenId(int storenId);
    Integer getReturnDeliveryIdByStorenId(int storenId);
    Integer getEquipCodeByStorenId(@Param("storenId") int storenId);

    // 반환 정보 추가
    public List<InspecResultDTO> inspecResultByStorenId(@Param("storenId") int storenId);

    // 스토렌 상태 업데이트
    int updateStorenStatus(int storenId, String status);

    // platformDeliveryId 기준으로 장비 등급 조회
    public String getFinalEquipGradeByDeliveryId(@Param("platformDeliveryId") int platformDeliveryId);

    // platformDeliveryReturnId 기준으로 장비 등급 조회
    public String getFinalEquipGradeByReturnDeliveryId(@Param("platformDeliveryReturnId") int platformDeliveryReturnId);

    // 반환 주소 입력 여부 확인용 메서드
    public int hasReturnAddressByStorenId(@Param("storenId") int storenId);
}