package com.sofrecom.sirhus.plugins.quzmon



import org.junit.*
import grails.test.mixin.*

@TestFor(TraitementController)
@Mock(Traitement)
class TraitementControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/traitement/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.traitementInstanceList.size() == 0
        assert model.traitementInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.traitementInstance != null
    }

    void testSave() {
        controller.save()

        assert model.traitementInstance != null
        assert view == '/traitement/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/traitement/show/1'
        assert controller.flash.message != null
        assert Traitement.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/traitement/list'

        populateValidParams(params)
        def traitement = new Traitement(params)

        assert traitement.save() != null

        params.id = traitement.id

        def model = controller.show()

        assert model.traitementInstance == traitement
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/traitement/list'

        populateValidParams(params)
        def traitement = new Traitement(params)

        assert traitement.save() != null

        params.id = traitement.id

        def model = controller.edit()

        assert model.traitementInstance == traitement
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/traitement/list'

        response.reset()

        populateValidParams(params)
        def traitement = new Traitement(params)

        assert traitement.save() != null

        // test invalid parameters in update
        params.id = traitement.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/traitement/edit"
        assert model.traitementInstance != null

        traitement.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/traitement/show/$traitement.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        traitement.clearErrors()

        populateValidParams(params)
        params.id = traitement.id
        params.version = -1
        controller.update()

        assert view == "/traitement/edit"
        assert model.traitementInstance != null
        assert model.traitementInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/traitement/list'

        response.reset()

        populateValidParams(params)
        def traitement = new Traitement(params)

        assert traitement.save() != null
        assert Traitement.count() == 1

        params.id = traitement.id

        controller.delete()

        assert Traitement.count() == 0
        assert Traitement.get(traitement.id) == null
        assert response.redirectedUrl == '/traitement/list'
    }
}
