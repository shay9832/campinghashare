package com.team.mvc.Controller;

import com.team.mvc.Interface.IStorenDAO;
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
import org.springframework.web.bind.annotation.*;

import java.text.NumberFormat;
import java.util.Locale;
import java.io.File;
import java.util.*;
import java.util.logging.Logger;


@Controller
public class EquipRegisterController {

    @Autowired
    private SqlSession sqlSession;

    // 로깅 추가
    private static final Logger logger = Logger.getLogger(EquipRegisterController.class.getName());

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
            // 오류 처리
        }
        model.addAttribute("majorCategory", category);
        return "equipRegister-middleCategory";
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
            // 오류 처리
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

        try {
            model.addAttribute("majorCategory", majorCategory);
            model.addAttribute("middleCategory", middleCategory);
            model.addAttribute("brand", brand);

            return "equipRegister-newPrice";
        } catch (Exception e) {
            return "error/500";
        }
    }

    // 검색창에 장비명, 신품가격 데이터 불러오기
    @RequestMapping(value = "/listequipnamesbybrandid.action")
    @ResponseBody
    public List<Map<String, Object>> listEquipNamesByBrand(@RequestParam("brand") String brand) {
        try {
            // 브랜드 ID 조회
            List<BrandDTO> brandList = sqlSession.getMapper(IBrandDAO.class).getBrandByName(brand);

            if (brandList == null || brandList.isEmpty()) {
                return Collections.emptyList();
            }

            int brandId = brandList.get(0).getBrandId();

            // 해당 브랜드의 장비명 목록 조회
            List<Map<String, Object>> equipList = sqlSession.getMapper(IEquipmentDAO.class).listEquipNamesByBrand(brandId);

            return equipList;

        } catch (Exception e) {
            return Collections.emptyList();
        }
    }

    // 장비 등록 완료 페이지로 이동 (장비 정보는 테이블에 저장)
    @RequestMapping(value = "/equipregister-complete.action", method = RequestMethod.POST)
    public String equipComplete(
            @ModelAttribute("userCode") Integer userCode,
            @RequestParam("majorCategory") String majorCategory,
            @RequestParam("middleCategory") String middleCategory,
            @RequestParam("brand") String brand,
            @RequestParam("equipName") String equipName,
            @RequestParam("originalPrice") String originalPrice,
            @RequestParam(value = "photos", required = false) List<MultipartFile> photos,
            HttpSession session,
            Model model) {

        try {
            int user_code = userCode;

            logger.info("사용자 코드: " + user_code);
            logger.info("대분류: " + majorCategory + ", 중분류: " + middleCategory);
            logger.info("브랜드: " + brand + ", 장비명: " + equipName);
            logger.info("원가: " + originalPrice);
            logger.info("사진 개수: " + (photos != null ? photos.size() : 0));

            // 대분류 카테고리 ID 조회
            List<CategoryDTO> majorCategoryList = sqlSession.getMapper(ICategoryDAO.class).listCategoryByName(majorCategory);

            if (majorCategoryList == null || majorCategoryList.isEmpty()) {
                model.addAttribute("message", "대분류 카테고리 정보를 찾을 수 없습니다.");
                model.addAttribute("redirectUrl", "/equipregister-majorcategory.action");
                return "redirect";
            }

            int parentCategoryId = majorCategoryList.get(0).getCategory_id();

            // 중분류 카테고리 목록 조회
            int categoryId = -1;
            List<CategoryDTO> middleCategoryList = sqlSession.getMapper(ICategoryDAO.class).listMiddleCategory(parentCategoryId);

            // 해당 중분류 카테고리 이름으로 카테고리 ID 찾기
            for (CategoryDTO category : middleCategoryList) {
                if (category.getCategory_name().equals(middleCategory)) {
                    categoryId = category.getCategory_id();
                    break;
                }
            }

            if (categoryId == -1) {
                model.addAttribute("message", "중분류 카테고리 정보를 찾을 수 없습니다.");
                model.addAttribute("redirectUrl", "/equipregister-middlecategory.action?category=" + majorCategory);
                return "redirect";
            }

            // 브랜드 ID 조회
            List<BrandDTO> brandList = sqlSession.getMapper(IBrandDAO.class).getBrandByName(brand);

            if (brandList == null || brandList.isEmpty()) {
                model.addAttribute("message", "브랜드 정보를 찾을 수 없습니다.");
                model.addAttribute("redirectUrl", "/equipregister-brand.action?majorCategory=" + majorCategory + "&middleCategory=" + middleCategory);
                return "redirect";
            }
            int brandId = brandList.get(0).getBrandId();

            // 장비명 ID 조회 또는 생성
            Integer equipNameId = sqlSession.getMapper(IEquipmentDAO.class).getEquipNameId(brandId, equipName);

            int price = Integer.parseInt(originalPrice.replaceAll(",", ""));

            // EquipmentDTO 생성 및 설정
            EquipmentDTO dto = new EquipmentDTO();
            dto.setUser_code(user_code);
            dto.setCategory_id(categoryId);
            dto.setEquip_name_id(equipNameId);
            dto.setOriginal_price(price);

            // 장비 코드 생성 및 EQUIP_CODE 테이블에 삽입
            sqlSession.getMapper(IEquipmentDAO.class).insertEquipCode(dto);

            logger.info("장비 코드 생성 완료: " + dto.getEquip_code());

            // 장비 등록 테이블에 정보 삽입
            int result = sqlSession.getMapper(IEquipmentDAO.class).insertEquipmentRegistration(dto);
            logger.info("장비 등록 결과: " + result);

            // 사진 처리 - 여기가 수정된 부분입니다
            if (photos != null && !photos.isEmpty()) {
                logger.info("사진 처리 시작, 개수: " + photos.size());
                // 애플리케이션 실제 경로 가져오기 (web root)
                String uploadDir = session.getServletContext().getRealPath("/resources/uploads");
                File uploadPath = new File(uploadDir);
                if (!uploadPath.exists()) {
                    uploadPath.mkdirs();
                    logger.info("업로드 디렉토리 생성: " + uploadDir);
                }

                int order = 1; // 첨부파일 순서
                IAttachmentDAO attachmentDAO = sqlSession.getMapper(IAttachmentDAO.class);

                for (MultipartFile photo : photos) {
                    if (!photo.isEmpty()) {
                        try {
                            // 파일 저장 로직
                            String originalFilename = photo.getOriginalFilename();
                            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));

                            logger.info("파일 저장 중: " + originalFilename);

                            // 파일 저장
                            File destination = new File(uploadPath + File.separator + originalFilename);
                            photo.transferTo(destination);
                            logger.info("파일 저장 완료: " + destination.getAbsolutePath());

                            // 첨부파일 테이블에 정보 저장
                            AttachmentDTO attachmentDTO = new AttachmentDTO();
                            attachmentDTO.setEquipCode(dto.getEquip_code());
                            attachmentDTO.setAttachmentName(originalFilename);
                            attachmentDTO.setAttachmentPath("/resources/uploads/" + originalFilename);
                            attachmentDTO.setAttachmentSize(photo.getSize());
                            attachmentDTO.setAttachmentOrder(order++);

                            // 첨부파일 정보 DB에 저장 - 여기서 문제가 있었을 수 있습니다
                            int attachResult = attachmentDAO.insertAttachment(attachmentDTO);
                            logger.info("첨부파일 등록 결과: " + attachResult + ", 장비 코드: " + attachmentDTO.getEquipCode());

                            if (attachResult <= 0) {
                                logger.warning("첨부파일 등록 실패: " + originalFilename);
                            }
                        } catch (Exception e) {
                            // 로그 추가
                            logger.warning("파일 처리 중 오류 발생: " + e.getMessage());
                            e.printStackTrace();
                        }
                    }
                }
                logger.info("사진 처리 완료");
            } else {
                logger.info("업로드된 사진 없음");
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
            logger.severe("장비 등록 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("message", "장비 등록 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("redirectUrl", "/equipregister-newprice.action?majorCategory=" + majorCategory
                    + "&middleCategory=" + middleCategory + "&brand=" + brand);
            return "redirect";
        }
    }

    // 장비명으로 평균 가격 정보 조회 API
    @RequestMapping(value = "/getAvgPricesByEquipName.action", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getAvgPricesByEquipName(@RequestParam("equipName") String equipName) {
        Map<String, Object> result = new HashMap<>();

        try {
            IStorenDAO storenDAO = sqlSession.getMapper(IStorenDAO.class);

            int avgNewPrice = storenDAO.getAvgNewPriceByEquipName(equipName);
            int avgRentalPrice = storenDAO.getAvgRentalPriceByEquipName(equipName);

            // 포맷 처리
            NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);

            result.put("success", true);
            result.put("avgNewPrice", avgNewPrice);
            result.put("avgRentalPrice", avgRentalPrice);
            result.put("formattedNewPrice", nf.format(avgNewPrice));
            result.put("formattedRentalPrice", nf.format(avgRentalPrice));

        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }

        return result;
    }

}