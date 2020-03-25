var Home = {};

Home.OpenNavEvent = function()  {
	$(".navContainer").click(function()  {
		if($(".bar2").css("opacity") == 1)  {
			//alert("Open Nav Menu!");
			$(".bar1").css("transform", "rotate(-45deg) translate(-9px, 6px)");
			$(".bar2").css("opacity", "0"); 
			$(".bar3").css("transform", "rotate(45deg) translate(-8px, -8px)");
			
			
			$(".sideNav").css("height", "100%");
			$(".leftDropDown").css("height", "100%");  
			
			$(".navContainer").removeClass("navContainer").addClass("navContainerNeedsClosed");
		}
		else if($(".bar2").css("opacity") == 0)  {
			//alert("Close Nav Menu!");
			$(".bar1").css("transform", "rotate(405deg) translate(-15px, 30px)");
			$(".bar2").css("opacity", "1.0"); 
			$(".bar3").css("transform", "rotate(315deg) translate(-15px, -30px)");
			
			$(".sideNav").css("height", "0%");
			$(".leftDropDown").css("height", "0%");  
			$(".navContainer").removeClass("navContainerNeedsClosed").addClass("navContainer");
		}
	});
}


$(document).ready(function()
{	  
		Home.OpenNavEvent(); 
	
});