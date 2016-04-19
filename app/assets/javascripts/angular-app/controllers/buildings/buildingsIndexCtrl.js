angular.module('buildingInspections').controller('BuildingsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'buildings',
function($scope, $stateParams, buildings) {

  $scope.loading = true;
  $scope.pageClass = 'listing-buildings';

  $scope.building = {};
  
  $scope.getBuildings = function() {
    buildings.index()
    .$promise.then(
      $scope.setBuildings
      ).finally(function() {
        $scope.loading = false;
      });
  };

  $scope.setBuildings = function(new_buildings) {
    $scope.buildings = new_buildings;
  };

  $scope.destroyBuilding = function(building) {
    buildings.destroy({id: building.id})
      .$promise.then(function(data) {
        $scope.buildings.splice($scope.buildings.indexOf(building), 1);
      });
  };

  $scope.addBuilding = function() {
    buildings.create(
      $scope.building
    ).$promise.then(function(data){ 
      $scope.buildings.push(data);
    });
    $scope.building = {};
    //$scope.getBuildings();
  };

  $scope.getBuildings();
  
}]);