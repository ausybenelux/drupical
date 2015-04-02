<?php

    // Turn off all error reporting
    error_reporting(0);
    ini_set("display_errors", 0);

    // MySQL
    $mysqli = @new mysqli('localhost', 'root', '10moioui');
    $mysql_running = TRUE;
    if (mysqli_connect_errno()) {
      $mysql_running = FALSE;
    }
    else {
      $mysql_version = $mysqli->server_info;
    }
    $mysqli->close();

    // Memcached
    $m = @new Memcached();
    $memcached_running = FALSE;
    if ($m->addServer('localhost', 11211)) {
        $memcached_running = TRUE;
        $memcached_version = $m->getVersion();
        $memcached_version = current($memcached_version);
    }
?>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <title>drupal</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-theme.min.css" rel="stylesheet">
        <link href="css/dashboard.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
          <div class="container-fluid">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed"
                      data-toggle="collapse" data-target="#navbar" aria-expanded="false"
                      aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="#">drupal</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav navbar-right">
                <li>
                  <a href="http://info.tools.drupical.local/phpinfo.php" target="_blank">phpinfo</a>
                </li>
                    <li>
                      <a href="http://info.tools.drupical.local" target="_blank">
                        info
                      </a>
                    </li>
                    <li>
                      <a href="http://adminer.tools.drupical.local" target="_blank">
                        adminer
                      </a>
                    </li>
                    <li>
                      <a href="http://phpmemcachedadmin.tools.drupical.local" target="_blank">
                        phpmemcachedadmin
                      </a>
                    </li>
                    <li>
                      <a href="http://opcachegui.tools.drupical.local" target="_blank">
                        opcachegui
                      </a>
                    </li>
                    <li>
                      <a href="http://uprofiler.tools.drupical.local" target="_blank">
                        uprofiler_ui
                      </a>
                    </li>
                    <li>
                      <a href="http://phpdoc.tools.drupical.local" target="_blank">
                        phpdoc
                      </a>
                    </li>
                    <li>
                      <a href="http://mailcatcher.tools.drupical.local" target="_blank">
                        mailcatcher
                      </a>
                    </li>
              </ul>
            </div>
          </div>
        </nav>
        <div class="container-fluid">
          <div class="row">
            <div class="main">
              <h1 class="page-header">Vagrant box</h1>
              <div class="table-responsive">
                <div class="page-header">
                  <h1>It works!</h1>
                </div>
                <p class="lead">The Virtual Machine is up and running, yay! Here's some additional information you might need.</p>
                <h3>Aliases</h3>
                <table class="table table-striped">

                      <tr>
                        <td><a href="http://drupical.local">drupical.local</a></td>
                      </tr>

                      <tr>
                        <td><a href="http://www.drupical.local">www.drupical.local</a></td>
                      </tr>

                </table>
                <h3>Installed software</h3>
                <table class="table table-striped">
                  <tr>
                    <td>PHP Version</td>
                    <td><?php echo phpversion(); ?></td>
                  </tr>
                  <tr>
                    <td>MySQL running</td>
                    <td><i class="fa <?php echo($mysql_running ? 'fa-check' : 'fa-close'); ?>"></i>
                    </td>
                  </tr>
                  <tr>
                    <td>MySQL version</td>
                    <td><?php echo($mysql_running ? $mysql_version : 'N/A'); ?></td>
                  </tr>
                  <tr>
                    <td>Memcache running</td>
                    <td><i class="fa <?php echo($memcached_running ? 'fa-check' : 'fa-close'); ?>"></i></td>
                  </tr>
                </table>
                <h3>PHP Modules</h3>
                <table class="table table-striped">
                      <tr>
                        <td>php-apc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-auth</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-auth-http</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-auth-sasl</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-benchmark</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-cache</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-cache-lite</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-codesniffer</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-compat</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-config</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-console-table</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-crypt-blowfish</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-crypt-cbc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-crypt-gpg</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-date</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-db</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-doc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-elisp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-event-dispatcher</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-file</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-fpdf</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-geshi</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-getid3</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-gettext</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-html-common</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-html-safe</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-html-template-it</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-htmlpurifier</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-http</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-http-request</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-http-upload</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-http-webdav-server</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-image-text</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-imlib</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-kolab-filter</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-kolab-freebusy</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-letodms-core</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-letodms-lucene</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-log</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mail</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mail-mime</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mail-mimedecode</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mdb2</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mdb2-driver-mysql</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mdb2-driver-pgsql</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mdb2-driver-sqlite</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-mime-type</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-checkip</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-dime</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-dnsbl</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-ftp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-imap</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-ipv4</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-ipv6</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-ldap</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-ldap2</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-lmtp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-nntp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-ping</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-portscan</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-sieve</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-smartirc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-smtp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-socket</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-url</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-net-whois</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-numbers-words</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-openid</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-pager</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-pear</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-radius-legacy</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-services-json</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-services-weather</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-soap</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-text-captcha</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-text-figlet</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-text-password</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-text-wiki</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-wikidiff2</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xajax</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xml-htmlsax3</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xml-parser</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xml-rpc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xml-rpc2</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xml-rss</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-xml-serializer</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php-zeroc-ice</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-adodb</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-apcu</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-auth-pam</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-curl</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-dbg</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-dev</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-enchant</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-exactimage</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-ffmpeg</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-gd</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-gearman</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-geoip</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-gmp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-imagick</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-imap</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-interbase</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-intl</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-json</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-lasso</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-ldap</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-librdf</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-libvirt-php</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-mapscript</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-mcrypt</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-memcache</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-memcached</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-midgard2</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-ming</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-mongo</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-mysql</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-mysqlnd</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-mysqlnd-ms</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-oauth</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-odbc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-pgsql</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-ps</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-pspell</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-radius</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-readline</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-recode</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-redis</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-remctl</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-rrd</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-sasl</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-snmp</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-sqlite</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-svn</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-sybase</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-tidy</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-tokyo-tyrant</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-uprofiler</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-uuid</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-xcache</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-xdebug</td>
                            <td><i class="fa fa-check"></i></td>
                      </tr>
                      <tr>
                        <td>php5-xmlrpc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-xsl</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>php5-zmq</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>phpsysinfo</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>phpunit</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                      <tr>
                        <td>phpunit-doc</td>
                            <td><i class="fa fa-close"></i></td>
                      </tr>
                </table>
                <h3>MySQL credentials</h3>
                <table class="table table-striped">
                  <tr>
                    <td>Hostname</td>
                    <td>localhost</td>
                  </tr>
                  <tr>
                    <td>Username</td>
                    <td>root</td>
                  </tr>
                  <tr>
                    <td>Password</td>
                    <td>10moioui</td>
                  </tr>
                </table>
              </div>
            </div>
          </div>
        </div>
    </body>
</html>