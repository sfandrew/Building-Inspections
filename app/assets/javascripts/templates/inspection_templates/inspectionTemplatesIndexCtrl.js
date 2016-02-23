angular.module('buildingInspections').controller('InspectionTemplatesIndexCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
function($scope, $stateParams, inspection_templates) {
  
  $scope.getInspectionTemplates = function() {
    $scope.inspection_templates = inspection_templates.index();
  };

  $scope.addInspectionTemplate = function() {
    inspection_templates.create({
      name: $scope.name,
    });
    $scope.name = '';
    $scope.getInspectionTemplates()
  };

  $scope.getInspectionTemplates();
  
}]);