package com.team.mvc.Service;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchMatchingRequestService implements ISearchMatchingRequestService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public StorenRequestDTO getStoren(int transactionId) {
        System.out.println("== SearchMatchingRequestService : getStoren : START ==");
        // dao객체 생성
        IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);
        IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);

        // 거래id로 스토렌 가져오기
        StorenDTO storenDto = storenDAO.getStorenByStorenId(transactionId);
        // 스토렌의 장비코드로 장비 정보 가져오기
        EquipmentDTO equipmentDto = equipDao.getEquipmentByEquipCode(storenDto.getEquip_code());

        // 스토렌에 장비 정보 넣어주기
        storenDto.setEquipmentDTO(equipmentDto);

        System.out.println("OWNER userCode : " + equipmentDto.getUser_code());

        // 해당 장비의 소유자 정보 가져오기
        UserDTO userDto = userDAO.getUserByUserCode(equipmentDto.getUser_code());

        System.out.println("== SearchMatchingRequestService : getStoren : END ==");

        // 스토렌Dto 반환
        return new StorenRequestDTO(storenDto, userDto);
    }

    @Override
    public boolean insertMatchingRequest(int storenId, int user_code, String rentalStartDate, String rentalEndDate) {
        System.out.println("== SearchMatchingRequestService : insertMatchingRequest : START ==");
        // dao객체 생성
        IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);

        // 매개변수로 넣을 matchingDto 세팅
        MatchingRequestDTO matchingDto = new MatchingRequestDTO();

        System.out.println("storenId : " + storenId);

        matchingDto.setTransaction_id(storenId);
        matchingDto.setUser_code(user_code);
        matchingDto.setRental_start_date(rentalStartDate);
        matchingDto.setRental_end_date(rentalEndDate);

        // DB에 insert 후 영향받은 행 개수 반환
        int result = matchingDao.insertStorenMatchingRequest(matchingDto);

        if (result == 1) {
            System.out.println("== SearchMatchingRequestService : insertMatchingRequest : TRUE ==");
            return true;
        }
        else {
            System.out.println("== SearchMatchingRequestService : insertMatchingRequest : FALSE ==");
            return false;
        }
    }

    @Override
    public MatchingRequestDTO getMatchingByStorenAndUser(int storenId, int user_code) {
        System.out.println("== SearchMatchingRequestService : getMatchingByStorenAndUser : START ==");

        // dao 생성
        IMatchingRequestDAO matchingDao = sqlSession.getMapper(IMatchingRequestDAO.class);
        MatchingRequestDTO matchingDto = new MatchingRequestDTO();

        matchingDto = matchingDao.getMatchingByStorenAndUser(storenId, user_code);

        if (matchingDto == null) {
            System.out.println("== SearchMatchingRequestService : getMatchingByStorenAndUser : FALSE ==");
            return null;
        }
        else {
            System.out.println("== SearchMatchingRequestService : getMatchingByStorenAndUser : TRUE ==");
            return matchingDto;
        }
    }
}
