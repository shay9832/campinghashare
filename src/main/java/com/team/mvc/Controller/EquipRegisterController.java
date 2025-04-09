package com.team.mvc.Controller;

import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.Interface.IBrandDAO;
import com.team.mvc.Interface.ICategoryDAO;
import com.team.mvc.Interface.IEquipmentDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class EquipRegisterController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("/equipregister-majorcategory.action")
    public String majorCategory(Model model) {

        List<CategoryDTO> majorCategory = sqlSession.getMapper(ICategoryDAO.class).listMajorCategory();

        Map<String, String> categoryIcons = new HashMap<>();
        categoryIcons.put("텐트/쉘터", "fa-solid fa-campground");
        categoryIcons.put("취침용품", "fa-solid fa-bed");
        categoryIcons.put("캠핑가구", "fa-solid fa-chair");
        categoryIcons.put("조명/전력장비", "fa-solid fa-lightbulb");
        categoryIcons.put("조리장비", "fa-solid fa-utensils");
        categoryIcons.put("냉/난방용품", "fa-solid fa-fan");
        categoryIcons.put("수납/운반용품", "fa-solid fa-box");
        categoryIcons.put("기타", "fa-solid fa-grip");


        model.addAttribute("majorCategory", majorCategory);
        model.addAttribute("categoryIcons", categoryIcons);

        return "equipRegister-majorCategory";
    }

    @RequestMapping("/equipregister-middlecategory.action")
    public String middleCategory(@RequestParam("category") String category, Model model) {
        // 대분류 정보 조회
        try {
            List<CategoryDTO> majorCategoryList = sqlSession.getMapper(ICategoryDAO.class).listCategoryByName(category);

            if (majorCategoryList != null) {

                CategoryDTO majorCategory = majorCategoryList.get(0);

                List<CategoryDTO> middleCategory = sqlSession.getMapper(ICategoryDAO.class).listMiddleCategory(majorCategory.getCategory_id());
                model.addAttribute("middleCategory", middleCategory);
            }

        } catch (Exception e) {
            System.out.println(e.toString());
        }
        model.addAttribute("majorCategory", category);
        return "equipRegister-middleCategory"; // 확장자까지 포함
    }

    @RequestMapping("/equipregister-brand.action")
    public String selectBrand(
            @RequestParam("majorCategory") String majorCategory,
            @RequestParam("middleCategory") String middleCategory,
            Model model) {
        try {
            List<BrandDTO> brands = sqlSession.getMapper(IBrandDAO.class).getBrands();

            model.addAttribute("brands", brands);
            model.addAttribute("majorCategory", majorCategory);
            model.addAttribute("middleCategory", middleCategory);

        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return "equipRegister-brand";
    }

    @RequestMapping("/equipregister-newprice.action")
    public String equipInfo(
            @RequestParam("majorCategory") String majorCategory,
            @RequestParam("middleCategory") String middleCategory,
            @RequestParam("brand") String brand,
            Model model) {
        model.addAttribute("majorCategory", majorCategory);
        model.addAttribute("middleCategory", middleCategory);
        model.addAttribute("brand", brand);
        return "equipRegister-newPrice";
    }

    @RequestMapping(value = "/equipregister-complete.action", method = RequestMethod.POST)
    public String equipComplete(@RequestParam("majorCategory") String majorCategory,
                                @RequestParam("middleCategory") String middleCategory,
                                @RequestParam("brand") String brand,
                                @RequestParam("equipName") String equipName,
                                @RequestParam("originalPrice") String originalPrice,
                                @RequestParam(value = "hasPhotos", required = false) String hasPhotos,
                                HttpSession session,
                                Model model) {

        System.out.println("=== equipComplete 메서드 실행 ===");
        System.out.println("대분류: " + majorCategory);
        System.out.println("중분류: " + middleCategory);
        System.out.println("브랜드: " + brand);
        System.out.println("장비명: " + equipName);
        System.out.println("신품가격: " + originalPrice);
        System.out.println("사진 있음: " + (hasPhotos != null ? "예" : "아니오"));

        try {
            // 현재 로그인한 회원의 user_code 가져오기
//            Integer user_code = (Integer) session.getAttribute("user_code");
//            if (user_code == null) {
//                return "redirect:/userlogin.action";
//            }
            int user_code = 1;
            System.out.println("테스트용 User Code: " + user_code);

            // 대분류 카테고리 ID 조회
            List<CategoryDTO> majorCategoryList = sqlSession.getMapper(ICategoryDAO.class).listCategoryByName(majorCategory);
            System.out.println("대분류 카테고리 조회 결과: " + (majorCategoryList != null ? majorCategoryList.size() : "null"));

            if (majorCategoryList == null || majorCategoryList.isEmpty()) {
                System.out.println("대분류 카테고리 정보를 찾을 수 없습니다.");
                model.addAttribute("message", "대분류 카테고리 정보를 찾을 수 없습니다.");
                model.addAttribute("redirectUrl", "/equipregister-majorcategory.action");
                return "redirect";
            }

            int parentCategoryId = majorCategoryList.get(0).getCategory_id();
            System.out.println("대분류 ID: " + parentCategoryId);

            // 중분류 카테고리 목록 조회
            int categoryId = -1;
            List<CategoryDTO> middleCategoryList = sqlSession.getMapper(ICategoryDAO.class).listMiddleCategory(parentCategoryId);
            System.out.println("중분류 카테고리 조회 결과: " + middleCategoryList.size() + "개");

            // 해당 중분류 카테고리 이름으로 카테고리 ID 찾기
            for (CategoryDTO category : middleCategoryList) {
                if (category.getCategory_name().equals(middleCategory)) {
                    categoryId = category.getCategory_id();
                    break;
                }
            }

            if (categoryId == -1) {
                System.out.println("중분류 카테고리 정보를 찾을 수 없습니다.");
                model.addAttribute("message", "중분류 카테고리 정보를 찾을 수 없습니다.");
                model.addAttribute("redirectUrl", "/equipregister-middlecategory.action?category=" + majorCategory);
                return "redirect";
            }

            // 브랜드 ID 조회
            List<BrandDTO> brandList = sqlSession.getMapper(IBrandDAO.class).getBrandByName(brand);
            System.out.println("브랜드 조회 결과: " + (brandList != null ? brandList.size() : "null"));

            if (brandList == null || brandList.isEmpty()) {
                model.addAttribute("message", "브랜드 정보를 찾을 수 없습니다.");
                model.addAttribute("redirectUrl", "/equipregister-brand.action?majorCategory=" + majorCategory + "&middleCategory=" + middleCategory);
                return "redirect";
            }
            int brandId = brandList.get(0).getBrandId();
            System.out.println("브랜드 ID: " + brandId);

            // 장비명 ID 조회 또는 생성
            Integer equipNameId = sqlSession.getMapper(IEquipmentDAO.class).getEquipNameId(brandId, equipName);
            System.out.println("장비명 ID 조회 결과: " + (equipNameId != null ? equipNameId : "존재하지 않음"));

            int price = Integer.parseInt(originalPrice.replaceAll(",", ""));
            System.out.println("변환된 가격: " + price);

            // EquipmentDTO 생성 및 설정
            EquipmentDTO dto = new EquipmentDTO();
            dto.setUser_code(user_code);
            dto.setCategory_id(categoryId);
            dto.setEquip_name_id(equipNameId);
            dto.setOriginal_price(price);

            System.out.println("EquipmentDTO 설정 완료: " + dto.getUser_code() + ", " + dto.getCategory_id() + ", " +
                    dto.getEquip_name_id() + ", " + dto.getOriginal_price());

            // 장비 코드 생성 및 EQUIP_CODE 테이블에 삽입
            sqlSession.getMapper(IEquipmentDAO.class).insertEquipCode(dto);

            // 장비 등록 테이블에 정보 삽입
            int result = sqlSession.getMapper(IEquipmentDAO.class).insertEquipmentRegistration(dto);

            if (result > 0) {
                // 성공적으로 등록된 경우
                return "equipRegister-complete";
            }
            else {
                model.addAttribute("errorMessage", "장비등록에 실패했습니다.");
                model.addAttribute("message", "장비 등록에 실패했습니다.");
                model.addAttribute("redirectUrl", "/equipregister-newprice.action?majorCategory=" + majorCategory
                        + "&middleCategory=" + middleCategory + "&brand=" + brand);
                return "redirect";
            }
        } catch (Exception e) {
            System.out.println(e.toString());
            model.addAttribute("message", "장비 등록 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("redirectUrl", "/equipregister-newprice.action?majorCategory=" + majorCategory
                    + "&middleCategory=" + middleCategory + "&brand=" + brand);
            return "redirect";
        }
    }

    @RequestMapping("/mypage-myequip.action")
    public String myEquip(Model model) {
        return "myPage-myEquip";
    }

}




