
<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Traitement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		<g:set var="entityName" value="${message(code: 'traitement.label', default: 'Traitement')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<ul class="nav nav-pills">
			<li><a href="#show-traitement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content"/></a></li>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		</ul>

		<div id="show-traitement" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list traitement">
			
				<g:if test="${traitementInstance?.operation}">
				<li class="fieldcontain">
					<span id="operation-label" class="property-label"><g:message code="traitement.operation.label" default="Operation" /></span>
					
						<span class="property-value" aria-labelledby="operation-label"><g:link controller="operation" action="show" id="${traitementInstance?.operation?.id}">${traitementInstance?.operation?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${traitementInstance?.id}" />
					<g:link class="edit" action="edit" id="${traitementInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
