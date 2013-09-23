package com.sofrecom.sirhus.plugins.quzmon
import grails.converters.*;
import org.springframework.dao.DataIntegrityViolationException

class TraitementController {

    def operationService
    def traitementService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def ajaxGetOperation() {

        def operation = Operation.get(params.operationID)
        render operation as JSON
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [traitementInstanceList: Traitement.list(params), traitementInstanceTotal: Traitement.count()]
    }

    def create() {
        [traitementInstance: new Traitement(params)]
    }

    def save() {
        
        params.dateCreated = new Date()
        
        Map rParams = traitementService.filterParams(params)

        //if(rData.withParams == true)
        
                
        def operationByID = Operation.get(rParams.operation.id)
        def bean = operationService.getBean(operationByID.nomClass)

        Map rData = [objectService : bean, methodName : operationByID.nomMethod, args:rParams]
        
        if(!params.withParams) {
            event for:'com.sofrecom.sirhus.plugins.quzmon', topic:'methodInvoke', data : rData
        } else {
            traitementService.invokeSchedule(params.dateLancement,rData)
        }

        def traitementInstance = new Traitement(params)
        if (!traitementInstance.save(flush: true)) {
            render(view: "create", model: [traitementInstance: traitementInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'traitement.label', default: 'Traitement'), traitementInstance.id])
        redirect(action: "show", id: traitementInstance.id)        
    }

    def show(Long id) {
        def traitementInstance = Traitement.get(id)
        if (!traitementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'traitement.label', default: 'Traitement'), id])
            redirect(action: "list")
            return
        }

        [traitementInstance: traitementInstance]
    }

    def edit(Long id) {
        def traitementInstance = Traitement.get(id)
        if (!traitementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'traitement.label', default: 'Traitement'), id])
            redirect(action: "list")
            return
        }

        [traitementInstance: traitementInstance]
    }

    def update(Long id, Long version) {
        def traitementInstance = Traitement.get(id)
        if (!traitementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'traitement.label', default: 'Traitement'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (traitementInstance.version > version) {
                traitementInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'traitement.label', default: 'Traitement')] as Object[],
                          "Another user has updated this Traitement while you were editing")
                render(view: "edit", model: [traitementInstance: traitementInstance])
                return
            }
        }

        traitementInstance.properties = params

        if (!traitementInstance.save(flush: true)) {
            render(view: "edit", model: [traitementInstance: traitementInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'traitement.label', default: 'Traitement'), traitementInstance.id])
        redirect(action: "show", id: traitementInstance.id)
    }

    def delete(Long id) {
        def traitementInstance = Traitement.get(id)
        if (!traitementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'traitement.label', default: 'Traitement'), id])
            redirect(action: "list")
            return
        }

        try {
            traitementInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'traitement.label', default: 'Traitement'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'traitement.label', default: 'Traitement'), id])
            redirect(action: "show", id: id)
        }
    }
}
