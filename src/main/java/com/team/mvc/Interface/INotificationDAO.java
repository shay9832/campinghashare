package com.team.mvc.Interface;

import com.team.mvc.DTO.NotificationDTO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;

// 알림 DAO 인터페이스
public interface INotificationDAO {

    // 최근 7일 이내 알림 목록 조회
    List<NotificationDTO> getRecentNotifications(@Param("userCode") int userCode);

    // 특정 유저의 알림 목록 조회
    List<NotificationDTO> getNotificationsByUserCode(@Param("userCode") int userCode);

    // 읽지 않은 알림 개수 조회
    int getUnreadNotificationCount(@Param("userCode") int userCode);

    // 특정 유저의 전체 알림 읽음 처리
    int markAllNotificationsAsRead(@Param("userCode") int userCode);

    // 전체 알림 읽음 처리 로그 삽입
    int insertReadLogForAll(@Param("userCode") int userCode);
}
