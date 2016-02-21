receta = angular.module("receta", [
	"templates",
	"ngRoute",
	"controllers", # the controllers module is defined in javascripts/controllers/
	"models", # the models module is defined in javascripts/models/
	"ngResource", # helps angular access the serverside RESTfully
	"services"
])

receta.config([ "$routeProvider", 
	($routeProvider) ->
		$routeProvider
			.when("/folders",
				controller: "FoldersIndexController"
				templateUrl: "folders/index.html"
			)
			# .when("/patients/new",
			# 	controller: "PatientsNewController"
			# 	templateUrl: "patients/new.html"
			# )
			.when("/folders/:id",
				controller: "FoldersShowController"
				templateUrl: "folders/show.html"
			)
			# .when("/patients/:id/edit",
			# 	controller: "PatientsEditController"
			# 	templateUrl: "patients/edit.html"
			# )
			.when("/docs/:id",
				controller: "DocsShowController"
				templateUrl: "docs/show.html"
			)
			.otherwise(
				redirectTo: "/folders"
			)

])

# initialize the controllers module
controllers = angular.module("controllers", [])
# in subsequent controller files, put at the top:
# controllers = angular.module("controllers")

models = angular.module("models", ["ngResource"])
# in subsequent model files, put at the top:
# models = angular.module("models")


# turns on token in API requests
receta.config ($httpProvider) ->
	authToken = $("meta[name=\"csrf-token\"]").attr("content")
	$httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

#
receta.directive("ngRender", () ->
	restrict: "A"
	templateUrl: "patients/_form.html"
)