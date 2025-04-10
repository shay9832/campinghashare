package com.team.mvc.Controller;

import com.team.mvc.DTO.AdminInspectListDTO;
import com.team.mvc.Interface.IAdminInspectListDAO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminInspectListController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value="/admin-inspectList.action", method = RequestMethod.GET)
    public String adminInspectList(Model model) {
        IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);
        model.addAttribute("list", dao.getList());
        model.addAttribute("listr", dao.getListr());
        return "admin-inspectList";
    }

    /**
     * 폼에서 직접 프로시저를 호출하는 핸들러 메소드 (MyBatis 사용)
     */
    @PostMapping("/admin-inspectList.action")
    public String adminInspectListAdd(
            @RequestParam(value = "platformDeliveryId", required = false) String platformDeliveryIdStr,
            @RequestParam(value = "platformDeliveryReturnId", required = false) String platformDeliveryReturnIdStr,
            @RequestParam(value = "equipGradeId", required = false, defaultValue = "0") Integer equipGradeId,
            RedirectAttributes redirectAttributes) {

        try {
            // 문자열에서 숫자 추출 및 변환
            Integer platformDeliveryId = null;
            Integer platformDeliveryReturnId = null;

            if (platformDeliveryIdStr != null && !platformDeliveryIdStr.isEmpty()) {
                try {
                    // "DELV-123" 형식에서 숫자만 추출
                    String numericPart = platformDeliveryIdStr.replaceAll("[^0-9]", "");
                    if (!numericPart.isEmpty()) {
                        platformDeliveryId = Integer.parseInt(numericPart);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("배송 ID 변환 실패: " + platformDeliveryIdStr);
                }
            }

            if (platformDeliveryReturnIdStr != null && !platformDeliveryReturnIdStr.isEmpty()) {
                try {
                    // "DELV-RTN-123" 형식에서 숫자만 추출
                    String numericPart = platformDeliveryReturnIdStr.replaceAll("[^0-9]", "");
                    if (!numericPart.isEmpty()) {
                        platformDeliveryReturnId = Integer.parseInt(numericPart);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("반환 ID 변환 실패: " + platformDeliveryReturnIdStr);
                }
            }

            // 둘 다 null인지 검증
            if (platformDeliveryId == null && platformDeliveryReturnId == null) {
                throw new IllegalArgumentException("배송 ID 또는 반환 ID가 필요합니다.");
            }

            // 디버깅 로그 추가
            System.out.println("프로시저 호출 정보: delivery=" + platformDeliveryId
                    + ", return=" + platformDeliveryReturnId
                    + ", grade=" + equipGradeId);

            // MyBatis Mapper 인터페이스 가져오기
            IAdminInspectListDAO dao = sqlSession.getMapper(IAdminInspectListDAO.class);

            // 방법 1: DTO 사용
            // AdminInspectListDTO dto = new AdminInspectListDTO();
            // dto.setPlatformDeliveryId(platformDeliveryId);
            // dto.setPlatformDeliveryReturnId(platformDeliveryReturnId);
            // dto.setEquipGradeId(equipGradeId);
            // dao.add(dto);

            // 방법 2: 직접 프로시저 호출 메소드 사용 (더 명시적임)
            dao.callINSPECT_RESULT(platformDeliveryId, platformDeliveryReturnId, equipGradeId);

            redirectAttributes.addFlashAttribute("message", "검수 결과가 성공적으로 등록되었습니다.");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "검수 결과 등록 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/admin-inspectList.action";
    }
}