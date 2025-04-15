package com.team.mvc.Interface;

import com.team.mvc.DTO.InspecResultDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IInspecResultDAO {
    List<InspecResultDTO> getResultListByStorenId(@Param("storen_id") int storenId);
}