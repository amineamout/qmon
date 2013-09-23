<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Traitement" %>

%{-- <div class="fieldcontain ${hasErrors(bean: operationInstance, field: 'nomClass', 'error')} ">
	<label for="nomClass">
		<g:message code="operation.nomClass.label" default="Nom Class" />
		
	</label>
	<g:textField name="nomClass" value="${operationInstance?.nomClass}"/>
</div> --}%

<script type="text/javascript">
$(document).ready(function() {
    $("#add").click(function() {
        var intId = $("#buildyourform div").length + 1;
        var fieldWrapper = $("<div class=\"fieldwrapper\" id=\"field" + intId + "\"/>");
        var fName = $("<input type=\"text\" class=\"fieldname\" />");
        var fType = $("<select class=\"fieldtype\"><option selected>Type du champs ...</option><option value=\"checkbox\">Checked</option><option value=\"textbox\">Text</option><option value=\"file\">file</option><option value=\"textarea\">Paragraph</option></select>");
        var removeButton = $("<input type=\"button\" class=\"remove\" value=\"supprimer\" />");
        removeButton.click(function() {
            $(this).parent().remove();
        });
        fieldWrapper.append(fName);
        fieldWrapper.append(fType);
        fieldWrapper.append(removeButton);
        $("#buildyourform").append(fieldWrapper);
    });
    $("#preview").click(function() {
        $("#yourform").remove();
        var fieldSet = $("<fieldset id=\"yourform\"><legend>Paramètres</legend></fieldset>");
        $("#buildyourform div").each(function() {
            var id = "input" + $(this).attr("id").replace("field","");
            var label = $("<label for=\"" + $(this).find("input.fieldname").first().val() + "\">" + $(this).find("input.fieldname").first().val() + "</label>");
            var input;
            switch ($(this).find("select.fieldtype").first().val()) {
                
                case "checkbox":
                    input = $("<input type=\"checkbox\" id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                    break;
              
                case "textbox":
                    input = $("<input type=\"text\" id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                    break;

                case "file":
                    input = $("<input type=\"file\" id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                    break;
               
                case "textarea":
                    input = $("<textarea id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                    break;
                   
            }

            fieldSet.append(label);
            fieldSet.append(input);
            fieldSet.append('<div>');

        });
        $(".form").append(fieldSet);
    });
});

</script>


<fieldset id="buildyourform">
    <legend>Ajouter paramètres</legend>
</fieldset>
<input type="button" value="Générer formulaire" class="add" id="preview" />
<input type="button" value="Ajouter un champs" class="add" id="add" />