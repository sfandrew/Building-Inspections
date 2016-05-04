angular.module('buildingInspections').controller('BuildingShowCtrl', [
  '$scope', 
  '$stateParams', 
  'buildings',
function($scope, $stateParams, buildings) {
  $scope.getBuilding = function() {
    $scope.building = buildings.show({id: $stateParams.id});

  };

  $scope.getBuilding();

  
}]);