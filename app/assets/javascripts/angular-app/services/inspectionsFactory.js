angular.module('buildingInspections').factory('inspections', [
  '$resource',
function($resource){
  
  var paramsForCreate = function(inspection) {
    return angular.toJson({
      inspection: {
        description: inspection.description,
        template_id: inspection.template_id,
        unit_id: inspection.selected_unit.id
      }
    });
  };

  return $resource("/inspections/:id.json", { id: "@id" },
    {
      'create':  { method: 'POST',
        transformRequest: paramsForCreate },
      'index':   { method: 'GET', isArray: true },
      'show':    { method: 'GET', isArray: false },
      'update':  { method: 'PUT' },
      'destroy': { method: 'DELETE' }
    }
  );
}]);