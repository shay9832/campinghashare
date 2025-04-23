package com.team.mvc.Interface;

import com.team.mvc.DTO.NotificationDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface INotificationDAO {
    List<NotificationDTO> getNotificationsByUserCode(@Param("userCode") int userCode);

    void markAllAsRead(@Param("userCode") int userCode);

    void insertReadLogForAll(@Param("userCode") int userCode);

}