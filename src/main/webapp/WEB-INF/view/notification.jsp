<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 알림 드롭다운 전체 영역 -->
<div class="notification-dropdown">
    <div class="notification-header">
        <div class="header-title">
            <i class="fa-solid fa-bell"></i>
            <span>알림</span>
        </div>
        <button id="readAllNotiBtn" class="read-all-btn">
            <i class="fa-solid fa-check-double"></i> 모두 읽음
        </button>
    </div>
    <div class="notification-list-container">
        <ul class="notification-list">
            <c:forEach var="noti" items="${notificationList}">
                <li class="notification-item ${noti.isRead == 0 ? 'unread' : ''}">
                    <a href="${noti.notiUrl}" class="notification-item-link">
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const readAllBtn = document.getElementById("readAllNotiBtn");

        if (readAllBtn) {
            readAllBtn.addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();
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
                        updateNotificationCount();
                        reloadNotificationDropdown();
                    }
                }).catch(error => {
                    console.error("Error marking all as read:", error);
                }).finally(() => {
                    this.innerHTML = '<i class="fa-solid fa-check-double"></i> 모두 읽음';
                    this.disabled = false;
                });
            });
        }

        function reloadNotificationDropdown() {
            fetch("/noti.action")
                .then(res => res.text())
                .then(html => {
                    const dropdowns = document.querySelectorAll(".notification-dropdown");
                    dropdowns.forEach(el => el.innerHTML = html);
                });
        }

        function updateNotificationCount() {
            fetch("/noti/count.action")
                .then(res => res.text())
                .then(count => {
                    const countNum = parseInt(count);
                    const notiCount = document.getElementById("notiCount");
                    const notiCountMini = document.getElementById("notiCountMini");

                    if (notiCount) {
                        notiCount.textContent = countNum;
                        notiCount.style.display = countNum > 0 ? "inline-block" : "none";
                    }
                    if (notiCountMini) {
                        notiCountMini.textContent = countNum;
                        notiCountMini.style.display = countNum > 0 ? "inline-block" : "none";
                    }
                });
        }
    });
</script>
