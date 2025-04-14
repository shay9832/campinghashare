package com.team.mvc.Service;

import com.team.mvc.DTO.MypageInspecListDTO;
import com.team.mvc.Interface.IMypageInspecListDAO;
import com.team.mvc.Interface.IMypageInspecListService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MypageInspecListService implements IMypageInspecListService {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<MypageInspecListDTO> listStorenStoreInspec(int user_code) {
        IMypageInspecListDAO dao = sqlSession.getMapper(IMypageInspecListDAO.class);
        List<MypageInspecListDTO> list = dao.listStorenStoreByUserCode(user_code);
        processInspecList(list);
        return list;
    }

    @Override
    public List<MypageInspecListDTO> listStorenReturnInspec(int user_code) {
        IMypageInspecListDAO dao = sqlSession.getMapper(IMypageInspecListDAO.class);
        List<MypageInspecListDTO> list = dao.listStorenReturnByUserCode(user_code);
        processInspecList(list);
        return list;
    }

    @Override
    public List<MypageInspecListDTO> listStorageStoreInspec(int user_code) {
        IMypageInspecListDAO dao = sqlSession.getMapper(IMypageInspecListDAO.class);
        List<MypageInspecListDTO> list = dao.listStorageStoreByUserCode(user_code);
        processInspecList(list);
        return list;
    }

    // 검수 목록 데이터 가공 메소드
    private void processInspecList(List<MypageInspecListDTO> list) {
        if (list == null) return;

        for (MypageInspecListDTO dto : list) {
            // 검수 완료 여부를 확인
            boolean isInspectionCompleted = !(dto.getInspec_status() != null &&
                    dto.getInspec_status().contains("대기")) &&
                    dto.getEquip_grade() != null;

            // null 값 처리
            if (dto.getEquip_grade() == null) {
                dto.setEquip_grade("N/A");
            }

            // 검수가 완료되지 않았다면 처리 유형과 날짜를 기본값으로 설정
            if (!isInspectionCompleted) {
                if (dto.getInspec_result_action_type() == null ||
                        dto.getInspec_result_action_type().equals("null")) {
                    dto.setInspec_result_action_type("검수 대기중");
                }

                if (dto.getCompleted_date() == null ||
                        dto.getCompleted_date().equals("null")) {
                    dto.setCompleted_date("검수 전");
                }
            }
        }
    }
}