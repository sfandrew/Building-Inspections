var inspectionApp = angular.module('buildingInspections', ['templates', 'ui.router', 'ngResource']);

inspectionApp.config(function($stateProvider, $urlRouterProvider) {

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
  })

  $stateProvider.state('inspection_template', {
    url: '/inspection_templates/{id}',
    templateUrl: 'inspection_templates/_show.html',
    controller: 'InspectionTemplatesShowCtrl'
  })


});

inspectionApp.config(function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content');
});


inspectionApp.controller('HomeCtrl', ['$scope', function($scope){
  $scope.title = 'Hello world!';
}]);


inspectionApp.controller('InspectionTemplateItemsCtrl', [
  '$scope', 
  'inspection_template_items',
  function($scope, items){
    $scope.items = items.items;


    $scope.toggleEdit = function(item) {
      if (item.editing) {
        item.editing = false;
      } else {
        item.editing = true;
      }
    };
}]);