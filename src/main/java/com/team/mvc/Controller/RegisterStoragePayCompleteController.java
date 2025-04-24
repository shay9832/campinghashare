package com.team.mvc.Controller;

import com.team.mvc.DTO.RegisterStorenPayDTO;
import com.team.mvc.Interface.IRegisterStorenPayDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterStoragePayCompleteController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value = "storenRegister-storage-pay-complete.action", method = RequestMethod.POST)
    public String storenRegisterStoragePayComplete(@RequestParam("equip_code") int equipCode,
                                                   @RequestParam("equipSize") String equipSize,
                                                   @RequestParam("storageDays") int storageDays,
                                                   @RequestParam("zipcode") String zipcode,
                                                   @RequestParam("address1") String address1,
                                                   @RequestParam("address2") String address2,
                                                   @RequestParam("finalStorageCost") int finalStorageCost,
                                                   @ModelAttribute("userCode") Integer userCode,
                                                   Model model) {

        // 주소 유효성 검사
        if (zipcode == null || zipcode.trim().isEmpty()
                || address1 == null || address1.trim().isEmpty()
                || address2 == null || address2.trim().isEmpty()) {

            model.addAttribute("errorMsg", "배송지 정보를 모두 입력해주세요.");
            model.addAttribute("equip_code", equipCode);
            model.addAttribute("equipSize", equipSize);
            model.addAttribute("storageDays", storageDays);
            model.addAttribute("finalStorageCost", finalStorageCost);
            return "storenRegister-storage-pay-info";
        }

        IRegisterStorenPayDAO dao = sqlSession.getMapper(IRegisterStorenPayDAO.class);

        // 1. payDto에 필요한 값 세팅
        RegisterStorenPayDTO payDto = new RegisterStorenPayDTO();
        payDto.setEquipCode(equipCode);
        payDto.setEquipSize(equipSize);
        payDto.setStorageDays(storageDays);
        payDto.setUserCode(userCode);
        payDto.setFinalStorageCost(finalStorageCost);

        System.out.println("insertStorenEntry equipSize: " + equipSize);
        System.out.println("insertStorenEntry equipSize: " + payDto.getEquipSize());
        System.out.println("equipCode: " + payDto.getEquipCode());
        System.out.println("storageDays: " + payDto.getStorageDays());
        System.out.println("storenId (예정): " + payDto.getStorenId());

        // 2. STOREN insert 실행 및 결과 확인
        int insertResult = dao.insertStorenEntry(payDto);
        if (insertResult == 0) {
            model.addAttribute("errorMsg", "보관 정보 저장에 실패했습니다.");
            model.addAttribute("equip_code", equipCode);
            model.addAttribute("equipSize", equipSize);
            model.addAttribute("storageDays", storageDays);
            model.addAttribute("finalStorageCost", finalStorageCost);
            return "storenRegister-storage-pay-info";  // 다시 이전 화면으로
        }

        System.out.println("==[PAY 등록 직전 로그]==");
        System.out.println("EQUIP SIZE: " + payDto.getEquipSize());
        System.out.println("EQUIP CODE: " + payDto.getEquipCode());
        System.out.println("USER CODE : " + payDto.getUserCode());

        // 3. PAY insert
        dao.insertStorenStoragePayment(payDto);

        // 4. 주소 로그 insert (기존대로)
        RegisterStorenPayDTO addrDto = new RegisterStorenPayDTO();
        addrDto.setUserCode(userCode);
        addrDto.setZipcode(zipcode);
        addrDto.setAddress1(address1);
        addrDto.setAddress2(address2);
        dao.insertAddressLog(addrDto);


        model.addAttribute("equipName", "스토렌(보관비)");
        return "storenRegister-storage-pay-complete";
    }
}