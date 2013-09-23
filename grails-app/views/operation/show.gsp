
<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Operation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		<g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

		<ul class="nav nav-pills">
			<li><a href="#show-operation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content"/></a></li>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		</ul>

		<div id="show-operation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list operation">
			
				<g:if test="${operationInstance?.nomClass}">
				<li class="fieldcontain">
					<span id="nomClass-label" class="property-label"><g:message code="operation.nomClass.label" default="Nom Class" /></span>
					
						<span class="property-value" aria-labelledby="nomClass-label"><g:fieldValue bean="${operationInstance}" field="nomClass"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${operationInstance?.nomMethod}">
				<li class="fieldcontain">
					<span id="nomMethod-label" class="property-label"><g:message code="operation.nomMethod.label" default="Nom Method" /></span>
					
						<span class="property-value" aria-labelledby="nomMethod-label"><g:fieldValue bean="${operationInstance}" field="nomMethod"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${operationInstance?.nomOperation}">
				<li class="fieldcontain">
					<span id="nomOperation-label" class="property-label"><g:message code="operation.nomOperation.label" default="Nom Operation" /></span>
					
						<span class="property-value" aria-labelledby="nomOperation-label"><g:fieldValue bean="${operationInstance}" field="nomOperation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${operationInstance?.descriptionOperation}">
				<li class="fieldcontain">
					<span id="descriptionOperation-label" class="property-label"><g:message code="operation.descriptionOperation.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="descriptionOperation-label"><g:fieldValue bean="${operationInstance}" field="descriptionOperation"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${operationInstance?.id}" />
					<g:link class="edit" action="edit" id="${operationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
