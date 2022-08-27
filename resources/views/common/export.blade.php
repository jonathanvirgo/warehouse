@extends('shared.master')

@section('page') Xuất kho @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
    <div class="container-main">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Xuất kho</h1>
        </div>
        <div class="row">
            <div class="col-12 col-sm-6 col-md-6 mb-2">
                <div class="form-group">
                    <label for="list_product" class="mb-1">Sản phẩm</label>
                    <select id="list_product" class="form-control select2">
                        <option value="0">Chọn sản phẩm</option>
                        @if (!empty($products))
                            @foreach ($products as $item)
                                <option value="{{ $item['pro_id'] }}" data-price="{{$item['price']}}" data-total="{{$item['total']}}">{{ $item->product->name. ' | ' . $item['total'] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="price" class="mb-1">Giá</label>
                    <input id="price" min="1000" type="number" class="form-control" placeholder="Giá xuất">
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
            <div class="col-12 col-sm-6 col-md-4 mb-2">
                <div class="form-group">
                    <label for="total" class="mb-1">Số lượng</label>
                    <input id="total" min="1" type="number" class="form-control" placeholder="Số lượng">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mb-2">
                <div class="form-group">
                    <label for="list_discount" class="mb-1">Loại xuất</label>
                    <select id="list_discount" class="form-control select2">
                        @if (!empty($discounts))
                            @foreach ($discounts as $item)
                                <option value="{{ $item['id'] }}" data-percent="{{$item['discount_percent']}}" data-number="{{$item['discount_number']}}" data-ship="{{$item['ship']}}" >{{ $item["name"] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mb-2">
                <div class="form-group">
                    <label for="report_date" class="mb-1">Ngày xuất</label>
                    <input type="text" class="form-control" id="report_date" value="{{$today}}">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mb-2">
                <div class="form-group">
                    <label for="discount_percent" class="mb-1">Chiếu khấu (%)</label>
                    <input id="discount_percent" min="1" type="number" class="form-control" placeholder="%" oninput="countDiscount()">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mb-2">
                <div class="form-group">
                    <label for="discount_number" class="mb-1">Chiếu khấu (đ)</label>
                    <input id="discount_number" min="1" type="number" class="form-control" placeholder="VNĐ" oninput="countDiscount()">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mb-2">
                <div class="form-group">
                    <label for="ship" class="mb-1">Ship</label>
                    <input id="ship" min="1" type="number" class="form-control" placeholder="VNĐ" oninput="countDiscount()">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="discount" class="mb-1">Tổng chiết khấu</label>
                    <input id="discount" min="1" type="number" class="form-control" placeholder="VNĐ">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-9 mb-2">
                <div class="form-group">
                    <label for="note" class="mb-1">Ghi chú</label>
                    <div class="d-flex">
                        <input type="text" class="form-control" id="note" value="">
                        <a onclick="addData(2)" class="btn btn-primary ms-1"><span class="material-symbols-outlined">add</span></a>
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
                        <th scope="col">Giá Nhập</th>
                        <th scope="col">Giá Xuất</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Kho</th>
                        <th scope="col">Chiếu khấu</th>
                        <th scope="col">Ghi chú</th>
                        <th scope="col">Ngày xuất</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
                </table>
            </div>
            <div style="margin-top: 20px;display: flex;justify-content: center;">
                <div style="display: flex; justify-content: flex-start;">
                    <button class="btn btn-primary" onclick="save(2)">Lưu</button>
                </div>
            </div>
        </div>
    </div>
@stop

@section('pageJs')
    <script>
        let arrData     = [];
        var arrProduct  = [];
        let totalArr    = 0;

        $('#list_product').on('select2:select', function (e) {
            $('input[id="total"]').attr({"max": $('#list_product option:selected').data('total')});
            let warehouse   = $('#list_warehouse').val();
            getPrice(e.params.data.id, warehouse, 'xuat');
        });

        $('#list_warehouse').on('select2:select', function (e) {
            let pro_id   = $('#list_product').val();
            getPrice(pro_id, e.params.data.id, 'xuat');
            getInventory(e.params.data.id);
            $('#price').val('');
            $('input[id="total"]').val('');
        });

        $('#list_discount').on('select2:select', function (e) {   
            let percent = $('#list_discount option:selected').data('percent');
            let number = $('#list_discount option:selected').data('number');
            $('#discount_percent').val(percent);
            $('#discount_number').val(number);
            countDiscount();
        });

        $(document).ready(function(){
            arrProduct = @json($products);
            $("#list_discount").val(3).trigger('change');
        });
    </script>
@stop