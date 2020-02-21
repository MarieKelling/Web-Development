$(document).ready(function() {
	//alert('hello');

	//Static Array Display
	/*var toDoList = [];
	toDoList[0] = "hi";
	toDoList[1] = "hello";

	for (var i = 0; i < toDoList.length; i++) {
		var newToDo = $('<div>', {text: toDoList[i]});
		$('.to-do-list').append(newToDo);
	}*/

	//Dynamic Array Display
	$('.add-btn').on('click', function() {

		/*$test = $('.test').text();
		alert($test);*/ 		//for normal elements 

		/*$userInput = $('.user-input').val();
		alert($userInput);*/	//for input elements 

		$userInput = $('.user-input').val();

		if ($userInput != "")
		{
			//var newToDo = $('<div>', {text: $userInput});
			var newToDo = $('<div class="to-do-item">'+$userInput+'<span class="remove-item">X</span></div>');

			$('.to-do-list').append(newToDo);

			$('.user-input').val("");

			//Remove to do item 
			$('.remove-item').on('click', function() {
				//alert('X-clicked');
				$(this).closest('.to-do-item').remove();
			});
		}

		if ($userInput == "") 
		{
			alert("Please enter the task to be added.");
		}
	
		
	});

	
});