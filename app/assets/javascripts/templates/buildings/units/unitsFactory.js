angular.module('buildingInspections').factory('units', [
  '$resource',
function($resource){
  
  return $resource("/buildings/:building_id/units/:id.json", { id: "@id", building_id: "@building_id" },
    {
      'create':  { method: 'POST' },
      'index':   { method: 'GET', isArray: true },
      'show':    { method: 'GET', isArray: false },
      'update':  { method: 'PUT' },
      'destroy': { method: 'DELETE' }
    }
  );
}]);