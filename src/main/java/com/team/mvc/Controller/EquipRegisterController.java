package com.team.mvc.Controller;

import com.team.mvc.DTO.AttachmentDTO;
import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.Interface.IAttachmentDAO;
import com.team.mvc.Interface.IBrandDAO;
import com.team.mvc.Interface.ICategoryDAO;
import com.team.mvc.Interface.IEquipmentDAO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import java.io.File;
import java.util.*;


@Controller
public class EquipRegisterController {

    @Autowired
    private SqlSession sqlSession;

    // 대분류 선택 페이지
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

    // 중분류 선택 페이지
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

    // 브랜드 선택 페이지
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

    // 장비명, 신품가 입력 페이지
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


    // 검색창에 장비명, 신품가격 데이터 불러오기
    @RequestMapping(value = "/listequipnamesbybrandid.action")
    @ResponseBody
    public List<Map<String, Object>> listEquipNamesByBrand(@RequestParam("brand") String brand) {
        System.out.println("브랜드명: " + brand);

        try {
            // 브랜드 ID 조회
            List<BrandDTO> brandList = sqlSession.getMapper(IBrandDAO.class).getBrandByName(brand);
            System.out.println("브랜드 목록 조회 결과: " + (brandList != null ? brandList.size() : "null"));

            if (brandList == null || brandList.isEmpty()) {
                return Collections.emptyList();
            }

            int brandId = brandList.get(0).getBrandId();

            // 해당 브랜드의 장비명 목록 조회
            List<Map<String, Object>> equipList = sqlSession.getMapper(IEquipmentDAO.class).listEquipNamesByBrand(brandId);
            System.out.println("장비명 목록 조회 결과: " + (equipList != null ? equipList.size() : "null"));

            return equipList;

        } catch (Exception e) {
            System.out.println("에러 발생: " + e.toString());
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    // 장비 등록 완료 페이지로 이동 (장비 정보는 테이블에 저장)
    @RequestMapping(value = "/equipregister-complete.action", method = RequestMethod.POST)
    public String equipComplete(@RequestParam("majorCategory") String majorCategory,
                                @RequestParam("middleCategory") String middleCategory,
                                @RequestParam("brand") String brand,
                                @RequestParam("equipName") String equipName,
                                @RequestParam("originalPrice") String originalPrice,
                                @RequestParam(value = "photos", required = false) List<MultipartFile> photos,
                                HttpSession session,
                                Model model) {

        System.out.println("=== equipComplete 메서드 실행 ===");
        System.out.println("대분류: " + majorCategory);
        System.out.println("중분류: " + middleCategory);
        System.out.println("브랜드: " + brand);
        System.out.println("장비명: " + equipName);
        System.out.println("신품가격: " + originalPrice);
        System.out.println("사진 있음: " + (photos != null ? "예" : "아니오"));

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


            // 사진 처리
            if (photos != null && !photos.isEmpty()) {
                // 애플리케이션 실제 경로 가져오기 (web root)
                String uploadDir = session.getServletContext().getRealPath("/resources/uploads");
                File uploadPath = new File(uploadDir);
                if (!uploadPath.exists()) {
                    uploadPath.mkdirs();
                }

                int order = 1; // 첨부파일 순서

                for (MultipartFile photo : photos) {
                    if (!photo.isEmpty()) {
                        try {
                            // 파일 저장 로직
                            String originalFilename = photo.getOriginalFilename();
                            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));

                            // 파일 저장
                            File destination = new File(uploadPath + File.separator + originalFilename);
                            photo.transferTo(destination);

                            // 첨부파일 테이블에 정보 저장
                            AttachmentDTO attachmentDTO = new AttachmentDTO();
                            attachmentDTO.setEquipCode(dto.getEquip_code());
                            attachmentDTO.setAttachmentName(originalFilename);
                            attachmentDTO.setAttachmentPath("/resources/uploads/" + originalFilename);
                            attachmentDTO.setAttachmentSize(photo.getSize());
                            attachmentDTO.setAttachmentOrder(order++);

                            // 첨부파일 정보 DB에 저장
                            sqlSession.getMapper(IAttachmentDAO.class).insertAttachment(attachmentDTO);
                        } catch (Exception e) {
                            System.out.println("파일 저장 중 오류 발생: " + e.getMessage());
                            // 하나의 파일 저장 실패해도 계속 진행
                        }
                    }
                }
            }

            if (result > 0) {
                // 성공적으로 등록된 경우
                return "equipRegister-complete";
            } else {
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

}




