package com.team.mvc.Controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.Interface.IStorenDAO;
import com.team.mvc.Interface.IAttachmentDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@Controller
public class StorenController {

    @Autowired
    private SqlSession sqlSession;

    // 렌탈 등록 화면 진입
    @RequestMapping(value = "/storenRegister-rentalRegister.action", method = RequestMethod.GET)
    public String rentalForm(@RequestParam("storen_id") int storenId, Model model) {
        try {
            IStorenDAO dao = sqlSession.getMapper(IStorenDAO.class);
            IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

            // storen_id로만 정보 조회
            StorenDTO info = dao.getRentalInfoByStorenId(storenId);

            if (info == null) {
                System.err.println("[ERROR] StorenDTO가 null입니다. storen_id = " + storenId);
                model.addAttribute("error", "장비 정보를 불러올 수 없습니다.");
                return "error";
            }

            // storen_id를 모델에 추가
            model.addAttribute("storen_id", storenId);

            // EquipmentDTO가 null인 경우 새로 생성하여 할당
            if (info.getEquipmentDTO() == null) {
                EquipmentDTO equipmentDTO = new EquipmentDTO();
                equipmentDTO.setEquip_code(info.getEquip_code());
                info.setEquipmentDTO(equipmentDTO);
            }

            // 사진 불러오기
            List<AttachmentDTO> photoList = attachmentDAO.listAttachmentByEquipCode(info.getEquip_code());
            info.setPhotoList(photoList);

            // 장비명으로 평균가 관련 데이터 가져오기
            String equipName = info.getEquipmentDTO().getEquip_name();
            int avgNewPrice = 0;
            int avgRentalPrice = 0;

            // 장비명이 있으면 장비명 기준, 없으면 장비코드 기준으로 평균 가격 조회
            if (equipName != null && !equipName.isEmpty()) {
                avgNewPrice = dao.getAvgNewPriceByEquipName(equipName);
                avgRentalPrice = dao.getAvgRentalPriceByEquipName(equipName);

                System.out.println("[DEBUG] 장비명으로 평균 가격 조회: " + equipName);
                System.out.println("[DEBUG] 평균 신품 가격: " + avgNewPrice);
                System.out.println("[DEBUG] 평균 렌탈 가격: " + avgRentalPrice);
            } else {
                avgNewPrice = dao.getAvgNewPrice(info.getEquip_code());
                avgRentalPrice = dao.getAvgRentalPrice(info.getEquip_code());

                System.out.println("[DEBUG] 장비코드로 평균 가격 조회: " + info.getEquip_code());
                System.out.println("[DEBUG] 평균 신품 가격: " + avgNewPrice);
                System.out.println("[DEBUG] 평균 렌탈 가격: " + avgRentalPrice);
            }

            // avgRentalPrice 설정
            info.setAvgRentalPrice(avgRentalPrice);

            // 신품 가격 추출 및 null 체크
            Integer rawPrice = info.getEquipmentDTO().getOriginal_price();
            int newPrice = (rawPrice != null) ? rawPrice : 0;

            // 브랜드 기타 여부
            boolean isOtherBrand = "기타".equals(info.getEquipmentDTO().getBrand());
            info.setOtherBrand(isOtherBrand);

            // 가격 비교 로직
            if (!isOtherBrand) {
                int priceDiff = 0;
                if (avgNewPrice > 0) {
                    priceDiff = (int) (((double) (newPrice - avgNewPrice) / avgNewPrice) * 100);
                }
                String priceDiffSymbol = priceDiff > 0 ? "▲" : priceDiff < 0 ? "▼" : "-";
                String priceDiffClass = priceDiff > 0 ? "text-coral" : priceDiff < 0 ? "text-success" : "text-secondary";

                info.setPriceDiff(Math.abs(priceDiff));
                info.setPriceDiffSymbol(priceDiffSymbol);
                info.setPriceDiffClass(priceDiffClass);
            }

            // 포맷 처리
            NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
            info.setPriceFormatted(nf.format(newPrice));
            info.setAvgPriceFormatted(nf.format(avgNewPrice));
            info.setAvgRentalPriceFormatted(nf.format(avgRentalPrice));

            model.addAttribute("info", info);

            // 디버그용 출력
            System.out.println("[DEBUG-FINAL] info JSON: " + new ObjectMapper().writeValueAsString(info));
            System.out.println("[DEBUG] storen_id: " + storenId);
            System.out.println("[DEBUG] info.equip_size_name: " + info.getEquip_size_name());
            System.out.println("[DEBUG] info.store_month: " + info.getStore_month());
            System.out.println("[DEBUG] info.priceFormatted: " + info.getPriceFormatted());
            System.out.println("[DEBUG] info.avgRentalPrice: " + info.getAvgRentalPrice());
            System.out.println("[DEBUG] info.avgRentalPriceFormatted: " + info.getAvgRentalPriceFormatted());

            if (info.getEquipmentDTO() != null) {
                System.out.println("[DEBUG] equipmentDTO.equip_name: " + info.getEquipmentDTO().getEquip_name());
                System.out.println("[DEBUG] equipmentDTO.brand: " + info.getEquipmentDTO().getBrand());
                System.out.println("[DEBUG] equipmentDTO.majorCategory: " + info.getEquipmentDTO().getMajorCategory());
                System.out.println("[DEBUG] equipmentDTO.middleCategory: " + info.getEquipmentDTO().getMiddleCategory());
            }

            return "storenRegister-rentalRegister";

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("[Controller ERROR] " + e.getMessage());
            model.addAttribute("error", "렌탈 등록 정보를 불러오는 중 오류 발생");
            return "error";
        }
    }

