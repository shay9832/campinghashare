<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<h2>페이지 모음</h2>

<!-- 공통 UI -->
<a href="${pageContext.request.contextPath}/main.action" target="_blank">main.jsp</a><br>
<a href="${pageContext.request.contextPath}/login-user.action" target="_blank">login-user.jsp</a><br>
<a href="${pageContext.request.contextPath}/registeruser-tel.action" target="_blank">registerUser-tel.jsp</a><br>
<a href="${pageContext.request.contextPath}/registeruser-id.action" target="_blank">registerUser-id.jsp</a><br>
<a href="${pageContext.request.contextPath}/registerUser-sns-id.jsp" target="_blank">registerUser-sns-id.jsp (직접 링크 유지)</a><br>
<a href="${pageContext.request.contextPath}/login-admin.action" target="_blank">login-admin.jsp</a><br>
<a href="${pageContext.request.contextPath}/admin/registeradmin-id.action" target="_blank">registerAdmin-id.jsp</a><br>
<br>

<!-- 장비 등록 프로세스 -->
<a href="${pageContext.request.contextPath}/equipregister-majorcategory.action" target="_blank">대분류 선택</a><br>
<a href="${pageContext.request.contextPath}/equipregister-middlecategory.action?category=텐트/쉘터" target="_blank">중분류 선택</a><br>
<a href="${pageContext.request.contextPath}/equipregister-brand.action?majorCategory=텐트/쉘터&middleCategory=텐트" target="_blank">브랜드 선택</a><br>
<a href="${pageContext.request.contextPath}/equipregister-newprice.action?majorCategory=텐트/쉘터&middleCategory=텐트&brand=코베아" target="_blank">신품가 입력</a><br>
<a href="${pageContext.request.contextPath}/equipregister-complete.action" target="_blank">등록 완료 (POST 테스트용)</a><br>
<br>

<!-- 스토렌 등록 / 렌탈 -->
<a href="${pageContext.request.contextPath}/storenRegister-storage-info.action" target="_blank">스토렌 정보 입력</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-storage-pay.action" target="_blank">스토렌 결제</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-storage-pay-coupon.action" target="_blank">스토렌 쿠폰 적용</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-storage-pay-info.action" target="_blank">결제 정보 확인</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-storage-pay-complete.action" target="_blank">결제 완료</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-inspecResult.action" target="_blank">검수 결과</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-inspecResult-return.action" target="_blank">반송 결과</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-rentalRegister.action" target="_blank">렌탈 등록</a><br>
<a href="${pageContext.request.contextPath}/storenRegister-rentalRegister-complete.action" target="_blank">렌탈 등록 완료</a><br>
<a href="${pageContext.request.contextPath}/rentalSearch-main.action" target="_blank">렌탈 검색 메인</a><br>
<a href="${pageContext.request.contextPath}/storenMatching-request.action" target="_blank">스토렌 매칭 요청</a><br>
<a href="${pageContext.request.contextPath}/storenMatching-rental-pay.action" target="_blank">렌탈 결제</a><br>
<a href="${pageContext.request.contextPath}/storenMatching-rental-pay-complete.action" target="_blank">렌탈 결제 완료</a><br>
<br>

<!-- 마이페이지 -->
<a href="${pageContext.request.contextPath}/mypage-main.action" target="_blank">마이페이지 메인</a><br>
<a href="${pageContext.request.contextPath}/mypage-infoedit.action" target="_blank">정보 수정</a><br>
<a href="${pageContext.request.contextPath}/mypage-infoedit-email.action" target="_blank">이메일 수정</a><br>
<a href="${pageContext.request.contextPath}/mypage-infoedit-nickname.action" target="_blank">닉네임 수정</a><br>
<a href="${pageContext.request.contextPath}/mypage-infoedit-passwordcheck.action" target="_blank">비밀번호 확인</a><br>
<a href="${pageContext.request.contextPath}/mypage-myequip.action" target="_blank">내 장비</a><br>
<a href="${pageContext.request.contextPath}/mypage-mypost.action" target="_blank">내 게시글</a><br>
<br>

<!-- 게시판 -->
<a href="${pageContext.request.contextPath}/notice.action" target="_blank">공지사항</a><br>
<a href="${pageContext.request.contextPath}/event.action" target="_blank">이벤트</a><br>
<a href="${pageContext.request.contextPath}/boardbest.action" target="_blank">인기게시판</a><br>
<a href="${pageContext.request.contextPath}/boardfree.action" target="_blank">자유게시판</a><br>
<a href="${pageContext.request.contextPath}/boardfree-post.action?postId=1" target="_blank">자유게시판 상세</a><br>
<a href="${pageContext.request.contextPath}/boardfree-write.action" target="_blank">자유게시판 글쓰기</a><br>
<a href="${pageContext.request.contextPath}/boardimage.action" target="_blank">이미지 게시판</a><br>
<a href="${pageContext.request.contextPath}/boardimage-post.action?postId=1" target="_blank">이미지 게시판 상세</a><br>
<a href="${pageContext.request.contextPath}/boardimage-write.action" target="_blank">이미지 게시판 글쓰기</a><br>
<a href="${pageContext.request.contextPath}/boardmain.action" target="_blank">게시판 메인</a><br>
<br>

<!-- 관리자 전용 기능 -->
<a href="${pageContext.request.contextPath}/admin-main.action" target="_blank">관리자 대시보드</a><br>
<a href="${pageContext.request.contextPath}/admin-boardUpdate.action" target="_blank">게시판 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-communityStatistics.action" target="_blank">커뮤니티 통계</a><br>
<a href="${pageContext.request.contextPath}/admin-couponList.action" target="_blank">쿠폰 목록</a><br>
<a href="${pageContext.request.contextPath}/admin-createCoupon.action" target="_blank">쿠폰 생성</a><br>
<a href="${pageContext.request.contextPath}/admin-deliveryUpdate.action" target="_blank">배송 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-equipList.action" target="_blank">장비 목록</a><br>
<a href="${pageContext.request.contextPath}/admin-equipStatistics.action" target="_blank">장비 통계</a><br>
<a href="${pageContext.request.contextPath}/admin-eventUpdate.action" target="_blank">이벤트 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-inspectList.action" target="_blank">검수 목록</a><br>
<a href="${pageContext.request.contextPath}/admin-matchingList.action" target="_blank">매칭 목록</a><br>
<a href="${pageContext.request.contextPath}/admin-payUpdate.action" target="_blank">결제 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-pointUpdate.action" target="_blank">포인트 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-replyUpdate.action" target="_blank">댓글 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-postUpdate.action" target="_blank">게시물 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-userDrop.action" target="_blank">회원 제재 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-userList.action" target="_blank">회원 목록</a><br>
<a href="${pageContext.request.contextPath}/admin-userReport.action" target="_blank">신고 관리</a><br>
<a href="${pageContext.request.contextPath}/admin-userReportList.action" target="_blank">신고 처리 내역</a><br>

</body>
</html>
