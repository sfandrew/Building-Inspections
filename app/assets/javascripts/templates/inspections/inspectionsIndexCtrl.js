angular.module('buildingInspections').controller('InspectionsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'inspections',
  'inspection_templates',
  'buildings',
  'units',
function($scope, $stateParams, inspections, inspection_templates, buildings, units) {
  
  $scope.getInspectionTemplates = function() {
    $scope.inspection_templates = inspection_templates.index();
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
      $scope.selected_unit = $scope.units[0];
    });
  };

  // $scope.addInspectionTemplate = function() {
  //   inspections.create({
  //     name: $scope.name,
  //   });
  //   $scope.name = '';
  //   $scope.getInspections()
  // };

  $scope.getInspectionTemplates();
  $scope.getBuildings();
  
}]);