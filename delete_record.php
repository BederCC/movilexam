<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header('Access-Control-Allow-Origin: http://localhost:49284');

include("dbconnection.php");
$con = dbconnection();

if (isset($_POST["numeroprestamo"])) {
    $numeroprestamo = $_POST["numeroprestamo"];
} else return;


$query = "DELETE FROM prestamo WHERE numeroprestamo = $numeroprestamo";

$arr = [];
$exe = mysqli_query($con, $query);

if ($exe) {
    $arr["success"] = "true";
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));
?>

