package com.team.mvc.DTO;

public class AdminBoardUpdateDTO {

    private int boardId;
    private String categoryName,manageLevel,boardName,labelId,lavelName;


    //getter setter 구성
    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getManageLevel() {
        return manageLevel;
    }

    public void setManageLevel(String manageLevel) {
        this.manageLevel = manageLevel;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public String getLabelId() {
        return labelId;
    }

    public void setLabelId(String labelId) {
        this.labelId = labelId;
    }

    public String getLavelName() {
        return lavelName;
    }

    public void setLavelName(String lavelName) {
        this.lavelName = lavelName;
    }
}
