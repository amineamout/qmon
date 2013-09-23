package quzmon

import com.sofrecom.sirhus.plugins.quzmon.TraitementService

class LogFilesJob {
	def fileManagementService

    static triggers = {

      cron name:'cronTrigger', cronExpression: '0 30 17 * * ?'

    }

    def execute() {
    	try {

	        if (fileManagementService.uploadLog("/tmp/logs/grails_qm.log") != true)
	        	fileManagementService.uploadLog("/tmp/logs/grails_qm.log.1")

    	}
    	catch(Exception e) {
    		//log.error("Error while trying to transfer log file")
    	}

    }
}
