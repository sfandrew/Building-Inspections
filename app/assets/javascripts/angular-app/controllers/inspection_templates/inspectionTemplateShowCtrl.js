angular.module('buildingInspections').controller('InspectionTemplateShowCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
  'scores',
function($scope, $stateParams, inspection_templates, scores) {
  $scope.loading = true;
  $scope.validScoreTypes = scores.validScoreTypes;
  $scope.newItem = {};
  console.log(scores.validScoreTypes);

  $scope.getInspectionTemplate = function() {
    inspection_templates.show({id: $stateParams.id})
      .$promise.then(
      function(data) {
        $scope.inspection_template = data
      }).finally(function() {
        $scope.loading = false;
      });
  };

  $scope.addItem = function() {
    if (!$scope.newItem.name || $scope.newItem.name === '') {
      return;
    }
    $scope.inspection_template.items.push({
      name: $scope.newItem.name,
      section: $scope.newItem.section,
      score_type: $scope.newItem.score_type
    });

    $scope.calcPositions();

    $scope.inspection_template = inspection_templates.update($scope.inspection_template);

    $scope.newItem = {};
  };

  $scope.deleteItem = function(item_to_delete) {
    $scope.inspection_template = inspection_templates.destroy_item({id: $scope.inspection_template.id}, item_to_delete);
  };

  $scope.calcPositions = function() {
    for (var i = 0; i < $scope.inspection_template.items.length; i++) {
      $scope.inspection_template.items[i].position = i;
    }
  };

  $scope.toggleEdit = function(item) {
    if (item.editing) {
      item.editing = false;
      inspection_templates.update($scope.inspection_template);
      $scope.getInspectionTemplate();
    } else {
      item.editing = true;
    }
  };

  $scope.getInspectionTemplate();
  
}]);