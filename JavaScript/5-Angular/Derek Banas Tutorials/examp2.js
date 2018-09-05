var app2 = angular.module("app2", []);

app2.controller("controller1", function($scope)  {
	
	$scope.randomNum1 = Math.floor((Math.random() * 10) + 1);		//Generates random number between 1 & 10 
	$scope.randomNum2 = Math.floor((Math.random() * 10) + 1);
	
});