
<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Traitement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		<g:set var="entityName" value="${message(code: 'traitement.label', default: 'Traitement')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<ul class="nav nav-pills">
			<li><a href="#list-traitement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content"/></a></li>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			<li class="active"><g:link class="active" class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		</ul>
		
		<div id="list-traitement" class="content scaffold-list" role="main">
			<fieldset>
				<legend><g:message code="default.list.label" args="[entityName]" /></legend>
			</fieldset>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-striped">
				<thead>
					<tr>
						<th><g:message code="traitement.operation.label" default="Operation" /></th>
						<th>Date lancement</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${traitementInstanceList}" status="i" var="traitementInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${traitementInstance.id}">${fieldValue(bean: traitementInstance, field: "operation")}</g:link></td>
						<td>${fieldValue(bean: traitementInstance, field: "dateCreated")}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${traitementInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
