/*Main Module*/

//Lesson 1: 
function sayHello(name)  {
	console.log('Hello' + name);
}

sayHello('Marie'); 

//Lesson 2: 
//View the module object on the console 
console.log(module); 
 
//This will throw an undefined error - vars not added to the global scope in node
var message = 'This is my message.';
console.log(global.message);  


//Lesson 3: 
//Load logger module/file to access the log function 
	//this gives app.js the exports object from thhe logger module/file 
const logger = require('./logger');

//Shows you the available exported log function
console.log(logger); 

//Can now use the log function 
logger.log('message');  

/*When just adding the method directly to 'exports' in the logger module, you would call the logger method directly  
	- instead of through log - ??? little confusion on this */
//logger('message');