<?php

// Turn off all error reporting
error_reporting(0);
ini_set("display_errors", 0);

$_GET['username'] = "root";

function adminer_object() {
  class AdminerSoftware extends Adminer {
    function credentials() {
      return array(
        'localhost',
        'root',
        '10moioui'
      );
    }
  }
  return new AdminerSoftware;
}

include 'adminer.php';