@extends('shared.master')

@section('page') Trang trống @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
    <div class="container-main">
        <div class="row">
            <div class="col-md-12 text-center" style="margin-top: 20%;">
                <h1>{{ $message }}</h1>
                <a class="btn btn-primary" href="{{ url('/') }}">Trở về Trang chủ</a>
            </div>
        </div>
    </div>
@stop

@section('pageJs')

@stop