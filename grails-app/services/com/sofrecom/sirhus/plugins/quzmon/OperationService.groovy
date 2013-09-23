package com.sofrecom.sirhus.plugins.quzmon

import groovy.xml.MarkupBuilder
import grails.converters.*;
import org.codehaus.groovy.grails.web.context.ServletContextHolder as SCH
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes as GA
import grails.util.GrailsNameUtils as GNU
import org.apache.commons.logging.LogFactory

class OperationService {
	def grailsApplication
	def ctx
	def Map mResult
	def traitementService
	private static final logging = LogFactory.getLog(this)

    //def defList = ["allMethods", "getGrailsApplication","setGrailsApplication", "getmResult","setmResult"]

    def allMethods() {

    	def returnList = []
    	//if(traitementService != null) {
    		def listOriginalServiceMethods = this?.metaClass.methods*.name.sort().unique()
    		if(grailsApplication != null)
    		grailsApplication?.serviceClasses.each { serviceArtefact ->
    			def serviceClass = serviceArtefact.getClazz()

    			def domain = serviceArtefact.getFullName()

    			def domainClass = this.class.classLoader.loadClass(domain)
				//newInstance(fields) : fields are parameters in a map
				def getInstance = domainClass.newInstance()
				
				def otherMethods = getInstance.metaClass.methods*.name.sort().unique()

				listOriginalServiceMethods.each {
					otherMethods.remove(it)
				}

				if(!returnList)
				returnList = otherMethods
					else
					returnList += otherMethods


	        }
	        
		mResult = [:]
		int i = 0
		returnList.each {
			if(it) {
				mResult[i]= it
				i++
			}
		}

		return mResult
	}

    /**
    CHECK IF CLASS (FILE) EXISTS !!
    AND THEN DO ACTION
    **/
    def methodsByClass(String className) {
    	def returnList
    	def listOriginalServiceMethods = this?.metaClass.methods*.name.sort().unique()

    	def domainClass = this.class.classLoader.loadClass(className)
			//newInstance(fields) : fields are parameters in a map
			def getInstance = domainClass.newInstance()
			def otherMethods = getInstance.metaClass.methods*.name.sort().unique()
			listOriginalServiceMethods.each {
				otherMethods.remove(it)
			}
				//get package name
				if(!returnList)
				returnList = otherMethods
				else
				returnList += otherMethods

				mResult = [:]
				int i = 0
				returnList.each {
					if(it) {
						mResult[i]= it
						i++
					}
				}

				return mResult

			}

	def getPackagesToXML() {

		def writer = new StringWriter()
		def builder = new MarkupBuilder(writer)
		def packageName = new java.io.File("grails-app/services")
		def parent = "0"
		//def packagesList = []

		try {
			if(packageName.exists() && packageName.canRead() && packageName.isDirectory()) {
				builder.root {
					packageName.eachFileRecurse() { file->
						if(file.isDirectory()) {
							def packagePath = file.path.minus("grails-app/services/").replace("/",".")
							if (packagePath.contains(parent))
								parent = parent
							else
								parent = "0"
								/**
								if elseif else
								Fix this by using list.explode(".") and then list(1) ..
								**/
							builder.item(id: packagePath, parent_id: parent) {
								builder.content {
									name(href:'#',packagePath)
								}
							}
							parent = packagePath
						}

					}
				}
			} else {
				return "<root><item><content><name>You have no packages in your service artefact</name></content></item></root>"
			}
		}
		catch(Exception e) {
			log.error("[getPackagesToXML()] Error while loading Packages in XML format\nDetails : "+ e)
		}

		return writer.toString()
	}

			def packageByPackage(String artefactName) {
				def index = 0
				mResult = [:]
				artefactName = artefactName?.replace(".","/")
				def packageName = new File("grails-app/${artefactName}")
				if(packageName.exists() && packageName.canRead() && packageName.isDirectory()) {
					packageName.eachFile() { file->
						if(file.isDirectory()) {
							index++
							mResult[index] = file.getName()
						}
		}
	}
	return mResult
}

def classByPackage(String packageName) {
	def index = 0
	mResult = [:]
	packageName = packageName?.replace(".","/")
	def className = new File("grails-app/${packageName}")
	try {

	if(className.exists() && className.canRead() && className.isDirectory()) {
		className.eachFile() { file->
			if (file.isFile()) {
				index++
				mResult[index] = packageName.minus("services/").replace("/",".")+"."+file.name.lastIndexOf('.').with {it != -1 ? file.name[0..<it] : file.name }
			}
		}
	}
	}
	catch(Exception e) {
		
	}
	
	return mResult
}

def getServiceClasses() {

	mResult = [:]
	int i = 0

	grailsApplication.serviceClasses.each { serviceArtefact ->
		def serviceClass = serviceArtefact.getClazz()
		def services = serviceArtefact.getFullName()
		mResult[i]= services
		i++
	}

	return mResult
}

def getDomainClasses() {

	mResult = [:]
	int i = 0

	grailsApplication.domainClasses.each { domainArtefact ->
		def domainClass = domainArtefact.getClazz()
		def domains = domainArtefact.getFullName()
		mResult[i]= domains
		i++
	}

	return mResult
}

def getControllerClasses() {

	mResult = [:]
	int i = 0

	grailsApplication.controllerClasses.each { controllerArtefact ->
		def controllerClass = controllerArtefact.getClazz()
		def controllers = controllerArtefact.getFullName()
		mResult[i]= controllers
		i++
	}

	return mResult
}

def getBean(String beanName) {

	try {
		if(!ctx)
		ctx = SCH.servletContext.getAttribute(GA.APPLICATION_CONTEXT)

		beanName = GNU.getPropertyNameRepresentation("${beanName}")
	}

	catch(Exception e) {
		log.error("Error while trying to get bean (Object)\nDetails : "+ e)
	}
		
        return ctx?."${beanName}"
    }

    @grails.events.Listener(namespace = 'com.sofrecom.sirhus.plugins.quzmon')
    def methodInvoke(params) {

    	def methodExec = params.methodName
    	try {
    	
	    	if(params.args) {
	    		params.objectService?."${methodExec}"(params.args)
	    		traitementService.saveParameters(params.objectService,params.args)
	    	}

	    	else {
	    		params.objectService?."${methodExec}"()
	    	}
    	}
    	catch(Exception e) {
    		log.error("Error while trying to invoke method ${methodExec}\nDetails : "+ e)
    	}
    }


    def scheduleMethod(params) {
    	def methodExec = params.methodName
    	try {
    	
	    	if(params.args) {
	    		params.objectService?."${methodExec}"(params.args)
	    		traitementService?.saveParameters(params.objectService,params.args)
	    	}

	    	else {
	    		params.objectService?."${methodExec}"()
	    	}
    	}
    	catch(Exception e) {
    		log.error("Error while trying to invoke method ${methodExec}\nDetails : "+ e)
    	}
    }

}
