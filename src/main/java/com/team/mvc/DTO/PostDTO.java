package com.team.mvc.DTO;

public class PostDTO {
    private int postId, userCode, boardId, postLabelId;
    private String  postTitle, postContent, createdDate;

    private String nickName, boardName, postLabelName;

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public int getPostLabelId() {
        return postLabelId;
    }

    public void setPostLabelId(int postLabelId) {
        this.postLabelId = postLabelId;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public String getPostLabelName() {
        return postLabelName;
    }

    public void setPostLabelName(String postLabelName) {
        this.postLabelName = postLabelName;
    }
}
