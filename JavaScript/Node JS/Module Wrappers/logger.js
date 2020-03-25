/*Logger Module*/ //for logging messages 

//Imagine we would be sending an HTTP request to a service at this end point to log a message
var url = '';			 

//We want to access this function from app.js 
function log(message)  {
	//Would send HTTP request
	console.log(message); 
}

//IN MODULES YOU CAN EXPORT AN OBJECT OR A SINGLE FUNCTION***

//OBJECT 
//Any methods or variables added to the 'exports' property on the module object will be exported
	//this adds a method 'log' to the exports property of this module (js file) and sets it to equate to the 'log' method defined in this file 	
module.exports.log = log; 

//We could also export the URL - although implementation details don't need to be public 
	//var name that is exported doesn't need to be the same as the var name defined in this module 
module.exports.endPoint = url;  


//SINGLE FUNCTION 
/*This adds the single method instead of an object with the method */
//module.exports = log;


