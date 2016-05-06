angular.module('buildingInspections').controller('BuildingShowCtrl', [
  '$scope', 
  '$stateParams', 
  'buildings',
  'NgMap',
function($scope, $stateParams, buildings, NgMap) {
  $scope.getBuilding = function() {
    $scope.building = buildings.show({id: $stateParams.id});
  };
  $scope.getBuilding();
}]);