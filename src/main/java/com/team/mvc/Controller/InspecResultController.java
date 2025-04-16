package com.team.mvc.Controller;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.InspecResultDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IInspecResultDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.stream.Collectors;

@Controller
public class InspecResultController {

    @Autowired
    private SqlSession sqlSession;

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

        model.addAttribute("inspectionResults1st", resultList1st);
        model.addAttribute("inspectionResults2nd", resultList2nd);
        model.addAttribute("userCode", userCode);

        return "storenRegister-inspecResult";
    }
}