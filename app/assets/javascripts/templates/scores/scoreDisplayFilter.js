angular.module('buildingInspections').filter('scoreDisplay', function() {
  return function(input) {
    switch (input) {
      case "PassFail":
        return "Pass/Fail";
        break;
      case "ZeroToTen":
        return "0-10";
        break;
      default:
        return "Invalid Score Type!";
    }
  };
});