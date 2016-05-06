angular.module('buildingInspections').controller('BuildingsIndexCtrl', [
  '$scope', 
  '$stateParams',
  'buildings',
function($scope, $stateParams, buildings) {

  $scope.loading = true;
  $scope.pageClass = 'listing-buildings';

  $scope.building = {};
  
  $scope.getBuildings = function() {
    buildings.index()
    .$promise.then(
      $scope.setBuildings
      ).finally(function() {
        $scope.loading = false;
      });
  };

  $scope.setBuildings = function(new_buildings) {
    $scope.buildings = new_buildings;
  };

  $scope.destroyBuilding = function(building) {
    buildings.destroy({id: building.id})
      .$promise.then(function(data) {
        $scope.buildings.splice($scope.buildings.indexOf(building), 1);
      });
  };

  $scope.addBuilding = function() {
    buildings.create(
      $scope.building
    ).$promise.then(function(data){ 
      $scope.buildings.push(data);
    }, function(data){
      if(data.data.error.length){
        $('.alert-danger').remove();
        $errorDiv = $('<div><a class="close" data-dismiss="alert" aria-label="close">&times;</a></div>').addClass('alert alert-danger');
        var errors = data.data.error;
        $.each(errors, function(index,value){
          $errorDiv.append('<li>' + value+ '</li>');
        });

        $('.error-messages').append($errorDiv)
      }
    });
    $scope.building = {};
    //$scope.getBuildings();
  };

  $scope.getBuildings();
  
}]);