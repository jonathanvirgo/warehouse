function ajax_call_error(jqXHR, exception){
    var msg = '';
    if (jqXHR.status === 0) {
        msg = 'Mất kết nối mạng. Vui lòng kiểm tra kết nối và thử lại.';
    } else if (jqXHR.status == 404) {
        msg = 'Không tìm thấy trang được yêu cầu. [404]';
    } else if (jqXHR.status == 500) {
        msg = 'Lỗi máy chủ nội bộ [500].';
    } else if (exception === 'parsererror') {
        msg = 'Phân tích cú pháp JSON không thành công.';
    } else if (exception === 'timeout') {
        msg = 'Lỗi hết thời gian.';
    } else if (exception === 'abort') {
        msg = 'Yêu cầu Ajax đã bị hủy bỏ.';
    } else {
        msg = jqXHR.responseText;
    }
    displayError(msg);
}

toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": false,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}

function displayMessage(message) {
    if(message != ''){
        toastr.success(message, 'Thông báo');
    }
} 

function displayError(message) {
    toastr.clear();
    if(message != ''){
        toastr.error(message, 'Thông báo');
    }
}

$(document).ready(function(){
    $('.select2').select2({
        theme: "bootstrap",
        language: {
           "noResults": function(){
               return "Không có kết quả được tìm thấy";
           }
        }
    });

    $('#report_date').flatpickr({
        dateFormat: "d-m-Y"
    });
});

function addData(type){
    //type 1 Import
    //type 2 Export
    //type 3 Pay
    let valid = validateData(type);
    if(valid){
        switch(type){
            case 1:
                addImport();
                $("#dataTable").show();
                break;
            case 2:
                addExport();
                $("#dataTable").show();
                break;
            case 3:
                addPay();
                $("#dataTable").show();
                break;
            default: break;
        }
        resetInput(type);
    }
}

function validateData(type){
    if(!$('#list_product').val() || $('#list_product').val() == 0){
        displayError("Bạn chưa chọn sản phẩm!");
        return false;
    }
    
    if(!$('#price').val() || $('#price').val() == 0){
        displayError("Bạn chưa nhập giá!");
        return false;
    }

    if(!$('#total').val() || $('#total').val() == 0){
        displayError("Bạn chưa nhập số lượng!");
        return false;
    }else{
        if(type == 3){
            let arrPro = arrData.filter(s => s.pro_id == $('#list_product').val());
            if(arrPro.length > 0){
                for(let item of arrPro){
                    totalArr += parseInt(item.total);
                }
            }
            let max = parseInt($('input[id="total"]').attr("max"));
            if(totalArr && totalArr > 0){
                max = max - totalArr;
            }
            if(max && $('#total').val() > max){
                displayError("Bạn nhập quá số lượng nhập: " + max +" !");
                return false;
            }
        }
    }
    if(type == 2){
        if(!$('#list_product option:selected').data('price') || $('#list_product option:selected').data('price') == 0){
            displayError("Sản phẩm chưa có giá nhập!");
            return false;
        }
    }
    // switch(type){
    //     case 1:
    //         break;
    //     case 2:
    //         break;
    //     case 3:
    //         break;
    //     default: break;
    // }
    return true;
}

function getData(type){
    let pro_id          = $('#list_product').val();
    let pro_name        = $('#list_product option:selected').text();
    let price           = $('#price').val();
    let total           = $('#total').val();
    let report_date     = $('#report_date').val();
    let note            = $('#note').val();
    let warehouse_id    = $('#list_warehouse').val();
    let warehouse_name  = $('#list_warehouse option:selected').text();
    let data;
    switch(type){
        case 1:
            let paied   = $('#confirm_pay').is(":checked");
            data = {"id": idArr,"pro_id": pro_id, "pro_name": pro_name, "price": price, "total": total, "paied": paied, "note": note, "report_date": report_date, "warehouse_id":warehouse_id, "warehouse_name": warehouse_name};
            break;
        case 2:
            let price_export    = $('#price').val();
            let price_import    = $('#list_product option:selected').data('price');
            let discount_percent = $('#discount_percent').val();
            let discount_number = $('#discount_number').val();
            let type_discount   = $('#list_discount').val();
            let ship            = $('#ship').val();
            let discount        = $('#discount').val() ? $('#discount').val() : 0;
            let income          = parseInt(price_export) - parseInt(discount) - parseInt(price_import);
            data = {"id": idArr,"pro_id": pro_id, "pro_name": pro_name, "price_export": price_export,"price_import": price_import, "total": total, "note": note, "report_date": report_date, "warehouse_id":warehouse_id, "warehouse_name": warehouse_name, "discount_percent": discount_percent,"discount_number": discount_number, "ship":ship,"discount":discount, "income": income < 0 ? 0 : income, "type_discount": type_discount};
            break;
        case 3:
            id_debt = $('#list_product option:selected').data("id");
            data = {"id": idArr,"pro_id": pro_id, "pro_name": pro_name, "price": price, "total": total, "note": note, "report_date": report_date, "id_debt": id_debt, "warehouse_id":warehouse_id, "warehouse_name": warehouse_name};
            break;
        default: break;
    }
    idArr += 1;
    return data;
}

