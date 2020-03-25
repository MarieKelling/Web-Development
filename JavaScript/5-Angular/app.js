var app = angular.module('Blog', ['ngRoute']); //Add ngRoute as dependency 

app.config(function($routProvider)  {
	$routProvider
		.when("/Blog", 
		{
			templateUrl: "Blog.html"
		})
		.when("/Posts", 
		{
			templateUrl: "Posts.html"
		})
		.when("/About", 
		{
			templateUrl: "About.html"
		})
		.otherwise({ redirectTo: "/Blog"})
}); 