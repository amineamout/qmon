class Resolver {

	/**
	*def grailsApplication
	*def ctx = grailsApplication.mainContext
	*getBean(ctx,"doThatService")
	**/
	def getBean(ctx,String beanName) {
		ctx.getBean(beanName)
	}
}