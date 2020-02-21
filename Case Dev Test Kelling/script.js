$(document).ready(function(){

		$texts = document.getElementsByClassName("hidden-text");

		//get & set height for each box element 
		for(var i = 0; i < $texts.length; i++) {
			$height = $texts.item(i).clientHeight;
			$texts.item(i).setAttribute('data-height', $height+'px');
			$texts.item(i).setAttribute('id', 'box-'+i);
		}

		$('.hidden-text').addClass('text-hide');

	  //hover for desktops
	  $(".box").hover(function() {
	  		$this = $(this);
	  		hover($this);
	  	  
		  }, function(){
		  	$this = $(this);
		  	unhover($this);
		});

	  //mousedown for mobile
	  $(".box").mousedown(function() {
	  	$this = $(this);
	  	hover($this);
	  });
	  $(".box").mouseup(function() {
	  	$this = $(this);
	  	unhover($this);
	  });
});

function hover($this) {
	$hiddenText = $this.find('.hidden-text');
	  	  $boxText = $this.find('.box-text');
	  	  $heightSet = $this.find('.hidden-text').attr("data-height");

		  $boxText.animate({'background-color': '#3168a6'}, {duration: 300});
		  $hiddenText.addClass('text-show');
		  $hiddenText.animate({'height': $heightSet }, {duration: 300});
}

function unhover($this) {
	$currentId = $this.find('.hidden-text').attr('id');

		  	$boxText.animate({'background-color': '#0a304e'}, {duration: 300});
		  	$hiddenText.animate({
		  		'height': '0'},
		  		{
		  			duration: 300,
		  			complete: function() { $('#'+$currentId).removeClass('text-show'); }
		  		}
		  	);
}