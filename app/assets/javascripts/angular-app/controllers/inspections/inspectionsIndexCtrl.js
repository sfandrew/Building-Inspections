angular.module('buildingInspections').controller('InspectionsIndexCtrl', [
  '$scope', 
  '$stateParams',
  '$state',
  'inspections',
  'inspection_templates',
  'buildings',
  'units',
function($scope, $stateParams, $state, inspections, inspection_templates, buildings, units) {
  
  $scope.inspection = {}
  $scope.pageClass = 'list-inspections';

  $scope.getInspectionTemplates = function() {
    $scope.inspection_templates = inspection_templates.index();
  };

  $scope.getInspections = function() {
    $scope.inspections = inspections.index();
  };

  $scope.getBuildings = function() {
    $scope.buildings = buildings.index();
  };

  $scope.setSelectedBuilding = function() {
    $scope.getUnitsForBuilding($scope.inspection.selected_building);
  };

  $scope.getUnitsForBuilding = function(building){
    units.index({building_id: building.id}, function(data){
      $scope.units = data;
      $scope.inspection.selected_unit = $scope.units[0];
    });
  };

  $scope.addInspection = function() {
    inspections.create($scope.inspection)
    .$promise.then(function(data) {
      $state.go('inspection', {id: data.id});
      //$scope.inspections.push(data);
    });
    $scope.inspection = {};
    $scope.selected_building_id = "";
  };

  $scope.inspectionTemplateHasItems = function(inspection_template) {
    return inspection_template.items_count > 0;
  };

  $scope.getInspectionTemplates();
  $scope.getBuildings();
  $scope.getInspections();
  
}]);