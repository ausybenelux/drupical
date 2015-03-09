<?php

// To see this example, you need to have PHPUnit library.
error_reporting(E_ALL|E_STRICT);

require_once 'Testing/Selenium.php';
require_once 'PHPUnit2/Framework/TestCase.php';

class test extends PHPUnit2_Framework_TestCase
{
    function __construct($name)
    {
        parent::__construct($name);
    }
    function setUp()
    {
        $this->selenium = new Testing_Selenium(
        	"*chrome", 
        	"http://pear.php.net/",
			'localhost',
			5555
        );
        $result = $this->selenium->start();
    }
    function tearDown()
    {
        $this->selenium->stop();
    }
    function testPEARSearch()
    {
        $this->selenium->open("http://pear.php.net/packages.php");
        $this->captureScreenshot("/home/vagrant/drupical/docroot/test.png");
        $this->assertEquals("PEAR :: Package Browser :: Top Level", $this->selenium->getTitle());
    }
}