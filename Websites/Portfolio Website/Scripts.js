var Home = {};

Home.AlertPageLoad = function()  {
	alert('Page Loaded From Function');
}

Home.HideDiv = function()  {
	$(".div1").click(function()  {
		$(this).hide(); 
	});
}

Home.OpenNavEvent = function()  {
	$(".navContainer").click(function()  {
		if($(".bar2").css("opacity") == 1)  {
			//alert("Open Nav Menu!");
			$(".bar1").css("transform", "rotate(-45deg) translate(-9px, 6px)");
			$(".bar2").css("opacity", "0"); 
			$(".bar3").css("transform", "rotate(45deg) translate(-8px, -8px)");
			
			$(".sideNav").css("width", "50%");
			$(".sideNav").css("height", "100%");
			$(".navContainer").removeClass("navContainer").addClass("navContainerNeedsClosed");
		}
		else if($(".bar2").css("opacity") == 0)  {
			//alert("Close Nav Menu!");
			$(".bar1").css("transform", "rotate(5deg) translate(9px, -6px)");
			$(".bar2").css("opacity", "1.0"); 
			$(".bar3").css("transform", "rotate(-5deg) translate(8px, 8px)");
			
			$(".sideNav").css("width", "0%");
			$(".sideNav").css("height", "0%");
			$(".navContainer").removeClass("navContainerNeedsClosed").addClass("navContainer");
		}
	});
}


$(document).ready(function()
{	
		//alert('Page Loaded From Document.Ready()');
		//Home.AlertPageLoad(); 
		
		Home.HideDiv(); 
		Home.OpenNavEvent(); 
	
});