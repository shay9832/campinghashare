package com.team.mvc.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MypageInspecListDTO {
    @JsonProperty("service_id")
    private int service_id;                   //거래id

    @JsonProperty("delivery_id")
    private Integer delivery_id;              //배송ID

    @JsonProperty("equip_code")
    private int equip_code;                   //장비코드

    @JsonProperty("inspec_type")
    private String inspec_type;               //검수유형

    @JsonProperty("equip_name")
    private String equip_name;                //장비명

    @JsonProperty("majorCategory")
    private String majorCategory;             //대분류카테명

    @JsonProperty("middleCategory")
    private String middleCategory;            //중분류카테명

    @JsonProperty("inspec_status")
    private String inspec_status;             //검수상태

    @JsonProperty("equip_grade")
    private String equip_grade;               //장비등급명

    @JsonProperty("inspec_result_action_type")
    private String inspec_result_action_type; //검수처리유형이름

    @JsonProperty("completed_date")
    private String completed_date;            //검수결과처리일

    @JsonProperty("user_code")
    private String user_code;                 //유저코드

    @JsonProperty("user_nickname")
    private String user_nickname;             //유저닉네임

    @JsonProperty("service_id")
    public int getService_id() {
        return service_id;
    }

    @JsonProperty("service_id")
    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    @JsonProperty("delivery_id")
    public Integer getDelivery_id() {
        return delivery_id;
    }

    @JsonProperty("delivery_id")
    public void setDelivery_id(Integer delivery_id) {
        this.delivery_id = delivery_id;
    }

    @JsonProperty("equip_code")
    public int getEquip_code() {
        return equip_code;
    }

    @JsonProperty("equip_code")
    public void setEquip_code(int equip_code) {
        this.equip_code = equip_code;
    }

    @JsonProperty("inspec_type")
    public String getInspec_type() {
        return inspec_type;
    }

    @JsonProperty("inspec_type")
    public void setInspec_type(String inspec_type) {
        this.inspec_type = inspec_type;
    }

    @JsonProperty("equip_name")
    public String getEquip_name() {
        return equip_name;
    }

    @JsonProperty("equip_name")
    public void setEquip_name(String equip_name) {
        this.equip_name = equip_name;
    }

    @JsonProperty("majorCategory")
    public String getMajorCategory() {
        return majorCategory;
    }

    @JsonProperty("majorCategory")
    public void setMajorCategory(String majorCategory) {
        this.majorCategory = majorCategory;
    }

    @JsonProperty("middleCategory")
    public String getMiddleCategory() {
        return middleCategory;
    }

    @JsonProperty("middleCategory")
    public void setMiddleCategory(String middleCategory) {
        this.middleCategory = middleCategory;
    }

    @JsonProperty("inspec_status")
    public String getInspec_status() {
        return inspec_status;
    }

    @JsonProperty("inspec_status")
    public void setInspec_status(String inspec_status) {
        this.inspec_status = inspec_status;
    }

    @JsonProperty("equip_grade")
    public String getEquip_grade() {
        return equip_grade;
    }

    @JsonProperty("equip_grade")
    public void setEquip_grade(String equip_grade) {
        this.equip_grade = equip_grade;
    }

    @JsonProperty("inspec_result_action_type")
    public String getInspec_result_action_type() {
        return inspec_result_action_type;
    }

    @JsonProperty("inspec_result_action_type")
    public void setInspec_result_action_type(String inspec_result_action_type) {
        this.inspec_result_action_type = inspec_result_action_type;
    }

    @JsonProperty("completed_date")
    public String getCompleted_date() {
        return completed_date;
    }

    @JsonProperty("completed_date")
    public void setCompleted_date(String completed_date) {
        this.completed_date = completed_date;
    }

    @JsonProperty("user_code")
    public String getUser_code() {
        return user_code;
    }

    @JsonProperty("user_code")
    public void setUser_code(String user_code) {
        this.user_code = user_code;
    }

    @JsonProperty("user_nickname")
    public String getUser_nickname() {
        return user_nickname;
    }

    @JsonProperty("user_nickname")
    public void setUser_nickname(String user_nickname) {
        this.user_nickname = user_nickname;
    }
}