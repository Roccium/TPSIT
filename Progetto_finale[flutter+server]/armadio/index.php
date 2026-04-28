<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header('Content-Type: application/json');
$request = $_SERVER['REQUEST_METHOD'];
switch ($request) {
case 'GET':
require 'api/get.php';
break;
Case 'POST':
require 'api/post.php';
break;
Case 'PUT':
require 'api/put.php';
break;
Case 'DELETE':
require 'api/delete.php';
break;
default:
http_response_code(405);
echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>