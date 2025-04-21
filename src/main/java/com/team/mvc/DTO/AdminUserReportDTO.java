package com.team.mvc.DTO;

public class AdminUserReportDTO {

    private int post_report_id,post_id;
    private String nickname1,nickname2,report_type_name,report_content,report_date,admin_id,completed_date,post_report_action_id;


    private String process_status;




    //getter setter


    public int getPost_report_id() {
        return post_report_id;
    }

    public void setPost_report_id(int post_report_id) {
        this.post_report_id = post_report_id;
    }

    public int getPost_id() {
        return post_id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }

    public String getNickname1() {
        return nickname1;
    }

    public void setNickname1(String nickname1) {
        this.nickname1 = nickname1;
    }

    public String getNickname2() {
        return nickname2;
    }

    public void setNickname2(String nickname2) {
        this.nickname2 = nickname2;
    }

    public String getReport_type_name() {
        return report_type_name;
    }

    public void setReport_type_name(String report_type_name) {
        this.report_type_name = report_type_name;
    }

    public String getReport_content() {
        return report_content;
    }

    public void setReport_content(String report_content) {
        this.report_content = report_content;
    }

    public String getReport_date() {
        return report_date;
    }

    public void setReport_date(String report_date) {
        this.report_date = report_date;
    }

    public String getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }

    public String getPost_report_action_id() {
        return post_report_action_id;
    }

    public void setPost_report_action_id(String post_report_action_id) {
        this.post_report_action_id = post_report_action_id;
    }

    public String getCompleted_date() {
        return completed_date;
    }

    public void setCompleted_date(String completed_date) {
        this.completed_date = completed_date;
    }

    public String getProcess_status() {
        return process_status;
    }

    public void setProcess_status(String process_status) {
        this.process_status = process_status;
    }
}
