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

function addImport(){
    let pro_id          = $('#list_product').val();
    let pro_name        = $('#list_product option:selected').text();
    let price_import    = $('#price_import').val();
    let total           = $('#total').val();
    let paied           = $('#confirm_pay').is(":checked");
    let report_date     = $('#report_date').val();
    let note            = $('#note').val();
    let dataImport = {"id": arrImport.length,"pro_id": pro_id, "pro_name": pro_name, "price_import": price_import, "total": total, "paied": paied, "note": note, "report_date": report_date};
    arrImport.push(dataImport);
    let html = addImportHtml(dataImport);
    $(".table-responsive").find("tbody").append(html);
}

function addPay(){
    let pro_id          = $('#list_product').val();
    let pro_name        = $('#list_product option:selected').text();
    let price           = $('#price').val();
    let total           = $('#total').val();
    let report_date     = $('#report_date').val();
    let note            = $('#note').val();
    let dataPay = {"id": arrPay.length,"pro_id": pro_id, "pro_name": pro_name, "price": price, "total": total, "note": note, "report_date": report_date, "id_debt": id_debt};
    arrPay.push(dataPay);
    let html = addPayHtml(dataPay);
    $(".table-responsive").find("tbody").append(html);
    console.log("arrPay", arrPay);
}

function addImportHtml(dataImport){
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
    span1.dataset.id = dataImport.id;
    span2.dataset.id = dataImport.id;
    $(span1).text("close");
    $(span1).css({"position":'relative', "left":"15px"});
    $(span2).text("edit");
    $(span1).click(function(){
        let id = $(this).data('id');
        deleteArr(id, 1);
    });
    td7.append(span2);
    td7.append(span1);
    

    $(td1).text(dataImport.pro_name);
    $(td2).text(dataImport.price_import);
    $(td3).text(dataImport.total);
    $(td4).text(dataImport.paied);
    $(td5).text(dataImport.report_date);
    $(td6).text(dataImport.note);
    $(div).attr('id', 'tr_'+dataImport.id);
    div.append(td1);
    div.append(td2);
    div.append(td3);
    div.append(td4);
    div.append(td5);
    div.append(td6);
    div.append(td7);
    return div;
}

function addPayHtml(dataImport){
    let div   = document.createElement("tr");
    let td1  = document.createElement("td");
    let td2  = document.createElement("td");
    let td3  = document.createElement("td");
    let td4  = document.createElement("td");
    let td5  = document.createElement("td");
    let td6  = document.createElement("td");

    let span1 = document.createElement("span");
    let span2 = document.createElement("span");
    $(span1).addClass('material-icons');
    $(span2).addClass('material-icons');
    span1.dataset.id = dataImport.id;
    span2.dataset.id = dataImport.id;
    $(span1).text("close");
    $(span1).css({"position":'relative', "left":"15px"});
    $(span2).text("edit");
    $(span1).click(function(){
        let id = $(this).data('id');
        deleteArr(id, 1);
    });
    td6.append(span2);
    td6.append(span1);
    

    $(td1).text(dataImport.pro_name);
    $(td2).text(dataImport.price);
    $(td3).text(dataImport.total);
    $(td4).text(dataImport.report_date);
    $(td5).text(dataImport.note);
    $(div).attr('id', 'tr_'+dataImport.id);
    div.append(td1);
    div.append(td2);
    div.append(td3);
    div.append(td4);
    div.append(td5);
    div.append(td6);
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

function resetInput(type){
    switch(type){
        case 1:
            $('#list_product').val(0).trigger('change');
            $('#price_import').val("");
            $('#total').val("");
            $('#confirm_pay').prop('checked', false);
            break;
        default: break;
    }
}

function save(type){
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
                        case 3:
                            url = "/pay/store";
                            data = {"arrPay" : JSON.stringify(arrPay)};
                            break;
                        default: break;
                    }
                    callAjaxSave(url, data);
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

function callAjaxSave(url, data){
    let loading      = $("#loading-page");
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