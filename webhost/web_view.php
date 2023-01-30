<?php

	$con=mysqli_connect("localhost","id19324946_mobile","InYxL{vmNh4]=e{1","id19324946_contactbook");
	$temp=array();

	$username=$_REQUEST['username'];
	$pass=$_REQUEST['pass'];

	$qry="select * from Test where (email='$username' or contact='$username') and pass='$pass'";

	$sql=mysqli_query($con,$qry);

	$cnt=mysqli_num_rows($sql);

	if($cnt==1){

		$temp['result']=1;

		$userdata=mysqli_fetch_assoc($sql);

		$temp['userdata']=$userdata;

	}
	else
	{
		$temp['result'] = 0;
	}

	echo json_encode($temp);
?>