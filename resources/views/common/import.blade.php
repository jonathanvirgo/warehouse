@extends('shared.master')

@section('page') Nhập kho @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
    <div class="container-main">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Nhập kho</h1>
        </div>
        <div class="row">
            <div class="col-12 col-sm-6 col-md-6 mb-2">
                <div class="form-group">
                    <label for="list_product" class="mb-1">Sản phẩm</label>
                    <select id="list_product" class="form-control select2">
                        <option value="0">Chọn sản phẩm</option>
                        @if (!empty($products))
                            @foreach ($products as $item)
                                <?php $product_selected = (isset($import['pro_id']) && $item['id'] == $import['pro_id']) ? 'selected' : ''; ?>
                                <option {{$product_selected}} value="{{ $item['id'] }}">{{ $item["name"] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="price" class="mb-1">Giá</label>
                    <input id="price" min="1000" type="number" class="form-control" placeholder="Giá nhập" value="<?php echo !empty($import['price']) ? $import['price'] : '';?>" readonly>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="list_warehouse" class="mb-1">Loại kho</label>
                    <select id="list_warehouse" class="form-control select2">
                        @if (!empty($warehouses))
                            @foreach ($warehouses as $item)
                                <?php $warehouse_selected = (isset($import['warehouse_id']) && $item['id'] == $import['warehouse_id']) ? 'selected' : ''; ?>
                                <option {{$warehouse_selected}} value="{{ $item['id'] }}" >{{ $item["name"] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 mb-2">
                <div class="form-group">
                    <label for="total" class="mb-1">Số lượng</label>
                    <input id="total" min="1" type="number" class="form-control" placeholder="Số lượng" value="<?php echo !empty($import['total']) ? $import['total'] : '';?>">
                </div>
            </div>
            <div class="col-12 col-sm-6 mb-2">
                <div class="form-group">
                    <label for="report_date" class="mb-1">Ngày nhập</label>
                    <input type="text" class="form-control" id="report_date" value="{{isset($import['report_date']) ? date('d-m-Y', strtotime($import['report_date'])) : $today}}">
                </div>
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-8 mb-2">
                <div class="form-group">
                    <label for="note" class="mb-1">Ghi chú</label>
                    <input type="text" class="form-control" id="note" value="<?php echo !empty($import['note']) ? $import['note'] : '';?>">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-4 mb-2">
                <div class="form-group pt-4">
                    <input class="form-check-input" style="margin-top: 12px" type="checkbox" value="" id="confirm_pay">
                    <label class="form-check-label" for="confirm_pay">Đã thanh toán</label>
                    @if(isset($import['id']))
                        <a onclick="saveEdit('{{$import['id']}}',1)" title="Lưu" class="btn btn-primary btn-add-local ms-5"><span class="material-symbols-outlined">save</span></a>
                    @else
                        <a onclick="addData(1)" title="Thêm nhập kho" class="btn btn-primary btn-add-local ms-5"><span class="material-symbols-outlined">add</span></a>
                        <a onclick="saveLocalData(1)" title="Lưu nhập kho" class="btn btn-primary btn-save-local ms-3" style="display: none"><span class="material-symbols-outlined">save</span></a>
                        <a onclick="cancelSaveLocalData(1)" title="Huỷ" class="btn btn-primary btn-save-local ms-1" style="display: none"><span class="material-symbols-outlined">close</span></a>
                    @endif
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
                        <th scope="col">Thanh toán</th>
                        <th scope="col">Kho</th>
                        <th scope="col">Ghi chú</th>
                        <th scope="col">Ngày nhập</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
                </table>
            </div>
            <div style="margin-top: 20px;display: flex;justify-content: center;">
                <div style="display: flex; justify-content: flex-start;">
                    <button class="btn btn-primary" onclick="save(1)">Lưu</button>
                </div>
            </div>
        </div>
    </div>
@stop

@section('pageJs')
<script>
    let arrImport = [];
    let totalArr = 0;
    let idEdit;
    let idArr       = 0;
    
    $('#list_product').on('select2:select', function (e) {
        let warehouse   = $('#list_warehouse').val();
        getPrice(e.params.data.id, warehouse, 'nhap');
    });

    $('#list_warehouse').on('select2:select', function (e) {
        let pro_id   = $('#list_product').val();
        getPrice(pro_id, e.params.data.id, 'nhap');
    });
</script>
@stop