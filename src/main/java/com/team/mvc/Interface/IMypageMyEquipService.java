package com.team.mvc.Interface;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.MyEquipDTO;
import com.team.mvc.DTO.StorenDTO;

import java.util.List;
import java.util.Map;

public interface IMypageMyEquipService {
    // 스토렌이 아닌 일반 장비 + 스토렌 장비 리스트 전체 조회
    MyEquipDTO listMyEquip(int userCode);
    
    // 스토렌이 아닌 일반 장비 전체 조회
    List<EquipmentDTO> listMyGeneral(int userCode);
    // 장비 상태 조회
    Map<String, Map<String, Integer>> getMyEquipmentStatus(int userCode);
    // 첫번째 등록된(근본) 스토렌 장비 전체 조회
    List<StorenDTO> listMyStoren(int userCode);
    // 같은 장비 코드의 여러 스토렌 장비 조회(스토렌 탭-상세)
    List<StorenDTO> listMyStorenDetail(int userCode, int equipCode);
    // 스토렌-화살표로 상태 필터링
    List<StorenDTO> listMyStorenByStatus(int userCode, String status);
    // 즉시 확인 필요로 상태 필터링(일단은 스토렌만)
    List<StorenDTO> listMyStorenByStatus(int userCode, String type, String[] statuses);

}
