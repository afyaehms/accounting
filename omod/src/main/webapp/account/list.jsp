<%--
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Billing module.
 *
 *  Billing module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Billing module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Billing module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>

<openmrs:require privilege="View Account" otherwise="/login.htm"
	redirect="/module/account/main.form" />

<spring:message var="pageTitle" code="accounting.account.manage"
	scope="page" />

<%@ include file="/WEB-INF/template/header.jsp"%>
<%@ include file="../includes/nav.jsp" %>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/moduleResources/account/styles/paging.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/moduleResources/account/scripts/paging.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/moduleResources/account/scripts/jquery/jquery-1.4.2.min.js"></script>
<h2>
	<spring:message code="accounting.account.manage" />
</h2>

<br />
<c:forEach items="${errors.allErrors}" var="error">
	<span class="error"><spring:message
			code="${error.defaultMessage}" text="${error.defaultMessage}" />
	</span><
</c:forEach>
<input type="button"
	value="<spring:message code='accounting.account.add'/>"
	onclick="javascript:window.location.href='account.form'" />

<br />
<br />
<c:choose>
	<c:when test="${not empty accounts}">
		<form method="post" onsubmit="return false" id="form">
			<input type="button" onclick="checkValue()"
				value="<spring:message code='accounting.account.deleteselected'/>" />
			<span class="boxHeader"><spring:message
					code="accounting.account.list" />
			</span>
			<div class="box">
				<table cellpadding="5" cellspacing="0">
					<tr>
						<th>#</th>
						<th><spring:message code="general.name" />
						</th>
						<th><spring:message code="accounting.accountType"/></th>
						<th><spring:message code="general.description" />
						</th>
						<th><spring:message code="accounting.createdDate" />
						</th>
						<th></th>
					</tr>
					<c:forEach items="${accounts}" var="account"
						varStatus="varStatus">
						<tr class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } ' <c:if test="${account.retired}"> style="text-decoration:line-through;"</c:if>>
							<td><c:out
									value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }" />
							</td>
							<td><a
								href="javascript:window.location.href='account.form?id=${account.id}'">${account.name}</a>
							</td>
							<td>${account.accountType }</td>
							<td>${account.description}</td>
							<td><openmrs:formatDate date="${account.createdDate}"
									type="textbox" />
							</td>
							<td><input type="checkbox" name="ids"
								value="${account.id}" />
							</td>
						</tr>
					</c:forEach>
					</form>
					<tr class="paging-container">
						<td colspan="7"><%@ include file="../paging.jsp"%></td>
					</tr>
				</table>
			</div>
			<script>
function checkValue()
{
	var form = jQuery("#form");
	if( jQuery("input[type='checkbox']:checked",form).length > 0 ) 
		form.submit();
	else{
		alert("Please choose items for deleting");
		return false;
	}
}</script>
	</c:when>
	<c:otherwise>
No Account found.
</c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/template/footer.jsp"%>
