
<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Operation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		<g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<ul class="nav nav-pills">
		<li><a href="#list-operation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content"/></a></li>
		<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
		<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		<li class="active"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		</ul>
		
		<div id="list-operation" class="content scaffold-list" role="main">
			<fieldset>
				<legend><g:message code="default.list.label" args="[entityName]" /></legend>
			</fieldset>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table class="table table-striped">
				<thead>
					<tr>
						<g:sortableColumn property="id" title="${message(code: 'operation.id.label', default: '#')}"/>
						<g:sortableColumn property="nomClass" title="${message(code: 'operation.nomClass.label', default: 'Nom classe')}" />

						<g:sortableColumn property="nomPackage" title="${message(code: 'operation.nomPackage.label', default: 'Nom package')}" />
					
						<g:sortableColumn property="nomMethod" title="${message(code: 'operation.nomMethod.label', default: 'Nom methode')}" />
					
						<g:sortableColumn property="nomOperation" title="${message(code: 'operation.nomOperation.label', default: 'Titre operation')}" />
					
						%{-- <g:sortableColumn property="nomPackage" title="${message(code: 'operation.nomPackage.label', default: 'Nom Package')}" /> --}%
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${operationInstanceList}" status="i" var="operationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: operationInstance, field: "id")}</td>

						<td><g:link action="show" id="${operationInstance.id}">${fieldValue(bean: operationInstance, field: "nomClass")}</g:link></td>

						<td>${fieldValue(bean: operationInstance, field: "nomPackage")}</td>

						<td>${fieldValue(bean: operationInstance, field: "nomMethod")}</td>
					
						<td>${fieldValue(bean: operationInstance, field: "nomOperation")}</td>
					
						%{-- <td>${fieldValue(bean: operationInstance, field: "nomPackage")}</td> --}%
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination pagination-sm">
				<ul>
				<li><g:paginate total="${operationInstanceTotal}" /></li>
				</ul>
			</div>
		</div>
	</body>
</html>
