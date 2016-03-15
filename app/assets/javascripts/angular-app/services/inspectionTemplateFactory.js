angular.module('buildingInspections').factory('inspection_templates', [
  '$resource',
function($resource){

  var paramsForUpdate = function(inspection_template) {
    console.log(inspection_template);
    return angular.toJson({
      inspection_template: {
        name: inspection_template.name,
        items_attributes: inspection_template.items
      }
    })
  };
  
  return $resource("/inspection_templates/:id.json", { id: "@id" },
    {
      'create':       { method: 'POST' },
      'index':        { method: 'GET', isArray: true },
      'show':         { method: 'GET', isArray: false },
      'update':       { method: 'PUT',
        transformRequest: paramsForUpdate
      },
      'destroy':      { method: 'DELETE' },
      'destroy_item': {
        method: 'PUT', transformRequest: function(data){
          return angular.toJson({
            inspection_template: {
              items_attributes: {
                id: data.id,
                _destroy: true
              }
            }
          });
        }
      }
    }
  );
}]);