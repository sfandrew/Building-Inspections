angular.module('buildingInspections').controller('InspectionShowCtrl', [
  '$scope', 
  '$stateParams', 
  'inspections',
function($scope, $stateParams, inspections) {

  $scope.loading = true;
  
  $scope.getInspection = function() {
    inspections.show({id: $stateParams.id})
    .$promise.then($scope.setInspection)
    .finally(function() {
    	$scope.loading = false;
    });
  };

  $scope.saveInspection = function() {
  	$scope.loading = true;
  	inspections.update({id: $scope.inspection.id}, $scope.paramsForUpdate())
  	.$promise.then($scope.setInspection)
  	.finally(function() {
  		$scope.loading = false;
  	});
  };

  $scope.setInspection = function(new_inspection) {
  	$scope.inspection = new_inspection
  };

  $scope.paramsForUpdate = function() {
  	return {inspection:
  		{
  			items_attributes: $scope.inspection.items
  		}
  	};
  };

  $scope.getInspection();

}]);