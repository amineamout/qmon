<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Operation" %>

<g:javascript src="jtree/jquery.jstree.js" />

<script type="text/javascript">
tinymce.init({
	selector:'textarea',
	width: 500
});
</script>

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

<div>

</div>

<div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'nomOperation', 'error')} ">
	<label for="nomOperation">
		<g:message code="operation.nomOperation.label" default="Nom Operation" />
		
	</label>
	<g:textField name="nomOperation" value="${operationInstance?.nomOperation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'descriptionOperation', 'error')} ">
	<label for="descriptionOperation">
		<g:message code="operation.descriptionOperation.label" default="Description" />
		
	</label>
	<g:textArea cols="20" rows="5" name="descriptionOperation" value="${operationInstance?.descriptionOperation}"/>
</div>

<label> Package </label>
<div id="packages">
	
</div>

<div>
	<label for="nomClass"> Nom classe : 
		%{-- we should use the service to get the operations names in here --}%

		<g:select id = "nomClass" noSelection="['':'-Choose class name-']" name="nomClass" optionKey="value" optionValue="value" from=""/>
		%{-- from="${serviceClasses}"/> --}%
		%{-- http://www.icodeya.com/2012/09/grails-different-ways-to-import.html --}%

	</label>
</div>

<script type="text/javascript">
/**
ATTENTION IL FAUT Séparer le package des classes afin de faciliter l'enregistrement et récuperation
**/
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
				var options = ' ';
				for (var i = 0; i < rList.packages.length; i++) {

					options += '<option value="' + rList.packages[i] + '">' + rList.packages[i] + '</option>';
				}                    
				$('#nomClass').html(options);})
	});

	$("#open").click(function(){
		var packageClass = "${operationInstance.nomClass}"

		console.log(packageClass.replace(/\./g,"\\\\."))

		var package = "#"+"com\\.sofrecom\\.sirhus\\.plugins\\.quzmon"
		var closedParents = $(package).parents("li.jstree-closed");
		
		for(var i=closedParents.length-1;i>=0;i--){
			openNode($(closedParents[i]));
		}

		$.jstree._reference(tree).select_node(package,function(){;},false);
	});

	function openNode(thisNode){
		if(typeof thisNode=="undefined") return;
		if(thisNode.hasClass("jstree-leaf") || thisNode.hasClass("jstree-open") ) return;
		$.jstree._reference(tree).open_node(thisNode,function(){;},true);
	}

	
});

</script>

<div>
	<input type="button" name="open" id="open" value="open up"/>
</div>

<div>
	<label for="nomMethod"> Nom Methode

		<g:select id="nomMethod" name="nomMethod" from="" noSelection="['':'- Choose a method -']"/>

		
	</label>
</div>
%{-- <div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'nomClass', 'error')} ">
	<label for="nomClass">
		<g:message code="operation.nomClass.label" default="Nom Class" />
		
	</label>
	<g:textField name="nomClass" value="${operationInstance?.nomClass}"/>
</div> --}%

%{-- <div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'nomMethod', 'error')} ">
	<label for="nomMethod">
		<g:message code="operation.nomMethod.label" default="Nom Method" />
		
	</label>
	<g:textField name="nomMethod" value="${operationInstance?.nomMethod}"/>
</div> --}%

%{-- <div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'nomPackage', 'error')} ">
	<label for="nomPackage">
		<g:message code="operation.nomPackage.label" default="Nom Package" />
		
	</label>
	<g:textField name="nomPackage" value="${operationInstance?.nomPackage}"/>
</div> --}%

%{-- <div>
	<label for="nomMethod">

 			<g:select name="nomMethod" optionKey="value" optionValue="value"
 			from="${allMethods}"/>

 			
	</label>
</div> --}%