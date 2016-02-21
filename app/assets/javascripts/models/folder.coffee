# =============================  models module  ===============================
models = angular.module("models", ["ngResource"])

# defaults methods are get({id: 1}), save, query, remove, delete
models.factory('Folder', ["$resource", "Model", ($resource, Model) ->
	$.extend($resource('/folders/:id', # url
		{format: "json"}, # param defaults
		{ # custom actions here 
			query: {method: "GET", url: "/folders/", isArray: true}, 
			update: {method: "PATCH", params: {id: '@_id'}}
		}
	), Model)
])