package com.team.mvc.DTO;

import java.util.List;

public class MyPayDTO {
    private UserDTO user;
    private List<CouponDTO> coupons;
    private StorenDTO storen;
    private MatchingRequestDTO matching_request;
    private AdminPaymentDTO admin_payment;

    public MyPayDTO() {}

    // 결제하기 전, 결제 정보 출력 페이지에 보내줄 DTO 구성
    public MyPayDTO(UserDTO user, List<CouponDTO> coupons, StorenDTO storen, MatchingRequestDTO matching_request) {
        this.user = user;
        this.coupons = coupons;
        this.storen = storen;
        this.matching_request = matching_request;
    }
    //결제 후, 결제 확인 출력 페이지에 보내줄 DTO 구성
    public MyPayDTO(MyPayDTO myPayDTO, MatchingRequestDTO matching_request) {
        this.matching_request = matching_request;
        this.admin_payment = myPayDTO.getAdmin_payment();
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public List<CouponDTO> getCoupons() {
        return coupons;
    }

    public void setCoupons(List<CouponDTO> coupons) {
        this.coupons = coupons;
    }

    public StorenDTO getStoren() {
        return storen;
    }

    public void setStoren(StorenDTO storen) {
        this.storen = storen;
    }

    public MatchingRequestDTO getMatching_request() {
        return matching_request;
    }

    public void setMatching_request(MatchingRequestDTO matching_request) {
        this.matching_request = matching_request;
    }

    public AdminPaymentDTO getAdmin_payment() {
        return admin_payment;
    }

    public void setAdmin_payment(AdminPaymentDTO admin_payment) {
        this.admin_payment = admin_payment;
    }
}
