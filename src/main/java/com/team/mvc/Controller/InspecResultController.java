package com.team.mvc.Controller;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.InspecResultDTO;
import com.team.mvc.DTO.UserDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IInspecResultDAO;
import com.team.mvc.Interface.IUserDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class InspecResultController {

    @Autowired
    private SqlSession sqlSession;

    // 검수 결과 상세 페이지 진입
    @GetMapping("/inspec-result.action")
    public String inspecResult(@RequestParam("storen_id") int storenId,
                               Model model,
                               @ModelAttribute("userCode") Integer userCode) {

        IInspecResultDAO inspecDao = sqlSession.getMapper(IInspecResultDAO.class);
        IAttachmentDAO attachDao = sqlSession.getMapper(IAttachmentDAO.class);

        List<InspecResultDTO> resultList = inspecDao.getResultListByStorenId(storenId);

        List<InspecResultDTO> resultList1st = resultList.stream()
                .filter(r -> "1차검수".equals(r.getInspecType()))
                .collect(Collectors.toList());

        List<InspecResultDTO> resultList2nd = resultList.stream()
                .filter(r -> "2차검수".equals(r.getInspecType()))
                .collect(Collectors.toList());

        if (!resultList.isEmpty()) {
            InspecResultDTO info = resultList.get(0);
            model.addAttribute("equipmentCategory", info.getEquipmentCategory());
            model.addAttribute("equipmentSubCategory", info.getEquipmentSubCategory());
            model.addAttribute("brand", info.getBrand());
            model.addAttribute("equipmentName", info.getEquipmentName());
            model.addAttribute("equipmentSize", info.getEquipmentSize());
            model.addAttribute("storenId", info.getStorenId());

            int equipCode = info.getEquipCode();
            List<AttachmentDTO> attachmentList = attachDao.listAttachmentByEquipCode(equipCode);
            model.addAttribute("equipmentImages", attachmentList);
        }

        if (!resultList.isEmpty()) {
            int totalScore = resultList.get(resultList.size() - 1).getTotalScore();
            model.addAttribute("totalScore", totalScore);
        }

        model.addAttribute("inspectionResults1st", resultList1st);
        model.addAttribute("inspectionResults2nd", resultList2nd);
        model.addAttribute("userCode", userCode);

        return "storenRegister-inspecResult";
    }

    // F등급 이하일 경우 반환 주소 입력 페이지 진입
    @GetMapping("/storenRegister-inspecResult-return.action")
    public String returnAddressForm(@RequestParam("storen_id") int storenId,
                                    @ModelAttribute("userCode") Integer userCode,
                                    Model model) {

        IUserDAO userDao = sqlSession.getMapper(IUserDAO.class);
        UserDTO user = userDao.getFullUserInfoByUserCode(userCode);

        // 전달할 사용자 정보
        model.addAttribute("recipient", user.getUserName());
        model.addAttribute("tel", user.getUserTel());
        model.addAttribute("zipCode", user.getZipCode());
        model.addAttribute("address1", user.getAddress1());
        model.addAttribute("address2", user.getAddress2());
        model.addAttribute("storenId", storenId);

        return "storenRegister-inspecResult-return";
    }
}
