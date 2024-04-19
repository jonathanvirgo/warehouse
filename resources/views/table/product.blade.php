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
  <form method="get" action="" id="search_form">
    <div class="row mb-3">
      <div class="col-12 col-sm-6 col-md-6 col-lg-4">
          <div class="form-group">
              <label class="mb-1"> <i class="fa fa-address-book-o" aria-hidden="true"></i> Tên sản phẩm</label>
              <select id="list_product" class="form-control select2" name="pro_id">
                  <option value="0">Tất cả sản phẩm</option>
                  @if (!empty($productSearch))
                      @foreach ($productSearch as $item)
                          <?php $selected_pro = $item['id'] == $search->pro_id ? 'selected="selected"' : ''; ?>
                          <option {{$selected_pro}} value="{{ $item['id'] }}">{{ $item['name'] }}</option>
                      @endforeach
                  @endif
              </select>
          </div>
      </div>
      <div class="col-12 col-sm-6 col-md-6 col-lg-4">
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
  @if(!$products->isEmpty())
    <div class="table-responsive">
      <table class="table table-striped table-sm">
        <thead>
          <tr>
            <th scope="col">Sản phẩm</th>
            <th scope="col">Hãng</th>
          </tr>
        </thead>
        <tbody>
          
            @foreach ($products as $item)
            <tr>
              <td name="{{$item['id']}}">{{$item['name']}}</td>
              <td>{{$item->brand->name}}</td>
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
<script>
  $('#list_product').on('select2:select', function (e) {
      $("#search_form").submit();
    });

    $('#order_by').on('select2:select', function (e) {
      $("#search_form").submit();
    });
</script>
@stop