function addImport(){
    let dataImport = getData(1);
    arrImport.push(dataImport);
    let html = addImportHtml(dataImport);
    $(".table-responsive").find("tbody").append(html);
}

function addExport(){
    let dataExport = getData(2);
    arrData.push(dataExport);
    let html = addExportHtml(dataExport);
    $(".table-responsive").find("tbody").append(html);
}

function addPay(){
    let dataPay = getData(3);
    arrData.push(dataPay);
    let html = addPayHtml(dataPay);
    $(".table-responsive").find("tbody").append(html);
    totalArr = 0;
}

function addImportHtml(data, id = ''){
    let div = document.createElement("tr");
    $(div).attr('id', 'tr_'+data.id);

    let td1  = document.createElement("td");
    let td2  = document.createElement("td");
    let td3  = document.createElement("td");
    let td4  = document.createElement("td");
    let td5  = document.createElement("td");
    let td6  = document.createElement("td");
    let td7  = document.createElement("td");
    let td8  = document.createElement("td");

    let span1 = document.createElement("span");
    let span2 = document.createElement("span");
    $(span1).addClass('material-icons');
    $(span2).addClass('material-icons');
    span1.dataset.id = data.id;
    span2.dataset.id = data.id;
    $(span1).text("close");
    $(span1).css({"position":'relative', "left":"15px"});
    $(span2).text("edit");
    $(span1).click(function(){
        let id = $(this).data('id');
        deleteArr(id, 1);
    });
    $(span2).click(function(){
        let id = $(this).data('id');
        editLocal(id, 1);
    });
    td8.append(span2);
    td8.append(span1);
    
    $(td1).text(data.pro_name);
    $(td2).text(data.price);
    $(td3).text(data.total);
    $(td4).text(data.paied ? 'Đã thanh toán' : 'Công nợ');
    $(td5).text(data.warehouse_name);
    $(td6).text(data.report_date);
    $(td7).text(data.note);
    if(id.length > 0){
        $(id).append(td1);
        $(id).append(td2);
        $(id).append(td3);
        $(id).append(td4);
        $(id).append(td5);
        $(id).append(td6);
        $(id).append(td7);
        $(id).append(td8);
    }else{
        $(div).append(td1);
        $(div).append(td2);
        $(div).append(td3);
        $(div).append(td4);
        $(div).append(td5);
        $(div).append(td6);
        $(div).append(td7);
        $(div).append(td8);
        return div;
    }
}

function addExportHtml(data, id = ''){
    let div   = document.createElement("tr");
    let td1  = document.createElement("td");
    let td2  = document.createElement("td");
    let td3  = document.createElement("td");
    let td4  = document.createElement("td");
    let td5  = document.createElement("td");
    let td6  = document.createElement("td");
    let td7  = document.createElement("td");
    let td8  = document.createElement("td");
    let td9  = document.createElement("td");

    let span1 = document.createElement("span");
    let span2 = document.createElement("span");
    $(span1).addClass('material-icons');
    $(span2).addClass('material-icons');
    span1.dataset.id = data.id;
    span2.dataset.id = data.id;
    $(span1).text("close");
    $(span1).css({"position":'relative', "left":"15px"});
    $(span2).text("edit");
    $(span1).click(function(){
        let id = $(this).data('id');
        deleteArr(id, 2);
    });
    $(span2).click(function(){
        let id = $(this).data('id');
        editLocal(id, 2);
    });
    td9.append(span2);
    td9.append(span1);
    $(td1).text(data.pro_name);
    $(td2).text(data.price_import);
    $(td3).text(data.price_export);
    $(td4).text(data.total);
    $(td5).text(data.warehouse_name);
    $(td6).text(data.discount);
    $(td7).text(data.note);
    $(td8).text(data.report_date);
    $(div).attr('id', 'tr_'+data.id);

    if(id.length > 0){
        $(id).append(td1);
        $(id).append(td2);
        $(id).append(td3);
        $(id).append(td4);
        $(id).append(td5);
        $(id).append(td6);
        $(id).append(td7);
        $(id).append(td8);
        $(id).append(td9);
    }else{
        div.append(td1);
        div.append(td2);
        div.append(td3);
        div.append(td4);
        div.append(td5);
        div.append(td6);
        div.append(td7);
        div.append(td8);
        div.append(td9);
    }

    return div;
}

