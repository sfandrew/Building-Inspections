angular.module('buildingInspections').controller('BuildingShowCtrl', [
  '$scope', 
  '$stateParams', 
  'buildings',
  'units',
  '$state',
  'NgMap',
function($scope, $stateParams, buildings, units, $state, NgMap) {
  NgMap.getMap().then(function(map) {
    $scope.map = map;
  });

  $scope.currentPage = 1;
  $scope.itemsPerPage = 10;
  $scope.unit = "";
  $scope.isCollapsed = true;
  
  $scope.getBuilding = function() {
    $scope.building = buildings.show({id: $stateParams.id});
  };

$scope.addUnit = function(){
  units.create({building_id: $scope.building.id, unit: $scope.unit}).$promise.then(function(data){
  	$scope.building.units.push(data);
  });
	$scope.unit = "";
};
  $scope.getBuilding();
}]);
