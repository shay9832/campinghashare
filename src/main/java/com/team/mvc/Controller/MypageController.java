package com.team.mvc.Controller;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MypageController {

    // 자동 의존성 주입
    @Autowired
    private IMypageMyEquipService myEquipService;
    @Autowired
    private IMypageDeliveryService deliveryService;
    @Autowired
    private IMypageInspecListService inspecListService;
    @Autowired
    private IMypageMatchingService matchingService;
    @Autowired
    private IMypageRentEquipService mypageRentEquipService;

    // 마이페이지-메인
    @RequestMapping(value="/mypage-main.action")
    public String mypageMain(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-main";
    }

    // 마이페이지-패스워드 체크
    @RequestMapping(value="/mypage-infoedit-passwordcheck.action")
    public String mypagePasswordCheck(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-infoEdit-passwordCheck";
    }

    // 마이페이지-회원 정보 수정
    @RequestMapping(value="/mypage-infoedit.action")
    public String mypageInfoEdit(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-infoEdit";
    }

    // 마이페이지-회원 정보 수정-휴대폰 번호 인증변경

    // 마이페이지-회원 정보 수정-이메일 수정
    @RequestMapping(value="/mypage-infoedit-email.action")
    public String mypageInfoEditEmail(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-infoEdit-email";
    }

    // 마이페이지-회원 정보 수정-닉네임 수정
    @RequestMapping(value="/mypage-infoedit-nickname.action")
    public String mypageInfoEditNickname(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-infoEdit-nickname";
    }

    //====================================================================================
    // 마이페이지-회원 정보 수정-비밀번호 변경
    @RequestMapping(value="/mypage-infoedit-password.action")
    public String mypageInfoEditPassword(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-infoEdit-password";
    }

    //====================================================================================
    // 마이페이지-회원 정보 수정-주소 변경
    @RequestMapping(value="/mypage-infoedit-address.action")
    public String mypageInfoEditAddress(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-infoEdit-address";
    }

    // 마이페이지-신뢰도
    @RequestMapping(value="/mypage-trust.action")
    public String mypageTrust(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-trust";
    }

    // 마이페이지-포인트
    @RequestMapping(value="/mypage-point.action")
    public String mypagePoint(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-point";
    }

    // 마이페이지-내가 소유한 장비
    @RequestMapping(value="/mypage-myequip.action")
    public String mypageMyEquip(@ModelAttribute("userCode") Integer userCode, Model model) {
        MyEquipDTO data = myEquipService.listMyEquip(userCode);

        System.out.println("로그인한 userCode: " + userCode);

        System.out.println("=== MypageController : mypageMyEquip() : START ===");

        System.out.println("EquipList size: " + data.getEquipList().size()); // 콘솔 출력
        System.out.println("StorenMap size: " + data.getStorenMap().size()); // 콘솔 출력
        System.out.println("firstStorenList size: " + data.getFirstStorenList().size()); // 콘솔 출력

        if (!data.getFirstStorenList().isEmpty()) {
            System.out.println("firstStorenList start_date : " + data.getFirstStorenList().getFirst().getRental_start_date());
        } else {
            System.out.println("firstStorenList is empty.");
        }

        model.addAttribute("equipList", data.getEquipList());
        model.addAttribute("storenMap", data.getStorenMap());
        model.addAttribute("firstStorenList", data.getFirstStorenList());
        //rentalList, storageList도 받아와야함

        System.out.println("=== MypageController : mypageMyEquip() : END ===");
        return "myPage-myEquip";
    }


    // 마이페이지-검수 결과 조회
    @RequestMapping(value="/mypage-inspecList.action")
    public String mypageInspecList(@ModelAttribute("userCode") Integer userCode, Model model) {

        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : START ===");

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
    public List<MypageInspecListDTO> getStorageStoreInspec(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STORAGE Store : START ===");
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STORAGE Store : END ===");
        return inspecListService.listStorageStoreInspec(userCode);
    }

    @RequestMapping(value="/api/inspec/storen/store", produces="application/json")
    @ResponseBody
    public List<MypageInspecListDTO> getStorenStoreInspec(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : START ===");
        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : END ===");
        return inspecListService.listStorenStoreInspec(userCode);
    }

    @RequestMapping(value="/api/inspec/storen/return", produces="application/json")
    @ResponseBody
    public List<MypageInspecListDTO> getStorenReturnInspec(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Return : START ===");
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Return : END ===");
        return inspecListService.listStorenReturnInspec(userCode);
    }

    // 마이페이지-배송 조회/내역
    // 처음에는 스토렌 사용자 배송내역 로드
    @RequestMapping(value="/mypage-delivery.action")
    public String mypageDelivery(@ModelAttribute("userCode") Integer userCode, Model model) {

        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : START ===");

        // 초기에는 스토렌 소유자 배송내역만 로드
        List<DeliveryDTO> storenOwnerDeliveries = deliveryService.getStorenOwnerDeliveries(userCode);
        model.addAttribute("deliveryList", storenOwnerDeliveries);
        model.addAttribute("activeTab", "storen"); // 초기 탭 지정
        model.addAttribute("storenTabType", "owner"); // 초기 서브탭 지정

        System.out.println("deliveryList size : " + storenOwnerDeliveries.size());
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : END ===");
        return "myPage-delivery";
    }

    // AJAX 요청 처리
    @RequestMapping(value="/api/delivery/storage", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getStorageDeliveries(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STORAGE : START ===");
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STORAGE : END ===");
        return deliveryService.getStorageDeliveries(userCode);
    }

    @RequestMapping(value="/api/delivery/storen/owner", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getStorenOwnerDeliveries(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : START ===");
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : END ===");
        return deliveryService.getStorenOwnerDeliveries(userCode);
    }

    @RequestMapping(value="/api/delivery/storen/user", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getStorenUserDeliveries(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN User : START ===");
        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN User : END ===");
        return deliveryService.getStorenUserDeliveries(userCode);
    }

    @RequestMapping(value="/api/delivery/rental", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> getRentalDeliveries(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageDelivery() - AJAX - RENTAL : START ===");
        System.out.println("=== MypageController : mypageDelivery() - AJAX - RENTAL : END ===");
        return deliveryService.getRentalDeliveries(userCode);
    }

    // 마이페이지-매칭 조회/내역
    @RequestMapping(value="/mypage-matchinglist.action")
    public String mypageMatchingList(@ModelAttribute("userCode") Integer userCode, Model model) {

        System.out.println("=== MypageController : mypageMatchingList() - AJAX - STOREN Owner : START ===");

        // 초기에는 스토렌 소유자의 매칭 신청이 들어온 내역만 로드
        List<StorenDTO> storenOwnerList = matchingService.listStroenOwnerTab(userCode);
        model.addAttribute("MatchingList", storenOwnerList);
        model.addAttribute("activeTab", "storen"); // 초기 탭 지정
        model.addAttribute("storenTabType", "owner"); // 초기 서브탭 지정
        model.addAttribute("userCode", userCode);

        System.out.println("deliveryList size : " + storenOwnerList.size());
        System.out.println("=== MypageController : mypageMatchingList() - AJAX - STOREN Owner : END ===");

        return "myPage-matchingList";
    }

    // AJAX 요청 처리 - 스토렌 소유자 탭
    @RequestMapping(value="/api/matching/storen/owner", produces="application/json")
    @ResponseBody
    public List<StorenDTO> getStorenOwnerMatching(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : getStorenOwnerMatching() - AJAX - STOREN Owner : START ===");
        System.out.println("=== MypageController : getStorenOwnerMatching() - AJAX - STOREN Owner : END ===");
        return matchingService.listStroenOwnerTab(userCode);
    }

    //AJAX 요청 처리 - 스토렌 유저 탭
    @RequestMapping(value="/api/matching/storen/user", produces="application/json")
    @ResponseBody
    public List<StorenDTO> getStorenUserMatching(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("=== MypageController : mypageMatchingList() - AJAX - STOREN User : START ===");
        System.out.println("=== MypageController : mypageMatchingList() - AJAX - STOREN User : END ===");
        return matchingService.listStorenUserTab(userCode);
    }

    // AJAX 요청 처리 - 스토렌 - 매칭 상세 정보
    @RequestMapping(value="/api/matching/storen/details/{transaction_id}", produces="application/json")
    @ResponseBody
    public List<MatchingRequestDTO> getStorenMatchingDetails(@PathVariable("transaction_id") int transactionId) {
        System.out.println("=== MypageController : getStorenMatchingDetails() - AJAX - STOREN Details : START ===");
        System.out.println("Transaction ID: " + transactionId);

        // 거래 ID에 대한 모든 매칭 요청 정보 가져오기
        List<MatchingRequestDTO> matchingRequests = matchingService.listStorenRequestTab(transactionId, "스토렌_매칭");

        System.out.println("=== MypageController : getStorenMatchingDetails() - AJAX - STOREN Details : END ===");
        return matchingRequests;
    }

    // 매칭 승인 처리를 위한 AJAX 요청 처리
    @PostMapping(value="/api/matching/approve", produces="application/json")
    @ResponseBody
    public Map<String, Object> approveMatching(@RequestParam("transactionId") int rentalId
                                             , @RequestParam("requestId") int requestId) {
        System.out.println("=== MypageController : approveMatching() - AJAX - Approve : START ===");
        Map<String, Object> result = new HashMap<>();

        try {
            // 매칭 승인 요청 저장
            boolean success = matchingService.approveMatchingRequest(rentalId, requestId);

            if (success) {
                result.put("success", true);
                result.put("message", "매칭 승인이 처리되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "매칭 승인이 처리되지 않았습니다.");
            }

        } catch(Exception e){
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        System.out.println("=== MypageController : approveMatching() - AJAX - Approve : END ===");
        return result;
    }

    @PostMapping(value="/api/matching/cancel", produces="application/json")
    @ResponseBody
    public Map<String, Object> cancelMatching(@RequestParam("transactionId") int rentalId
                                            , @RequestParam("requestId") int requestId) {
        System.out.println("=== MypageController : cancelMatching() - AJAX - Approve : START ===");
        Map<String, Object> result = new HashMap<>();

        try {
            // 매칭 승인 요청 저장
            boolean success = matchingService.cancleMatchingRequest(rentalId, requestId);

            if (success) {
                result.put("success", true);
                result.put("message", "매칭 신청이 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "매칭 신청이 삭제되지 않았습니다.");
            }

        } catch(Exception e){
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        System.out.println("=== MypageController : cancelMatching() - AJAX - Approve : END ===");
        return result;
    }

    // 마이페이지-내가 대여한 장비
    @RequestMapping(value="/mypage-rentequip.action")
    public String mypageRentEquip(@ModelAttribute("userCode") Integer userCode, Model model) {
        // 사용자가 대여한 장비 정보 조회
        MyRentEquipDTO rentEquipInfo = mypageRentEquipService.listRentStorenInfo(userCode);

        // 모델에 데이터 추가
        model.addAttribute("rentEquipInfo", rentEquipInfo);

        return "myPage-rentEquip";
    }

    // 마이페이지-내가 작성한 글
    @RequestMapping(value="/mypage-mypost.action")
    public String mypageMyPost(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-myPost";
    }

    // 마이페이지-찜
    @RequestMapping(value="/mypage-wishlist.action")
    public String mypageWishlist(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-wishlist";
    }

    // 마이페이지-나의 캠핑일지
    @RequestMapping(value="/mypage-diary.action")
    public String mypageDiary(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-diary";
    }

    // 마이페이지-나의 캠핑일지-추가
    @RequestMapping(value="/mypage-diary-write.action")
    public String mypageDiaryWrite(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-diary-write";
    }

    // 마이페이지-나의 캠핑일지-조회
    @RequestMapping(value="/mypage-diary-post.action")
    public String mypageDiaryPost(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-diary-post";
    }

    //====================================================================================
    // 마이페이지-북마크
    @RequestMapping(value="/mypage-bookmark.action")
    public String mypageBookmark(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-bookmark";
    }

    //====================================================================================
    // 마이페이지-쿠폰 내역
    @RequestMapping(value="/mypage-coupon.action")
    public String mypageCoupon(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-coupon";
    }

    // 마이페이지-1:1 문의내역
    @RequestMapping(value="/mypage-inquiry.action")
    public String mypageInquiry(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-inquiry";
    }

    // 마이페이지-1:1 문의내역-추가
    @RequestMapping(value="/mypage-inquiry-write.action")
    public String mypageInquiryWrite(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-inquiry-write";
    }

    // 마이페이지-1:1 문의내역-조회
    @RequestMapping(value="/mypage-inquiry-post.action")
    public String mypageInquiryPost(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-inquiry-post";
    }

    //====================================================================================
    // 마이페이지-회원 탈퇴
    @RequestMapping(value="/mypage-leave.action")
    public String mypageLeave(@ModelAttribute("userCode") Integer userCode, Model model) {
        return "myPage-leave";
    }

}