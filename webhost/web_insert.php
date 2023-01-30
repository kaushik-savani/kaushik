<?php

	$con=mysqli_connect("localhost","id19324946_mobile","InYxL{vmNh4]=e{1","id19324946_contactbook");

	$temp=array();

	if($con){
		$temp['connection']=1;
	}
	else{
		$temp['connection']=0;
	}


	$name=$_REQUEST['name'];
	$email=$_REQUEST['email'];
	$contact=$_REQUEST['contact'];
	$pass=$_REQUEST['pass'];

	$phonefilepath=$_FILES['file']['tmp_name'];  // Image Located in Phone
	$phonefilename=$_FILES['file']['name'];		// Image name created according to date and time

	$imagepath="profile/".$phonefilename;		// Location where image tobe stored


	$checkqry="select * from Test where email='$email' or contact='$contact'";

	$checksql=mysqli_query($con,$checkqry);

	$cnt=mysqli_num_rows($checksql);

	if($cnt==0){
		if(move_uploaded_file($phonefilepath, $imagepath)){

		$qry="insert into Test (name,email,contact,pass,imagename) values ('$name','$email','$contact','$pass','$imagepath')";

		$sql=mysqli_query($con,$qry);

			if($sql){
				$temp['result']=1;
			}
			else{
				$temp['result']=0;
			}

			}
		else{
			$temp['result']=0;
		}
	}
	else{
			$temp['result']=2;
		}



	echo json_encode($temp);
	

?>