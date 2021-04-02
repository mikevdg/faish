<?php 
define(FILEPATH, "/var/www/incoming");

function logMessage($message) {
	$fp = fopen(FILEPATH."/access.log", "a");
	if (false == $fp) {
		echo "Could not open log file.";
		return;
	}
	$logstring = date("Y-m-d H:i")." ".$message."\n";
	fwrite($fp, $logstring);
	fclose($fp);
}

$userfileName = $_FILES['userfile']['tmp_name'];
error_log("User file is ".$userfileName);

$userfile = fopen($userfileName, "r");

if (!$userfile) {
	logMessage("Couldn't open file ".$userfileName);
	header("HTTP/1.1 401 Your file ran away and is hiding somewhere");
	fclose($userfile);
	return;
} 

$line = fgets($userfile);
$headingLine = "Application/vnd.squl1 ModuleExport size=";
if (strcmp($headingLine, substr($line, 0, 40))){
	logMessage ("Invalid file sent.");
	header("HTTP/1.1 400 I don't know what the heck that file is, but it's not squl.");
	fclose($userfile);
	return;
}

do {
	$c = fgetc($userfile);
} while ($c != false && $c !=':');

$md5 = rtrim(fgets($userfile));
if (!$md5) {
	logMessage("No content");
	header("HTTP/1.1 401 Where's the file you promised?");
	fclose($userfile);
	return;	
}
$filename = $md5.'.squl';

$newFilename = FILEPATH."/".$md5.".squl";
error_log( $newFilename );
if (file_exists($newFilename)) {
	logMessage("Idiot tried to upload the same file twice.");
	header("HTTP/1.1 401 This module has already been uploaded.");	
	return;
}
fclose($userfile);
rename($userfileName, $newFilename);
logMessage("uploaded ".$newFilename);
header("HTTP/1.1 200 Uploaded ".$newFilename);
?>
