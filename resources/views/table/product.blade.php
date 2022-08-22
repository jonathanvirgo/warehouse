@extends('shared.master')

@section('page') Bảng nhập kho @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
<div class="container-main">
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Danh sách sản phẩm</h1>
  </div>
  @if(!$products->isEmpty())
    <div class="table-responsive">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <th scope="col">Sản phẩm</th>
            <th scope="col">Số lượng</th>
            <th scope="col">Giá nhập</th>
            <th scope="col">Loại</th>
          </tr>
        </thead>
        <tbody>
          
            @foreach ($products as $item)
            <tr>
              <td>{{$item['name']}}</td>
              <td>{{$item['total']}}</td>
              <td>{{number_format($item['price_import'])}}</td>
              <td>{{$item->type->name}}</td>
            </tr>
            @endforeach
          
        </tbody>
      </table>
    </div>
  @else
    <p>Không có dữ liệu</p>
  @endif
</div>
@stop

@section('pageJs')
@stop