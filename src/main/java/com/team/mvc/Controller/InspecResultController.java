package com.team.mvc.Controller;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.InspecResultDTO;
import com.team.mvc.DTO.InspecResultDTO.InspecItemDetail;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IInspecResultDAO;
import com.team.mvc.Interface.IStorenDAO;
import com.team.mvc.Interface.IUserDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


@Controller
public class InspecResultController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("/inspec-result.action")
    public String inspecResultByStorenId(@RequestParam("storen_id") Integer storenId, Model model) {
        IInspecResultDAO inspecResultDAO = sqlSession.getMapper(IInspecResultDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

        // storen_id로 platformDeliveryId와 platformDeliveryReturnId 찾기
        Integer platformDeliveryId = inspecResultDAO.getDeliveryIdByStorenId(storenId);
        Integer platformDeliveryReturnId = inspecResultDAO.getReturnDeliveryIdByStorenId(storenId);

        // 장비 코드 가져오기
        Integer equipCode = inspecResultDAO.getEquipCodeByStorenId(storenId);

        if (platformDeliveryId == null) {
            // 배송 ID를 찾을 수 없는 경우 처리
            return "redirect:/mypage-inspecList.action";
        }

        // 검수 결과 데이터 로드
        InspecResultDTO firstInspect = inspecResultDAO.getInspectResultByDeliveryId(platformDeliveryId);
        List<InspecItemDetail> firstDetailList = inspecResultDAO.getItemListByDeliveryId(platformDeliveryId);
        firstInspect.setItemList(firstDetailList);
        model.addAttribute("firstInspect", firstInspect);

        // 반환 배송 ID가 있는 경우 2차 검수 결과도 로드
        if (platformDeliveryReturnId != null) {
            InspecResultDTO secondInspect = inspecResultDAO.getInspectResultByReturnDeliveryId(platformDeliveryReturnId);
            List<InspecItemDetail> secondDetailList = inspecResultDAO.getItemListByReturnDeliveryId(platformDeliveryReturnId);
            secondInspect.setItemList(secondDetailList);
            model.addAttribute("secondInspect", secondInspect);
        }

        // 장비 사진 가져오기
        if (equipCode != null) {
            List<AttachmentDTO> equipmentImages = attachmentDAO.listAttachmentByEquipCode(equipCode);
            model.addAttribute("equipmentImages", equipmentImages);
        }

        model.addAttribute("storen_id", storenId);

        return "storenRegister-inspecResult";
    }

    // F등급 장비 반환 주소 입력 페이지
    @RequestMapping(value = "/storenRegister-inspecResult-return.action", method = RequestMethod.GET)
    public String returnAddressForm(@RequestParam("storen_id") int storenId,
                                    @ModelAttribute("userCode") Integer userCode,
                                    Model model) {
        try {
            IStorenDAO dao = sqlSession.getMapper(IStorenDAO.class);

            // storen_id로 스토렌 정보 조회
            StorenDTO info = dao.getStorenByStorenId(storenId);

            // 권한 검증: 로그인 사용자가 등록한 장비인지 확인
            if (info == null || info.getUser_code() != userCode) {
                model.addAttribute("error", "접근 권한이 없습니다.");
                return "error";
            }

            // 사용자 정보 조회
            IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);
            UserDTO user = userDAO.getFullUserInfoByUserCode(userCode);

            if (user != null) {
                // UserDTO의 실제 필드명과 getter 메서드에 맞게 설정
                model.addAttribute("recipient", user.getUserName());
                model.addAttribute("tel", user.getUserTel());
                model.addAttribute("zipCode", user.getZipCode());
                model.addAttribute("address1", user.getAddress1());
                model.addAttribute("address2", user.getAddress2());
            }

            model.addAttribute("storen_id", storenId);

            return "storenRegister-inspecResult-return";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "반환 정보를 불러오는 중 오류 발생");
            return "error";
        }
    }
}