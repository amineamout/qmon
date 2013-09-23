<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Traitement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		
		<g:set var="entityName" value="${message(code: 'traitement.label', default: 'Traitement')}" />

		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

		<ul class="nav nav-pills">
			<li><a href="#create-traitement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content"/></a></li>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li class="active"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
		</ul>

		<div id="create-traitement" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${traitementInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${traitementInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" class="form-horizontal">
			<fieldset>
				<legend><g:message code="default.create.label" args="[entityName]" /></legend>
				<g:render template="form"/>
				<div class="form-actions form">
					<g:submitButton name="create" class="btn btn-inverse btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					<input class="btn" type="reset" value="Clear"/>
				</div>
			</fieldset>
		</g:form>
		</div>
	</body>
</html>
