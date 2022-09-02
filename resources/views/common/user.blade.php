@extends('shared.master')

@section('page') Profile @stop

@section('canonical'){{ URL::current() }}@stop

@section('alternate'){{ URL::current() }}@stop

@section('pageCss')

@stop

@section('content')
    <div class="container-main">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">Profile</h1>
        </div>
        <div class="row">
            <div class="col-12 col-sm-6 col-md-6 mb-2">
                <div class="form-group">
                    <label for="list_user" class="mb-1">User</label>
                    <select id="list_user" class="form-control select2">
                        <option value="0">Chọn user</option>
                        @if (!empty($users))
                            @foreach ($users as $item)
                                <?php $user_selected = (isset($user['id']) && $item['id'] == $user['id']) ? 'selected' : ''; ?>
                                <option {{$user_selected}} value="{{ $item['id'] }}" data-role="{{$item['role_id']}}" data-warehouse="{{$item['warehouse_id']}}" data-campain="{{$item['campain_id']}}">{{ $item['name']}}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-3 mb-2" id="warehouse_container" style="display:none">
                <div class="form-group">
                    <label for="list_warehouse" class="mb-1">Loại kho</label>
                    <select id="list_warehouse" class="form-control select2">
                        @if (!empty($warehouses))
                            @foreach ($warehouses as $item)
                                <?php $warehouse_selected = (isset($user['warehouse_id']) && $item['id'] == $user['warehouse_id']) ? 'selected' : ''; ?>
                                <option {{$warehouse_selected}} value="{{ $item['id'] }}" >{{ $item["name"] }}</option>
                            @endforeach
                        @endif
                    </select>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-md-3 mb-2">
                <div class="form-group">
                    <label for="list_campain" class="mb-1">Campain</label>
                        <select id="list_campain" class="form-control select2">
                            <option value="0">Chọn campain</option>
                            @if (!empty($campains))
                                @foreach ($campains as $item)
                                    <option value="{{ $item['id'] }}">{{ $item["name"] }}</option>
                                @endforeach
                            @endif
                        </select>
                        
                    </div>
                </div>
            </div>
            <div class="col-12" style="text-align: center;">
                <a onclick="saveProfile()" title="Lưu" class="btn btn-primary ms-3"><span class="material-symbols-outlined">save</span></a>
            </div>
        </div>
    </div>
@stop

@section('pageJs')
<script>
    $('#list_user').on('select2:select', function (e) {
        let campain = $('#list_user option:selected').data('campain');
        if(campain){
            $('#list_campain').val(campain).trigger('change');
        }
        let role    = $('#list_user option:selected').data('role');
        if(role == 4){
            $('#warehouse_container').show();
            let warehouse = $('#list_user option:selected').data('warehouse');
            $('#list_warehouse').val(warehouse).trigger('change');
        }else{
            $('#warehouse_container').hide();
        }
    });
</script>
@stop