<?php
function dbconnection()
{
    $con = mysqli_connect("localhost","root","","cooperativa");
    return $con;
}