function addPayHtml(data, id = ''){
    let div   = document.createElement("tr");
    let td1  = document.createElement("td");
    let td2  = document.createElement("td");
    let td3  = document.createElement("td");
    let td4  = document.createElement("td");
    let td5  = document.createElement("td");
    let td6  = document.createElement("td");
    let td7  = document.createElement("td");

    let span1 = document.createElement("span");
    let span2 = document.createElement("span");
    $(span1).addClass('material-icons');
    $(span2).addClass('material-icons');
    span1.dataset.id = data.id;
    span2.dataset.id = data.id;
    $(span1).text("close");
    $(span1).css({"position":'relative', "left":"15px"});
    $(span2).text("edit");
    $(span1).click(function(){
        let id = $(this).data('id');
        deleteArr(id, 3);
    });
    $(span2).click(function(){
        let id = $(this).data('id');
        editLocal(id, 3);
    });
    td7.append(span2);
    td7.append(span1);
    

    $(td1).text(data.pro_name);
    $(td2).text(data.price);
    $(td3).text(data.total);
    $(td4).text(data.warehouse_name);
    $(td5).text(data.note);
    $(td6).text(data.report_date);
    $(div).attr('id', 'tr_'+data.id);

    if(id.length > 0){
        $(id).append(td1);
        $(id).append(td2);
        $(id).append(td3);
        $(id).append(td4);
        $(id).append(td5);
        $(id).append(td6);
        $(id).append(td7);
    }else{
        div.append(td1);
        div.append(td2);
        div.append(td3);
        div.append(td4);
        div.append(td5);
        div.append(td6);
        div.append(td7);
    }
    return div;
}

function deleteArr(index, type){
    $.confirm({
        title: 'Bạn có chắc chắn muốn xóa không?',
        content: '',
        theme: 'Bootstrap',
        buttons: {
            accept:{
                text: 'Đồng ý',
                action:function () {
                    switch(type){
                        case 1:
                            for(let [i, item] of arrImport.entries()){
                                if(item.id == index){   
                                    $('#tr_'+index).remove();
                                    arrImport.splice(i, 1);
                                }
                            }
                            if(arrImport.length == 0){
                                $("#dataTable").hide();
                            }
                            break;
                        case 2:
                        case 3:
                            for(let [i, item] of arrData.entries()){
                                if(item.id == index){   
                                    $('#tr_'+index).remove();
                                    arrData.splice(i, 1);
                                }
                            }
                            if(arrData.length == 0){
                                $("#dataTable").hide();
                            }
                            break;
                        default: break;
                    }
                },
                btnClass: 'btn-success',
                keys: ['enter']
            },
            reject:{
                text: 'Không',
                btnClass: 'btn-danger',
                action:function () {
                },
                keys: ['esc']
            }
        }
    });
}

function editLocal(index, type){
    switch(type){
        case 1:
            for(let [i, item] of arrImport.entries()){
                if(item.id == index){   
                    idEdit = index;
                    setInputData(item, type);
                    break;
                }
            }
            break;
        case 2:  
        case 3:
            for(let [i, item] of arrData.entries()){
                if(item.id == index){   
                    idEdit = index;
                    setInputData(item, type);
                    break;
                }
            }
            break;
        default: break;
    }
}

function setInputData(data, type){
    $('#list_warehouse').val(data.warehouse_id).trigger('change');
    $('#list_product').val(data.pro_id).trigger('change');
    $('#price').val(data.price);
    $('#total').val(data.total);
    $('#report_date').val(data.report_date);
    $('#note').val(data.note);
    toggleBtnAdd(false);
    switch(type){
        case 1:
            $('#confirm_pay').prop('checked', data.paied);
            break;
        case 2:
            $('#price').val(data.price_export);
            $('#discount_percent').val(data.discount_percent);
            $('#discount_number').val(data.discount_number);
            $('#list_discount').val(data.type_discount).trigger('change');
            $('#ship').val(data.ship);
            $('#discount').val(data.discount);
            break;
        case 3:
            
            break;
        default: break;
    }
}

