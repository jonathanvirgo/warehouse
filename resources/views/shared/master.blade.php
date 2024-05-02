<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('page')</title>

    <link rel="apple-touch-icon" sizes="57x57" href="/images/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="/images/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/images/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/images/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/images/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/images/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/images/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/images/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="/images/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="/images/favicon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/images/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="/images/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/images/favicon/favicon-16x16.png">
    <link rel="manifest" href="/images/favicon/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/images/favicon/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link type="text/css" rel="stylesheet" href="/css/dashboard.css"/>
    <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/select2.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/toastr.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/jquery-confirm.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/select2-bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/flatpickr.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/daterangepicker.css"/>
    <link type="text/css" rel="stylesheet" href="/css/style.css"/>


    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="/js/popper.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/select2.min.js"></script>
    <script type="text/javascript" src="/js/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="/js/toastr.min.js"></script>
    <script type="text/javascript" src="/js/moment.min.js"></script>
    <script type="text/javascript" src="/js/daterangepicker.min.js"></script>
    <script type="text/javascript" src="/js/flatpickr.js"></script>
    <script type="text/javascript" src="/js/custom.js?v=1.0.0.0"></script>
    
    @section('pageCss')
    @show
</head>
<body>
    @if (Auth::check())
        @include('shared.menu')
        <div class="container-fluid" style="margin-top: 50px">
            <div class="row">
                @include('shared.menu-left')
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    @yield('content')
                    @include('shared.footer')
                </main>
            </div>
        </div>
    @else
        @yield('content')
    @endif
    
    @section('pageJs')
    <script>

    </script>
    @show
</body>
</html>