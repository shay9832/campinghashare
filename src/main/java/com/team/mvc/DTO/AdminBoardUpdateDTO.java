package com.team.mvc.DTO;

public class AdminBoardUpdateDTO {

   private Integer boardId;         //게시판ID
   private String categoryName;     //카테고리명
   private String adminGrade;       //관리등급
   private String boardName;        //게시판명


    private Integer labelId;
    private String labelName;


    //getter setter(게시판 업데이트)

    public Integer getBoardId() {
        return boardId;
    }

    public void setBoardId(Integer boardId) {
        this.boardId = boardId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getAdminGrade() {
        return adminGrade;
    }

    public void setAdminGrade(String adminGrade) {
        this.adminGrade = adminGrade;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }


    //getter setter(말머리 업데이트)

    public Integer getLabelId() {
        return labelId;
    }

    public void setLabelId(Integer labelId) {
        this.labelId = labelId;
    }

    public String getLabelName() {
        return labelName;
    }

    public void setLabelName(String labelName) {
        this.labelName = labelName;
    }
}