function resetInput(type){
    $('#list_product').val(0).trigger('change');
    $('#price').val("");
    $('#total').val("");
    $('#confirm_pay').prop('checked', false);
    switch(type){
        case 1:
            break;
        case 2:
            $('#list_discount').val(3).trigger('change');
            $('#discount_percent').val("");
            $('#discount_number').val("");
            $('#ship').val("");
            $('#discount').val("");
            break;
        default: break;
    }
}

function save(type, id = ''){
    let url ="";
    let data = {};
    $.confirm({
        title: 'Bạn có chắc chắn muốn lưu không?',
        content: '',
        theme: 'Bootstrap',
        buttons: {
            accept:{
                text: 'Đồng ý',
                action:function () {
                    switch(type){
                        case 1:
                            url = "/import/store";
                            data = {"arrImport" : JSON.stringify(arrImport)};
                            break;
                        case 2:
                            url = "/export/store";
                            data = {"arrExport" : JSON.stringify(arrData)};
                            break;
                        case 3:
                            url = "/pay/store";
                            data = {"arrPay" : JSON.stringify(arrData)};
                            break;
                        case 4:
                            let id = $('#list_user').val();
                            let warehouse_id = $('#list_warehouse').val();
                            let campain_id = $('#list_campain').val();
                            url = "/user/store";
                            data = {'id': id, 'warehouse_id': warehouse_id, 'campain_id': campain_id};
                            break;
                        default: break;
                    }
                    if(id){
                        data['id'] = id;
                    }
                    callAjax(url, data);
                },
                btnClass: 'btn-success',
                keys: ['enter']
            },
            reject:{
                text: 'Không',
                btnClass: 'btn-danger',
                action:function () {
                },
                keys: ['esc']
            }
        }
    });
}

function callAjax(url, data){
    let loading = $("#loading-page");
    $.ajax({
        url: url,
        data: data,
        type:'POST',
        beforeSend: function () {
          loading.show();
       },
       success: function (result) {
            loading.hide();
            if (result.status) {
                displayMessage(result.message);
                window.location.href = result.url;
            } else {
                displayError(result.message);
            }
        },
        error: function(jqXHR, exception){
            loading.hide();
            ajax_call_error(jqXHR, exception);
        }   
    });
}

function deleteTable(id, type){
    $.confirm({
        title: 'Bạn có chắc chắn muốn xoá không?',
        content: '',
        theme: 'Bootstrap',
        buttons: {
            accept:{
                text: 'Đồng ý',
                action:function () {
                    let url = "/import/delete";
                    switch(type){
                        case 2:
                            url = "/export/delete";
                            break;
                        case 3:
                            url = "/pay/delete";
                            break;
                        default: break;
                    }
                    
                    let data = {"id" : id, "type": type};
                    callAjax(url, data);
                },
                btnClass: 'btn-success',
                keys: ['enter']
            },
            reject:{
                text: 'Không',
                btnClass: 'btn-danger',
                action:function () {
                },
                keys: ['esc']
            }
        }
    });
}

function getPrice(pro_id, warehouse_id, im_export){
    let loading     = $("#loading-page");
    loading.show();
    $.get('/product/price?pro_id='+ pro_id + '&warehouse_id=' + warehouse_id + '&im_export='+ im_export, function(response){
        loading.hide();
        if(response.status){
            $('#price').val(response.price == 0 ? '' : response.price);
        }else{
            displayError(response.message);
        }
    });
}

function setPriceAttr(pro_id, warehouse_id, im_export){
    $.get('/product/price?pro_id='+ pro_id + '&warehouse_id=' + warehouse_id + '&im_export='+ im_export, function(response){
        if(response.status){
            $('#list_product option:selected').data('price', response.price);
        }else{
            displayError(response.message);
        }
    });
}

function getInventory(warehouse_id){
    let loading     = $("#loading-page");
    loading.show();
    $.get('/product/inventory?warehouse_id=' + warehouse_id, function(response){
        loading.hide();
        console.log("getPrice", response);
        if(response.status){
            if(arrProduct.length > 0){
                for(let item of arrProduct){
                    $("#list_product option[value='"+item.id+ "']").remove();
                }
            }
            
            $("#list_product").empty();
            arrProduct = response.data ? response.data : [];

            for(let item2 of arrProduct){
                let newProduct = new Option(item2.product.name + " | " + item2.price + " | " + item2.total, item2.pro_id, false, false);
                newProduct.dataset.id       = item2.id;
                newProduct.dataset.total    = item2.total;
                newProduct.dataset.price    = item2.price;
                // Append it to the select
                $('#list_product').append(newProduct);
            }
            let newProduct = new Option("Chọn sản phẩm", 0, false, false);
            $('#list_product').append(newProduct);
            $('#list_product').val(0).trigger('change');
        }else{
            displayError(response.message);
        }
    });
}

