var inspectionApp = angular.module('buildingInspections', ['templates', 'ui.router', 'ngResource']);

inspectionApp.config(['$stateProvider', '$urlRouterProvider', 
  function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise('home');

  $stateProvider.state('home', {
    url: "/home",
    templateUrl: 'home.html',
    controller: 'HomeCtrl'
  });

  $stateProvider.state('inspection_templates', {
    url: '/inspection_templates',
    templateUrl: 'inspection_templates/_index.html',
    controller: 'InspectionTemplatesIndexCtrl'
  });

  $stateProvider.state('inspection_template', {
    url: '/inspection_templates/{id}',
    templateUrl: 'inspection_templates/_show.html',
    controller: 'InspectionTemplateShowCtrl'
  });

  $stateProvider.state('inspections', {
    url: '/inspections',
    templateUrl: 'inspections/_index.html',
    controller: 'InspectionsIndexCtrl'
  });

  $stateProvider.state('inspection', {
    url: '/inspections/{id}',
    templateUrl: 'inspections/_show.html',
    controller: 'InspectionShowCtrl'
  });

  $stateProvider.state('buildings', {
    url: '/buildings',
    templateUrl: 'buildings/_index.html',
    controller: 'BuildingsIndexCtrl'
  });

  $stateProvider.state('building', {
    url: '/buildings/{id}',
    templateUrl: 'buildings/_show.html',
    controller: 'BuildingShowCtrl'
  });

  $stateProvider.state('new_unit', {
    url: '/buildings/{id}/units/new',
    templateUrl: 'buildings/units/_new.html',
    controller: 'UnitNewCtrl'
  });


}]);

inspectionApp.config(['$httpProvider', function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content');
}]);


inspectionApp.controller('HomeCtrl', ['$scope', function($scope){
  $scope.title = 'Hello world!';
}]);