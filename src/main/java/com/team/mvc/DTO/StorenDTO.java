package com.team.mvc.DTO;

import java.util.Date;
import java.util.List;

public class StorenDTO {
    private EquipmentDTO equipmentDTO;                      //일반 장비 DTO
    private int storen_id, size_id, store_month;            //스토렌id, 장비코드, 사이즈id, 보관개월수
    private Integer equip_code;
    private String storen_title, storen_content;            //스토렌 제목, 상품내용
    private Integer daily_rent_price;                       //일일 렌탈가격
    private String created_date;                            //생성일(스토렌 신청일, 매칭 승인 시 티켓 생성일)

    private int user_code;

    private String equip_size_name;                         //사이즈 이름
    private int required_space, daily_storage_fee;          //필요 공간, 1일 보관가격
    private String type;

    // 검색 및 페이징 관련
    private String searchKeyword;
    private Pagenation pagenation;

    // 마이페이지 매칭내역 때문에 추가한 속성
    // 날짜 관련 속성------------------------------------------------------------------------------------------------------
    private String inspec_completed_date;                   //검수완료일=입고일

    private String rental_start_date;                       //렌탈시작일
                                // (=검수완료일+3일[창고->사용자])
    private String rental_end_date;                         //렌탈종료일
                                // (=입고일 + 보관개월수를 일자로 변환 - 3[사용자->창고] -3[창고->소유자])
    private String final_return_date;                       //최종반환일
                                // (=입고일 + 보관개월수)
    //-------------------------------------------------------------------------------------------------------날짜 관련 속성
    private Integer matching_request_count;                 //매칭수
    private String matching_status;                         //매칭상태(매칭중, 매칭완료)
    private MatchingRequestDTO matchingDTO;                 //매칭DTO
    private String matching_status_detail;                  //마이페이지-내가 대여한 장비에서 쓰기 위한 세부 매칭 상태

    //장비 등급 추가
    private String equip_grade;                             //장비등급이름

    // 장비 상태 추가
    private String status;                                  //장비상태

    // 추가된 필드: 이미지 리스트 및 평균가 비교 관련
    private List<AttachmentDTO> photoList;                  // 장비 사진 리스트
    private boolean otherBrand;                             // 기타 브랜드 여부
    private String priceFormatted;                          // 신품 가격 포맷 문자열
    private String avgPriceFormatted;                       // 평균 신품 가격 포맷 문자열
    private String avgRentalPriceFormatted;                 // 평균 렌탈 가격 포맷 문자열
    private int priceDiff;                                  // 가격 차이율
    private String priceDiffSymbol;                         // 상승/하락/중립 기호
    private String priceDiffClass;                          // 색상 클래스명
    private int avgRentalPrice;                             // 추가: 평균 렌탈 가격

    // 반환 관련 필드 추가
    private String recipient;
    private String tel;
    private String zipCode;
    private String address1;
    private String address2;
    private Date returnRequestDate;
    private Date returnCompletedDate;


    // Getter/Setter -----------------------------------------

    public EquipmentDTO getEquipmentDTO() {
        return equipmentDTO;
    }

    public void setEquipmentDTO(EquipmentDTO equipmentDTO) {
        this.equipmentDTO = equipmentDTO;
    }

    public int getStoren_id() {
        return storen_id;
    }

    public void setStoren_id(int storen_id) {
        this.storen_id = storen_id;
    }

    public int getSize_id() {
        return size_id;
    }

    public void setSize_id(int size_id) {
        this.size_id = size_id;
    }

    public int getStore_month() {
        return store_month;
    }

    public void setStore_month(int store_month) {
        this.store_month = store_month;
    }

    public Integer getEquip_code() {
        return equip_code;
    }

    public void setEquip_code(Integer equip_code) {
        this.equip_code = equip_code;
    }

    public String getStoren_title() {
        return storen_title;
    }

    public void setStoren_title(String storen_title) {
        this.storen_title = storen_title;
    }

    public String getStoren_content() {
        return storen_content;
    }

    public void setStoren_content(String storen_content) {
        this.storen_content = storen_content;
    }

    public Integer getDaily_rent_price() {
        return daily_rent_price;
    }

