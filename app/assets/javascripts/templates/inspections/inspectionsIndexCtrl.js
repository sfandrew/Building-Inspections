angular.module('buildingInspections').controller('InspectionsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'inspections',
  'inspection_templates',
  'buildings',
  'units',
function($scope, $stateParams, inspections, inspection_templates, buildings, units) {
  
  $scope.inspection = {}

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
    for (var i = 0; i < $scope.buildings.length; i++) {
      if ($scope.buildings[i].id == $scope.selected_building_id) {
        $scope.selected_building = $scope.buildings[i];
        $scope.getUnitsForBuilding($scope.selected_building);
        return;
      }
    }
  };

  $scope.getUnitsForBuilding = function(building){
    units.index({building_id: building.id}, function(data){
      $scope.units = data;
      $scope.inspection.selected_unit = $scope.units[0];
    });
  };

  $scope.addInspection = function() {
    inspections.create({
      inspection: {
        description: $scope.inspection.description,
        template_id: $scope.inspection.template_id,
        unit_id: $scope.inspection.selected_unit.id
      }
    }, function() {
      $scope.getInspections();
    });
    $scope.inspection = {};
    $scope.selected_building_id = "";
  };

  $scope.getInspectionTemplates();
  $scope.getBuildings();
  $scope.getInspections();
  
}]);