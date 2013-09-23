package com.sofrecom.sirhus.plugins.quzmon



import org.junit.*
import grails.test.mixin.*

@TestFor(ParameterController)
@Mock(Parameter)
class ParameterControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/parameter/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.parameterInstanceList.size() == 0
        assert model.parameterInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.parameterInstance != null
    }

    void testSave() {
        controller.save()

        assert model.parameterInstance != null
        assert view == '/parameter/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/parameter/show/1'
        assert controller.flash.message != null
        assert Parameter.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/parameter/list'

        populateValidParams(params)
        def parameter = new Parameter(params)

        assert parameter.save() != null

        params.id = parameter.id

        def model = controller.show()

        assert model.parameterInstance == parameter
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/parameter/list'

        populateValidParams(params)
        def parameter = new Parameter(params)

        assert parameter.save() != null

        params.id = parameter.id

        def model = controller.edit()

        assert model.parameterInstance == parameter
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/parameter/list'

        response.reset()

        populateValidParams(params)
        def parameter = new Parameter(params)

        assert parameter.save() != null

        // test invalid parameters in update
        params.id = parameter.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/parameter/edit"
        assert model.parameterInstance != null

        parameter.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/parameter/show/$parameter.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        parameter.clearErrors()

        populateValidParams(params)
        params.id = parameter.id
        params.version = -1
        controller.update()

        assert view == "/parameter/edit"
        assert model.parameterInstance != null
        assert model.parameterInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/parameter/list'

        response.reset()

        populateValidParams(params)
        def parameter = new Parameter(params)

        assert parameter.save() != null
        assert Parameter.count() == 1

        params.id = parameter.id

        controller.delete()

        assert Parameter.count() == 0
        assert Parameter.get(parameter.id) == null
        assert response.redirectedUrl == '/parameter/list'
    }
}
