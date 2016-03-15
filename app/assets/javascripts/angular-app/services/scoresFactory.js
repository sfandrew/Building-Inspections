angular.module('buildingInspections').factory('scores', [
function(){
  function Score(scoreType) {
    this.scoreType = scoreType;
  }

  Score.validScoreTypes = ["PassFail", "ZeroToTen"];

  return Score;

}]);