<!DOCTYPE html>
<html lang="en">
   <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    

      <title><g:layoutTitle default="Home"/></title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="${resource(dir: 'css', file: 'bstrap/css/bootstrap.css')}" type="text/css"/>
      <link rel="stylesheet" href="${resource(dir: 'css', file: 'bstrap/css/bootstrap-responsive.css')}" type="text/css"/>
      <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'jquery-ui/jquery-ui-1.10.3.custom.css')}">

      <link rel="stylesheet" href="${resource(dir: 'css', file: 'bstrap/css/fixedbar.css')}" type="text/css"/>

     <g:javascript src="jquery/jquery-1.9.1.js" />
     <g:javascript src="bstrap/bootstrap.js" />
     <g:javascript src="jquery-ui/jquery-ui-1.10.3.custom.js" />
      
    

   </head>
   <body>

        <div id="wrap">
          
        	<div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            %{-- <a class="brand" href="${createLink(uri:'/',absolute:true)}"> <img src="${resource(dir: 'images', file: '')}" width="111" height="30" alt="BP Monitor &middot; SSM" /></a> --}%
            <div class="nav-collapse collapse">
              <ul class="nav">
                <li>
                  %{-- <i class="icon-home"></i> --}%
                  <a href="${createLink(uri:'/',absolute:true)}"><i class="icon-home"></i> Accueil</a>
                </li>
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tâches<b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li><a href="#">Gestion des fichiers CSV</a></li>
                    <li><a href="${createLink(uri:'/operation',absolute:true)}">Operations</a></li>
                    <li><a href="${createLink(uri:'/traitement',absolute:true)}">Traitements</a></li>
                    <li class="divider"></li>
                    <li class="nav-header">Nav header</li>
                    <li><a href="#">Separated link</a></li>
                    <li><a href="#">One more separated link</a></li>
                  </ul>
                </li>
                <li><a href="${createLink(uri:'/journal',absolute:true)}">Journal</a></li>
              </ul>
               <ul class="nav pull-right">
                    <li>
                        <a>
                          <i class="icon-eye-open"></i>
                          <span class="label label-important"> 5 Notifications</span>
                        </a>
                    </li>
                   <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Paramètres <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li><a href="#"><i class="icon-user"></i> Profile</a></li>
                    
                    <li class="divider"></li>
                    <li class="nav-header">Administration</li>
                    <li><a href="#"><i class="icon-cog"></i> Paramètres Généraux</a></li>
                    <li><a href="#"><i class="icon-trash"></i> Archived</a></li>
                    <li><a href="#"><i class="icon-hand-right"></i> Logout</a></li>
                  </ul>
                </li>
              </ul>
            </div><!--/.nav-collapse -->

          </div>
        </div>
      </div>


	       <div class="container">
	       		<g:layoutBody/>
			</div>
		<div id="push"></div>
		</div>

	    <div id="footer">
	      <div class="container">
	        <p class="muted credit">
	        	Sofrecom Services Morocco &middot; Batch processing plugin, CSV Parser This is an amazing plugin for batch processing using a lot frameworks more informations <a href="http://github.com/droidzi/qmon" rel="external">quzmon plugin</a>.
	        </p>
	      </div>
	    </div>

      <r:layoutResources/>

   </body>
</html>