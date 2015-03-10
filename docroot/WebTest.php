<?php
class WebTest extends PHPUnit_Extensions_Selenium2TestCase
{
    /**
     * Variable to specify which browsers to run the tests on
     * @var array
     */
    public static $browsers = [
        ['browserName' => 'firefox'],
        ['browserName' => 'chrome'] 
    ];
 
    public function __construct() {
        $this->setHost('localhost');
        $this->setPort(4444);
        $this->setDesiredCapabilities([]);
    }
 
    public function setUp()
    {
        $this->setBrowserUrl('http://www.example.com/');
    }
 
    /**
     * This is just a test that will open a website in chrome and firefox
     */
    public function testOpenSite()
    {


        $this->url('/');

        $fp = fopen('/home/vagrant/drupical/docroot/screenshot.' . time() . '.png','wb');

        fwrite($fp, $this->currentScreenshot());

        fclose($fp);
                        
        $this->assertEquals('Example WWW Page', $this->title());        
    }
}