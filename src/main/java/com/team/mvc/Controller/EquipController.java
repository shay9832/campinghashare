//package com.team.mvc.Controller;
//
//import com.team.mvc.DTO.BrandDTO;
//import com.team.mvc.DTO.CategoryDTO;
//import com.team.mvc.Interface.IBrandDAO;
//import com.team.mvc.Interface.ICategoryDAO;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Controller
//public class EquipController {
//
//    @Autowired
//    private ICategoryDAO categoryDAO;
//
//    @Autowired
//    private IBrandDAO brandDAO;
//
//    @RequestMapping("/majorcategory.action")
//    public String majorCategory(Model model) {
//        List<CategoryDTO> majorCategory = categoryDAO.getMajorCategory();
//
//        Map<String, String> categoryIcons = new HashMap<>();
//        categoryIcons.put("텐트/쉘터", "fa-solid fa-campground");
//        categoryIcons.put("취침용품", "fa-solid fa-bed");
//        categoryIcons.put("캠핑가구", "fa-solid fa-chair");
//        categoryIcons.put("조명/전력장비", "fa-solid fa-lightbulb");
//        categoryIcons.put("조리장비", "fa-solid fa-utensils");
//        categoryIcons.put("냉/난방용품", "fa-solid fa-fan");
//        categoryIcons.put("수납/운반용품", "fa-solid fa-box");
//        categoryIcons.put("기타", "fa-solid fa-grip");
//
//        model.addAttribute("majorCategory", majorCategory);
//        model.addAttribute("categoryIcons", categoryIcons);
//
//        return "equipRegister-majorCategory";
//    }
//
//    @RequestMapping("/middlecategory")
//    public String middleCategory(@RequestParam("category") String category, Model model) {
//        try {
//            List<CategoryDTO> majorCategoryList = categoryDAO.getCategoryByName(category);
//
//            if (majorCategoryList != null && !majorCategoryList.isEmpty()) {
//                CategoryDTO majorCategory = majorCategoryList.get(0);
//                List<CategoryDTO> middleCategory = categoryDAO.getMiddleCategory(majorCategory.getCategory_id());
//                model.addAttribute("middleCategory", middleCategory);
//            }
//
//        } catch (Exception e) {
//            System.out.println(e.toString());
//        }
//
//        model.addAttribute("majorCategory", category);
//        return "equipResister-middleCategory";
//    }
//
//    @RequestMapping("/selectbrand")
//    public String selectBrand(
//            @RequestParam("majorCategory") String majorCategory,
//            @RequestParam("middleCategory") String middleCategory,
//            Model model) {
//        try {
//            List<BrandDTO> brands = brandDAO.getBrands();
//
//            model.addAttribute("brands", brands);
//            model.addAttribute("majorCategory", majorCategory);
//            model.addAttribute("middleCategory", middleCategory);
//
//        } catch (Exception e) {
//            System.out.println(e.toString());
//        }
//
//        return "equipResister-brand";
//    }
//
//    @RequestMapping("/equipinfo")
//    public String equipInfo(
//            @RequestParam("majorCategory") String majorCategory,
//            @RequestParam("middleCategory") String middleCategory,
//            @RequestParam("brand") String brand,
//            Model model) {
//        model.addAttribute("majorCategory", majorCategory);
//        model.addAttribute("middleCategory", middleCategory);
//        model.addAttribute("brand", brand);
//        return "equipRester-complete";
//    }
//}
