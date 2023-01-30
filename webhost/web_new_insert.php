<?php

	$con=mysqli_connect("localhost","id19324946_mobile","InYxL{vmNh4]=e{1","id19324946_contactbook");

	$temp=array();

	if($con){
		$temp['connection']=1;
	}
	else{
		$temp['connection']=0;
	}


	$id=$_REQUEST['id'];
	$userid=$_REQUEST['userid'];

		$qry="update Test set userid='$userid'  where id='$id'";

		$sql=mysqli_query($con,$qry);

			if($sql){
				$temp['result']=1;
			}
			else{
				$temp['result']=0;
			}


	echo json_encode($temp);
	

?>