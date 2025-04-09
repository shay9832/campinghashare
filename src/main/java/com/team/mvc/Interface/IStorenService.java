package com.team.mvc.Interface;

import java.util.List;
import com.team.mvc.DTO.StorenDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IStorenService {
    List<StorenDTO> getStorenListWithEquipment(int userCode);
}