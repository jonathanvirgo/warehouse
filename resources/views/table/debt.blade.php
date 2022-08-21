@extends('shared.master')

@section('page') Dashboard @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Bảng công nợ</h1>
  </div>
  <div class="row mb-3">
      <div class="col-6">
          <div class="form-group">
              <label class="calendar-title mb-1"><i class="fa fa-calendar-check-o" aria-hidden="true"></i> Ngày</label>
              <input type="text" class="form-control" id="reportdate" name="reportdate" value="{{ $search->reportdate }}">
          </div>
      </div>
  </div>
  <div id="dataTable">
    <div class="table-responsive">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Sản phẩm</th>
            <th scope="col">Giá</th>
            <th scope="col">Số lượng</th>
            <th scope="col">Ngày nhập</th>
          </tr>
        </thead>
        <tbody>
          @if(!$depts->isEmpty())
            @foreach ($depts as $item)
            <tr>
              <td>{{$item['id']}}</td>
              <td>{{$item->product->name}}</td>
              <td>{{$item['price']}}</td>
              <td>{{$item['total']}}</td>
              <td>{{date('d/m/Y', strtotime($item->report_date))}}</td>
            </tr>
            @endforeach
          @endif
        </tbody>
      </table>
    </div>
  </div>
  
@stop

@section('pageJs')
  <script>
      $(function() {
        var start = '{{$fromdate}}';
        var end   = '{{$todate}}';

        function cb(start, end) {
          $('#reportdate').val(start.format('DD-MM-YYYY') + ' - ' + end.format('DD-MM-YYYY'));
        }
        $('#reportdate').daterangepicker({
          startDate: start,
          endDate: end,
          locale: {
            format: 'DD-MM-YYYY'
          },
          ranges: {
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days': [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month': [moment().startOf('month'), moment().endOf('month')],
          'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
      }, cb);
    });
  </script>
@stop