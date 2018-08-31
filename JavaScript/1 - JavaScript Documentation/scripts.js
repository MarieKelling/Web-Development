window.onload = function(){

	//Basic way to grab HTML element & do something with it
	document.getElementById("greeting").addEventListener("click", sayHello);
	function sayHello()  {
		alert("Hello!");
	}

	//Can be helpful to put into variables to decrease code repetition 
	var headline = document.getElementById("headline");
	var list = document.getElementById("list");
	var listItems = document.getElementsByTagName("li");
	var addButton = document.getElementById("addBtn");


	for (i = 0; i < listItems.length; i++)  {
		listItems[i].addEventListener("click", echoListItem);
	}

	function echoListItem()  {
		headline.innerHTML = this.innerHTML; 
	}

	for (i = 0; i < listItems.length; i++)  {
		listItems[i].addEventListener("mouseover", highlightItem);
	}

	function highlightItem()  {
		this.style.color = "Aqua"; 
	}

	addButton.addEventListener("click", addItem);

	function addItem()  {
		list.innerHTML += "<li>New Item</li>"; 
	}

}


