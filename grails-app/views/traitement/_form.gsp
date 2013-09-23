<%@ page import="com.sofrecom.sirhus.plugins.quzmon.Traitement" %>
<g:javascript src="jquery-ui-timepicker/jquery-ui-timepicker-addon.js" />


<div class="fieldcontain ${hasErrors(bean: traitementInstance, field: 'operation', 'error')} required control-group">
	<label for="operation" class="control-label">
		<g:message code="traitement.operation.label" default="Operation" />
		<span class="required-indicator">*</span>
	</label>
    <div class="controls">
     <g:select id="operation" name="operation.id" from="${com.sofrecom.sirhus.plugins.quzmon.Operation.list()}" optionKey="id" required="" value="${traitementInstance?.operation?.id}" class="many-to-one"/>

     <script type="text/javascript">
     $(document).ready(function() {
        $("#details").click(function(event){
            $(function() {
                var operationID = $('#operation').val();

                if(operationID != null)
                    $.get("${request.contextPath}/traitement/ajaxGetOperation",
                      {operationID : operationID, ajax: 'true'}, 
                      function(operation) {
                        console.log(operation)
                        $('#dialogContent').html("<strong>Nom opération</strong> : " + operation.nomOperation+"<br/><strong>Description</strong> : "+operation.descriptionOperation + "<br/><strong>Nom class</strong> : "+ operation.nomClass);
                        $( "#dialog" ).dialog({width : 600});
                    })
            });
        });
    });
     </script>
     <span><a href="#details" id="details">More details</a></span>
 </div>

 <div id="dialog" title="Operation details" style="display: none;">
    <p id="dialogContent">Empty</p>
</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $('#withParams').click(function(){
        if (this.checked) {
            $("#dateTime").show()
        } else {
            $("#dateTime").hide()
        }
    });

    $('#dateLancement').datetimepicker({
        controlType: 'select',
        dateFormat: 'dd-mm-yy',
        timeFormat: 'HH:mm',
        dayNamesMin: [ "Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa" ],
        //to display down
        beforeShow: function (input, inst) {
            var offset = $(input).offset();
            var height = $(input).height();
            window.setTimeout(function () {
                inst.dpDiv.css({ top: (offset.top + height + 4) + 'px', left: offset.left + 'px' })
            }, 1);
        }
    });

});
</script>
<div class="control-group">
    <label for="withParams" class="control-label">
        Lancer ultérieurement
    </label>
    <div class="controls">
        <g:checkBox id="withParams" name="withParams" value="${false}" />
    </div>
</div>

<div class="control-group" id="dateTime" style="display:none">
       <label for="dateLancement" class="control-label">
       Date lancement
        </label>
        <div class="controls">
            <input id="dateLancement" name="dateLancement" />
        </div>
</div>

<script type="text/javascript">

$(document).ready(function() {
     
            $("#add").click(function() {
                var intId = $("#buildyourform div").length + 1;
                var fieldWrapper = $("<div class=\"fieldwrapper control-group\" id=\"field" + intId + "\"/>");
                var fName = $("<input type=\"text\" class=\"fieldname\" />");
                var fType = $("<span class=\"add-on\"> <select class=\"fieldtype\"><option selected>Type du champs ...</option><option value=\"checkbox\">Checked</option><option value=\"textbox\">Text</option><option value=\"file\">file</option><option value=\"textarea\">Paragraph</option></select>");
                var removeButton = $("<span class=\"add-on\"> <input type=\"button\" class=\"remove\" value=\"supprimer\" />");
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
                    fieldSet.append('<div class="control-group">')
                    var id = "input" + $(this).attr("id").replace("field","");
                    var label = $("<label class=\"control-label\" for=\"" + $(this).find("input.fieldname").first().val() + "\">" + $(this).find("input.fieldname").first().val() + "</label>");
                    var input;
                    switch ($(this).find("select.fieldtype").first().val()) {

                        case "checkbox":
                        input = $("<div class=\"controls\"><input type=\"checkbox\" id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                        break;

                        case "textbox":
                        input = $("<div class=\"controls\"><input type=\"text\" id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                        break;

                        case "file":
                        input = $("<div class=\"controls\"><input type=\"file\" id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                        break;

                        case "textarea":
                        input = $("<div class=\"controls\"><textarea id=\"" + $(this).find("input.fieldname").first().val() + "\" name=\"" + $(this).find("input.fieldname").first().val() + "\" />");
                        break;

                    }

                    fieldSet.append(label);
                    fieldSet.append(input);
                    //fieldSet.append('<div>');

                });
        $("#form").append(fieldSet);
        });
});

</script>

<fieldset id="buildyourform">
    <legend>Ajouter paramètres</legend>
</fieldset>

<input type="button" value="Générer formulaire" class="add" id="preview" />
<input type="button" value="Ajouter un champs" class="add" id="add" />

<div id="form"></div>
