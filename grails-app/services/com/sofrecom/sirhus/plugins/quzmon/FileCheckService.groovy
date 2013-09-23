package com.sofrecom.sirhus.plugins.quzmon

class FileCheckService {

	

/**
1 - CONVERT the date formatting stuffs to Constants

FOR NUMBER OF LINE TO CHECK YOU CAN SPECIFY BY PERCENTAGE % ACCORDING TO THE DOC NUMBER OF LINE

EXAMPLE : numberOfLineToCheck = FileManagementService.getNbOfLine() * 0.75

in the IHM

**/
    def checkType(dataInput) {

    	def checkInteger = /[-+]?[0-9]+/
    	def checkFloat = /[-+]?[0-9]*\.?[0-9]*/
    	///def checkDate = '([0-9]{2})/([0-9]{2})/([0-9]{4})'

    	//while checking replace / with
    	if(!dataInput) {
    		return "empty"
    	} else if (dataInput != null) {
	    	if (dataInput ==~ checkInteger) {
					if (dataInput.toInteger() instanceof Integer) {
						return "Integer"
					}
			} else if(dataInput ==~ checkFloat) {
				if (dataInput.toFloat() instanceof Float) {
					return "Float"
				}
			} else if (this.checkDateFormat(dataInput)) {
					return "Date"
				
			} else {
				return "String" 
			}
		}
	}

	def convertToType(var,type) {
		if(type == "Integer")
			return var.toInteger()
		else if(type == "Float")
			return var.toFloat()
		else if(type == "String")
			return var.toString()
		else if(type == "Date")
			return this.toDate(var)
	}

	def toDate(dateString) {
		def checkDateDMY = '(0?[1-9]|[12][0-9]|3[01])([/ -.])(0?[1-9]|1[012])([/ -.])((19|20)\\d\\d)'
	def checkDateMDY = '(0?[1-9]|1[012])([/ -.])(0?[1-9]|[12][0-9]|3[01])([/ -.])((19|20)\\d\\d)'
	def checkDateYMD = '((19|20)\\d\\d)([/ -.])(0?[1-9]|1[012])([/ -.])(0?[1-9]|[12][0-9]|3[01])'
	def formatDMY = "dd/MM/yyyy"
	def formatMDY = "MM/dd/yyyy"
	def formatYMD = "yyyy/MM/dd"
		dateString = dateString.replaceAll("[ -.]","/")

		if (dateString ==~ checkDateDMY) {
			return new Date().parse(formatDMY, dateString)
		} else if(dateString ==~ checkDateMDY) {
			return new Date().parse(formatMDY, dateString)
		} else if (dateString ==~ checkDateYMD) {
			return new Date().parse(formatYMD, dateString)
		}
	}
	//IHM : Please enter your date separator
	def checkDateFormat(dateString) {
		def checkDateDMY = '(0?[1-9]|[12][0-9]|3[01])([/ -.])(0?[1-9]|1[012])([/ -.])((19|20)\\d\\d)'
	def checkDateMDY = '(0?[1-9]|1[012])([/ -.])(0?[1-9]|[12][0-9]|3[01])([/ -.])((19|20)\\d\\d)'
	def checkDateYMD = '((19|20)\\d\\d)([/ -.])(0?[1-9]|1[012])([/ -.])(0?[1-9]|[12][0-9]|3[01])'
	def formatDMY = "dd/MM/yyyy"
	def formatMDY = "MM/dd/yyyy"
	def formatYMD = "yyyy/MM/dd"
		/**
		//Not needed anymore :
		dateString.replaceAll("[.- ]","/")
		//before converting to date
		//beside in date you should do something to handle dates like "1/1/2013" and their conversion
		**/

		if (dateString ==~ checkDateDMY) {
			return true
			//return "Date"
			//return new Date().parse(formatDMY, dateString)
		} else if(dateString ==~ checkDateMDY) {
			return true
			//return "Date"
			//return new Date().parse(formatMDY, dateString)
		} else if (dateString ==~ checkDateYMD) {
			return true
			//return "Date"
			//return new Date().parse(formatYMD, dateString)
		} else { return false}
	}

	/**
		i * (i%rowSize)
	**/

	def checkTypeByLines(numberOfLineToCheck,fileName,rowSize,separator =',(?=([^\"]*\"[^\"]*\")*[^\"]*$)') {
		def typeList = []
		//Map sum = [:]
		def csv = new java.io.File(fileName)
		def currentLine = 0
		csv.splitEachLine(separator) { row ->
			if(currentLine != 0 && currentLine <= numberOfLineToCheck) {
				for(int index = 0; index < rowSize; index++) {
				//println " Line " +currentLine +" Type " + this.checkType(row[index])
				typeList += this.checkType(row[index])
				//if (index == rowSize - 1)
					//println ""
				//Map[currentLine] << this.checkType(row[0])
				//checkTypes
				//do magic here
				//println typeOf(row[0])
				}

			}
			currentLine++
		}
		return typeList
	}

	def getPropertiesName(fileName,separator =',(?=([^\"]*\"[^\"]*\")*[^\"]*$)') {
		def propList = []
		def csv = new java.io.File(fileName)
		def line
		csv.withReader { row ->
			line = row.readLine()
		}
		propList = line.split(separator)
		/**
		line.replaceAll("'","")
		println line
		**/
		return propList
	}

	def checkEmptyRows(fileName,rowIndex,numberOfLineToCheck=3,separator =',(?=([^\"]*\"[^\"]*\")*[^\"]*$)') {
		def csv = new java.io.File(fileName)
		def currentLine = 0
		csv.splitEachLine(separator) { row ->
			if(currentLine != 0 && currentLine <= numberOfLineToCheck) {
				println row[rowIndex] + " " + currentLine + " " + numberOfLineToCheck
				if(row[rowIndex] != null)
					return true
				else
					return false
			}
			currentLine++
		}
	}

	def typesConsistency(typesList, rowSize) {
		def countConsistency = 0
		def rTypeList = []
		def index = 0
		def indexSec = 0
		for(index = 0; index < typesList?.size() / rowSize; index++) {
			indexSec = index
			countConsistency = 0
			for(indexSec; indexSec < typesList?.size(); indexSec = indexSec + rowSize)
				if(typesList[index] == typesList[indexSec])
					countConsistency++

			if(countConsistency >= rowSize * 0.95)
				rTypeList += typesList[index]
			else
				rTypeList += "d_"+typesList[index]
		}
		return rTypeList
	}

	/**
		if(typesConsistency(list,rowSize).size() == getPropertiesName().size())
			//PROCEED
		else
			//SOMETHING IS WRONG
	**/

}