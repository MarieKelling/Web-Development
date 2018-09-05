var app = angular.module('app', []);										//Define a Module 

app.controller('controller', function($scope)  {					//Define a Controller in the app Module
	$scope.firstNum = 1;
	$scope.secondNum = 1; 
	
	//Define a method to execute when the Sum button is clicked 
	$scope.updateValue = function()  {
		$scope.calculation = $scope.firstNum + ' + ' + $scope.secondNum +
		' = ' + (+$scope.firstNum +  +$scope.secondNum); 
	};

});