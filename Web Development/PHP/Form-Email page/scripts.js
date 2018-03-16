
$(document).ready(function()
{  
	function _(id) { return document.getElementById(id); }
	function submitForm()
	{
		_("mybtn").disabled = true;
		_("status").innerHTML = 'please wait ...';
		
		
		var formdata = new FormData();
		formdata.append( "name", _("name").value );
		formdata.append( "email", _("email").value );
		formdata.append( "message", _("message").value );
		
		var ajax = new XMLHttpRequest();
		ajax.open( "POST", "example_parser.php" );				//
		ajax.onreadystatechange = function() 						//
		{
			if(ajax.readyState == 4 && ajax.status == 200) 
			{
				if(ajax.responseText == "success")
				{
					_("my_form").innerHTML = '<h2>Thanks ' + _("name").value + ', your message has been sent.</h2>';  //Form ID in HTML 
				} 
				else 
				{
					_("status").innerHTML = ajax.responseText;
					_("mybtn").disabled = false; 
				}
			}
		}
		ajax.send( formdata ); 
	}
		
