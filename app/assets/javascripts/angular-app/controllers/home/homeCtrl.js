angular.module('buildingInspections').controller('homeCtrl', ['$scope', 'buildings','NgMap',
	function($scope, buildings, NgMap){

		NgMap.getMap().then(function(map) {
            $scope.map = map;
        });
		
		$scope.retriveBuildings = function(){
			$scope.buildings = buildings.index();
		};

		$scope.showInfoWindow = function(event,building){

			// var marker = new google.maps.Marker({
   //  						position: [building.latitude,building.longtitude],
   //  						map: $scope.map,
   //  						title: 'Uluru (Ayers Rock)'
  	// 		});

			var infowindow = new google.maps.InfoWindow();
			var center = new google.maps.LatLng(building.latitude,building.longtitude);
			
			infowindow.setContent(
				'<h5>Building Name: ' + building.name + '</h5>'+ '<p>Address: ' + building.address_line_1 + '</p>' +
				'<p>Address 2: ' + building.address_line_2 + '</p>' +
				'<p>City: ' + building.city + ' State: ' + building.state + ' Zip: ' + building.zip);
			infowindow.setPosition(center);
			infowindow.open($scope.map, this);
		

			
		};



	$scope.retriveBuildings();
	
}]);