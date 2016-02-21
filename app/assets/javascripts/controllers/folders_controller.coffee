# ============================  controllers module  ===========================
controllers = angular.module("controllers", [])


controllers.controller("FoldersIndexController", ["$scope", "Folder", "flash", ($scope, Folder, flash) -> 
	# in case there is a flash message, pull it into scope so the view has access to it
	$scope.flash = flash

	# while this looks synchronous, what is returned is a "future", an object
	# that will be filled with data when the XHR response returns
	$scope.all_folders = Folder.all()
	
	# show the top-level folders
	$scope.folders = $scope.all_folders	
])


controllers.controller("FoldersShowController", ["$scope", "$routeParams", "$location", "Folder", "flash", ($scope, $routeParams, $location, Folder, flash) -> 
# in case there is a flash message, pull it into scope so the view has access to it
	$scope.flash = flash

	$scope.folder = Folder.find( $routeParams.id )
])


# controllers.controller("FoldersNewController", ["$scope", "$location", "Folder", "flash", ($scope, $location, Folder, flash) -> 
# 	# in case there is a flash message, pull it into scope so the view has access to it
# 	$scope.flash = flash
# 
# 	$scope.patient = new Folder
# 	
# 	$scope.submitForm = () ->
# 		$scope.patient.$save(null, () -> # parameters, success, error
# 			flash.setMessage "Successfully created"
# 			$location.path( "/patients/#{ $scope.patient._id }" )
# 		) 
# ])
# 
# 
# controllers.controller("FoldersEditController", ["$scope", "$routeParams", "$location", "Folder", "flash", ($scope, $routeParams, $location, Folder, flash) -> 
# 	# in case there is a flash message, pull it into scope so the view has access to it
# 	$scope.flash = flash
# 
# 	$scope.patient = Folder.get({ id: $routeParams.id})
# 		
# 	$scope.submitForm = () ->
# 		$scope.patient.$update(null, () -> # parameters, success, error
# 			flash.setMessage "Successfully saved"
# 			$location.path( "/patients/#{ $scope.patient._id }" )
# 		)
# 		
# 	$scope.destroy = () ->
# 		if confirm("Are you sure you want to delete?")
# 			$scope.patient.$delete({id: $scope.patient._id}, () ->
# 				flash.setMessage "Deleted"
# 				$location.path( "/patients/")
# 			)
# ])
