<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<c:set var="tenant" value="n3c_clinical" />
<c:set var="service" value="clinicalcohort_registration" />

<h2>UNA check: ${param.email}</h2>

<sql:query var="dua" dataSource="jdbc/N3CRegistrationTagLib">
	select id,name from incommon.domain_map where (? = domain or ? ~ ('([a-z0-9]+[.])+'||domain||'$')) and ? !~ 'nih.gov$'
	<sql:param>${param.email}</sql:param>
	<sql:param>${param.email}</sql:param>
	<sql:param>${param.email}</sql:param>
</sql:query>

<c:forEach items="${dua.rows}" var="row" varStatus="rowCounter">
	<p><b>${row.name}</b> is federated with InCommon, which supports use of your institutional credentials
	to log into N3C. Click on the button below to continue your registration.</p>
	<a href="https://federation.nih.gov/Shibboleth.sso/Login?SAMLDS=1&entityID=urn:mace:incommon:${param.email}&target=https%3A%2F%2Ffederation.nih.gov%2FShibAuth%2Finitiatelogin%3Ftarget%3Dhttps%253A%252F%252Fauth.ncats.nih.gov%252F_api%252Fv2%252Fauth%252Fauthenticate%253Fclient_id%25253D${service}%252526redirect_uri%25253Dhttps%2525253A%2525252F%2525252Fauth.ncats.nih.gov%2525252F_api%2525252Fv2%2525252Fauth%2525252F${tenant}%2525252F${service}%2525252Fsaml%252526protocol%25253Dsaml%252526connection%25253DInCommon%252526tenant%25253D${tenant}" class="btn btn-primary btn-n3c active" role="button" aria-pressed="true">Login Via InCommon</a>
	<c:set var="incommon_id">${row.id}</c:set>
</c:forEach>

<c:choose>
	<c:when test="${(fn:endsWith(param.email,'nih.gov') || fn:endsWith(param.email, 'hhs.gov'))}">
		<a href="https://auth.ncats.nih.gov/_api/v2/auth/authenticate?client_id=${service}&connection=HHS%20-%20PIV%20only&redirect_uri=https%3A%2F%2Fauth.ncats.nih.gov%2F_api%2Fv2%2Fauth%2F${tenant}%2F${service}%2Fsaml&protocol=saml&tenant=${tenant}" class="btn btn-primary btn-n3c active" role="button" aria-pressed="true">Login Using PIV</a>
	</c:when>
	<c:when test="${empty incommon_id}">
		<p>Your institution is not federated with InCommon, so you will need to log into N3C via login.gov. If you already have a
		login.gov ID that uses your institutional email, click on the button below to continue your registration. If you do not already
		have a login.gov ID, you need to first create on using your institutional email and then click on the button below to
		continue your registration.</p>
		<a href="https://auth.ncats.nih.gov/_api/v2/auth/authenticate?client_id=${service}&connection=Login.gov&redirect_uri=https%3A%2F%2Fauth.ncats.nih.gov%2F_api%2Fv2%2Fauth%2F${tenant}%2F${service}%2Fsaml&protocol=saml&tenant=${tenant}" class="btn btn-primary btn-n3c active" role="button" aria-pressed="true">Login Via Login.gov</a>
	</c:when>
</c:choose>
