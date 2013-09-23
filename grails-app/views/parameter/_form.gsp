<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Parameter" %>



<div class="fieldcontain ${hasErrors(bean: parameterInstance, field: 'dateLancement', 'error')} required">
	<label for="dateLancement">
		<g:message code="parameter.dateLancement.label" default="Date Lancement" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateLancement" precision="day"  value="${parameterInstance?.dateLancement}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: parameterInstance, field: 'key', 'error')} ">
	<label for="key">
		<g:message code="parameter.key.label" default="Key" />
		
	</label>
	<g:textField name="key" value="${parameterInstance?.key}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: parameterInstance, field: 'objet', 'error')} ">
	<label for="objet">
		<g:message code="parameter.objet.label" default="Objet" />
		
	</label>
	<g:textField name="objet" value="${parameterInstance?.objet}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: parameterInstance, field: 'value', 'error')} ">
	<label for="value">
		<g:message code="parameter.value.label" default="Value" />
		
	</label>
	<g:textField name="value" value="${parameterInstance?.value}"/>
</div>

