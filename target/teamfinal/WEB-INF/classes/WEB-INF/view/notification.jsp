<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="notiContainer" class="noti-dropdown">
    <c:forEach var="n" items="${notiList}">
        <div class="noti-item <c:if test='${n.isRead eq "N"}'>unread</c:if>'">
            <span>${n.message}</span>
            <span class="noti-time">${n.createdDate}</span>
        </div>
    </c:forEach>
</div>

<style>
    .noti-dropdown {
        background: #fff;
        padding: 10px;
        border: 1px solid var(--border-light);
        border-radius: 6px;
        box-shadow: var(--shadow-md);
        max-height: 300px;
        overflow-y: auto;
        position: absolute;
        right: 0;
        top: 100%;
        width: 320px;
        z-index: 99999;
    }

    .noti-item.unread {
        font-weight: bold;
        background-color: #f9f9f9;
    }

    .noti-time {
        display: block;
        font-size: 12px;
        color: gray;
        margin-top: 4px;
    }
</style>

<script>
    // 알림창 열릴 때 읽음 처리 요청
    fetch('${pageContext.request.contextPath}/noti-readall.action', { method: 'POST' });
</script>
