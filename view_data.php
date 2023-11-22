<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include("dbconnection.php");
$con = dbconnection();

$query = "SELECT numeroprestamo, importe FROM prestamo";

$exe = mysqli_query($con, $query);

if (!$exe) {
    die('Error en la consulta: ' . mysqli_error($con));
}

$arr = [];
while ($row = mysqli_fetch_assoc($exe)) {
    $arr[] = $row;
}

mysqli_close($con);

if (count($arr) > 0) {
    error_log("Consulta SQL exitosa. Se encontraron registros.");
} else {
    error_log("Consulta SQL exitosa. No se encontraron registros.");
}

print(json_encode($arr));
?>


 <?php