package com.team.mvc.Controller;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.CategoryDTO;

@Controller
public class AdminCreateBrandController {

    @Autowired
    private SqlSessionTemplate sqlSession;

    private static final String NAMESPACE = "com.team.mvc.Interface.IAdminCreateBrandDAO.";

    /**
     * 브랜드/장비명 관리 페이지 - 모든 요청 처리
     */
    @RequestMapping("/admin-createBrand.action")
    public String createBrand(
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "brandId", required = false) Integer brandId,
            @RequestParam(value = "equip_name_id", required = false) Integer equipNameId,
            @RequestParam(value = "formAction", required = false) String formAction,
            @RequestParam(value = "brandName", required = false) String brandName,
            @RequestParam(value = "equip_name", required = false) String equipName,
            @RequestParam(value = "category_id", required = false) Integer categoryId,
            Model model, RedirectAttributes redirectAttributes) {

        try {
            // POST 요청 처리 (폼 제출)
            if (formAction != null) {
                return handleFormSubmission(formAction, brandId, equipNameId, brandName, equipName, categoryId, redirectAttributes);
            }

            // GET 요청 처리 (페이지 로드)
            return handlePageLoad(action, brandId, equipNameId, model);
        } catch (Exception e) {
            // 에러 처리
            redirectAttributes.addFlashAttribute("errorMessage", "처리 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/admin-createBrand.action";
        }
    }

    /**
     * 폼 제출 처리 (POST 요청)
     */
    @Transactional
    public String handleFormSubmission(
            String formAction, Integer brandId, Integer equipNameId,
            String brandName, String equipName, Integer categoryId,
            RedirectAttributes redirectAttributes) {

        // 브랜드 생성
        if ("createBrand".equals(formAction) && brandName != null) {
            BrandDTO brand = new BrandDTO();
            brand.setBrandName(brandName);
            sqlSession.insert(NAMESPACE + "insertBrand", brand);
            redirectAttributes.addFlashAttribute("successMessage", "브랜드가 성공적으로 생성되었습니다.");
            return "redirect:/admin-createBrand.action";
        }

        // 브랜드 수정
        else if ("updateBrand".equals(formAction) && brandId != null && brandName != null) {
            BrandDTO brand = new BrandDTO();
            brand.setBrandId(brandId);
            brand.setBrandName(brandName);
            sqlSession.update(NAMESPACE + "updateBrand", brand);
            redirectAttributes.addFlashAttribute("successMessage", "브랜드가 성공적으로 수정되었습니다.");
            return "redirect:/admin-createBrand.action";
        }

        // 브랜드 삭제 (연관된 장비명도 함께 삭제)
        else if ("deleteBrand".equals(formAction) && brandId != null) {
            // 먼저 연관된 장비명 삭제
            try {
                sqlSession.delete(NAMESPACE + "deleteEquipmentByBrandId", brandId);
            } catch (Exception e) {
                // 메서드가 없는 경우 개별 장비 삭제로 대체
                List<EquipmentDTO> equipmentList = sqlSession.selectList(NAMESPACE + "getEquipmentListByBrandId", brandId);
                for (EquipmentDTO equipment : equipmentList) {
                    sqlSession.delete(NAMESPACE + "deleteEquipment", equipment.getEquip_name_id());
                }
            }

            // 그 다음 브랜드 삭제
            sqlSession.delete(NAMESPACE + "deleteBrand", brandId);
            redirectAttributes.addFlashAttribute("successMessage", "브랜드와 관련 장비명이 성공적으로 삭제되었습니다.");
            return "redirect:/admin-createBrand.action";
        }

        // 장비명 생성
        else if ("createEquipment".equals(formAction) && brandId != null && equipName != null) {
            EquipmentDTO equipment = new EquipmentDTO();
            equipment.setEquip_name(equipName);
            equipment.setBrandId(brandId);

            sqlSession.insert(NAMESPACE + "insertEquipment", equipment);
            redirectAttributes.addFlashAttribute("successMessage", "장비명이 성공적으로 생성되었습니다.");
            return "redirect:/admin-createBrand.action?action=selectBrand&brandId=" + brandId;
        }

        // 장비명 수정
        else if ("updateEquipment".equals(formAction) && equipNameId != null && equipName != null && brandId != null) {
            EquipmentDTO equipment = new EquipmentDTO();
            equipment.setEquip_name_id(equipNameId);
            equipment.setEquip_name(equipName);
            equipment.setBrandId(brandId);

            sqlSession.update(NAMESPACE + "updateEquipment", equipment);
            redirectAttributes.addFlashAttribute("successMessage", "장비명이 성공적으로 수정되었습니다.");
            return "redirect:/admin-createBrand.action?action=selectBrand&brandId=" + brandId;
        }

        // 장비명 삭제
        else if ("deleteEquipment".equals(formAction) && equipNameId != null && brandId != null) {
            sqlSession.delete(NAMESPACE + "deleteEquipment", equipNameId);
            redirectAttributes.addFlashAttribute("successMessage", "장비명이 성공적으로 삭제되었습니다.");
            return "redirect:/admin-createBrand.action?action=selectBrand&brandId=" + brandId;
        }

        // 기본 리다이렉트
        return "redirect:/admin-createBrand.action";
    }

    /**
     * 페이지 로드 처리 (GET 요청)
     */
    private String handlePageLoad(String action, Integer brandId, Integer equipNameId, Model model) {
        // 브랜드 목록은 항상 로드
        List<BrandDTO> brandList = sqlSession.selectList(NAMESPACE + "getBrandList");
        model.addAttribute("brandList", brandList);

        // 카테고리 목록 로드
        List<CategoryDTO> categoryList = sqlSession.selectList(NAMESPACE + "getCategoryList");
        model.addAttribute("categoryList", categoryList);

        // 특정 브랜드 선택 처리
        if ("selectBrand".equals(action) && brandId != null) {
            BrandDTO selectedBrand = sqlSession.selectOne(NAMESPACE + "getBrandById", brandId);
            model.addAttribute("selectedBrand", selectedBrand);

            List<EquipmentDTO> equipmentList = sqlSession.selectList(NAMESPACE + "getEquipmentListByBrandId", brandId);
            model.addAttribute("equipmentList", equipmentList);
        }

        // 브랜드 수정 처리
        else if ("editBrand".equals(action) && brandId != null) {
            BrandDTO brandToEdit = sqlSession.selectOne(NAMESPACE + "getBrandById", brandId);
            model.addAttribute("brandToEdit", brandToEdit);
        }

        // 장비명 수정 처리
        else if ("editEquipment".equals(action) && equipNameId != null && brandId != null) {
            EquipmentDTO equipmentToEdit = sqlSession.selectOne(NAMESPACE + "getEquipmentById", equipNameId);
            model.addAttribute("equipmentToEdit", equipmentToEdit);

            // 장비가 속한 브랜드 정보 조회
            BrandDTO selectedBrand = sqlSession.selectOne(NAMESPACE + "getBrandById", brandId);
            model.addAttribute("selectedBrand", selectedBrand);

            List<EquipmentDTO> equipmentList = sqlSession.selectList(NAMESPACE + "getEquipmentListByBrandId", brandId);
            model.addAttribute("equipmentList", equipmentList);
        }

        return "admin-createBrand";
    }
}