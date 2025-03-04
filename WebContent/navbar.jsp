<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="n3c" uri="http://icts.uiowa.edu/N3CRegistrationTagLib"%>

	<nav class="navbar navbar-expand-lg">
		<a class="navbar-brand" href="<util:applicationRoot/>/"><img src="<util:applicationRoot/>/resources/images/logo.png" height=50px>N3C Registration</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			<c:if test="${not empty admin}">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="/" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="<util:applicationRoot/>/admin">Admin Main</a>
							<a class="dropdown-item" href="<util:applicationRoot/>/admin/organizations.jsp">Organization Roster</a>
							<a class="dropdown-item" href="<util:applicationRoot/>/admin/users.jsp">User Roster</a>
					</div>
				</li>
			</c:if>
			<c:if test="${not empty admin}">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="/" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Tenants</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<n3c:foreachTenantGroup var="x">
							<n3c:tenantGroup>
								<a class="dropdown-item" href="<util:applicationRoot/>/admin/tenant.jsp?group=<n3c:tenantGroupGroupName/>"><n3c:tenantGroupDescription/></a>
							</n3c:tenantGroup>
						</n3c:foreachTenantGroup>
					</div>
				</li>
			</c:if>
			<c:if test="${not empty user_email}">
				<li class="nav-item"><a class="nav-link" href="<util:applicationRoot/>/profile.jsp">Profile</a></li>			
				<li class="nav-item" style="text-align: right;"><a class="nav-link" href="<util:applicationRoot/>/logout.jsp">Logout</a></li>
			</c:if>
			</ul>
		</div>
	</nav>
