# ============================  controllers module  ===========================
controllers = angular.module("controllers")

# controllers.controller("DocsIndexController", ["$scope", "Doc", "flash", ($scope, Doc, flash) -> 
# 	# in case there is a flash message, pull it into scope so the view has access to it
# 	$scope.flash = flash
# 
# 	# while this looks synchronous, what is returned is a "future", an object
# 	# that will be filled with data when the XHR response returns
# 	$scope.patients = Doc.query()
# ])
# 
# 
controllers.controller("DocsShowController", ["$scope", "$routeParams", "$location", "$sce", "Doc", "flash", ($scope, $routeParams, $location, $sce, Doc, flash) -> 
# in case there is a flash message, pull it into scope so the view has access to it
	$scope.flash = flash
	
	$scope.trustAsHtml = $sce.trustAsHtml
	
	$scope.doc = Doc.find( $routeParams.id )
	
	$scope.expanded_section = null
	
	$scope.toggle = ( section ) ->
		if $scope.expanded_section == section
			$scope.expanded_section = null
		else
			$scope.expanded_section = section
])

# 
# controllers.controller("DocsNewController", ["$scope", "$location", "Doc", "flash", ($scope, $location, Doc, flash) -> 
# 	# in case there is a flash message, pull it into scope so the view has access to it
# 	$scope.flash = flash
# 
# 	$scope.patient = new Doc
# 	
# 	$scope.submitForm = () ->
# 		$scope.patient.$save(null, () -> # parameters, success, error
# 			flash.setMessage "Successfully created"
# 			$location.path( "/patients/#{ $scope.patient._id }" )
# 		) 
# ])
# 

controllers.controller("DocsEditController", ["$scope", "$routeParams", "$location", "Doc", "flash", ($scope, $routeParams, $location, Doc, flash) -> 
	# in case there is a flash message, pull it into scope so the view has access to it
	$scope.flash = flash

	$scope.doc = Doc.find(  $routeParams.id )

	$scope.expanded_section = null
	
	$scope.expand = ( section ) ->
		$scope.expanded_section = section
	
	$scope.submitForm = () ->
		# important to set this before every update
		$scope.doc.sections_attributes = $scope.doc.sections
		$scope.doc.$update(null, () -> # parameters, success, error
			flash.setMessage "Successfully saved"
			$location.path( "/docs/#{ $scope.doc._id }" )
		)
	
	$scope.destroySection = (section) ->
		if confirm "Are you sure you want to delete this section?"
			section._destroy = true
			# important to set this before every update
			$scope.doc.sections_attributes = $scope.doc.sections
			$scope.doc.$update(null, () -> # parameters, success, error
				flash.setMessage "Successfully saved"
				$location.path( "/docs/#{ $scope.doc._id }/edit" )
			)
	
	$scope.addSection = () ->
		$scope.doc.sections.push( {})
		
	# $scope.destroy = () ->
	# 	if confirm("Are you sure you want to delete?")
	# 		$scope.patient.$delete({id: $scope.patient._id}, () ->
	# 			flash.setMessage "Deleted"
	# 			$location.path( "/patients/")
	# 		)
])

