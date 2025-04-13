package com.team.mvc.DTO;

public class PostViewLogDTO {
    private int postViewLogId, userCode, postId;
    private String createdDate;

    // Getters and Setters
    public int getPostViewLogId() {
        return postViewLogId;
    }

    public void setPostViewLogId(int postViewLogId) {
        this.postViewLogId = postViewLogId;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }
}