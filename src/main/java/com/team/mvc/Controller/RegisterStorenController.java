package com.team.mvc.Controller;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.RegisterStorenDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IRegisterStorenDAO;
import com.team.mvc.Interface.IStorenDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.*;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Controller
public class RegisterStorenController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value ="/storenRegister-storage-info.action", method = RequestMethod.GET)
    public String getEquipInfo(@RequestParam("equip_code") int equipCode,
                               @ModelAttribute("userCode") Integer userCode,
                               Model model) {
        IRegisterStorenDAO dao = sqlSession.getMapper(IRegisterStorenDAO.class);
        RegisterStorenDTO dto = dao.getEquipInfo(equipCode);

        model.addAttribute("equipInfo", dto);
        model.addAttribute("userCode", userCode);

        // 장비 사진 정보 조회
        IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);
        List<AttachmentDTO> photoList = attachmentDAO.listAttachmentByEquipCode(equipCode);
        System.out.println("장비 코드 " + equipCode + "의 사진 개수: " + (photoList != null ? photoList.size() : "null"));

        if (photoList != null && !photoList.isEmpty()) {
            for (int i = 0; i < photoList.size(); i++) {
                AttachmentDTO photo = photoList.get(i);
                System.out.println("사진 " + (i+1) + " 경로: " + photo.getAttachmentPath());
            }
        }

        Map<String, Object> infoMap = new HashMap<>();
        infoMap.put("photoList", photoList);
        model.addAttribute("info", infoMap);

        // 신품 가격 비교를 위한 평균 가격 정보 가져오기
        try {
            IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

            // 장비명 기준으로 평균 가격 조회
            int avgNewPrice = storenDAO.getAvgNewPriceByEquipName(dto.getEquip_name());

            // 포맷팅 및 가격 차이 계산
            NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
            String formattedAvgPrice = nf.format(avgNewPrice);

            // 가격 차이 계산 (퍼센트)
            int priceDiff = 0;
            String priceDiffSymbol = "";
            String priceDiffClass = "text-secondary";

            if (avgNewPrice > 0) {
                priceDiff = Math.round((dto.getOriginal_price() - avgNewPrice) / (float)avgNewPrice * 100);
                if (priceDiff > 0) {
                    priceDiffSymbol = "▲";
                    priceDiffClass = "text-coral";
                } else if (priceDiff < 0) {
                    priceDiffSymbol = "▼";
                    priceDiffClass = "text-success";
                    priceDiff = Math.abs(priceDiff);
                }
            }

            // 가격 관련 정보 모델에 추가
            model.addAttribute("avgNewPrice", avgNewPrice);
            model.addAttribute("formattedAvgPrice", formattedAvgPrice);
            model.addAttribute("priceDiff", priceDiff);
            model.addAttribute("priceDiffSymbol", priceDiffSymbol);
            model.addAttribute("priceDiffClass", priceDiffClass);
        } catch (Exception e) {
            // 평균 가격 조회 실패 시 에러 처리 (기본값은 모델에 이미 추가됨)
        }

        return "storenRegister-storage-info";
    }
}