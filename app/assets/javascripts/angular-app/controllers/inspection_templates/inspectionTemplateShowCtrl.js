angular.module('buildingInspections').controller('InspectionTemplateShowCtrl', [
  '$scope', 
  '$stateParams', 
  'inspection_templates',
  'scores',
function($scope, $stateParams, inspection_templates, scores) {
  $scope.loading = true;
  $scope.validScoreTypes = scores.validScoreTypes;
  $scope.newItem = {};
  $scope.newSection = {name: ""};
  $scope.pageClass = 'show-inspection-template';

  $scope.getInspectionTemplate = function() {
    inspection_templates.show({id: $stateParams.id})
      .$promise.then(
      function(data) {
        $scope.inspection_template = data;
        $scope.generateItemSections();
      }).finally(function() {
        $scope.loading = false;
      });

  };

  $scope.addItem = function() {
    if (!$scope.newItem.name || $scope.newItem.name === '') {
      return;
    }
    $scope.inspection_template.items.push({
      name: $scope.newItem.name,
      section: $scope.newItem.section,
      score_type: $scope.newItem.score_type
    });

    $scope.calcPositions();

    $scope.inspection_template = inspection_templates.update($scope.inspection_template);

    $scope.newItem = {};
  };

  $scope.deleteItem = function(item_to_delete) {
    $scope.inspection_template = inspection_templates.destroy_item({id: $scope.inspection_template.id}, item_to_delete);
  };

  $scope.calcPositions = function() {
    for (var i = 0; i < $scope.inspection_template.items.length; i++) {
      $scope.inspection_template.items[i].position = i;
    }
  };

  $scope.toggleEdit = function(item) {
    if (item.editing) {
      item.editing = false;
      inspection_templates.update($scope.inspection_template)
      .$promise.then($scope.getInspectionTemplate);
    } else {
      item.editing = true;
    }
  };

  $scope.generateItemSections = function() {
    $scope.sections = [];
    if (!$scope.inspection_template) {
      return $scope.sections;
    }
    for (var i = 0; i < $scope.inspection_template.items.length; i++) {
      var section = $scope.inspection_template.items[i].section;
      if ($scope.sections.indexOf(section) == -1) {
        $scope.sections.push(section);
      }
    }
  };

  $scope.addSection = function() {
    $scope.inspection_template.sections.push($scope.newSection.name);
    $scope.updateInspectionTemplateSections();
    $scope.newSection.name = "";
  };

  $scope.deleteSection = function(section) {
    var i = $scope.inspection_template.sections.indexOf(section);
    if (i >= 0) {
      $scope.inspection_template.sections.splice(i, 1);
      $scope.updateInspectionTemplateSections();
    }
  };

  $scope.moveSectionUp = function(section) {
    var i = $scope.inspection_template.sections.indexOf(section)
    if (i > 0) {
      var tmp = $scope.inspection_template.sections[i];
      $scope.inspection_template.sections[i] = $scope.inspection_template.sections[i-1];
      $scope.inspection_template.sections[i-1] = tmp;
      $scope.updateInspectionTemplateSections();
      return;
    }
  };

  $scope.moveSectionDown = function(section) {
    var i = $scope.inspection_template.sections.indexOf(section)
    if (i >= 0 && i < ($scope.inspection_template.sections.length - 1)) {
      var tmp = $scope.inspection_template.sections[i];
      $scope.inspection_template.sections[i] = $scope.inspection_template.sections[i+1];
      $scope.inspection_template.sections[i+1] = tmp;
      $scope.updateInspectionTemplateSections();
      return;
    }
  };

  $scope.updateInspectionTemplateSections = function() {
    inspection_templates.update({id: $scope.inspection_template.id}, 
      {sections: $scope.inspection_template.sections})
      .$promise.then(function(data) {
        $scope.inspection_template = data;
      }, function(data){
        $('.alert-danger').remove();
        $errorDiv = $('<div><a class="close" data-dismiss="alert" aria-label="close">&times;</a></div>').addClass('alert alert-danger');
        var errors = data.data.error;
        $.each(errors, function(index,value){
          $errorDiv.append('<li>' + value+ '</li>');
        });
        $('.error-messages').append($errorDiv);
      });
  };

  $scope.itemSectionNotInSections = function(item) {
    for (var i = 0; i < $scope.inspection_template.sections.length; i++) {
      if (item.section == $scope.inspection_template.sections[i]) {
        return false;
      }
    }
    return true;
  };

  $scope.uniqueSection = function(inspection_template_sections, current_section){
    if (inspection_template_sections.length > 0){
      for (var i = 0; i < inspection_template_sections.length; i++) {
        if (inspection_template_sections[i] == current_section) {
          $('.section-input').removeClass('has-success');
          $('.section-input').addClass('has-error');
          $('.section-submit').prop('disabled',true);
          break;
        } else{
          $('.section-submit').prop('disabled',false);
          $('.section-input').removeClass('has-error');
          $('.section-input').addClass('has-success');
        };
      };
    }
  };

  //$scope.$watchCollection('inspection_template.items', $scope.generateItemSections);

  $scope.getInspectionTemplate();
  
}]);