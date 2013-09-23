package com.sofrecom.sirhus.plugins.quzmon

class Operation {
	/**
	Operation : are going to be created by only the Admin
	Traitement : Only allowed operations can be invoked from 'Traitement' can be executed by any user having a login and a password
	
	**/
	String descriptionOperation
	String nomOperation
	String nomPackage
	String nomClass
	String nomMethod

	static hasMany = [traitement: Traitement]
    static constraints = {
    	
    }

    @Override
    String toString() {
    	return "${this.nomOperation}"
    }
}
