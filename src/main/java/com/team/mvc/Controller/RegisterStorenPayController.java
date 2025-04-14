package com.team.mvc.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterStorenPayController {

    @Autowired
    private SqlSession sqlSession;

    // GET과 POST 모두 처리
    @RequestMapping(value="storenRegister-storage-pay.action", method={RequestMethod.GET, RequestMethod.POST})
    public String getPay(@RequestParam("equip_id") int equip_id,
                         @RequestParam("equipName") String equipName,
                         @RequestParam("majorCategory") String majorCategory,
                         @RequestParam("middleCategory") String middleCategory,
                         @RequestParam("brand") String brand,
                         @RequestParam("equipSize") String equipSize,
                         @RequestParam("storageDays") int storageDays,
                         @RequestParam("storageCost") int storageCost,
                         Model model) {

        // 기존 코드 유지
        model.addAttribute("equip_id", equip_id);
        model.addAttribute("equipName", equipName);
        model.addAttribute("majorCategory", majorCategory);
        model.addAttribute("middleCategory", middleCategory);
        model.addAttribute("brand", brand);
        model.addAttribute("equipSize", equipSize);
        model.addAttribute("storageDays", storageDays);
        model.addAttribute("storageCost", storageCost);

        model.addAttribute("discountAmount", 20000);

        return "storenRegister-storage-pay";
    }
}