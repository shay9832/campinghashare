package com.team.mvc.DTO;

import java.util.Date;

// 알림 데이터를 담는 DTO
public class NotificationDTO {
    private int notiId;
    private int userCode;
    private int notiTypeId;
    private Date createdDate;

    // NOTI_TYPE 테이블 조인 결과
    private String notiTypeName;
    private String notiContent;

    // 읽음 여부 (NOTI_CHECK_LOG 존재 여부)
    private boolean isRead;

    // 생성자
    public NotificationDTO() {}

    // Getter / Setter
    public int getNotiId() {
        return notiId;
    }

    public void setNotiId(int notiId) {
        this.notiId = notiId;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public int getNotiTypeId() {
        return notiTypeId;
    }

    public void setNotiTypeId(int notiTypeId) {
        this.notiTypeId = notiTypeId;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getNotiTypeName() {
        return notiTypeName;
    }

    public void setNotiTypeName(String notiTypeName) {
        this.notiTypeName = notiTypeName;
    }

    public String getNotiContent() {
        return notiContent;
    }

    public void setNotiContent(String notiContent) {
        this.notiContent = notiContent;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }
}
