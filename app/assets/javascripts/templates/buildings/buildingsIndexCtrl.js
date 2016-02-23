angular.module('buildingInspections').controller('BuildingsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'buildings',
function($scope, $stateParams, buildings) {
  
  $scope.getBuildings = function() {
    $scope.buildings = buildings.index();
  };

  $scope.addBuilding = function() {
    buildings.create({
      name: $scope.name,
    });
    $scope.name = '';
    $scope.getBuildings();
  };

  $scope.getBuildings();
  
}]);