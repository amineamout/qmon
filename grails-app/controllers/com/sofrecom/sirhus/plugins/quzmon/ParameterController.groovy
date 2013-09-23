package com.sofrecom.sirhus.plugins.quzmon

import org.springframework.dao.DataIntegrityViolationException

class ParameterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [parameterInstanceList: Parameter.list(params), parameterInstanceTotal: Parameter.count()]
    }

    def show(Long id) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list")
            return
        }

        [parameterInstance: parameterInstance]
    }

    def edit(Long id) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list")
            return
        }

        [parameterInstance: parameterInstance]
    }

    def update(Long id, Long version) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (parameterInstance.version > version) {
                parameterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'parameter.label', default: 'Parameter')] as Object[],
                          "Another user has updated this Parameter while you were editing")
                render(view: "edit", model: [parameterInstance: parameterInstance])
                return
            }
        }

        parameterInstance.properties = params

        if (!parameterInstance.save(flush: true)) {
            render(view: "edit", model: [parameterInstance: parameterInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'parameter.label', default: 'Parameter'), parameterInstance.id])
        redirect(action: "show", id: parameterInstance.id)
    }

    def delete(Long id) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list")
            return
        }

        try {
            parameterInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "show", id: id)
        }
    }
}
