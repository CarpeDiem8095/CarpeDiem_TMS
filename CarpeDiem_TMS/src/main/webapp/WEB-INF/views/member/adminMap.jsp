<%@page import="java.util.List"%>
<%@page import="com.cp.tms.model.member.IMemberDao"%>
<%@page import="com.cp.tms.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#container {
	width: 900px;
	border: 2px solid red;
	margin: auto;
}

th {
	border: 1px solid #444444;
}
</style>
</head>
<body>
	<div id="container">
		<h3>관리자 전용 페이지</h3>
		<form action="./questionBoardAdmin.do" method="post" id="frm" name="frm"
			onsubmit="return chkbox();">
			<div class="panel-group" id="accordion">
				<table class="table table-bordered">
					<tr class="info">
						<c:if test="${mDto.auth eq 'A'}">
							<th>
					<input type="checkbox" id="allCheck" onclick="checkAll(this.checked)">
							</th>
						</c:if>
						<th>회원 번호</th>
						<th>이메일</th>
						<th>닉네임</th>
						<th>등록일</th>
						<c:if test="${mDto.auth eq 'Y'}">
							<th>사용여부</th>
						</c:if>
					</tr>
					<c:forEach var="mDto" items="${selAll}" varStatus="vs">
			<tr>
				<td><input type="checkbox" name="ch" value="${mDto.seq}"></td>
				<td>${vs.count}</td>	
				<td>${mDto.email}</td>
				<c:choose>
					<c:when test="${mDto.delflag eq 'Y'}">
						<td>
							<p style="color: red;">관리자 의해 삭제됨</p>
						</td>
					</c:when>
					<c:otherwise>
						<td>
<%-- 							<jsp:setProperty property="depth" name="pho" value="${mDto.ninkname}"/> --%>
<%-- 							<jsp:getProperty property="photo" name="pho"/> --%>
							<a href="./detailBoard.do?seq=${mDto.seq}">${mDto.nickname}</a>
						</td>
					</c:otherwise>
				</c:choose>
				<td>${mDto.withdrawal}</td>
				<td>
				<fmt:formatDate value="${mDto.joindate}" type="date"/>
				</td>
			</tr>
			</c:forEach>
				</table>
			</div>

			<!-- 페이징 -->
			<div class="center" style="text-align: center;">
				<ul class="pagination">
					<c:if test="${page.startPage ne 1}">
						<li><a href="./questionBoardAdmin.do?page=1">◀◀</a></li>
						<li><a
							href="./questionBoardAdmin.do?page=${page.startPage-1}">◁</a></li>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}"
						step="1">
						<li><a href="./questionBoardAdmin.do?page=${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</a></li>
					</c:forEach>
					<c:if test="${page.startPage+page.countPage le page.totalPage}">
						<li><a href="./questionBoardAdmin.do?page=${page.endPage+1}">▷</a></li>
						<li><a href="./questionBoardAdmin.do?page=${page.totalPage}">▶▶</a></li>
					</c:if>
				</ul>
			</div>
		</form>
		</div>
</body>
</html>