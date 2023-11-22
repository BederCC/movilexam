<?php
header("Access-Control-Allow-Origin: *");

include("dbconnection.php"); 
$con=dbconnection();

if (isset($_POST["numeroprestamo"])) {
    $id_usuario = $_POST["numeroprestamo"];
} else {
    return;
}

if (isset($_POST["importe"])) {
    $importe = $_POST["importe"];
} else {
    return;
}

$query = "UPDATE prestamo SET importe = '$importe' WHERE numeroprestamo = '$numeroprestamo'";

$exe=mysqli_query($con, $query);
$arr=[];
if($exe)
{
$arr["success"]="true";
}
else
{
$arr["success"]="false";
}
print (json_encode($arr));
?>