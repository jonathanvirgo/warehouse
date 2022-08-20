<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="/css/dashboard.css"/>
    <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/select2.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/toastr.min.css"/>
    <link type="text/css" rel="stylesheet" href="/css/jquery-confirm.min.css"/>

    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="/js/popper.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/select2.min.js"></script>
    <script type="text/javascript" src="/js/jquery-confirm.min.js"></script>
    <script type="text/javascript" src="/js/toastr.min.js"></script>

    @section('pageCss')
    @show
</head>
<body>
    @include('shared.menu')
    @yield('content')
    @include('shared.footer')
    @section('pageJs')
    @show
</body>
</html>