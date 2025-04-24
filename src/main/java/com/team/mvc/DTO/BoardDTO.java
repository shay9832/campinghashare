package com.team.mvc.DTO;

public class BoardDTO {
    private int boardId, boardCateId, writeGradeId;
    private String boardName, boardDesc;

    // getter / setter
    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public int getBoardCateId() {
        return boardCateId;
    }

    public void setBoardCateId(int boardCateId) {
        this.boardCateId = boardCateId;
    }

    public int getWriteGradeId() {
        return writeGradeId;
    }

    public void setWriteGradeId(int writeGradeId) {
        this.writeGradeId = writeGradeId;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public String getBoardDesc() {
        return boardDesc;
    }

    public void setBoardDesc(String boardDesc) {
        this.boardDesc = boardDesc;
    }
}
