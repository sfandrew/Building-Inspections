var inspectionApp = angular.module('buildingInspections', ['templates', 'ui.router']);

inspectionApp.config(function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise('home');

  $stateProvider.state('home', {
    url: "/home",
    templateUrl: '/assets/home.html',
    controller: 'HomeCtrl'
  });

  $stateProvider.state('inspection_templates', {
    url: '/inspection_templates',
    templateUrl: '/assets/inspection_templates/_index.html',
    controller: 'InspectionTemplatesCtrl'
  })


});


inspectionApp.factory('inspection_templates', [function(){
  var o = {
    inspection_templates: [
      {
        name: "test1",
        items: [
        {
          name: 'item1',
          section: 'section1'
        },
        {
          name: 'item2',
          section: 'section2'
        }
      ]
      },
      {
        name: "test2",
        items: [
        {
          name: 'item1',
          section: 'section1'
        },
        {
          name: 'item2',
          section: 'section2'
        }
      ]
      }
    ]
  };
  return o;
}]);

inspectionApp.factory('inspection_template_items', [function(){
  var o = {
    items: [
      {
        name: "test1"
      },
      {
        name: "test2"
      }
    ]
  };
  return o;
}]);


inspectionApp.controller('HomeCtrl', ['$scope', function($scope){
  $scope.title = 'Hello world!';
}]);


inspectionApp.controller('InspectionTemplatesCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
function($scope, $stateParams, inspection_templates) {

  $scope.inspection_templates = inspection_templates.inspection_templates;

  $scope.addInspectionTemplate = function() {
    $scope.inspection_templates.push({
      name: $scope.name,
      items: [
        {
          name: 'item1',
          section: 'section1'
        },
        {
          name: 'item2',
          section: 'section2'
        }
      ]
    });
    $scope.name = '';
  };
}]);


inspectionApp.controller('InspectionTemplateItemsCtrl', [
  '$scope', 
  'inspection_template_items',
  function($scope, items){
    $scope.items = items.items;

    $scope.addItem = function() {
      if (!$scope.name || $scope.name === '') {
        return;
      }
      $scope.items.push({
        name: $scope.name,
        section: $scope.section
      });
      $scope.name = '';
      $scope.section = '';
    };

    $scope.toggleEdit = function(item) {
      if (item.editing) {
        item.editing = false;
      } else {
        item.editing = true;
      }
    };
}]);