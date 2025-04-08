package com.team.mvc;

public class AdminInspectListDTO {

    //장비코드,검수유형,장비명,카테고리명,검수항목,관리자ID,검수결과,검수코멘트,검수상태

    private int equipCode;
    private String inspectName, equipName, categoryName, inspectList, adminId, inspectResult, inspectComment, inspectState;

    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }

    public String getInspectName() {
        return inspectName;
    }

    public void setInspectName(String inspectName) {
        this.inspectName = inspectName;
    }

    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getInspectList() {
        return inspectList;
    }

    public void setInspectList(String inspectList) {
        this.inspectList = inspectList;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getInspectResult() {
        return inspectResult;
    }

    public void setInspectResult(String inspectResult) {
        this.inspectResult = inspectResult;
    }

    public String getInspectComment() {
        return inspectComment;
    }

    public void setInspectComment(String inspectComment) {
        this.inspectComment = inspectComment;
    }

    public String getInspectState() {
        return inspectState;
    }

    public void setInspectState(String inspectState) {
        this.inspectState = inspectState;
    }
}