    public void setDaily_rent_price(Integer daily_rent_price) {
        this.daily_rent_price = daily_rent_price;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public int getUser_code() {
        return user_code;
    }

    public void setUser_code(int user_code) {
        this.user_code = user_code;
    }

    public String getEquip_size_name() {
        return equip_size_name;
    }

    public void setEquip_size_name(String equip_size_name) {
        this.equip_size_name = equip_size_name;
    }

    public int getRequired_space() {
        return required_space;
    }

    public void setRequired_space(int required_space) {
        this.required_space = required_space;
    }

    public int getDaily_storage_fee() {
        return daily_storage_fee;
    }

    public void setDaily_storage_fee(int daily_storage_fee) {
        this.daily_storage_fee = daily_storage_fee;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public Pagenation getPagenation() {
        return pagenation;
    }

    public void setPagenation(Pagenation pagenation) {
        this.pagenation = pagenation;
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

    public Integer getMatching_request_count() {
        return matching_request_count;
    }

    public void setMatching_request_count(Integer matching_request_count) {
        this.matching_request_count = matching_request_count;
    }

    public String getMatching_status() {
        return matching_status;
    }

    public void setMatching_status(String matching_status) {
        this.matching_status = matching_status;
    }

    public List<AttachmentDTO> getPhotoList() {
        return photoList;
    }

    public void setPhotoList(List<AttachmentDTO> photoList) {
        this.photoList = photoList;
    }

    public boolean isOtherBrand() {
        return otherBrand;
    }

    public void setOtherBrand(boolean otherBrand) {
        this.otherBrand = otherBrand;
    }

    public String getPriceFormatted() {
        return priceFormatted;
    }

    public void setPriceFormatted(String priceFormatted) {
        this.priceFormatted = priceFormatted;
    }

    public String getAvgPriceFormatted() {
        return avgPriceFormatted;
    }

    public void setAvgPriceFormatted(String avgPriceFormatted) {
        this.avgPriceFormatted = avgPriceFormatted;
    }

    public String getAvgRentalPriceFormatted() {
        return avgRentalPriceFormatted;
    }

    public void setAvgRentalPriceFormatted(String avgRentalPriceFormatted) {
        this.avgRentalPriceFormatted = avgRentalPriceFormatted;
    }

    public int getPriceDiff() {
        return priceDiff;
    }

    public void setPriceDiff(int priceDiff) {
        this.priceDiff = priceDiff;
    }

    public String getPriceDiffSymbol() {
        return priceDiffSymbol;
    }

    public void setPriceDiffSymbol(String priceDiffSymbol) {
        this.priceDiffSymbol = priceDiffSymbol;
    }

    public String getPriceDiffClass() {
        return priceDiffClass;
    }

    public void setPriceDiffClass(String priceDiffClass) {
        this.priceDiffClass = priceDiffClass;
    }

    public int getAvgRentalPrice() {
        return avgRentalPrice;
    }

    public void setAvgRentalPrice(int avgRentalPrice) {
        this.avgRentalPrice = avgRentalPrice;
    }

    public String getEquip_grade() {
        return equip_grade;
    }

    public void setEquip_grade(String equip_grade) {
        this.equip_grade = equip_grade;
    }

    public String getInspec_completed_date() {
        return inspec_completed_date;
    }

    public void setInspec_completed_date(String inspec_completed_date) {
        this.inspec_completed_date = inspec_completed_date;
    }

    public String getFinal_return_date() {
        return final_return_date;
    }

    public void setFinal_return_date(String final_return_date) {
        this.final_return_date = final_return_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public MatchingRequestDTO getMatchingDTO() {
        return matchingDTO;
    }

    public void setMatchingDTO(MatchingRequestDTO matchingDTO) {
        this.matchingDTO = matchingDTO;
    }

    public String getMatching_status_detail() {
        return matching_status_detail;
    }

    public void setMatching_status_detail(String matching_status_detail) {
        this.matching_status_detail = matching_status_detail;
    }

    // 반환 관련 필드 getter/setter
    public String getRecipient() { return recipient; }
    public void setRecipient(String recipient) { this.recipient = recipient; }

    public String getTel() { return tel; }
    public void setTel(String tel) { this.tel = tel; }

    public String getZipCode() { return zipCode; }
    public void setZipCode(String zipCode) { this.zipCode = zipCode; }

    public String getAddress1() { return address1; }
    public void setAddress1(String address1) { this.address1 = address1; }

    public String getAddress2() { return address2; }
    public void setAddress2(String address2) { this.address2 = address2; }

    public Date getReturnRequestDate() { return returnRequestDate; }
    public void setReturnRequestDate(Date returnRequestDate) { this.returnRequestDate = returnRequestDate; }

    public Date getReturnCompletedDate() { return returnCompletedDate; }
    public void setReturnCompletedDate(Date returnCompletedDate) { this.returnCompletedDate = returnCompletedDate; }

}
