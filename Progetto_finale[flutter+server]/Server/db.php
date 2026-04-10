<?php
$conn = new mysqli("localhost", "root", "", "armadio");
if ($conn->connect_error) {
header('Content-Type: application/json');
http_response_code(500);
echo json_encode(["status" => "error", "message" => "Connection failed: " .
$conn->connect_error]);
exit;
}; 
?>
