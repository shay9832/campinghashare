package com.team.mvc.DTO;

import java.util.List;
import java.util.Map;

public class StorenRequestDTO {
    private StorenDTO storenDto;
    private UserDTO userDto;

    public StorenRequestDTO() {}

    public StorenRequestDTO(StorenDTO storenDto, UserDTO userDto) {
        this.storenDto = storenDto;
        this.userDto = userDto;
    }

    public StorenDTO getStorenDto() {
        return storenDto;
    }

    public void setStorenDto(StorenDTO storenDto) {
        this.storenDto = storenDto;
    }

    public UserDTO getUserDto() {
        return userDto;
    }

    public void setUserDto(UserDTO userDto) {
        this.userDto = userDto;
    }
}
