angular.module('buildingInspections').controller('homeCtrl', ['$scope', 'buildings','NgMap',
	function($scope, buildings, NgMap){

		NgMap.getMap().then(function(map) {
            $scope.map = map;
        });
        // http://plnkr.co/edit/8ec6BDo04iZPSRqeTuqk?p=preview
        $scope.buildingAddress = '';
		$scope.predicate = 'name';
		$scope.reverse = true; 
		$scope.address = '';
		$scope.currentPage = 1;
  		$scope.itemsPerPage = 10;

		$scope.order = function (predicate) {  
         $scope.reverse = ($scope.predicate === predicate) ? !$scope.reverse : false;  
         $scope.predicate = predicate;  
       }; 

		$scope.retriveBuildings = function(){
			$scope.buildings = buildings.index();
		};

		$scope.allBuildings = function(buildings){
			$scope.locations = [];
			for(var i = 0; i < buildings.length; i++){
				currentLocation = [buildings[i].latitude, buildings[i].longitude]
				$scope.locations.push(currentLocation);
			}
			var bounds = new google.maps.LatLngBounds();
			for (var i=0; i < $scope.locations.length; i++) {
      			var latlng = new google.maps.LatLng($scope.locations[i][0], $scope.locations[i][1]);
      			bounds.extend(latlng);
    		}
    		$scope.map.setCenter(bounds.getCenter());
      		$scope.map.fitBounds(bounds);
		};
		
		$scope.buildingSize = function(){
			buildings.index().$promise.then(function(data) {
				test =  data.length;
				return test;
			});
		};

		$scope.filterBuildingAddress = function(building) {
    		return (building.address_line_1 + building.address_line_2 + building.zip + building.state).indexOf($scope.address) >= 0;
  		};

  		$scope.showDetail = function(evnt,bldg){
  			$scope.map.showInfoWindow('foo-iw');
  			
  		};
  		$scope.showCity = function(event, building) {
            $scope.selectedbuilding = building;
            $scope.map.showInfoWindow('myInfoWindow', this);
        };

	$scope.retriveBuildings();
}]);