    // 장비명으로 평균 가격 정보를 가져오는 AJAX 요청 처리 메서드
    @RequestMapping(value = "/getStorenAvgPricesByEquipName.action", method = RequestMethod.GET)
    @ResponseBody
    public AvgPriceInfo getAvgPricesByEquipName(@RequestParam("equipName") String equipName) {
        try {
            IStorenDAO dao = sqlSession.getMapper(IStorenDAO.class);

            int avgNewPrice = dao.getAvgNewPriceByEquipName(equipName);
            int avgRentalPrice = dao.getAvgRentalPriceByEquipName(equipName);

            NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
            String formattedNewPrice = nf.format(avgNewPrice);
            String formattedRentalPrice = nf.format(avgRentalPrice);

            return new AvgPriceInfo(avgNewPrice, avgRentalPrice, formattedNewPrice, formattedRentalPrice);
        } catch (Exception e) {
            e.printStackTrace();
            return new AvgPriceInfo(0, 0, "0", "0");
        }
    }

    // 평균 가격 정보를 담는 내부 클래스 (AJAX 응답용)
    public static class AvgPriceInfo {
        private int avgNewPrice;
        private int avgRentalPrice;
        private String formattedNewPrice;
        private String formattedRentalPrice;

        public AvgPriceInfo(int avgNewPrice, int avgRentalPrice, String formattedNewPrice, String formattedRentalPrice) {
            this.avgNewPrice = avgNewPrice;
            this.avgRentalPrice = avgRentalPrice;
            this.formattedNewPrice = formattedNewPrice;
            this.formattedRentalPrice = formattedRentalPrice;
        }

        public int getAvgNewPrice() {
            return avgNewPrice;
        }

        public int getAvgRentalPrice() {
            return avgRentalPrice;
        }

        public String getFormattedNewPrice() {
            return formattedNewPrice;
        }

        public String getFormattedRentalPrice() {
            return formattedRentalPrice;
        }
    }

    // 렌탈 정보 업데이트 처리
    @RequestMapping(value = "/updateStorenRegister-rentalRegister.action", method = RequestMethod.POST)
    public String updateStorenRegisterRentalRegister(StorenDTO dto, RedirectAttributes redirect) {
        try {
            IStorenDAO dao = sqlSession.getMapper(IStorenDAO.class);

            // 디버그용 로깅
            System.out.println("[DEBUG] 렌탈 정보 업데이트 - storen_id: " + dto.getStoren_id());
            System.out.println("[DEBUG] 렌탈 정보 업데이트 - storen_title: " + dto.getStoren_title());
            System.out.println("[DEBUG] 렌탈 정보 업데이트 - storen_content: " + dto.getStoren_content());
            System.out.println("[DEBUG] 렌탈 정보 업데이트 - daily_rent_price: " + dto.getDaily_rent_price());

            int result = dao.updateStorenRegisterRentalRegister(dto);

            if (result > 0) {
                return "redirect:/storenRegister-rentalRegister-complete.action";
            } else {
                redirect.addFlashAttribute("error", "렌탈 정보 업데이트에 실패했습니다.");
                return "redirect:/storenRegister-rentalRegister.action?storen_id=" + dto.getStoren_id();
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirect.addFlashAttribute("error", "시스템 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/storenRegister-rentalRegister.action?storen_id=" + dto.getStoren_id();
        }
    }

    // 등록 완료 페이지
    @RequestMapping(value = "/storenRegister-rentalRegister-complete.action", method = RequestMethod.GET)
    public String rentalComplete() {
        return "storenRegister-rentalRegister-complete";
    }
}