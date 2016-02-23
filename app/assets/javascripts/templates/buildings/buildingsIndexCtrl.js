angular.module('buildingInspections').controller('BuildingsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'buildings',
function($scope, $stateParams, buildings) {

  $scope.building = {};
  
  $scope.getBuildings = function() {
    $scope.buildings = buildings.index();
  };

  $scope.addBuilding = function() {
    buildings.create(
      $scope.building
    );
    $scope.building = {};
    $scope.getBuildings();
  };

  $scope.getBuildings();
  
}]);