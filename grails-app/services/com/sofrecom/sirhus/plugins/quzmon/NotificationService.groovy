package com.sofrecom.sirhus.plugins.quzmon

import org.apache.commons.logging.LogFactory

class NotificationService {
	def mailService
    def message
    def date
    private static final log = LogFactory.getLog(this)

    def sendSuccess(Map params) {
        try {
        
        	mailService.sendMail {

    			to "${params.userAddress}"
    			subject "[SUCCESS] Terminaison du job #${params.jobId} concernant la tâche ${params.jobName}"
    			body "<html>Bonjour,<br/>La tâche \"${params.jobName}\" que vous avez lancé le ${params.startDate} à ${params.startTime} a terminé avec succès !</html>"

    		}
        }
        catch(Exception e) {
            log.error("Couldn't send email\nDetails : " +e)
        }
    }

    def sendFailure(Map params) {
        try {
    	mailService.sendMail {

			to "${params.userAddress}"
			subject "[FAILURE] Rupture du job #${params.jobId} conernant la tâche ${params.jobName}"
			body "<html>Bonjour,<br/>La tâche \"${params.jobName}\" que vous avez lancé le ${params.startDate} à ${params.startTime} a terminé avec succès !</html>"

		}
        }
        catch(Exception e) {
            log.error("Couldn't send email\nDetails : " +e)
        }

    }

    def sendFiredJob(Map params) {
        try {
    	mailService.sendMail {
    		to "${params.userAddress}"
    		subject "[JOB FIRED] Votre tâche \" ${params.jobName} \" a été lancé à ${params.startDate}"
    		body ""
    	}
        }
        catch(Exception e) {
            log.error("Couldn't send email\nDetails : " +e)
        }
    }
}
