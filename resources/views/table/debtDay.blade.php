@extends('shared.master')

@section('page') Bảng công nợ @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
  <div class="container-main">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
      <h1 class="h2">Bảng công nợ theo ngày</h1>
      <!-- <a onclick="exportExcel('debtDay')" class="btn btn-outline-dark">Xuất Excel</a> -->
    </div>
    
    <form method="get" action="" id="search_form">
      <div class="row mb-3">
        <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-2">
            <div class="form-group">
                <label for="report_date" class="mb-1">Ngày</label>
                <input type="text" class="form-control" id="report_date" value="{{$search->day}}" name="day">
            </div>
        </div>
        <div class="col-12 col-sm-6 col-md-3 col-lg-3">
          <div class="form-group">
            <label class="mb-1"><i class="fa fa-university" aria-hidden="true"></i> Kho</label>
            <select id="list_warehouse" class="form-control select2" name="warehouse_id">
            @if (!empty($warehouses))
                @foreach ($warehouses as $item)
                  <?php $selected_warehouse = $item['id'] == $search->warehouse_id ? 'selected="selected"' : ''; ?>
                    <option {{$selected_warehouse}} value="{{ $item['id'] }}" >{{ $item["name"] }}</option>
                @endforeach
            @endif
            </select>
          </div>
        </div>
      </div>
    </form>
  @if(!empty($data))
    <div class="table-responsive">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <th scope="col">Sản phẩm</th>
            <th scope="col">Đơn Giá</th>
            <th scope="col">SL Nhập</th>
            <th scope="col">Đã TT</th>
            <th scope="col">Chưa TT</th>
            <th scope="col">Công nợ</th>
          </tr>
        </thead>
        <tbody>
            <?php ?>
            @foreach ($data as $item)
            <tr>
              <td>{{$item->name}}</td>
              <td>{{number_format($item->price)}}</td>
              <td>{{number_format($item->total_import)}}</td>
              <td>{{number_format(empty($item->total_pay) ? 0 : $item->total_pay)}}</td>
              <td>{{number_format($item->total_import - (empty($item->total_pay) ? 0 : $item->total_pay))}}</td>
              <td>{{number_format($item->price * ($item->total_import - (empty($item->total_pay) ? 0 : $item->total_pay)))}}</td>
            </tr>
            @endforeach
            <tr>
              <th colspan="5">Tổng công nợ</th>
              <th colspan="1">{{number_format($totalImports - $totalPay)}}</th>
            </tr>
        </tbody>
      </table>
    </div>
    @else
      <p>Không có dữ liệu</p>
    @endif
  </div>
@stop

@section('pageJs')
  <script>
    $('#list_warehouse').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#report_date').change(function(e){
      $("#search_form").submit();
    });
  </script>
@stop