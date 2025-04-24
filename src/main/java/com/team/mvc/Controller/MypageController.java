package com.team.mvc.Controller;

import com.team.mvc.DTO.*;
import com.team.mvc.Interface.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

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
    @Autowired
    private IMypageWishlistService wishlistService;
    @Autowired
    private IMypageInfoEditService infoEditService;
    @Autowired
    private IMypageMainService mainService;
    @Autowired
    private IMypagePointService pointService;
    @Autowired
    private IMypageMypostService mypostService;


    // 마이페이지-메인
    @RequestMapping(value="/mypage-main.action")
    public String mypageMain(@ModelAttribute("userCode") Integer userCode, Model model) {
        UserDTO user = mainService.getUserDTO(userCode);
        LinkedHashMap<String, Object> myEquipMap = mainService.getMyEquipmentMap(userCode);
        LinkedHashMap<String, Object> rentEquipMap = mainService.getRentEquipmentMap(userCode);
        Map<String, Object> postCommentMap = mainService.getPostCommentMap(userCode);
        Map<String, Map<String, Integer>> statusMap = mainService.getMyEquipmentStatus(userCode);
        List<StorenDTO> wishlist = mainService.getMyWishlist(userCode);

        model.addAttribute("user", user);
        model.addAttribute("myEquipMap", myEquipMap);
        model.addAttribute("rentEquipMap", rentEquipMap);
        model.addAttribute("postList", postCommentMap.get("postList"));
        model.addAttribute("commentList", postCommentMap.get("replyList"));
        model.addAttribute("emergencyMap", statusMap.get("emergency"));
        model.addAttribute("storenStatusMap", statusMap.get("storen"));
        model.addAttribute("count", statusMap.get("count"));
        model.addAttribute("wishlist", wishlist);

        return "myPage-main";
    }

    // 마이페이지-패스워드 체크
    @RequestMapping(value="/mypage-infoedit-passwordcheck.action")
    public String mypagePasswordCheck(@ModelAttribute("userCode") Integer userCode, Model model) {
        String userId = infoEditService.getUserIdByUserCode(userCode);
        model.addAttribute("userId", userId);
        return "myPage-infoEdit-passwordCheck";
    }

    // 마이페이지-패스워드 체크-패스워드 일치여부 판단
    @PostMapping("/mypage-password-check.action")
    @ResponseBody
    public String checkPassword(@ModelAttribute("userCode") Integer userCode
                                            , @RequestParam("password") String password) {
        System.out.println("입력한 비밀번호: " + password);
        return infoEditService.checkPassword(userCode, password) ? "success" : "fail";
    }

    // 마이페이지-회원 정보 수정
    @RequestMapping(value="/mypage-infoedit.action")
    public String mypageInfoEdit(@ModelAttribute("userCode") Integer userCode, Model model) {
        UserDTO user = infoEditService.getUserInfoByUserCode(userCode);
        model.addAttribute("user", user);
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
        List<MyPointDTO> pointList = pointService.listMyPointHistory(userCode);
        UserDTO user = pointService.getMyPointInfo(userCode);

        model.addAttribute("user", user);
        model.addAttribute("pointList", pointList);

        // 진행률 계산
        int currentTotal = user.getTotalPoint() + user.getTotalTrust();
        int nextTotal = currentTotal + user.getRemainPoint() + user.getRemainTrust();
        int progressPercentage = (int)((double)currentTotal / nextTotal * 100);
        model.addAttribute("progressPercentage", progressPercentage);

        return "myPage-point";
    }


    // 마이페이지-내가 소유한 장비(첫 요청 시)
    @RequestMapping(value="/mypage-myequip.action")
    public String getMypageMyEquip(@RequestParam(value = "page", defaultValue = "1") int page
                                   , @RequestParam(value = "size", defaultValue = "5") int size // 페이지당 표시할 장비 수
                                   , @RequestParam(value = "searchKeyword", required = false) String searchKeyword
                                   , @RequestParam(value = "sortType", required = false, defaultValue = "recent") String sortType
                                   , @ModelAttribute("userCode") Integer userCode
                                   , Model model) {
        System.out.println("=== MypageController : mypageMyEquip() : START ===");

        // DTO 생성 및 검색/정렬 조건 설정
        EquipmentDTO dto = new EquipmentDTO();
        dto.setUser_code(userCode);

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchKeyword", searchKeyword);
        }

        // 정렬 조건 설정 (최신순, 이름순, 등급순 등)
        dto.setSortType(sortType);
        model.addAttribute("sortType", sortType);

        // 장비 상태현황 맵 가져오기
        Map<String, Map<String, Integer>> statusMap = myEquipService.getMyEquipmentStatus(userCode);
        model.addAttribute("emergencyMap", statusMap.get("emergency"));
        model.addAttribute("storenStatusMap", statusMap.get("storen"));
        model.addAttribute("count", statusMap.get("count"));

        // 전체 장비 수 조회
        int totalEquipCount = myEquipService.getMyGeneralEquipCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalEquipCount, size, 10);
        dto.setPagenation(pagenation);

        // 일반 장비 리스트 가져오기 (페이징 적용)
        List<EquipmentDTO> equipmentList = myEquipService.listMyGeneralPaged(dto);

        model.addAttribute("equipList", equipmentList);
        model.addAttribute("pagenation", pagenation);
        model.addAttribute("activeTab", "general"); // 초기 탭 지정

        model.addAttribute("activeTab", "general"); // 초기 탭 지정
        
        System.out.println("=== MypageController : mypageMyEquip() : END ===");
        return "myPage-myEquip";
    }

    // 마이페이지-내가 소유한 장비 - 일반 탭
    @RequestMapping(value="/api/myequipment/general", produces="application/json")
    @ResponseBody
    public List<EquipmentDTO> getMypageMyGeneral(@ModelAttribute("userCode") Integer userCode) {
        return myEquipService.listMyGeneral(userCode);
    }

    // 마이페이지-내가 소유한 장비 - 스토렌 탭
    @RequestMapping(value="/api/myequipment/storen", produces="application/json")
    @ResponseBody
    public List<StorenDTO> getMypageMyStoren(@ModelAttribute("userCode") Integer userCode) {
        System.out.println("Storen-userCode : " + userCode);
        return myEquipService.listMyStoren(userCode);
    }

    // 스토렌 탭 전용 페이지네이션 API
    @RequestMapping("/api/myequipment/storen/paged")
    @ResponseBody
    public Map<String, Object> getMypageMyStorenPaged(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            @RequestParam(value = "sortType", required = false, defaultValue = "recent") String sortType,
            @ModelAttribute("userCode") Integer userCode) {

        Map<String, Object> result = new HashMap<>();

        // DTO 생성 및 검색/정렬 조건 설정
        StorenDTO dto = new StorenDTO();
        dto.setUser_code(userCode);

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchKeyword(searchKeyword);
        }

        // 정렬 조건 설정
        dto.setSortType(sortType);

        // 전체 스토렌 수 조회
        int totalStorenCount = myEquipService.getMyStorenCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalStorenCount, size, 10);
        dto.setPagenation(pagenation);

        // 스토렌 리스트 가져오기 (페이징 적용)
        List<StorenDTO> storenList = myEquipService.listMyStorenPaged(dto);

        result.put("storenList", storenList);
        result.put("pagenation", pagenation);

        return result;
    }

    // 마이페이지-내가 소유한 장비 - 스토렌 탭 - 상세
    @RequestMapping(value="/api/myequipment/storen/details", produces="application/json")
    @ResponseBody
    public List<StorenDTO> getMypageMyStorenDetails(@ModelAttribute("userCode") Integer userCode
                                                    , @RequestParam("equipCode") Integer equipCode) {
        return myEquipService.listMyStorenDetail(userCode, equipCode);
    }

    // 마이페이지-화살표 : 상태별 스토렌 조회
    @GetMapping("/api/myequipment/storen/filter")
    @ResponseBody
    public List<StorenDTO> getStorenByStatus(@ModelAttribute("userCode") Integer userCode
                                                     , @RequestParam("status") String status) {
        // 서비스 메소드 호출하여 여러 상태로 필터링된 스토렌 목록 가져오기
        return myEquipService.listMyStorenByStatus(userCode, status);
    }

    // 마이페이지-긴급 확인 필요 : 상태별 스토렌 탭 조회(추후 통합 탭 조회로 수정 예정)
    @GetMapping("/api/myequipment/emergency-filter")
    @ResponseBody
    public List<StorenDTO> getStorenByMultipleStatus(@ModelAttribute("userCode") Integer userCode,
                                                       @RequestParam("keyword") String keyword,
                                                       @RequestParam("statuses") String statusesParam) {
        // 쉼표로 구분된 상태 문자열을 배열로 변환
        String[] statuses = statusesParam.split(",");
        System.out.println("Received statuses: " + Arrays.toString(statuses)); // 로그 추가

        // 서비스 메소드 호출하여 즉시 확인 필요 항목 가져오기
        return myEquipService.listMyStorenByStatus(userCode, keyword, statuses);
    }


    // 마이페이지-검수 결과 조회
    @RequestMapping(value="/mypage-inspecList.action")
    public String mypageInspecList(@ModelAttribute("userCode") Integer userCode, Model model
                                    , @RequestParam(value="id", required=false) Integer id
                                    , @RequestParam(value="activeTab", required=false) String activeTab
                                    , @RequestParam(value="storenTabType", required=false) String storenTabType) {

        System.out.println("=== MypageController : mypageInspecList() - AJAX - STOREN Store : START ===");

        // 기본값 설정
        activeTab = (activeTab != null) ? activeTab : "storen";
        storenTabType = (storenTabType != null) ? storenTabType : "store";

        // 초기에는 스토렌 입고 검수내역만 로드
        List<MypageInspecListDTO> storenStoreInspec = inspecListService.listStorenStoreInspec(userCode);
        model.addAttribute("inspecList", storenStoreInspec);
        model.addAttribute("activeTab", activeTab); // 초기 탭 지정
        model.addAttribute("storenTabType", storenTabType); // 초기 서브탭 지정
        model.addAttribute("storenId", id);

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

    // 검수 검색 API
    @RequestMapping(value="/api/inspec/search", produces="application/json")
    @ResponseBody
    public List<MypageInspecListDTO> searchInspec(@ModelAttribute("userCode") Integer userCode,
                                                  @RequestParam("id") Integer storenId) {
        return inspecListService.getInspecByStorenId(storenId);
    }

    // 마이페이지-배송 조회/내역
    // 처음에는 스토렌 사용자 배송내역 로드
    @RequestMapping(value="/mypage-delivery.action")
    public String mypageDelivery(@ModelAttribute("userCode") Integer userCode, Model model
                                , @RequestParam(value="id", required=false) Integer id
                                , @RequestParam(value="activeTab", required=false) String activeTab
                                , @RequestParam(value="storenTabType", required=false) String storenTabType) {

        System.out.println("=== MypageController : mypageDelivery() - AJAX - STOREN Owner : START ===");

        // 기본값 설정
        activeTab = (activeTab != null) ? activeTab : "storen";
        storenTabType = (storenTabType != null) ? storenTabType : "owner";

        // 초기에는 스토렌 소유자 배송내역만 로드
        List<DeliveryDTO> storenOwnerDeliveries = deliveryService.getStorenOwnerDeliveries(userCode);

        // 모델에 데이터 추가
        model.addAttribute("deliveryList", storenOwnerDeliveries);
        model.addAttribute("activeTab", activeTab);
        model.addAttribute("storenTabType", storenTabType);
        model.addAttribute("storenId", id);


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

    // 배송 검색 API
    @RequestMapping(value="/api/delivery/search", produces="application/json")
    @ResponseBody
    public List<DeliveryDTO> searchDelivery(@ModelAttribute("userCode") Integer userCode,
                                            @RequestParam("id") Integer storenId) {
        return deliveryService.getDeliveryByStorenId(userCode, storenId);
    }

    // 마이페이지-매칭 조회/내역
    @RequestMapping(value="/mypage-matchinglist.action")
    public String mypageMatchingList(@ModelAttribute("userCode") Integer userCode, Model model
                                    , @RequestParam(value="id", required=false) Integer id
                                    , @RequestParam(value="activeTab", required=false) String activeTab
                                    , @RequestParam(value="storenTabType", required=false) String storenTabType) {

        System.out.println("=== MypageController : mypageMatchingList() - AJAX - STOREN Owner : START ===");
        StorenDTO storenSearch = new StorenDTO();
        if (id != null) {
            // 특정 스토렌id 검색으로 매칭 페이지에 들어왔다면
            storenSearch = matchingService.getMatchingByStorenId(userCode, id);
            model.addAttribute("storenId", id);
            model.addAttribute("activeTab", activeTab);
            model.addAttribute("storenTabType", storenTabType);
            model.addAttribute("storenSearch", storenSearch);
        }
        else {
            // 초기에는 스토렌 소유자의 매칭 신청이 들어온 내역만 로드
            List<StorenDTO> storenOwnerList = matchingService.listStroenOwnerTab(userCode);
            model.addAttribute("MatchingList", storenOwnerList);
            model.addAttribute("activeTab", "storen"); // 초기 탭 지정
            model.addAttribute("storenTabType", "owner"); // 초기 서브탭 지정
            model.addAttribute("userCode", userCode);
            model.addAttribute("storenId", id);

            System.out.println("deliveryList size : " + storenOwnerList.size());
            System.out.println("=== MypageController : mypageMatchingList() - AJAX - STOREN Owner : END ===");
        }

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

    // 매칭 검색 API
    @RequestMapping(value="/api/matching/search", produces="application/json")
    @ResponseBody
    public StorenDTO searchMatching(@ModelAttribute("userCode") Integer userCode,
                                          @RequestParam("id") Integer storenId) {
        return matchingService.getMatchingByStorenId(userCode, storenId);
    }

    // 마이페이지-내가 대여한 장비
    @RequestMapping(value="/mypage-rentequip.action")
    public String mypageRentEquip(@ModelAttribute("userCode") Integer userCode, Model model) {
        System.out.println("내가 대여한 장비의 유저코드 : " + userCode);
        // 사용자가 대여한 장비 정보 조회
        MyRentEquipDTO rentEquipInfo = mypageRentEquipService.listRentStorenInfo(userCode);
        // 장비 상태현황 맵 가져오기
        Map<String, Map<String, Integer>> statusMap = mypageRentEquipService.getRentEquipmentStatus(userCode);

        model.addAttribute("emergencyMap", statusMap.get("emergency"));
        model.addAttribute("storenStatusMap", statusMap.get("storen"));
        model.addAttribute("count", statusMap.get("count"));
        // 모델에 데이터 추가
        model.addAttribute("rentEquipInfo", rentEquipInfo);

        return "myPage-rentEquip";
    }

    // 마이페이지-내가 작성한 글
    @RequestMapping(value="/mypage-mypost.action")
    public String mypageMyPost(@ModelAttribute("userCode") Integer userCode
                            , @RequestParam(value = "page", defaultValue = "1") int page
                            , @RequestParam(value = "size", defaultValue = "10") int size
                            , @RequestParam(value = "searchType", required = false) String searchType
                            , @RequestParam(value = "searchKeyword", required = false) String searchKeyword
                            , @RequestParam(value = "sortType", required = false, defaultValue = "recent") String sortType
                            , Model model) {
        // 검색 조건이 담길 dto 생성
        BoardPostDTO dto = new BoardPostDTO();
        dto.setUserCode(userCode);
        dto.setSortType(sortType);

        // 검색 조건 설정
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchKeyword", searchKeyword);
        }

        // 전체 게시물 수 조회
        int totalPostCount = mypostService.getUserPostCount(dto);

        // 페이징 처리
        Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);
        dto.setPagenation(pagenation);

        // 게시물 목록 조회
        List<BoardPostDTO> postList = mypostService.getUserPostList(dto);

        // 모델에 데이터 추가
        model.addAttribute("postList", postList);
        model.addAttribute("pagenation", pagenation);
        model.addAttribute("sortType", sortType);
        model.addAttribute("isPostMode", true);

        return "myPage-myPost";
    }
    // AJAX를 위한 API 메소드
    @RequestMapping("api/mypage-mypost.action")
    @ResponseBody
    public Map<String, Object> myPageMyPostApi(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            @RequestParam(value = "sortType", required = false, defaultValue = "recent") String sortType,
            @RequestParam(value = "isPostMode", required = false, defaultValue = "true") boolean isPostMode,
            @ModelAttribute("userCode") Integer userCode) {

        Map<String, Object> result = new HashMap<>();

        // 검색 조건이 담길 dto 생성
        BoardPostDTO dto = new BoardPostDTO();
        dto.setUserCode(userCode);
        dto.setSortType(sortType);

        // 검색 조건 설정
        if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            dto.setSearchType(searchType);
            dto.setSearchKeyword(searchKeyword);
        }

        if (isPostMode) {
            // 게시글 모드
            int totalPostCount = mypostService.getUserPostCount(dto);
            Pagenation pagenation = new Pagenation(page, totalPostCount, size, 10);
            dto.setPagenation(pagenation);

            List<BoardPostDTO> postList = mypostService.getUserPostList(dto);

            result.put("postList", postList);
            result.put("pagenation", pagenation);
        } else {
            // 댓글 모드
            int totalReplyCount = mypostService.getUserReplyCount(dto);
            Pagenation pagenation = new Pagenation(page, totalReplyCount, size, 10);
            dto.setPagenation(pagenation);

            List<ReplyDTO> replyList = mypostService.getUserReplyList(dto);

            result.put("replyList", replyList);
            result.put("pagenation", pagenation);
        }

        result.put("sortType", sortType);
        result.put("isPostMode", isPostMode);

        return result;
    }

    // 마이페이지-찜
    @RequestMapping(value="/mypage-wishlist.action")
    public String mypageWishlist(@ModelAttribute("userCode") Integer userCode, Model model) {
        List<StorenDTO> storenList = wishlistService.listMyWishStoren(userCode);
        model.addAttribute("storenList", storenList);
        model.addAttribute("activeTab", "storen");
        return "myPage-wishlist";
    }

    // 마이페이지-찜 AJAX 요청 처리(스토렌 탭)
    @RequestMapping(value="/api/wish/storen", produces="application/json")
    @ResponseBody
    public List<StorenDTO> mypageWishlistStoren(@ModelAttribute("userCode") Integer userCode){

        System.out.println("userCode: " + userCode);

        return wishlistService.listMyWishStoren(userCode);
    }

    @RequestMapping(value="/api/wish/delete", produces = "application/json")
    @ResponseBody
    public Map<String, Object> deleteWish(@ModelAttribute("userCode") Integer userCode
                                          , @RequestParam("id") Integer id
                                          , @RequestParam("type") String type) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 매칭 승인 요청 저장
            boolean success = wishlistService.deleteMyWishStoren(userCode, id, type);

            if (success) {
                result.put("success", true);
                result.put("message", "찜이 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "찜이 삭제되지 않았습니다.");
            }

        } catch(Exception e){
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        return result;
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