angular.module('buildingInspections').controller('InspectionTemplateShowCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
function($scope, $stateParams, inspection_templates) {
  $scope.loading = true;

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
    if (!$scope.name || $scope.name === '') {
      return;
    }
    $scope.inspection_template.items.push({
      name: $scope.name,
      section: $scope.section
    });

    $scope.calcPositions();

    $scope.inspection_template = inspection_templates.update({id: $stateParams.id}, $scope.paramsForUpdate());

    $scope.name = '';
    $scope.section = '';
  };

  $scope.deleteItem = function(item_to_delete) {
    $scope.inspection_template = inspection_templates.update({id: $stateParams.id}, $scope.paramsForDeletingItem(item_to_delete));
  };

  $scope.paramsForUpdate = function() {
    return {
      inspection_template: {
        name: $scope.inspection_template.name,
        items_attributes: $scope.inspection_template.items
      }
    };
  };

  $scope.paramsForDeletingItem = function(item_to_delete) {
    return {
      inspection_template: {
        items_attributes: {
          id: item_to_delete.id,
          _destroy: true
        }
      }
    };
  };

  $scope.calcPositions = function() {
    for (var i = 0; i < $scope.inspection_template.items.length; i++) {
      $scope.inspection_template.items[i].position = i;
    }
  };

  $scope.toggleEdit = function(item) {
    if (item.editing) {
      item.editing = false;
      inspection_templates.update({id: $stateParams.id}, $scope.paramsForUpdate());
      $scope.getInspectionTemplate();
    } else {
      item.editing = true;
    }
  };

  $scope.getInspectionTemplate();
  
}]);