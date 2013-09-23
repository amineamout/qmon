package com.sofrecom.sirhus.plugins.quzmon

class Traitement {

	Date dateCreated
	static belongsTo = [operation: Operation]
	//static hasMany = [parameter: Parameter]

    static constraints = {
    }
}
