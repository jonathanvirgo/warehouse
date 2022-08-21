@extends('shared.master')

@section('page') Dashboard @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Dashboard</h1>
  </div>
  <div id="dataTable">
    <div class="table-responsive">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Header</th>
            <th scope="col">Header</th>
            <th scope="col">Header</th>
            <th scope="col">Header</th>
          </tr>
        </thead>
        <tbody>
          @if(!$pays->isEmpty())
            @foreach ($pays as $item)
            <tr>
              <td>{{$item['id']}}</td>
              <td>{{$item->product->name}}</td>
              <td>{{$item['price']}}</td>
              <td>{{$item['total']}}</td>
              <td>{{date('d/m/Y', strtotime($item->report_date))}}</td>
              <td>{{$item['note']}}</td>
            </tr>
            @endforeach
          @endif
        </tbody>
      </table>
    </div>
  </div>
  
@stop

@section('pageJs')

@stop