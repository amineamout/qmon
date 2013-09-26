// configuration for plugin testing - will not be included in the plugin zip
import org.apache.log4j.*
import org.apache.log4j.RollingFileAppender

/*
grails.resources.modules = {

    jquery {

        resource url:'js/jquery/jquery-1.9.1.js', disposition: 'head'
    }
    bootstrap {
        defaultBundle 'jquery'
        resource url:'js/bstrap/bootstrap.js', disposition: 'head'
        resource url:'css/bstrap/css/bootstrap.css', disposition: 'head'
        dependsOn 'jquery'
    }
    
    jqueryui {
        defaultBundle 'jquery'
        resource url:'js/jquery-ui/jquery-ui-1.10.3.custom.js', disposition: 'head'
        resource url:'css/jquery-ui/jquery-ui-1.10.3.custom.css', disposition: 'head'
        dependsOn 'jquery'
    }
    
    fixed {
        resource url:'css/bstrap/css/fixedbar.css', disposition: 'head'
        dependsOn 'bootstrap'
    }

    reponsive {
        resource url:'css/bstrap/css/bootstrap-responsive.css', disposition: 'head'
        dependsOn 'bootstrap'
    }
    

}
*/

log4j = {

    appenders {
        //file name:'file', file:'/var/logs/mylog.log'
         appender new RollingFileAppender(
                name: "file",
                maxFileSize: 1024,
                file: "/tmp/logs/grails_qm.log",
                layout: pattern(conversionPattern: "%c{2} %m%n")
                )
                
    }

    root {
        info 'stdout', 'file'
        error 'stdout', 'file'
    }

    info additivity: false
         stdout: ["grails.app.services.com.sofrecom.sirhus.plugins.quzmon.OperationService","grails.app.services.com.sofrecom.sirhus.plugins.quzmon.NotificationService"]
    error additivity: false
         stdout: ["grails.app.services.com.sofrecom.sirhus.plugins.quzmon.OperationService","grails.app.services.com.sofrecom.sirhus.plugins.quzmon.NotificationService"]
}
