angular.module('buildingInspections').controller('InspectionTemplatesShowCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
function($scope, $stateParams, inspection_templates) {
  
  $scope.getInspectionTemplate = function() {
    $scope.inspection_template = inspection_templates.show({id: $stateParams.id});
  };

  $scope.addItem = function() {
    if (!$scope.name || $scope.name === '') {
      return;
    }
    $scope.inspection_template.items.push({
      name: $scope.name,
      section: $scope.section
    });

    $scope.calcPositions();

    inspection_templates.update({id: $stateParams.id}, {inspection_template: $scope.inspection_template});

    $scope.name = '';
    $scope.section = '';
  };

  $scope.calcPositions = function() {
    for (var i = 0; i < $scope.inspection_template.items.length; i++) {
      $scope.inspection_template.items[i].position = i;
    }
  };

  $scope.getInspectionTemplate();
  
}]);