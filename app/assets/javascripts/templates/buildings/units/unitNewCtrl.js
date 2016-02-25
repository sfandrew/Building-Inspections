angular.module('buildingInspections').controller('UnitNewCtrl', [
  '$scope', 
  '$stateParams',
  '$state',
  'buildings',
  'units',
function($scope, $stateParams, $state, buildings, units) {
  $scope.building = buildings.show({id: $stateParams.id});
  
  $scope.unit = {};

  $scope.addUnit = function(){
    units.create({building_id: $scope.building.id, unit: $scope.unit}, function(data) {
      $state.go('building', {id: $scope.building.id})      
    }, function(error){
      $scope.error = true;
    });
    $scope.loading = true;
  }
}]);