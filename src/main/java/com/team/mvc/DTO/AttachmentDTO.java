package com.team.mvc.DTO;

public class AttachmentDTO {
    private int attachmentEquipRegId, equipCode, attachmentOrder;
    private String attachmentName, attachmentPath, createdDate;
    private long attachmentSize;

    public int getAttachmentEquipRegId() {
        return attachmentEquipRegId;
    }

    public void setAttachmentEquipRegId(int attachmentEquipRegId) {
        this.attachmentEquipRegId = attachmentEquipRegId;
    }

    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }

    public int getAttachmentOrder() {
        return attachmentOrder;
    }

    public void setAttachmentOrder(int attachmentOrder) {
        this.attachmentOrder = attachmentOrder;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public String getAttachmentPath() {
        return attachmentPath;
    }

    public void setAttachmentPath(String attachmentPath) {
        this.attachmentPath = attachmentPath;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public long getAttachmentSize() {
        return attachmentSize;
    }

    public void setAttachmentSize(long attachmentSize) {
        this.attachmentSize = attachmentSize;
    }
}
