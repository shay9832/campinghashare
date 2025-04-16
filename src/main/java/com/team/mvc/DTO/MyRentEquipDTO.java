package com.team.mvc.DTO;

import java.util.ArrayList;
import java.util.List;

// 상위 DTO
public class MyRentEquipDTO {
    private int user_code;
    private List<MyRentalItemDTO> rentalItems;

    // 생성자, getter, setter
    public MyRentEquipDTO() {}

    public MyRentEquipDTO(int user_code) {
        this.user_code = user_code;
        this.rentalItems = new ArrayList<>();
    }

    public int getUser_code() {
        return user_code;
    }

    public void setUser_code(int user_code) {
        this.user_code = user_code;
    }

    public List<MyRentalItemDTO> getRentalItems() {
        return rentalItems;
    }

    public void setRentalItems(List<MyRentalItemDTO> rentalItems) {
        this.rentalItems = rentalItems;
    }

    public void addRentalItem(MyRentalItemDTO item) {
        if (this.rentalItems == null) {
            this.rentalItems = new ArrayList<>();
        }
        this.rentalItems.add(item);
    }
}

