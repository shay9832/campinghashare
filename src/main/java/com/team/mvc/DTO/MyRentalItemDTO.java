package com.team.mvc.DTO;

// 하위 DTO
public class MyRentalItemDTO {
    private MatchingRequestDTO matching;
    private StorenDTO storen;
    private AdminPaymentDTO payment;

    // 생성자, getter, setter
    public MyRentalItemDTO() {}

    public MatchingRequestDTO getMatching() {
        return matching;
    }

    public void setMatching(MatchingRequestDTO matching) {
        this.matching = matching;
    }

    public StorenDTO getStoren() {
        return storen;
    }

    public void setStoren(StorenDTO storen) {
        this.storen = storen;
    }

    public AdminPaymentDTO getPayment() {
        return payment;
    }

    public void setPayment(AdminPaymentDTO payment) {
        this.payment = payment;
    }
}
