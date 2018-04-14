<?php

/*
 * Response Codes
 * 1001->Success
 * 1002->Some Error Occurred
 * 1003->Invalid credentials
 * 500->Internal Server Error
 * Format of response generated
 * {responseCode:code,responseText:text,data:data}
 */
//Create Connection
include('connection.php');
$response = array('responseCode' => null, 'responseText' => null, 'data' => null);
$con = connection();
if (!$con) {
    $response['responseCode'] = 500;
    $response['responseText'] = 'Internal Server Error';
    $response['data'] = null;
    die(json_encode($response));
}
//Get Post Data
$data = $_POST['data'];

$email = $data['email'];
$password = $data['password'];

//Prepare SQL Statement
$stmt = mysqli_prepare($con, "SELECT login.email_id, login.password, login.role_id, login.fl_flag, login.status, role.role_name, role.home_link, role.table_name FROM login,role where login.email_id=? and login.password=? and login.role_id=role.role_id");

//Bind Variables
mysqli_stmt_bind_param($stmt, "ss", $email, $password);

//Execute Query
mysqli_execute($stmt);

//Bind output results with variables should be same as the fetched columns
mysqli_stmt_bind_result($stmt, $email_id, $password, $role_id, $fl_flag, $status, $role_name, $home_link, $table_name);

//loop to fetch all rows
if (mysqli_stmt_fetch($stmt)) {
    mysqli_stmt_reset($stmt);
    $stmt = mysqli_prepare($con, "Select * from $table_name where email_id=?");
    //Bind Variables
    mysqli_stmt_bind_param($stmt, "s", $email);

    //Execute Query
    mysqli_execute($stmt);

    //Bind output results with variables should be same as the fetched columns
    //Get all the details of the user
    mysqli_stmt_bind_result($stmt, $id, $email_id, $name, $firm_name, $address_id, $contact_no, $tin_no, $cin_no, $gstin_no);

    if (mysqli_stmt_fetch($stmt)) {
        mysqli_stmt_reset($stmt);
        $stmt = mysqli_prepare($con, "Select * from address where address_id=?");
        mysqli_stmt_bind_param($stmt, "i", $address_id);
        mysqli_execute($stmt);
        mysqli_stmt_bind_result($stmt, $address_id, $line1, $line2, $line3, $city, $state, $country);
        if (mysqli_stmt_fetch($stmt)) {
            session_start();
            $_SESSION['emailId']=$email_id;
            $_SESSION['name']=$name;
            $_SESSION['firm_name']=$firm_name;
            $_SESSION['line1']=$line1;
            $_SESSION['line2']=$line2;
            $_SESSION['line3']=$line3;
            $_SESSION['city']=$city;
            $_SESSION['state']=$state;
            $_SESSION['country']=$country;
            $_SESSION['contact_no']=$contact_no;
            $_SESSION['tin_no']=$tin_no;
            $_SESSION['cin_no']=$cin_no;
            $_SESSION['gstin_no']=$gstin_no;
            $response['responseCode']=1001;
            $response['responseText']='Success';
            $data=array('homeLink'=>$home_link);
            $response['data']=  json_encode($data);
            echo json_encode($response);
        } else {
            $response['responseCode'] = 1002;
            $response['responseText'] = 'Some error occurred';
            echo json_encode($response);
        }
    } else {
        $response['responseCode'] = 1002;
        $response['responseText'] = 'Some error occurred';
        echo json_encode($response);
    }
} else {
    $response['responseCode'] = 1003;
    $response['responseText'] = 'Invalid Credentials';
    echo json_encode($response);
}