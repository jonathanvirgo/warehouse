@extends('shared.master')

@section('page') Bảng công nợ @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
  <div class="container-main">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
      <h1 class="h2">Bảng công nợ</h1>
    </div>
    
    <form method="get" action="" id="search_form">
      <div class="row mb-3">
        <div class="col-12 col-sm-6 col-md-6 col-lg-4">
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
        <div class="col-12 col-sm-6 col-md-3 col-lg-4">
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
        <div class="col-12 col-sm-6 col-md-3 col-lg-4">
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
  @if(!$depts->isEmpty())
    <div class="table-responsive">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <th scope="col">Sản phẩm</th>
            <th scope="col">Số lượng</th>
            <th scope="col">Đơn Giá</th>
            <th scope="col">Tổng Giá</th>
          </tr>
        </thead>
        <tbody>
            <?php ?>
            @foreach ($depts as $item)
            <tr>
              <td>{{$item->product->name}}</td>
              <td>{{$item['total']}}</td>
              <td>{{number_format($item['price'])}}</td>
              <td>{{number_format($item['price'] * $item['total'])}}</td>
            </tr>
            @endforeach
            <tr>
              <th colspan="3">Tổng số</th>
              <th colspan="2">{{number_format($totalPrice)}}</th>
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
    $('#list_product').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#order_by').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#list_warehouse').on('select2:select', function (e) {
      $("#search_form").submit();
    });
  </script>
@stop