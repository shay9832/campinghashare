package com.team.mvc.DTO;

public class DeliveryDTO {
    private String delivery_type;                                   //배송종류
    private int sender, receiver;                                   //수취인, 발송인(의 유저코드) --만약 -1이라면 창고라는 뜻
    private Integer storen_id, storage_id, rental_matching_done_id, rental_id; //스토렌ID, 보관ID, 렌탈매칭완료ID, 렌탈ID (null 가능성 있음)
    private Integer delivery_id;                                    //배송ID
    private String equip_name;                                      //장비명
    private String carrier_name, waybill_number;                    //운송사이름, 운송장번호 (스토렌, 보관일 때 null)
    private String start_date, end_date;                            //배송시작일, 배송종료일
    private String inspec_completed_date, inspec_completed_type;    //검수결과처리일, 검수결과처리유형 (렌탈일 때 null)

    private String status;                                          //배송상태
    private String statusClass;                                     //배송상태 클래스
    
    public String getDelivery_type() {
        return delivery_type;
    }

    public void setDelivery_type(String delivery_type) {
        this.delivery_type = delivery_type;
    }

    public int getSender() {
        return sender;
    }

    public void setSender(int sender) {
        this.sender = sender;
    }

    public int getReceiver() {
        return receiver;
    }

    public void setReceiver(int receiver) {
        this.receiver = receiver;
    }

    public Integer getStoren_id() {
        return storen_id;
    }

    public void setStoren_id(Integer storen_id) {
        this.storen_id = storen_id;
    }

    public Integer getStorage_id() {
        return storage_id;
    }

    public void setStorage_id(Integer storage_id) {
        this.storage_id = storage_id;
    }

    public Integer getRental_matching_done_id() {
        return rental_matching_done_id;
    }

    public void setRental_matching_done_id(Integer rental_matching_done_id) {
        this.rental_matching_done_id = rental_matching_done_id;
    }

    public Integer getRental_id() {
        return rental_id;
    }

    public void setRental_id(Integer rental_id) {
        this.rental_id = rental_id;
    }

    public Integer getDelivery_id() {
        return delivery_id;
    }

    public void setDelivery_id(Integer delivery_id) {
        this.delivery_id = delivery_id;
    }

    public String getEquip_name() {
        return equip_name;
    }

    public void setEquip_name(String equip_name) {
        this.equip_name = equip_name;
    }

    public String getCarrier_name() {
        return carrier_name;
    }

    public void setCarrier_name(String carrier_name) {
        this.carrier_name = carrier_name;
    }

    public String getWaybill_number() {
        return waybill_number;
    }

    public void setWaybill_number(String waybill_number) {
        this.waybill_number = waybill_number;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getInspec_completed_date() {
        return inspec_completed_date;
    }

    public void setInspec_completed_date(String inspec_completed_date) {
        this.inspec_completed_date = inspec_completed_date;
    }

    public String getInspec_completed_type() {
        return inspec_completed_type;
    }

    public void setInspec_completed_type(String inspec_completed_type) {
        this.inspec_completed_type = inspec_completed_type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusClass() {
        return statusClass;
    }

    public void setStatusClass(String statusClass) {
        this.statusClass = statusClass;
    }
}
