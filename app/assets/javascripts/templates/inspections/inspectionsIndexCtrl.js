angular.module('buildingInspections').controller('InspectionsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'inspections',
  'inspection_templates',
function($scope, $stateParams, inspections, inspection_templates) {
  
  $scope.getInspectionTemplates = function() {
    $scope.inspection_templates = inspection_templates.index();
  };

  // $scope.addInspectionTemplate = function() {
  //   inspections.create({
  //     name: $scope.name,
  //   });
  //   $scope.name = '';
  //   $scope.getInspections()
  // };

  $scope.getInspectionTemplates();
  
}]);