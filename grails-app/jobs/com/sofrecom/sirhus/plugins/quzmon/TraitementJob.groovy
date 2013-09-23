package com.sofrecom.sirhus.plugins.quzmon

import org.quartz.Job
import org.quartz.JobExecutionContext
import org.quartz.JobExecutionException

//import com.sofrecom.sirhus.plugins.quzmon.TraitementService

import org.apache.commons.logging.LogFactory

class TraitementJob implements Job {
	boolean transactional = false
	def operationService
  private static final log = LogFactory.getLog(this)
    
    static triggers = {}
    

    def void execute(JobExecutionContext context) throws JobExecutionException {

       try {
         
       		operationService.scheduleMethod(context.mergedJobDataMap)

       }

       catch(Exception e) {
			log.error("Error while lunching scheduled task : " + e)
       }

    }
}