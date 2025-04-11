package com.team.mvc.DTO;

public class MypageInspecListDTO {
    private int service_id;                   //거래id
    private Integer delivery_id;                  //배송ID
    private int equip_code;                       //장비코드
    private String inspec_type;                   //검수유형
    private String equip_name;                    //장비명
    private String majorCategory, middleCategory; //대분류카테명, 중분류카테명
    private String inspec_status;                 //검수상태
    private String equip_grade;                   //장비등급명
    private String inspec_result_action_type;     //검수처리유형이름
    private String completed_date;                //검수결과처리일
    private String user_code;                     //유저코드
    private String user_nickname;                 //유저닉네임

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public Integer getDelivery_id() {
        return delivery_id;
    }

    public void setDelivery_id(Integer delivery_id) {
        this.delivery_id = delivery_id;
    }

    public int getEquip_code() {
        return equip_code;
    }

    public void setEquip_code(int equip_code) {
        this.equip_code = equip_code;
    }

    public String getInspec_type() {
        return inspec_type;
    }

    public void setInspec_type(String inspec_type) {
        this.inspec_type = inspec_type;
    }

    public String getEquip_name() {
        return equip_name;
    }

    public void setEquip_name(String equip_name) {
        this.equip_name = equip_name;
    }

    public String getMajorCategory() {
        return majorCategory;
    }

    public void setMajorCategory(String majorCategory) {
        this.majorCategory = majorCategory;
    }

    public String getMiddleCategory() {
        return middleCategory;
    }

    public void setMiddleCategory(String middleCategory) {
        this.middleCategory = middleCategory;
    }

    public String getInspec_status() {
        return inspec_status;
    }

    public void setInspec_status(String inspec_status) {
        this.inspec_status = inspec_status;
    }

    public String getEquip_grade() {
        return equip_grade;
    }

    public void setEquip_grade(String equip_grade) {
        this.equip_grade = equip_grade;
    }

    public String getInspec_result_action_type() {
        return inspec_result_action_type;
    }

    public void setInspec_result_action_type(String inspec_result_action_type) {
        this.inspec_result_action_type = inspec_result_action_type;
    }

    public String getCompleted_date() {
        return completed_date;
    }

    public void setCompleted_date(String completed_date) {
        this.completed_date = completed_date;
    }

    public String getUser_code() {
        return user_code;
    }

    public void setUser_code(String user_code) {
        this.user_code = user_code;
    }

    public String getUser_nickname() {
        return user_nickname;
    }

    public void setUser_nickname(String user_nickname) {
        this.user_nickname = user_nickname;
    }
}
