<?php
$mysqli  = new mysqli("localhost", "root", "", "armadio");
if ($mysqli ->connect_error) {
header('Content-Type: application/json');
http_response_code(500);
echo json_encode(["status" => "error", "message" => "Connection failed: " .
$mysqli ->connect_error]);
exit;
}; 
?>
