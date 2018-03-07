<?php

	if( isset($_POST['name']) && isset($_POST['email']) && isset($_POST['message']) )
	{
			$name = $_POST['name']; 									// HINT: use preg_replace() to filter the data
			$email = $_POST['email'];
			$message = nl2br($_POST['message']);					//Converts new lines inputted by the user to <br> tags 
			$to = "mariekelling@yahoo.com";
			$from = $email;
			$subject = 'Contact Form Message';
			$body = '<b>Name:</b> '.$name.' <br> <b>Email:</b> '.$email.'  <p>'.$message.'</p>';
			
			$headers = "From: $from\n";
			$headers .= "MIME-Version: 1.0\n";
			$headers .= "Content-type: text/html; charset=iso-8859-1\n";
			
			if( mail($to, $subject, $body, $headers) ) 
			{
				echo "success";
			} 
			else 
			{
				
				echo "The server failed to send the message. Please try again later.";
			}
	}
	$name = $_POST['name'];
	$email = $_POST['email']; 
	$message = $_POST['message'];
	
	$to = "mariekelling@yahoo.com";
	$subject = "Form to Email Submission";
	$body = "This is an automated message, do not reply to this email. \n\n $message";
	
	mail($to, $subject, $body);
	
	echo "Message Sent!"; 

?>