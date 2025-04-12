package com.team.mvc.DTO;

public class AdminEquipListDTO {
    private int EQUIP_CODE,STOREN_ID,USER_CODE,SIZE_ID,REQUIRED_SPACE,DAILY_STORAGE_FEE,STORE_MONTH;
    private int DAILY_RENT_PRICE;
    private String EQUIP_NAME;
    private String MAJOR_CATEGORY_NAME;
    private String MIDDLE_CATEGORY_NAME;
    private int ORIGINAL_PRICE;
    private String CREATED_DATE;
    private String EQUIP_SIZE_NAME;
    private String STOREN_TITLE;
    private String STOREN_CONTENT;



    // DB 컬럼명과 일치하는 게터/세터
    public int getEQUIP_CODE() {
        return EQUIP_CODE;
    }

    public void setEQUIP_CODE(int EQUIP_CODE) {
        this.EQUIP_CODE = EQUIP_CODE;
    }

    public String getEQUIP_NAME() {
        return EQUIP_NAME;
    }

    public void setEQUIP_NAME(String EQUIP_NAME) {
        this.EQUIP_NAME = EQUIP_NAME;
    }

    public String getMAJOR_CATEGORY_NAME() {
        return MAJOR_CATEGORY_NAME;
    }

    public void setMAJOR_CATEGORY_NAME(String MAJOR_CATEGORY_NAME) {
        this.MAJOR_CATEGORY_NAME = MAJOR_CATEGORY_NAME;
    }

    public String getMIDDLE_CATEGORY_NAME() {
        return MIDDLE_CATEGORY_NAME;
    }

    public void setMIDDLE_CATEGORY_NAME(String MIDDLE_CATEGORY_NAME) {
        this.MIDDLE_CATEGORY_NAME = MIDDLE_CATEGORY_NAME;
    }

    public int getORIGINAL_PRICE() {
        return ORIGINAL_PRICE;
    }

    public void setORIGINAL_PRICE(int ORIGINAL_PRICE) {
        this.ORIGINAL_PRICE = ORIGINAL_PRICE;
    }

    public String getCREATED_DATE() {
        return CREATED_DATE;
    }

    public void setCREATED_DATE(String CREATED_DATE) {
        this.CREATED_DATE = CREATED_DATE;
    }

    public int getSTOREN_ID() {
        return STOREN_ID;
    }

    public void setSTOREN_ID(int STOREN_ID) {
        this.STOREN_ID = STOREN_ID;
    }

    public int getUSER_CODE() {
        return USER_CODE;
    }

    public void setUSER_CODE(int USER_CODE) {
        this.USER_CODE = USER_CODE;
    }

    public int getSIZE_ID() {
        return SIZE_ID;
    }

    public void setSIZE_ID(int SIZE_ID) {
        this.SIZE_ID = SIZE_ID;
    }

    public int getREQUIRED_SPACE() {
        return REQUIRED_SPACE;
    }

    public void setREQUIRED_SPACE(int REQUIRED_SPACE) {
        this.REQUIRED_SPACE = REQUIRED_SPACE;
    }

    public int getDAILY_STORAGE_FEE() {
        return DAILY_STORAGE_FEE;
    }

    public void setDAILY_STORAGE_FEE(int DAILY_STORAGE_FEE) {
        this.DAILY_STORAGE_FEE = DAILY_STORAGE_FEE;
    }

    public int getSTORE_MONTH() {
        return STORE_MONTH;
    }

    public void setSTORE_MONTH(int STORE_MONTH) {
        this.STORE_MONTH = STORE_MONTH;
    }

    public int getDAILY_RENT_PRICE() {
        return DAILY_RENT_PRICE;
    }

    public void setDAILY_RENT_PRICE(int DAILY_RENT_PRICE) {
        this.DAILY_RENT_PRICE = DAILY_RENT_PRICE;
    }

    public String getEQUIP_SIZE_NAME() {
        return EQUIP_SIZE_NAME;
    }

    public void setEQUIP_SIZE_NAME(String EQUIP_SIZE_NAME) {
        this.EQUIP_SIZE_NAME = EQUIP_SIZE_NAME;
    }

    public String getSTOREN_TITLE() {
        return STOREN_TITLE;
    }

    public void setSTOREN_TITLE(String STOREN_TITLE) {
        this.STOREN_TITLE = STOREN_TITLE;
    }

    public String getSTOREN_CONTENT() {
        return STOREN_CONTENT;
    }

    public void setSTOREN_CONTENT(String STOREN_CONTENT) {
        this.STOREN_CONTENT = STOREN_CONTENT;
    }
}