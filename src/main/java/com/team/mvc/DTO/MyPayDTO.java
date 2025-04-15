package com.team.mvc.DTO;

import java.util.List;

public class MyPayDTO {
    private UserDTO user;
    private List<CouponDTO> coupons;
    private StorenDTO storen;
    private MatchingRequestDTO matching_request;

    public MyPayDTO() {}

    public MyPayDTO(UserDTO user, List<CouponDTO> coupons, StorenDTO storen, MatchingRequestDTO matching_request) {
        this.user = user;
        this.coupons = coupons;
        this.storen = storen;
        this.matching_request = matching_request;
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
}
