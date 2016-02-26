angular.module('buildingInspections').controller('InspectionShowCtrl', [
  '$scope', 
  '$stateParams', 
  'inspections',
function($scope, $stateParams, inspections) {
  
  $scope.getInspection = function() {
    $scope.inspection = inspections.show({id: $stateParams.id});
  };

  $scope.getInspection();

}]);