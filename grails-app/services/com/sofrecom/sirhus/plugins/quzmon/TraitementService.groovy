package com.sofrecom.sirhus.plugins.quzmon

import java.text.SimpleDateFormat

class TraitementService {

	def fileCheckService

	def sayHelloToName(params) {
		println "Hello ${params.name} !"
	}

	def filterParams(params) {
		Map rData = new HashMap()
        try {
            
       
        
        params.each { k, v ->
           if((k != "create" || k != "edit") && (k != "action" && k != "controller") && v != null) {
                if(fileCheckService?.checkType(v) == "Integer") {
                    rData.put(k, v.toInteger())
                } else if(fileCheckService?.checkType(v) == "Date") {
                    rData.put(k,fileCheckService?.toDate(v))
                } else {
                    rData.put(k,v)
                }
            }
        }
         }
        catch(Exception e) {
            
        }
        
        return rData
	}
	
    def saveParameters(objectName,params) {

    	def newDate = new Date()
    	
    	params.each() { key, value ->
    		new Parameter(dateLancement : newDate, key : key, objet : "${objectName}", value : value).save()
    	}
    	
    }

    def invokeSchedule(date,params) {
        try {
        
            def df = new SimpleDateFormat( "d-M-yyyy H:m" )
            def planning = df.parse(date)
            TraitementJob.schedule(planning, params)

        }
        catch(Exception e) {
            //
        }
    }

}