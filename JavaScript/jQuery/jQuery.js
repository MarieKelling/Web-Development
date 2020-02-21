$(document).ready(function()
{
			$("h1").hide().show(1000)
			
			$(".hide").click(function(){
				$("div").hide(); 
			});
			
			$(".show").click(function(){
				$("div").show(); 
			});
			
			$("#toggle").click(function(){
				$("div").toggle(); 
			});
			
			$("document").on("mousemove", function(e){
				$("#coords").html("Coords: Y: " + e.clientY + "X: " + e.clientX); 	
			});
			
			//focus blur events 
			$("input").focus(function(){
				$(this).css('background', 'pink');
			});
			$("input").blur(function(){
				$(this).css('background', 'white');
			});
			//Grab the value typed in input and alert it 
			$("input").blur(function(e){
				alert(e.target.value);
			});
			
			
			
			
				
});