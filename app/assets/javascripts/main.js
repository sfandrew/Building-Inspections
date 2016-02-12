var inspectionApp = angular.module('buildingInspections', ['templates']);

inspectionApp.controller('HomeCtrl', ['$scope', function($scope){
  $scope.title = 'Hello world!';
}]);

inspectionApp.controller('InspectionTemplatesCtrl', ['$scope', function($scope){
  $scope.inspection_templates = [
    {
      name: "test1"
    },
    {
      name: "test2"
    }
  ]
}]);