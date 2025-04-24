<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* 알림 드롭다운 컨테이너 */
    .notification-dropdown {
        width: 340px;
        max-height: 460px;
        background: #fff;
        box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        position: relative; /* 여기를 absolute에서 relative로 변경 */
        border-radius: 12px;
        overflow: hidden;
        z-index: 999;
        border: 1px solid rgba(0,0,0,0.1);
        animation: notiFadeIn 0.3s ease;
    }

    @keyframes notiFadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* 알림 헤더 영역 */
    .notification-header {
        padding: 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #f0f0f0;
        background-color: #fafafa;
    }

    .header-title {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
        font-size: 16px;
        color: #333;
    }

    .header-title i {
        color: var(--color-maple);
    }

    .read-all-btn {
        background: transparent;
        border: none;
        color: var(--color-maple);
        cursor: pointer;
        font-size: 14px;
        padding: 6px 10px;
        border-radius: 4px;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .read-all-btn:hover {
        background-color: #f8f1e6;
        color: #b85a2a;
    }

    /* 알림 리스트 컨테이너 */
    .notification-list-container {
        max-height: 380px;
        overflow-y: auto;
        scrollbar-width: thin;
    }

    .notification-list-container::-webkit-scrollbar {
        width: 6px;
    }

    .notification-list-container::-webkit-scrollbar-track {
        background: #f9f9f9;
    }

    .notification-list-container::-webkit-scrollbar-thumb {
        background-color: #ddd;
        border-radius: 3px;
    }

    /* 알림 리스트 */
    .notification-list {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    /* 알림 아이템 */
    .notification-item {
        border-bottom: 1px solid #f2f2f2;
        transition: all 0.2s ease;
    }

    .notification-item:last-child {
        border-bottom: none;
    }

    .notification-item:hover {
        background-color: #fafafa;
    }

    .notification-item a {

    }

    .notification-link {
        display: flex;
        padding: 16px;
        text-decoration: none;
        color: #333;
        position: relative;
        align-items: center;
        gap: 12px;
    }

    /* 읽지 않은 알림 표시 */
    .noti-indicator {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: transparent;
        flex-shrink: 0;
    }

    .notification-item.unread .noti-indicator {
        background-color: var(--color-coral);
    }

    .notification-item.unread {
        background-color: #fff8f2;
    }

    /* 알림 내용 영역 */
    .noti-content-wrapper {
        display: flex;
        flex-direction: column;
        gap: 6px;
        flex: 1;
    }

    .noti-content {
        font-size: 14px;
        line-height: 1.4;
        color: #333;
        word-break: break-word;
    }

    .notification-item.unread .noti-content {
        font-weight: 600;
    }

    .noti-date {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 12px;
        color: #888;
    }

    .noti-date i {
        font-size: 11px;
    }

    /* 알림 없음 상태 */
    .no-data {
        padding: 32px 16px;
    }

    .empty-notification {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: #aaa;
        gap: 12px;
    }

    .empty-notification i {
        font-size: 32px;
    }

    .empty-notification p {
        font-size: 14px;
        margin: 0;
    }

    /* 반응형 처리 */
    @media (max-width: 576px) {
        .notification-dropdown {
            position: relative;
            width: 100%;
            position: fixed;
            top: 60px;
            right: 10px;
            left: 10px;
            width: calc(100% - 20px);
            max-height: calc(100vh - 120px);
            border-radius: 8px;
        }

        .notification-link {
            padding: 12px 16px;
        }
    }
</style>


<div class="notification-dropdown">
    <!-- 상단 제목 및 전체읽음 -->
    <div class="notification-header">
        <div class="header-title">
            <i class="fa-solid fa-bell"></i>
            <span>알림</span>
        </div>
        <button id="readAllNotiBtn" class="read-all-btn">
            <i class="fa-solid fa-check-double"></i> 모두 읽음
        </button>
    </div>

    <!-- 알림 리스트 -->
    <div class="notification-list-container">
        <ul class="notification-list">
            <c:forEach var="noti" items="${notificationList}">
                <li class="notification-item ${noti.isRead == 0 ? 'unread' : ''}">
                    <a href="#" class="notification-item-link">

                        <div class="noti-indicator"></div>
                        <div class="noti-content-wrapper">
                            <span class="noti-content">${noti.notiContent}</span>
                            <span class="noti-date">
                                <i class="fa-regular fa-clock"></i>
                                <fmt:formatDate value="${noti.createdDate}" pattern="yyyy-MM-dd" />
                            </span>
                        </div>
                    </a>
                </li>
            </c:forEach>
            <c:if test="${empty notificationList}">
                <li class="notification-item no-data">
                    <div class="empty-notification">
                        <i class="fa-regular fa-bell-slash"></i>
                        <p>최근 알림이 없습니다.</p>
                    </div>
                </li>
            </c:if>
        </ul>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 알림 메뉴 외부 클릭 시 닫기
        document.addEventListener("click", function(e) {
            const notiBox = document.getElementById("notiBox");
            const notiBell = document.getElementById("notiBell");

            if (notiBox && notiBell) {
                if (!notiBox.contains(e.target) && e.target !== notiBell && !notiBell.contains(e.target)) {
                    notiBox.style.display = "none";
                }
            }
        });

        // '모두 읽음' 버튼에 호버 효과 추가
        const readAllBtn = document.querySelector("#readAllNotiBtn");
        if (readAllBtn) {
            readAllBtn.addEventListener("mouseenter", function() {
                this.style.transform = "translateY(-1px)";
            });

            readAllBtn.addEventListener("mouseleave", function() {
                this.style.transform = "translateY(0)";
            });

            // '모두 읽음' 버튼 클릭 시 알림 전체 읽음 처리
            readAllBtn.addEventListener("click", function(e) {
                e.stopPropagation(); // 이벤트 버블링 방지

                // 버튼에 로딩 상태 표시
                this.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> 처리 중';
                this.disabled = true;

                fetch("/noti/readall.action", {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                }).then(response => {
                    if (response.ok) {
                        // 읽음 처리 후 알림 갱신
                        updateNotificationCount(); // 알림 카운트 업데이트
                        loadNotifications(); // 알림 목록 갱신
                    }
                }).catch(error => {
                    console.error("Error marking notifications as read:", error);
                }).finally(() => {
                    // 버튼 상태 복원
                    this.innerHTML = '<i class="fa-solid fa-check-double"></i> 모두 읽음';
                    this.disabled = false;
                });
            });
        }

        // 알림 목록 갱신 함수
        function loadNotifications() {
            const notiBox = document.querySelector(".noti-dropdown-container");
            if (notiBox) {
                fetch("/noti.action")
                    .then(res => res.text())
                    .then(html => {
                        notiBox.innerHTML = html; // 알림 드롭다운 내용 갱신
                    })
                    .catch(error => {
                        console.error("Error loading notifications:", error);
                    });
            }
        }

        // 알림 카운트 업데이트 함수
        function updateNotificationCount() {
            const notiCount = document.getElementById("notiCount");
            const notiCountMini = document.getElementById("notiCountMini");

            fetch("/noti/count.action")
                .then(res => res.text())
                .then(count => {
                    const countNum = parseInt(count);
                    // 메인 헤더 카운트 업데이트
                    if (notiCount) {
                            notiCount.textContent = countNum;
                            notiCount.style.display = "inline-block";

                            // 카운트 변경 시 애니메이션 효과
                            notiCount.classList.add("pulse");
                            setTimeout(() => {
                                notiCount.classList.remove("pulse");
                            }, 1000);
                        } else {
                            notiCount.style.display = "none";
                        }
                    }

                    // 미니 헤더 카운트 업데이트
                    if (notiCountMini) {
                        if (countNum > 0) {
                            notiCountMini.textContent = countNum;
                            notiCountMini.style.display = "inline-block";

                            // 카운트 변경 시 애니메이션 효과
                            notiCountMini.classList.add("pulse");
                            setTimeout(() => {
                                notiCountMini.classList.remove("pulse");
                            }, 1000);
                        } else {
                            notiCountMini.style.display = "none";
                        }
                    }
                })
                .catch(error => {
                    console.error("Error updating notification count:", error);
                });
        }

        // 알림 아이템 클릭 이벤트 처리
        document.querySelector(".notification-list")?.addEventListener("click", function(e) {
            const notificationLink = e.target.closest('.notification-item-link');
            if (notificationLink) {
                e.preventDefault();

                // 알림 읽음 효과 적용
                    })
                    .catch(error => {
                        console.error("Error updating notification count:", error);
                    });
            }
        }

        // 알림 아이템에 이벤트 위임으로 클릭 이벤트 처리
        document.querySelector("#notiBox")?.addEventListener("click", function(e) {
            const notificationLink = e.target.closest('.notification-link');
            if (notificationLink) {
                // 알림 클릭 시 처리 로직을 여기에 추가할 수 있음
                // 예: 특정 페이지로 이동, 알림 읽음 처리 등
                e.preventDefault();

                // 여기서는 단순히 읽음 효과만 적용 (실제 구현 시 서버에 읽음 처리 요청 필요)
                const notificationItem = notificationLink.closest('.notification-item');
                if (notificationItem && notificationItem.classList.contains('unread')) {
                    notificationItem.classList.remove('unread');
                    updateNotificationCount(); // 읽음 처리 후 카운트 업데이트
                }

                // 필요 시 알림 링크 처리 로직 추가
                // window.location.href = notificationLink.getAttribute('href');
            }
        });
    });

    // 알림 카운트 배지 애니메이션 스타일
    if (!document.getElementById("noti-animation-style")) {
        const styleElement = document.createElement("style");
        styleElement.id = "noti-animation-style";
        styleElement.textContent = `

                // 링크 처리 로직 (원하는 대로 수정)
                // window.location.href = notificationLink.getAttribute('href');
            }
        });

        // 페이지 로드 시 초기 알림 카운트 로드
        updateNotificationCount();

        // 알림 아이콘에 호버 효과
        const notiBell = document.getElementById("notiBell");
        if (notiBell) {
            notiBell.addEventListener("mouseenter", function() {
                this.style.transform = "scale(1.05)";
            });

            notiBell.addEventListener("mouseleave", function() {
                this.style.transform = "scale(1)";
            });
        }
    });

    // 알림 카운트 배지 애니메이션 스타일 추가
    document.head.insertAdjacentHTML('beforeend', `
        <style>
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.2); }
                100% { transform: scale(1); }
            }

            .noti-count-badge.pulse {
                animation: pulse 0.5s ease;
            }

            #notiBell, #notiBellMini {
                transition: transform 0.2s ease;
            }
        `;
        document.head.appendChild(styleElement);
    }
    `);
</script>