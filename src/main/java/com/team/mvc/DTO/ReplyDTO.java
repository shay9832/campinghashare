package com.team.mvc.DTO;

public class ReplyDTO {
    private int replyId, userCode,  postId;
    private Integer rootReplyId;  // 대댓글인 경우 부모 댓글 ID
    private String replyContent, createdDate, nickname; // 조인으로 가져올 닉네임

    private BoardPostDTO replyPostDTO;                     // 해당 댓글이 달린 게시물DTO

    // Getters and Setters
    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public Integer getRootReplyId() {
        return rootReplyId;
    }

    public void setRootReplyId(Integer rootReplyId) {
        this.rootReplyId = rootReplyId;
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

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public BoardPostDTO getReplyPostDTO() {
        return replyPostDTO;
    }

    public void setReplyPostDTO(BoardPostDTO replyPostDTO) {
        this.replyPostDTO = replyPostDTO;
    }
}
