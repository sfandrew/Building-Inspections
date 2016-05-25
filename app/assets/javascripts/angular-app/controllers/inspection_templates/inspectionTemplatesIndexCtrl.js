angular.module('buildingInspections').controller('InspectionTemplatesIndexCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
function($scope, $stateParams, inspection_templates) {
  $scope.loading = true;
  $scope.pageClass = 'list-inspection-templates';
  $scope.newInspectionTemplate = {name: ''};

  $scope.getInspectionTemplates = function() {
    inspection_templates.index()
      .$promise.then(
        $scope.setInspectionTemplates, 
        function(error) {
          $scope.error = "Error: " + error.status + "!"; 
        }
      ).finally(function(data) {
          $scope.loading = false;
      });
  };

  $scope.setInspectionTemplates = function(new_inspection_templates) {
    $scope.inspection_templates = new_inspection_templates;
  };

  $scope.addInspectionTemplate = function() {
    inspection_templates.create({
      name: $scope.newInspectionTemplate.name,
    })
    .$promise.then($scope.getInspectionTemplates);
    $scope.newInspectionTemplate.name = '';
  };

  $scope.getInspectionTemplates();
  
}]);