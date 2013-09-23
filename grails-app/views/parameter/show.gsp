
<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Parameter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="plugmain">
		<g:set var="entityName" value="${message(code: 'parameter.label', default: 'Parameter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-parameter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-parameter" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list parameter">
			
				<g:if test="${parameterInstance?.dateLancement}">
				<li class="fieldcontain">
					<span id="dateLancement-label" class="property-label"><g:message code="parameter.dateLancement.label" default="Date Lancement" /></span>
					
						<span class="property-value" aria-labelledby="dateLancement-label"><g:formatDate date="${parameterInstance?.dateLancement}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterInstance?.key}">
				<li class="fieldcontain">
					<span id="key-label" class="property-label"><g:message code="parameter.key.label" default="Key" /></span>
					
						<span class="property-value" aria-labelledby="key-label"><g:fieldValue bean="${parameterInstance}" field="key"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterInstance?.objet}">
				<li class="fieldcontain">
					<span id="objet-label" class="property-label"><g:message code="parameter.objet.label" default="Objet" /></span>
					
						<span class="property-value" aria-labelledby="objet-label"><g:fieldValue bean="${parameterInstance}" field="objet"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterInstance?.value}">
				<li class="fieldcontain">
					<span id="value-label" class="property-label"><g:message code="parameter.value.label" default="Value" /></span>
					
						<span class="property-value" aria-labelledby="value-label"><g:fieldValue bean="${parameterInstance}" field="value"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${parameterInstance?.id}" />
					<g:link class="edit" action="edit" id="${parameterInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
