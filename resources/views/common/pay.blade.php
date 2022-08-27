@extends('shared.master')

@section('page') Thanh toán @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
    <div class="container-main">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Thanh toán</h1>
        </div>
        <div class="row">
            <div class="col-12 col-sm-6 col-md-6 mb-2">
                <div class="form-group">
                    <label for="list_product" class="mb-1">Sản phẩm</label>
                    <select id="list_product" class="form-control select2">
                        <option value="0">Chọn sản phẩm</option>
                        @if (!empty($products))
                            @foreach ($products as $item)
                                <option value="{{ $item['pro_id'] }}" data-id="{{$item['id']}}" data-price="{{$item['price']}}" data-total="{{$item['total']}}">{{ $item->product->name. ' | '. $item['price'] . ' | ' . $item['total'] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="price" class="mb-1">Giá</label>
                    <input id="price" type="number" class="form-control" placeholder="Giá nhập">
                </div>
            </div>

            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="list_warehouse" class="mb-1">Loại kho</label>
                    <select id="list_warehouse" class="form-control select2">
                        @if (!empty($warehouses))
                            @foreach ($warehouses as $item)
                                <option value="{{ $item['id'] }}" >{{ $item["name"] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>
            
            <div class="col-12 col-sm-6 mb-2">
                <div class="form-group">
                    <label for="total" class="mb-1">Số lượng</label>
                    <input id="total" type="number" class="form-control" placeholder="Số lượng">
                </div>
            </div>
            <div class="col-12 col-sm-6 mb-2">
                <div class="form-group">
                    <label for="report_date" class="mb-1">Ngày thanh toán</label>
                    <input type="text" class="form-control" id="report_date" value="{{$today}}">
                </div>
            </div>
            <div class="col-12 mb-2">
                <div class="form-group">
                    <label for="note" class="mb-1">Ghi chú</label>
                    <div class="d-flex">
                        <input type="text" class="form-control" id="note" value="">
                        <a onclick="addData(3)" class="btn btn-primary ms-1"><span class="material-symbols-outlined">add</span></a>
                    </div>
                </div>
            </div>
        </div>
        <div id="dataTable">
            <h2>Dữ liệu</h2>
            <div class="table-responsive">
                <table class="table table-striped table-sm">
                <thead>
                    <tr>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Kho</th>
                        <th scope="col">Ghi chú</th>
                        <th scope="col">Ngày thanh toán</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
                </table>
            </div>
            <div style="margin-top: 20px;display: flex;justify-content: center;">
                <div style="display: flex; justify-content: flex-start;">
                    <button class="btn btn-primary" onclick="save(3)">Lưu</button>
                </div>
            </div>
        </div>
    </div>
@stop

@section('pageJs')
    <script>
        let id_debt     = 0;
        var arrProduct  = [];
        let arrData      = [];
        let totalArr    = 0;
        $('#list_product').on('select2:select', function (e) {
            let price = $('#list_product option:selected').data('price');
            $('#price').val(price);
            $('input[id="total"]').attr({"max": $('#list_product option:selected').data('total')});
            id_debt = $('#list_product option:selected').data('id');
        });

        $('#list_warehouse').on('select2:select', function (e) {
            // let pro_id   = $('#list_product').val();
            // getPrice(pro_id, e.params.data.id, 1);
            getInventory(e.params.data.id);
            $('#price').val('');
            $('input[id="total"]').val('');
        });

        $(document).ready(function(){
            arrProduct = @json($products);
        });
    </script>
@stop