function countDiscount(){
    let discount_percent = $('#discount_percent').val();
    let discount_number = $('#discount_number').val();
    let ship            = $('#ship').val();
    let price_export    = $('#price').val();
    let discount;
    if(price_export){
        if(discount_percent){
            discount = parseFloat(discount_percent) * parseInt(price_export) / 100;
        }
        if(discount_number) discount += parseInt(discount_number);
        if(ship) discount += parseInt(ship);
    }
    $('#discount').val(discount);
}

function cancelSaveLocalData(type){
    resetInput(type);
    toggleBtnAdd(true);
}

function toggleBtnAdd(isShow){
    isShow ? $('.btn-save-local').hide() : $('.btn-save-local').show();
    isShow ? $('.btn-add-local').show() : $('.btn-add-local').hide();
}

function saveLocalData(type){
    let data = getData(type)
    switch(type){
        case 1:
            for(let [i, item] of arrImport.entries()){
                if(item.id == idEdit){   
                    item.note = data.note;
                    item.paied = data.paied;
                    item.price = data.price;
                    item.pro_id = data.pro_id;
                    item.pro_name = data.pro_name;
                    item.report_date = data.report_date;
                    item.total = data.total;
                    item.warehouse_id = data.warehouse_id;
                    item.warehouse_name = data.warehouse_name;
                    $("#tr_" + idEdit).empty();
                    addImportHtml(item, '#tr_' + idEdit);
                    idEdit = null;
                    break;
                }
            }
            break;
        case 2:
            for(let [i, item] of arrData.entries()){
                if(item.id == idEdit){   
                    item.discount           = data.discount;
                    item.discount_number    = data.discount_number;
                    item.discount_percent   = data.discount_percent;
                    item.income             = data.income;
                    item.note               = data.note;
                    item.price_export       = data.price_export;
                    item.price_import       = data.price_import;
                    item.pro_id             = data.pro_id;
                    item.pro_name           = data.pro_name;
                    item.report_date        = data.report_date;
                    item.ship               = data.ship;
                    item.total              = data.total;
                    item.type_discount      = data.type_discount;
                    item.warehouse_id       = data.warehouse_id;
                    item.warehouse_name     = data.warehouse_name;

                    $("#tr_" + idEdit).empty();
                    addExportHtml(item, '#tr_' + idEdit);
                    idEdit = null;
                    break;
                }
            }
            break;
        case 3:
            for(let [i, item] of arrData.entries()){
                if(item.id == idEdit){   
                    item.note = data.note;
                    item.price = data.price;
                    item.pro_id = data.pro_id;
                    item.pro_name = data.pro_name;
                    item.report_date = data.report_date;
                    item.total = data.total;
                    item.warehouse_id = data.warehouse_id;
                    item.warehouse_name = data.warehouse_name;
                    
                    $("#tr_" + idEdit).empty();
                    addPayHtml(item, '#tr_' + idEdit);
                    idEdit = null;
                    break;
                }
            }
            break;
        default: break;
    }
    cancelSaveLocalData(type);
}

function editTable(id, type){
    switch(type){
        case 1:
            window.location.href = "/import/edit/"+id;
            break;
        case 2:
            window.location.href = "/export/edit/"+id;
            break;
        case 3:
            window.location.href = "/pay/edit/"+id;
            break;
        default: break;
    }
}

function saveEdit(id, type){
    let data = getData(type);
    switch(type){
        case 1:
            arrImport.push(data);
            break;
        case 2:
        case 3:
            arrData.push(data);
            break;
        default: break;
    }
    save(type, id);
}

function saveProfile(){
    if(!$('#list_user').val() || $('#list_user').val() == 0){
        displayError("Bạn chưa chọn user!");
        return false;
    }
    if(!$('#list_campain').val() || $('#list_campain').val() == 0){
        displayError("Bạn chưa chọn campain!");
        return false;
    }
    save(4);
}

function exportExcel(type){
    switch(type){
        case 'debt':
            let warehouse_id    = $('#list_warehouse').val();
            let pro_id          = $('#list_product').val();
            location.href       = '/export/debt?warehouse_id='+warehouse_id+'&pro_id='+pro_id;  
            break;
        default: break;
    }
}