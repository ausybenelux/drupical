<?php

    // Turn off all error reporting
    error_reporting(0);
    ini_set("display_errors", 0);

    ob_start();
    phpinfo();
    $phpinfo = ob_get_contents();
    ob_end_clean();

    preg_match('%<style type="text/css">(.*?)</style>.*?(<body>.*</body>)%s', $phpinfo, $matches

    $matches[2] = str_replace('<table>', '<table class="table table-bordered">', $matches[2]);
    $matches[2] = str_replace('<h1>', '<h1 class="page-header">', $matches[2]);
    $matches[2] = str_replace('<h2>', '<h2 class="sub-header">', $matches[2]);

    $doc = new DOMDocument();
    $doc->loadHTML($matches[2]);

    $nodeList = $doc->getElementsByTagName('h2');

?>

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <title>drupicaldev</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap-theme.min.css" rel="stylesheet">
        <link href="css/dashboard.min.css" rel="stylesheet">
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
                    <a class="navbar-brand" href="#">drupicaldev</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="http://info.dev.drupicaldev.local/phpinfo.php" target="_blank">phpinfo</a>
                        </li>
                        <li>
                            <a href="http://info.dev.drupicaldev.local" target="_blank">
                                info
                            </a>
                        </li>
                        <li>
                            <a href="http://adminer.dev.drupicaldev.local" target="_blank">
                                adminer
                            </a>
                        </li>
                        <li>
                            <a href="http://phpmemcachedadmin.dev.drupicaldev.local" target="_blank">
                                phpmemcachedadmin
                            </a>
                        </li>
                        <li>
                            <a href="http://opcachegui.dev.drupicaldev.local" target="_blank">
                                opcachegui
                            </a>
                        </li>
                        <li>
                            <a href="http://uprofiler.dev.drupicaldev.local" target="_blank">
                                uprofiler_ui
                            </a>
                        </li>
                        <li>
                            <a href="http://phpdoc.dev.drupicaldev.local" target="_blank">
                                phpdoc
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    <ul class="nav nav-sidebar">
                    <?php
                    foreach ($nodeList as $node) {
                    echo '<li><a href="#module_' . $node->nodeValue . '">' . $node->nodeValue . '</a></li>';
                    }
                    ?>
                    </ul>
                </div>
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <h1 class="page-header">phpinfo</h1>
                    <div class="table-responsive">
                        <?php print $matches[2]; ?>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
