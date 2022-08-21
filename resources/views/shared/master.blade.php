<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
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
    <script type="text/javascript" src="/js/custom.js"></script>
    
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
        $('#navbarCollapse > .nav-item .nav-link').click(function(e) {
            var $this = $(this);
            $this.parent().siblings().removeClass('active').end().addClass('active');
            e.preventDefault();
        });
    </script>
    @show
</body>
</html>