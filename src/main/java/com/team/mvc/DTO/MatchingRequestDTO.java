package com.team.mvc.DTO;

public class MatchingRequestDTO {
    private int transaction_id;         //거래id (스토렌id 또는 렌탈id)
    private String transaction_type;    //거래유형 ('스토렌_매칭신청', '스토렌_매칭완료', '렌탈_매칭신청', '렌탈_매칭완료')
    private int user_code;              //유저코드
    private String user_nickname;       //유저닉네임
    private String rental_start_date;   //렌탈시작일
    private String rental_end_date;     //렌탈종료일
    private int rental_duration;        //대여기간(일)
    private int rental_pay;             //결제예정금액
    private int trust;                  //신뢰도
    private int rental_history;         //대여이력
    private String requested_date;      //신청일
    private String payment_date;        //결제일
    private int matching_req_id;        //매칭신청id
    private String payment_status;      //결제상태('미결제', '결제대기', '결제완료')
    private int matching_done_id;       //매칭완료id

    public int getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(int transaction_id) {
        this.transaction_id = transaction_id;
    }

    public String getTransaction_type() {
        return transaction_type;
    }

    public void setTransaction_type(String transaction_type) {
        this.transaction_type = transaction_type;
    }

    public int getUser_code() {
        return user_code;
    }

    public void setUser_code(int user_code) {
        this.user_code = user_code;
    }

    public String getUser_nickname() {
        return user_nickname;
    }

    public void setUser_nickname(String user_nickname) {
        this.user_nickname = user_nickname;
    }

    public String getRental_start_date() {
        return rental_start_date;
    }

    public void setRental_start_date(String rental_start_date) {
        this.rental_start_date = rental_start_date;
    }

    public String getRental_end_date() {
        return rental_end_date;
    }

    public void setRental_end_date(String rental_end_date) {
        this.rental_end_date = rental_end_date;
    }

    public int getRental_duration() {
        return rental_duration;
    }

    public void setRental_duration(int rental_duration) {
        this.rental_duration = rental_duration;
    }

    public int getRental_pay() {
        return rental_pay;
    }

    public void setRental_pay(int rental_pay) {
        this.rental_pay = rental_pay;
    }

    public int getTrust() {
        return trust;
    }

    public void setTrust(int trust) {
        this.trust = trust;
    }

    public int getRental_history() {
        return rental_history;
    }

    public void setRental_history(int rental_history) {
        this.rental_history = rental_history;
    }

    public String getRequested_date() {
        return requested_date;
    }

    public void setRequested_date(String requested_date) {
        this.requested_date = requested_date;
    }

    public String getPayment_date() {
        return payment_date;
    }

    public void setPayment_date(String payment_date) {
        this.payment_date = payment_date;
    }

    public int getMatching_req_id() {
        return matching_req_id;
    }

    public void setMatching_req_id(int matching_req_id) {
        this.matching_req_id = matching_req_id;
    }

    public String getPayment_status() {
        return payment_status;
    }

    public void setPayment_status(String payment_status) {
        this.payment_status = payment_status;
    }

    public int getMatching_done_id() {
        return matching_done_id;
    }

    public void setMatching_done_id(int matching_done_id) {
        this.matching_done_id = matching_done_id;
    }
}
