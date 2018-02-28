<?php

	$name = $_POST['name'];
	$message = $_POST['message'];
	
	$to = "mariekelling@yahoo.com";
	$subject = "Form to Email Submission";
	$body = "This is an automated message, do not reply to this email. \n\n $message";
	
	mail($to, $subject, $body);
	
	echo "Message Sent!"; 

?>