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

import java.util.List;

@Controller
public class InspecResultController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("/inspec-result.action")
    public String inspecResultByStorenId(@RequestParam("storen_id") Integer storenId,
                                         @SessionAttribute("userCode") Integer loginUserCode,
                                         Model model) {
        IInspecResultDAO inspecResultDAO = sqlSession.getMapper(IInspecResultDAO.class);
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);
        IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

        // platformDeliveryId, platformDeliveryReturnId 조회
        Integer platformDeliveryId = inspecResultDAO.getDeliveryIdByStorenId(storenId);
        Integer platformDeliveryReturnId = inspecResultDAO.getReturnDeliveryIdByStorenId(storenId);
        Integer equipCode = inspecResultDAO.getEquipCodeByStorenId(storenId);

        if (platformDeliveryId == null) {
            model.addAttribute("error", "검수 정보를 찾을 수 없습니다.");
            return "error";
        }

        // 1차 검수
        InspecResultDTO firstInspect = null;
        try {
            firstInspect = inspecResultDAO.getInspectResultByDeliveryId(platformDeliveryId);
            if (firstInspect != null) {
                List<InspecItemDetail> list = inspecResultDAO.getItemListByDeliveryId(platformDeliveryId);
                firstInspect.setItemList(list);
                System.out.println("first itemList size = " + (list != null ? list.size() : "null"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("firstInspect", firstInspect);

        // 2차 검수 (있을 경우)
        InspecResultDTO secondInspect = null;
        try {
            if (platformDeliveryReturnId != null) {
                secondInspect = inspecResultDAO.getInspectResultByReturnDeliveryId(platformDeliveryReturnId);
                if (secondInspect != null) {
                    secondInspect.setItemList(inspecResultDAO.getItemListByReturnDeliveryId(platformDeliveryReturnId));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("secondInspect", secondInspect);

        // 장비 사진
        try {
            if (equipCode != null) {
                List<AttachmentDTO> equipmentImages = attachmentDAO.listAttachmentByEquipCode(equipCode);
                model.addAttribute("equipmentImages", equipmentImages);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // storen 정보
        StorenDTO storen = null;
        try {
            storen = storenDAO.getStorenByStorenId(storenId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("storen", storen);

        // 로그인 유저가 소유자인지 판단
        boolean isOwner = storen != null && storen.getUser_code() == loginUserCode;
        model.addAttribute("isOwner", isOwner);

        // 장비 등급 판단
        String grade = null;
        try {
            grade = (platformDeliveryReturnId != null)
                    ? inspecResultDAO.getFinalEquipGradeByReturnDeliveryId(platformDeliveryReturnId)
                    : inspecResultDAO.getFinalEquipGradeByDeliveryId(platformDeliveryId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("equipGrade", grade);

        // 반환 주소 등록 여부
        boolean hasReturnAddress = false;
        try {
            hasReturnAddress = inspecResultDAO.hasReturnAddressByStorenId(storenId) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("hasReturnAddress", hasReturnAddress);

        model.addAttribute("storen_id", storenId);
        return "storenRegister-inspecResult";
    }

    @RequestMapping(value = "/storenRegister-inspecResult-return.action", method = RequestMethod.GET)
    public String returnAddressForm(@RequestParam("storen_id") int storenId,
                                    @SessionAttribute("userCode") Integer userCode,
                                    Model model) {
        try {
            IStorenDAO dao = sqlSession.getMapper(IStorenDAO.class);
            IUserDAO userDAO = sqlSession.getMapper(IUserDAO.class);

            StorenDTO info = dao.getStorenByStorenId(storenId);
            if (info == null || info.getUser_code() != userCode) {
                model.addAttribute("error", "접근 권한이 없습니다.");
                return "error";
            }

            UserDTO user = userDAO.getFullUserInfoByUserCode(userCode);
            if (user != null) {
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
