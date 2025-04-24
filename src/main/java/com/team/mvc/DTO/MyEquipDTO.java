package com.team.mvc.DTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MyEquipDTO {

    private List<EquipmentDTO> equipList;
    private Map<Integer, List<StorenDTO>> storenMap;
    private List<StorenDTO> firstStorenList;
    // rentalList, storageList 도 추가 예정

    public MyEquipDTO() {}

    public MyEquipDTO(List<EquipmentDTO> equipList, Map<Integer, List<StorenDTO>> storenMap, List<StorenDTO> firstStorenList) {
        this.equipList = equipList;
        this.storenMap = storenMap;
        this.firstStorenList = firstStorenList;
    }

    public List<EquipmentDTO> getEquipList() {
        return equipList;
    }

    public void setEquipList(List<EquipmentDTO> equipList) {
        this.equipList = equipList;
    }

    public Map<Integer, List<StorenDTO>> getStorenMap() {
        return storenMap;
    }

    public void setStorenMap(Map<Integer, List<StorenDTO>> storenMap) {
        this.storenMap = storenMap;
    }

    public List<StorenDTO> getFirstStorenList() {
        return firstStorenList;
    }

    public void setFirstStorenList(List<StorenDTO> firstStorenList) {
        this.firstStorenList = firstStorenList;
    }
}