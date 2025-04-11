package com.team.mvc.Controller;

import com.team.mvc.DTO.DeliveryDTO;
import com.team.mvc.DTO.MyEquipDTO;
import com.team.mvc.DTO.MypageInspecListDTO;
import com.team.mvc.Interface.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MypageController {

    // 자동 의존성 주입
    //@Autowired
    //private SqlSession sqlSession;
    @Autowired
    private IMypageMyEquipService myEquipService;
    @Autowired
    private IMypageDeliveryService deliveryService;
    @Autowired
    private IMypageInspecListService inspecListService;

    // 마이페이지-메인
    @RequestMapping(value="/mypage-main.action")
    public String mypageMain(Model model) {
        return "myPage-main";
    }

    // 마이페이지-패스워드 체크
    @RequestMapping(value="/mypage-infoedit-passwordcheck.action")
    public String mypagePasswordCheck(Model model) {
        return "myPage-infoEdit-passwordCheck";
    }

    // 마이페이지-회원 정보 수정
    @RequestMapping(value="/mypage-infoedit.action")
    public String mypageInfoEdit(Model model) {
        return "myPage-infoEdit";
    }

    // 마이페이지-회원 정보 수정-휴대폰 번호 인증변경

    // 마이페이지-회원 정보 수정-이메일 수정
    @RequestMapping(value="/mypage-infoedit-email.action")
    public String mypageInfoEditEmail(Model model) {
        return "myPage-infoEdit-email";
    }

    // 마이페이지-회원 정보 수정-닉네임 수정
    @RequestMapping(value="/mypage-infoedit-nickname.action")
    public String mypageInfoEditNickname(Model model) {
        return "myPage-infoEdit-nickname";
    }

    //====================================================================================
    // 마이페이지-회원 정보 수정-비밀번호 변경
    @RequestMapping(value="/mypage-infoedit-password.action")
    public String mypageInfoEditPassword(Model model) {
        return "myPage-infoEdit-password";
    }

    //====================================================================================
    // 마이페이지-회원 정보 수정-주소 변경
    @RequestMapping(value="/mypage-infoedit-address.action")
    public String mypageInfoEditAddress(Model model) {
        return "myPage-infoEdit-address";
    }

    // 마이페이지-신뢰도
    @RequestMapping(value="/mypage-trust.action")
    public String mypageTrust(Model model) {
        return "myPage-trust";
    }

    // 마이페이지-포인트
    @RequestMapping(value="/mypage-point.action")
    public String mypagePoint(Model model) {
        return "myPage-point";
    }

    // 마이페이지-내가 소유한 장비
    @RequestMapping(value="/mypage-myequip.action")
    public String mypageMyEquip(Model model) {
        //IEquipmentDAO equipDao = sqlSession.getMapper(IEquipmentDAO.class);

        //List<StorenDTO> storenList = storenService.getStorenListWithEquipment(2);

        // &&로그인 완성 후 세션에서 받은 유저 코드로 매개변수 수정해야함!!
        //ArrayList<EquipmentDTO> equipList = equipDao.listByUserCode(2);
        //model.addAttribute("equipList", equipList);
        //model.addAttribute("storenList", storenList);

        System.out.println("=== MypageController : mypageMyEquip() : START ===");

        MyEquipDTO data = myEquipService.listMyEquip(2); // 로그인 이후 세션에서 받아오는 걸로 교체 예정

        System.out.println("EquipList size: " + data.getEquipList().size()); // 콘솔 출력
        System.out.println("StorenMap size: " + data.getStorenMap().size()); // 콘솔 출력
        System.out.println("firstStorenList size: " + data.getFirstStorenList().size()); // 콘솔 출력

        model.addAttribute("equipList", data.getEquipList());
        model.addAttribute("storenMap", data.getStorenMap());
        model.addAttribute("firstStorenList", data.getFirstStorenList());
        //rentalList, storageList도 받아와야함

        System.out.println("=== MypageController : mypageMyEquip() : END ===");
        return "myPage-myEquip";
    }


    // 마이페이지-검수 결과 조회
    @RequestMapping(value="/mypage-inspecList.action")
    public String mypageInspecList(Model model) {

        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : START ===");
        int userCode = 2; // 로그인 이후 세션에서 받아오는 걸로 교체 예정

        // 초기에는 스토렌 입고 검수내역만 로드
        List<MypageInspecListDTO> storenStoreInspec = inspecListService.listStorenStoreInspec(userCode);
        model.addAttribute("inspecList", storenStoreInspec);
        model.addAttribute("activeTab", "storen"); // 초기 탭 지정
        model.addAttribute("storenTabType", "store"); // 초기 서브탭 지정

        System.out.println("storenStoreInspec size : " + storenStoreInspec.size());
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : END ===");

        return "myPage-inspecList";
    }

    // AJAX 요청 처리
    @RequestMapping(value="/api/inspec/storage", produces="application/json")
    @ResponseBody
    public List<MypageInspecListDTO> getStorageStoreInspec() {
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STORAGE Store : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STORAGE Store : END ===");
        return inspecListService.listStorageStoreInspec(user_code);

    }

    @RequestMapping(value="/api/inspec/storen/store", produces="application/json")
    @ResponseBody
    public List<MypageInspecListDTO> getStorenStoreInspec() {
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : END ===");
        return inspecListService.listStorenStoreInspec(user_code);
    }

    @RequestMapping(value="/api/inspec/storen/return", produces="application/json")
    @ResponseBody
    public List<MypageInspecListDTO> getStorenReturnInspec() {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Return : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Return : END ===");
        return inspecListService.listStorenReturnInspec(user_code);
    }

    // 마이페이지-배송 조회/내역
    // 처음에는 스토렌 사용자 배송내역 로드
    @RequestMapping(value="/mypage-delivery.action")
    public String mypageDelivery(Model model) {

        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : START ===");
        int userCode = 2; // 로그인 이후 세션에서 받아오는 걸로 교체 예정

        // 초기에는 스토렌 소유자 배송내역만 로드
        List<DeliveryDTO> storenUserDeliveries = deliveryService.getStorenOwnerDeliveries(userCode);
        model.addAttribute("deliveryList", storenUserDeliveries);
        model.addAttribute("activeTab", "storen"); // 초기 탭 지정
        model.addAttribute("storenTabType", "owner"); // 초기 서브탭 지정

        System.out.println("deliveryList size : " + storenUserDeliveries.size());
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : END ===");
        return "myPage-delivery";
    }

    // AJAX 요청 처리
    @RequestMapping(value="/api/delivery/storage", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getStorageDeliveries() {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STORAGE : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STORAGE : END ===");
        return deliveryService.getStorageDeliveries(user_code);

    }

    @RequestMapping(value="/api/delivery/storen/owner", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getStorenOwnerDeliveries() {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : END ===");
        return deliveryService.getStorenOwnerDeliveries(user_code);
    }

    @RequestMapping(value="/api/delivery/storen/user", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getStorenUserDeliveries() {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN User : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN User : END ===");
        return deliveryService.getStorenUserDeliveries(user_code);
    }

    @RequestMapping(value="/api/delivery/rental", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getRentalDeliveries() {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - RENTAL : START ===");
        int user_code = 2; // 세션에서 가져와야 함
        System.out.println("=== MypageController : mypageDelivery() - AJAX - RENTAL : END ===");
        return deliveryService.getRentalDeliveries(user_code);
    }

    // 마이페이지-매칭 조회/내역
    @RequestMapping(value="/mypage-matchinglist.action")
    public String mypageMatchingList(Model model) {
        return "myPage-matchingList";
    }

    // 마이페이지-내가 대여한 장비
    @RequestMapping(value="/mypage-rentequip.action")
    public String mypageRentEquip(Model model) {
        return "myPage-rentEquip";
    }

    // 마이페이지-내가 작성한 글
    @RequestMapping(value="/mypage-mypost.action")
    public String mypageMyPost(Model model) {
        return "myPage-myPost";
    }

    // 마이페이지-찜
    @RequestMapping(value="/mypage-wishlist.action")
    public String mypageWishlist(Model model) {
        return "myPage-wishlist";
    }

    // 마이페이지-나의 캠핑일지
    @RequestMapping(value="/mypage-diary.action")
    public String mypageDiary(Model model) {
        return "myPage-diary";
    }

    // 마이페이지-나의 캠핑일지-추가
    @RequestMapping(value="/mypage-diary-write.action")
    public String mypageDiaryWrite(Model model) {
        return "myPage-diary-write";
    }

    // 마이페이지-나의 캠핑일지-조회
    @RequestMapping(value="/mypage-diary-post.action")
    public String mypageDiaryPost(Model model) {
        return "myPage-diary-post";
    }

    //====================================================================================
    // 마이페이지-북마크
    @RequestMapping(value="/mypage-bookmark.action")
    public String mypageBookmark(Model model) {
        return "myPage-bookmark";
    }

    //====================================================================================
    // 마이페이지-쿠폰 내역
    @RequestMapping(value="/mypage-coupon.action")
    public String mypageCoupon(Model model) {
        return "myPage-coupon";
    }

    // 마이페이지-1:1 문의내역
    @RequestMapping(value="/mypage-inquiry.action")
    public String mypageInquiry(Model model) {
        return "myPage-inquiry";
    }

    // 마이페이지-1:1 문의내역-추가
    @RequestMapping(value="/mypage-inquiry-write.action")
    public String mypageInquiryWrite(Model model) {
        return "myPage-inquiry-write";
    }

    // 마이페이지-1:1 문의내역-조회
    @RequestMapping(value="/mypage-inquiry-post.action")
    public String mypageInquiryPost(Model model) {
        return "myPage-inquiry-post";
    }

    //====================================================================================
    // 마이페이지-회원 탈퇴
    @RequestMapping(value="/mypage-leave.action")
    public String mypageLeave(Model model) {
        return "myPage-leave";
    }

}