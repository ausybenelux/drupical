<?php

class WebTest extends PHPUnit_Extensions_SeleniumTestCase
{

    protected $captureScreenshotOnFailure = TRUE;
    protected $screenshotPath = '/home/vagrant/drupical/docroot';
    protected $screenshotUrl = 'http://localhost';

    protected function setUp()
    {
        $this->setBrowser('chrome');
        $this->setBrowserUrl('http://www.example.com/');
        $this->setPort(5555);
    }

    public function testTitle()
    {
        $this->open('http://www.example.com/');
        $this->assertTitle('Example WWW Page');
    }
}