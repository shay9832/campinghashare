package com.team.mvc.DTO;

public class StorenDTO {
    private EquipmentDTO equipmentDTO;                      //일반 장비 DTO
    private int storen_id, equip_code, size_id, store_month;//스토렌id, 장비코드, 사이즈id, 보관개월수
    private String storen_title, storen_content;            //스토렌 제목, 상품내용
    private Integer daily_rent_price;                       //일일 렌탈가격
    private String created_date;                            //생성일

    private int user_code;

    private String equip_size_name;                         //사이즈 이름
    private int required_space, daily_storage_fee;          //필요 공간, 1일 보관가격
    private String type;

    // 검색 및 페이징 관련
    private String searchKeyword;
    private Pagenation pagenation;

    // 마이페이지 매칭내역 때문에 추가한 속성
    private String rental_start_date;                       //렌탈시작일(=검수 후 입고일)
    private String rental_end_date;                         //렌탈종료일(=입고일 + 보관개월수를 일자로 변환)
    private Integer matching_request_count;                 //매칭수
    private String matching_status;                         //매칭상태

    //장비 등급 추가
    private String equip_grade;                             //장비등급이름

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

    public int getEquip_code() {
        return equip_code;
    }

    public void setEquip_code(int equip_code) {
        this.equip_code = equip_code;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getEquip_grade() {
        return equip_grade;
    }

    public void setEquip_grade(String equip_grade) {
        this.equip_grade = equip_grade;
    }
}
