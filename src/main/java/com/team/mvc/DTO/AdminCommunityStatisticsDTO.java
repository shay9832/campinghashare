package com.team.mvc.DTO;

public class AdminCommunityStatisticsDTO {
    private int postNum,repleNum,checkNum,postDeclarationNum,repleDeclarationNum,allDeclarationNum;
    private String boardName,declarationType,newPostNum;




    //getter setter

    public int getPostNum() {
        return postNum;
    }

    public void setPostNum(int postNum) {
        this.postNum = postNum;
    }

    public int getRepleNum() {
        return repleNum;
    }

    public void setRepleNum(int repleNum) {
        this.repleNum = repleNum;
    }

    public int getCheckNum() {
        return checkNum;
    }

    public void setCheckNum(int checkNum) {
        this.checkNum = checkNum;
    }

    public int getPostDeclarationNum() {
        return postDeclarationNum;
    }

    public void setPostDeclarationNum(int postDeclarationNum) {
        this.postDeclarationNum = postDeclarationNum;
    }

    public int getRepleDeclarationNum() {
        return repleDeclarationNum;
    }

    public void setRepleDeclarationNum(int repleDeclarationNum) {
        this.repleDeclarationNum = repleDeclarationNum;
    }

    public int getAllDeclarationNum() {
        return allDeclarationNum;
    }

    public void setAllDeclarationNum(int allDeclarationNum) {
        this.allDeclarationNum = allDeclarationNum;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public String getDeclarationType() {
        return declarationType;
    }

    public void setDeclarationType(String declarationType) {
        this.declarationType = declarationType;
    }

    public String getNewPostNum() {
        return newPostNum;
    }

    public void setNewPostNum(String newPostNum) {
        this.newPostNum = newPostNum;
    }
}
