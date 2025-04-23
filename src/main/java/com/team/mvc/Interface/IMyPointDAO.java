package com.team.mvc.Interface;

import com.team.mvc.DTO.MyPointDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMyPointDAO {
    //해당 유저의 포인트 내역 가져오기
    List<MyPointDTO> listMyPoint(@Param("userCode") int userCode);
}
