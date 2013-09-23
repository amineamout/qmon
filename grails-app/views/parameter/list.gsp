
<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Parameter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		<g:set var="entityName" value="${message(code: 'parameter.label', default: 'Parameter')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-parameter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="list-parameter" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-striped">
				<thead>
					<tr>
					
						<g:sortableColumn property="dateLancement" title="${message(code: 'parameter.dateLancement.label', default: 'Date Lancement')}" />
					
						<g:sortableColumn property="key" title="${message(code: 'parameter.key.label', default: 'Key')}" />
					
						<g:sortableColumn property="objet" title="${message(code: 'parameter.objet.label', default: 'Objet')}" />
					
						<g:sortableColumn property="value" title="${message(code: 'parameter.value.label', default: 'Value')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${parameterInstanceList}" status="i" var="parameterInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${parameterInstance.id}">${fieldValue(bean: parameterInstance, field: "dateLancement")}</g:link></td>
					
						<td>${fieldValue(bean: parameterInstance, field: "key")}</td>
					
						<td>${fieldValue(bean: parameterInstance, field: "objet")}</td>
					
						<td>${fieldValue(bean: parameterInstance, field: "value")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${parameterInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
