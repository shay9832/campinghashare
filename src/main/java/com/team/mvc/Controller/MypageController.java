package com.team.mvc.Controller;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.MyEquipDTO;
import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.Interface.*;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MypageController {

    // 자동 의존성 주입
    //@Autowired
    //private SqlSession sqlSession;
    @Autowired
    private IMypageMyEquipService myEquipService;

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


        MyEquipDTO data = myEquipService.listMyEquip(2); // 로그인 이후 세션에서 받아오는 걸로 교체 예정

        model.addAttribute("equipList", data.getEquipList());
        model.addAttribute("storenMap", data.getStorenMap());
        model.addAttribute("firstStorenList", data.getFirstStorenList());
        //rentalList, storageList도 받아와야함


        return "myPage-myEquip";
    }


    // 마이페이지-검수 결과 조회
    @RequestMapping(value="/mypage-inspecList.action")
    public String mypageInspecList() {
        return "myPage-inspecList";
    }

    // 마이페이지-배송 조회/내역
    @RequestMapping(value="/mypage-delivery.action")
    public String mypageDelivery() {
        return "myPage-delivery";
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