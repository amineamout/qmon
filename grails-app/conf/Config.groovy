// configuration for plugin testing - will not be included in the plugin zip
import org.apache.log4j.*
import org.apache.log4j.RollingFileAppender

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