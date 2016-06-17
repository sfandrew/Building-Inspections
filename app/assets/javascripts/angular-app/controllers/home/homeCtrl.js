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
		$scope.numPerPage = 5; 
		$scope.currentPage = 1;

		$scope.order = function (predicate) {  
         $scope.reverse = ($scope.predicate === predicate) ? !$scope.reverse : false;  
         $scope.predicate = predicate;  
       }; 

		$scope.retriveBuildings = function(){
			$scope.buildings = buildings.index();
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

		$scope.showInfoWindow = function(event,building){

			var building_position = {lat: building.latitude, lng: building.longitude};
			var marker = new google.maps.Marker({
    						position: building_position
  			});

			var infowindow = new google.maps.InfoWindow();
			var center = new google.maps.LatLng(building.latitude,building.longitude);
			
			infowindow.setContent(
				'<h5>Building Name: ' + building.name + '</h5>'+ '<p>Address: ' + building.address_line_1 + '</p>' +
				'<p>Address 2: ' + building.address_line_2 + '</p>' +
				'<p>City: ' + building.city + ' State: ' + building.state + ' Zip: ' + building.zip);
			infowindow.setPosition(center);
			infowindow.open($scope.map, marker);	
		};

	$scope.retriveBuildings();
}]);