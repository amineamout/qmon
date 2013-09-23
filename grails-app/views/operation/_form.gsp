<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Operation" %>

<g:javascript src="jtree/jquery.jstree.js" />
<g:javascript src="tinymce/tinymce.min.js" />

<script type="text/javascript" language="javascript">
$(document).ready(function(){
	$("#nomClass").change(function(){
		var nomClass = $('#nomClass').val();
		$.get("${request.contextPath}/operation/ajaxMethodsByClass",
			{nomClass:nomClass, ajax: 'true'}, 
			function(rList) {
				var options = ' ';
				for (var i = 0; i < rList.methods.length; i++) {
					options += '<option value="' + rList.methods[i] + '">' + rList.methods[i] + '</option>';
				}                    
				$('#nomMethod').html(options);})
	});
});
</script>

<script type="text/javascript">
tinymce.init({
	selector:'textarea',
	width: 500
});
</script>

<div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'nomOperation', 'error')} control-group">
	<label for="nomOperation" class="control-label">
		<g:message code="operation.nomOperation.label" default="Nom Operation" />
	</label>

	<div class="controls">
		<g:textField name="nomOperation" value="${operationInstance?.nomOperation}" class="input-xlarge"/>
		<p class="help-block">your action's description, shown to the final user.</p>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'descriptionOperation', 'error')} control-group">
	<label for="descriptionOperation" class="control-label">
		<g:message code="operation.descriptionOperation.label" default="Description" />
	</label>
	<div class="controls">
		<g:textArea rows="5" name="descriptionOperation" value="${operationInstance?.descriptionOperation}" class="input-xlarge"/>
	</div>
</div>


<div class="control-group">

	<label class="control-label">Package</label>
	<g:hiddenField id="nomPackage" name="nomPackage" value="" />
	<div class="controls">
		<div id="packages">
		</div>
	</div>

</div>

<div class="control-group">
	<label for="nomClass" class="control-label">Nom classe</label>
	<div class="controls">
		<g:select class="input-xlarge" id = "nomClass" noSelection="['':'-Choose class name-']" name="nomClass" optionKey="value" optionValue="value" from=""/>
	</div>
</div>

<script type="text/javascript">

$(function () {
	var tree = $("#packages").jstree({ 
		"xml_data" : {
			"ajax" : {
				"url" : '${request.contextPath}/operation/ajaxPackageByPackage',
			},
		},
		"plugins" : [ "themes", "ui", "xml_data" ]
	});
	tree.bind('select_node.jstree', function(event, data) {
		var nomPackage = data.rslt.obj.attr ("id")
		$.get("${request.contextPath}/operation/ajaxClassByPackage",
			{nomPackage:nomPackage, ajax: 'true'}, 
			function(rList) {
				$('input[name=nomPackage]').val(nomPackage);
				var options = ' ';
				for (var i = 0; i < rList.packages.length; i++) {

					options += '<option value="' + rList.packages[i] + '">' + rList.packages[i] + '</option>';
				}                    
				$('#nomClass').html(options);})
	});         
});

</script>

<div class="control-group">
	<label for="nomMethod" class="control-label">Nom Methode</label>
	<div class="controls">
		<g:select class="input-xlarge" id="nomMethod" name="nomMethod" from="" noSelection="['':'- Choose a method -']"/>
	</div>
</div>