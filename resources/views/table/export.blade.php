@extends('shared.master')

@section('page') Bảng xuất kho @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
<div class="container-main">
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Dashboard</h1>
  </div>

  <form method="get" action="" id="search_form">
    <div class="row mb-3">
      <div class="col-12 col-sm-6 col-md-6 col-lg-3">
          <div class="form-group">
              <label class=" mb-1"><i class="fa fa-calendar-check-o" aria-hidden="true"></i> Ngày</label>
              <input type="text" class="form-control" id="reportdate" name="reportdate" value="{{ $search->reportdate }}">
          </div>
      </div>
      <div class="col-12 col-sm-6 col-md-6 col-lg-3">
          <div class="form-group">
              <label class="mb-1"> <i class="fa fa-address-book-o" aria-hidden="true"></i> Tên sản phẩm</label>
              <select id="list_product" class="form-control select2" name="pro_id">
                  <option value="0">Tất cả sản phẩm</option>
                  @if (!empty($products))
                      @foreach ($products as $item)
                          <?php $selected_pro = $item['pro_id'] == $search->pro_id ? 'selected="selected"' : ''; ?>
                          <option {{$selected_pro}} value="{{ $item['pro_id'] }}">{{ $item->product->name }}</option>
                      @endforeach
                  @endif
              </select>
          </div>
      </div>
      <div class="col-12 col-sm-6 col-md-6 col-lg-2">
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
      <div class="col-12 col-sm-6 col-md-6 col-lg-2">
        <div class="form-group">
          <label class="mb-1"><i class="fa fa-university" aria-hidden="true"></i> Loại</label>
          <select id="list_discount" class="form-control select2" name="type_discount">
          @if (!empty($discounts))
              @foreach ($discounts as $item)
                <?php $selected_discount = $item['id'] == $search->type_discount ? 'selected="selected"' : ''; ?>
                  <option {{$selected_discount}} value="{{ $item['id'] }}" >{{ $item["name"] }}</option>
              @endforeach
          @endif
          </select>
        </div>
      </div>
      <div class="col-12 col-sm-6 col-md-6 col-lg-2">
        <div class="form-group">
          <label class="mb-1"><i class="fa fa-sort" aria-hidden="true"></i> Sắp xếp</label>
          <select id="order_by" class="form-control select2" name="order_by">
            @foreach ($orders_by as $item)
            <?php $selected = $item['id'] == $search->order_by ? 'selected="selected"' : ''; ?>
            <option {{$selected}} value="{{ $item['id'] }}">{{ $item["name"] }}</option>
            @endforeach
          </select>
        </div>
      </div>
    </div>
  </form>
  @if(!$exports->isEmpty())
  <div class="table-responsive">
    <table class="table table-striped table-sm">
      <thead>
        <tr>
          <th scope="col">Sản phẩm</th>
          <th scope="col">Số lượng</th>
          @if(in_array(Auth::user()->role_id, [1,2]))
          <th scope="col">Giá nhập</th>
          @endif
          <th scope="col">Giá xuất</th>
          <th scope="col">Chiếu khấu</th>
          <th scope="col">Tổng chiếu khấu</th>
          @if(in_array(Auth::user()->role_id, [1,2]))
          <th scope="col">Doanh thu</th>
          <th scope="col">Tổng doanh thu</th>
          @endif
          <th scope="col">Ghi chú</th>
          <th scope="col">Ngày nhập</th>
          @if(Auth::user()->role_id == 1 || Auth::user()->role_id == 2)
          <th scope="col"></th>
          @endif
        </tr>
      </thead>
      <tbody>
        @foreach ($exports as $item)
          <tr>
            <td>{{$item->product->name}}</td>
            <td>{{$item['total']}}</td>
            @if(in_array(Auth::user()->role_id, [1,2]))
            <td>{{number_format($item['price_import'])}}</td>
            @endif
            <td>{{number_format($item['price_export'])}}</td>
            <td>{{number_format($item['discount'])}}</td>
            <td>{{number_format($item['discount'] * $item['total'])}}</td>
            @if(in_array(Auth::user()->role_id, [1,2]))
            <td>{{number_format($item['income'])}}</td>
            <td>{{number_format($item['income'] * $item['total'])}}</td>
            @endif
            <td>{{$item['note']}}</td>
            <td>{{date('d/m/Y', strtotime($item->report_date))}}</td>
            @if(Auth::user()->role_id == 1 || Auth::user()->role_id == 2)
            <td>
              <div class="d-flex" style="color:#000; cursor:pointer">
                <a onclick="deleteTable('{{$item->id}}', 2)"><span class="material-icons">close</span></a>
                <a onclick="editTable('{{$item->id}}', 2)"><span class="material-icons">edit</span></a>
              </div>
            </td>
            @endif
          </tr>
          @endforeach
          <tr>
            @if(in_array(Auth::user()->role_id, [1,2]))
            <th colspan="5">Tổng số</th>
            <th colspan="2">{{number_format($totalDiscount)}}</th>
            @else
            <th colspan="4">Tổng số</th>
            <th colspan="3">{{number_format($totalDiscount)}}</th>3
            @endif
            @if(in_array(Auth::user()->role_id, [1,2]))
            <th colspan="4">{{number_format($totalIncome)}}</th>
            @endif
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

    $('#reportdate').on('apply.daterangepicker', function(ev, picker) {
      $("#search_form").submit();
    });

    $('#list_product').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#order_by').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#list_warehouse').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#list_discount').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $(document).ready(function(){
      @if(Auth::user()->role_id == 5)
        $('#list_warehouse').prop("disabled", true);
        $('#list_discount').prop("disabled", true);
      @endif
    });
</script>
@stop