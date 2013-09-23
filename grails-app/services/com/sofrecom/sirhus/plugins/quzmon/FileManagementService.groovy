package com.sofrecom.sirhus.plugins.quzmon

import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.springframework.web.multipart.MultipartFile
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.apache.commons.logging.LogFactory
//import grails.events.*

class FileManagementService {

	boolean transactional = true
	private static final log = LogFactory.getLog(this)

	def boolean uploadLog(fileName, destinationDirectory="uploads/logs") {

		def servletContext = ServletContextHolder.servletContext
		def storagePath = servletContext.getRealPath(destinationDirectory)

		def storagePathDirectory = new java.io.File(storagePath)
		if(!storagePathDirectory.exists()) {
			println "Creating ${storagePath}"
			if(storagePathDirectory.mkdirs()) {
				log.info("Successfully created")
			}
			else
			{
				log.info("Can not create directory")
			}
		}

		File logSource = new java.io.File(fileName)
		if(logSource != null) {
			//logSource.transferTo(new java.io.File("${storagePath}/"+ new Date().format('MM_dd_yy')+"_log"))
			return logSource.renameTo(new java.io.File(storagePathDirectory, new Date().format('MM_dd_yy')+"_log.log"))

			}



	}

	def String uploadFile(MultipartFile file,name,destinationDirectory="uploads") {
		
		/*if (GrailsUtil.environment == "production") {
			storagePath = "/opt/assets"
			*/

		//Call should be like : <img src="${resource(dir:'assets', file: 'myfile.ext')}" />
		try {
			


			def servletContext = ServletContextHolder.servletContext
			def storagePath = servletContext.getRealPath(destinationDirectory)

			def storagePathDirectory = new java.io.File(storagePath)
			if(!storagePathDirectory.exists()) {
				println "Creating ${storagePath}"
				if(storagePathDirectory.mkdirs()) {
					log.info("Successfully created")
				}
				else
				{
					log.info("Can not create directory")
				}
			}
		//file.getContentType() == 'text/plain'
		//file.size()
		//progressUplaod = (100 * bytes processed) / file.size()
		if(!file.isEmpty()) {
			file.transferTo(new java.io.File("${storagePath}/"+new Date().getTime()+"${name}"))
			return "${storagePath}/${name}"
			} else {
				return null
			}
		}
		catch(Exception e) {
			log.error("File couldn't be uploaded\nDetails : "+e)
		}
	}
	
	def parseCSVFile(fileName) {

		//Closure.call()
		long startTime = System.nanoTime();
		def csv = new java.io.File(fileName)
		def currentLine = 0
		def progress = 0
		def numberOfLines = 0
		try {

		if (!System.properties['os.name'].toLowerCase().contains('windows'))
		{
			//try aaand catch with csv.eachLine{...} // make it a function to implement it everywhere
			//error occured at this line when something happens but not here at each function

			try {
				//numberOfLines = this.numOfLines(csv)
				numberOfLines = "wc -l ${fileName}".execute().text.replaceAll(" ${fileName}","").toInteger()
			}
			catch(Exception e) {
				numberOfLines = this.numOfLines(csv)
			}
			
			
		}
		else
		{
			numberOfLines = this.numOfLines(csv)
		}
				}
		catch(Exception e) {
			log.error("Error while trying to get number of lines")
		}
		
		println numberOfLines
		//def numOfLines = 50000
		//token = ',(?=([^\"]*\"[^\"]*\")*[^\"]*$)'
		//csv.splitEachLine(token) { ... }
		try {
		
		csv.splitEachLine(',') { row ->
			if(currentLine != 0) {
				//progress = (((double)currentLine/ numberOfLines+1)*100.0)
				progress = (100 * currentLine) / numberOfLines
				//println progress
				//println row.size()
				//println row.lenght
				//event(topic:'getIncrement',data:[row:progress])
				//println row[0].class.name +" "+ row[1].class.name +" "+ row[2] +" "+ row[3]
				//do something to get the row data into a map and then Trainee(map).save(flush:true)
				//http://work.msanjay.in/2010/03/11/csv-file-reader-groovy/
				//http://www.ibm.com/developerworks/java/library/j-grails09159/index.html
				//
				//new Trainee(studentUsername: row[0], mathsMark: row[1].toInteger(), javaMark : row[2].toInteger(), managementMark: row[3].toInteger()).save(failOnError:true)

				//delete new Trainee(..)
				//add closure to function argument
				//let user do what he wants
				//call closure
				//test if passed OK else return line where error occured in specific line TRY CATCH
				//ask user to add business logic in closure
				//see how to check for empty lines
				//
			}
			currentLine++
		}

		}
		catch(Exception e) {
			log.error("Error while parsing file "+e)
		}

		//ADD TRY CATCH() EXPLOITIN currentLine, to know where the error occured while parsing
		
		long endTime = System.nanoTime();
		long difference = endTime - startTime;
		
		println "Elapsed millisec: " + (difference/1000000)
		println "Elapsed sec: " + (difference/1000000000)
		println "Elapsed min: " + (difference/60000000000)
		//new Student(username:"Daniel",birthdate: new Date(),email: "dut@gmail.com",firstName: "amine",lastName: "mohammed").save(failOnError:true)
		
//		def csv = new File("grails-app/conf/code.list.csv")
//		def code
//		csv.splitEachLine(',') { row ->
//		   traineeInstance = Student.findByUsername(row[1]) ?: new Trainee(
//			  username: row[0],mathsMark: row[1],Java: row[2],Ma,agement: row[3]
//		   ).save(failOnError: true, flush: true)
//		}
}

def numOfLines(java.io.File csv) {

	def numberOfLines = 0
	csv.eachLine{ numberOfLines++ }
	return numberOfLines
}

}
