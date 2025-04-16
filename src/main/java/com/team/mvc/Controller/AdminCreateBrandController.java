package com.team.mvc.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.Interface.IAdminCreateBrandDAO;

@Controller
public class AdminCreateBrandController {

    @Autowired
    private IAdminCreateBrandDAO adminCreateBrandDAO;

    /**
     * 브랜드/장비명 관리 페이지 - 모든 요청 처리
     */
    @RequestMapping("/admin-createBrand.action")
    public String createBrand(
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "brand_id", required = false) Integer brandId,
            @RequestParam(value = "equip_name_id", required = false) Integer equipNameId,
            @RequestParam(value = "formAction", required = false) String formAction,
            @RequestParam(value = "brandName", required = false) String brandName,
            @RequestParam(value = "equip_name", required = false) String equipName,
            @RequestParam(value = "category_id", required = false) Integer categoryId,
            Model model, RedirectAttributes redirectAttributes) {

        // POST 요청 처리 (폼 제출)
        if (formAction != null) {
            // 브랜드 생성
            if (formAction.equals("createBrand") && brandName != null) {
                BrandDTO brand = new BrandDTO();
                brand.setBrandName(brandName);
                adminCreateBrandDAO.insertBrand(brand);
                return "redirect:/admin-createBrand.action";
            }

            // 브랜드 수정
            else if (formAction.equals("updateBrand") && brandId != null && brandName != null) {
                BrandDTO brand = new BrandDTO();
                brand.setBrand_Id(brandId);
                brand.setBrandName(brandName);
                adminCreateBrandDAO.updateBrand(brand);
                return "redirect:/admin-createBrand.action";
            }

            // 브랜드 삭제
            else if (formAction.equals("deleteBrand") && brandId != null) {
                adminCreateBrandDAO.deleteBrand(brandId);
                return "redirect:/admin-createBrand.action";
            }

            // 장비명 생성
            else if (formAction.equals("createEquipment") && brandId != null && equipName != null) {
                EquipmentDTO equipment = new EquipmentDTO();
                // 장비명에는 brand_id 필드가 없으므로 해당 관계는 equip_name 테이블에만 있음
                // 따라서 직접적인 설정은 불가능하며 DAO에서 처리
                equipment.setEquip_name(equipName);
                if (categoryId != null) {
                    equipment.setCategory_id(categoryId);
                }
                adminCreateBrandDAO.insertEquipment(equipment);
                return "redirect:/admin-createBrand.action?action=selectBrand&brand_id=" + brandId;
            }

            // 장비명 수정
            else if (formAction.equals("updateEquipment") && equipNameId != null && equipName != null) {
                EquipmentDTO equipment = new EquipmentDTO();
                equipment.setEquip_name_id(equipNameId);
                equipment.setEquip_name(equipName);
                if (categoryId != null) {
                    equipment.setCategory_id(categoryId);
                }
                adminCreateBrandDAO.updateEquipment(equipment);

                // 장비가 속한 브랜드 ID로 리다이렉트 (brand_id 필드가 EquipmentDTO에 없으므로 조정 필요)
                EquipmentDTO equipmentInfo = adminCreateBrandDAO.getEquipmentById(equipNameId);
                // 임시로 redirectAttributes로 전달
                return "redirect:/admin-createBrand.action?action=selectBrand&brand_id=" + brandId;
            }

            // 장비명 삭제
            else if (formAction.equals("deleteEquipment") && equipNameId != null) {
                adminCreateBrandDAO.deleteEquipment(equipNameId);

                // 삭제 후 해당 브랜드의 장비 목록으로 리다이렉트
                return "redirect:/admin-createBrand.action?action=selectBrand&brand_id=" + brandId;
            }
        }

        // GET 요청 처리 (페이지 로드)
        // 브랜드 목록은 항상 로드
        List<BrandDTO> brandList = adminCreateBrandDAO.getBrandList();
        model.addAttribute("brandList", brandList);

        // 카테고리 목록 로드
        List<CategoryDTO> categoryList = adminCreateBrandDAO.getCategoryList();
        model.addAttribute("categoryList", categoryList);

        // 특정 브랜드 선택 처리
        if (action != null && action.equals("selectBrand") && brandId != null) {
            BrandDTO selectedBrand = adminCreateBrandDAO.getBrandById(brandId);
            model.addAttribute("selectedBrand", selectedBrand);

            List<EquipmentDTO> equipmentList = adminCreateBrandDAO.getEquipmentListByBrandId(brandId);
            model.addAttribute("equipmentList", equipmentList);
        }

        // 브랜드 수정 처리
        if (action != null && action.equals("editBrand") && brandId != null) {
            BrandDTO brandToEdit = adminCreateBrandDAO.getBrandById(brandId);
            model.addAttribute("brandToEdit", brandToEdit);
        }

        // 장비명 수정 처리
        if (action != null && action.equals("editEquipment") && equipNameId != null) {
            EquipmentDTO equipmentToEdit = adminCreateBrandDAO.getEquipmentById(equipNameId);
            model.addAttribute("equipmentToEdit", equipmentToEdit);

            // 장비명 정보를 이용해 해당 브랜드 정보 조회
            // 브랜드 ID는 직접 equipmentToEdit에서 가져올 수 없으므로 수정 필요
            // 여기서는 임시로 파라미터로 전달된 brandId 사용
            if (brandId != null) {
                BrandDTO selectedBrand = adminCreateBrandDAO.getBrandById(brandId);
                model.addAttribute("selectedBrand", selectedBrand);

                List<EquipmentDTO> equipmentList = adminCreateBrandDAO.getEquipmentListByBrandId(brandId);
                model.addAttribute("equipmentList", equipmentList);
            }
        }

        return "admin-createBrand";
    }
}