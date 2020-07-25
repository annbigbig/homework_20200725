<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.2/dist/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/localization/messages_zh_TW.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/blue.css"/>
<link rel="stylesheet" type="text/css" href="css/jquery-validation-custom.css"/>
<link rel="shortcut icon" href="favicon.ico"/>
<script type="text/javascript">
$(document).ready(function() {
	
	//----------------------------------------------
	
	
	
	$("#dataTable").on('click','a.one',function(event){
		event.preventDefault();
		console.log("阻止class=one的按鈕預設行為");
    }).on('click','a.sort',function(event){
		event.preventDefault();
		console.log("阻止class=sort的按鈕預設行為");
		
		var str_href = $(this).attr("href");
		var str_array = str_href.split(":");
		var order_column = str_array[0];
		var order_type = str_array[1];
		var keyword = $("#keyword").val();
		var page_number = $("#page_number").val();
        makeAjaxCall(keyword, page_number, order_column, order_type);
        console.log("after ajax call");
    })
    ;

	/* not working , because DOM elements were made after $(document).ready()
	$(".one").click(function(event) {
		event.preventDefault();
		console.log("阻止class=one的按鈕預設行為");
	});
	*/

	$("#pages").on('click','a.page',function(event){
		event.preventDefault();
		console.log("inside a.page clickHandler:");    
        
		var keyword = $("#keyword").val();
		var page_number = $(this).attr("href");
		var order_column = $("#order_column").val();
        var order_type = $("#order_type").val();
        makeAjaxCall(keyword, page_number, order_column, order_type);
		
        console.log("after ajax call");
    });
	
	$("#myForm").submit(function(event) {
		// dont submit form actually i dont wanna change page
	    event.preventDefault();
		console.log("已經阻止提交表單了");
	    
	}).validate({
         rules: {
             keyword: "required",
             page_number: "required"
             },
         messages: {
             keyword: "请输入查詢關鍵字",
             page_number: "請輸入頁碼"
         },
         errorElement : "div",
         errorLabelContainer: ".errorTxt",
         submitHandler: function(form){
             console.log("inside submitHandler:");    
             
             var keyword = $("#keyword").val();
             var page_number = 1; //default page number is 1 if u fire search from [Search] button
             var order_column = $("#order_column").val();
             var order_type = $("#order_type").val();
             makeAjaxCall(keyword, page_number, order_column, order_type);
             
             console.log("after ajax call");
         }
    });
	//----------------------------------------------
	onlyRunOnce();
	console.log("ready ! yo man");
});

/*
   jquery ajax on error
   https://stackoverflow.com/questions/6792878/jquery-ajax-error-function

   jquery how to iterate JSON data and draw it as table
   https://stackoverflow.com/questions/21434012/loop-through-a-json-array-to-create-a-table
   https://stackoverflow.com/questions/17724017/using-jquery-to-build-table-rows-from-ajax-responsejson
*/

function onlyRunOnce(){
	
     var flag = $("#initial_flag").text();
     if (flag == "yes"){
      	$("#initial_flag").empty();
       	//alert("first time page load !");
      	makeAjaxCall("x", 1, "name", "asc");
     }
     console.log("flag = " + flag);
}

function renderHTML(data) {
	
	//resolve data into variables
	var min_page_number = data.min_page_number;
	var page_number = data.page_number;
	var max_page_number = data.max_page_number;
    var records_per_page = data.records_per_page;
    var total_records = data.total_records;
    var keyword = data.keyword;
    var order_column = data.order_column;
    var order_type = data.order_type;
    var products = data.products;
    
    //report search results , and if no matched records found
    var msg = "關鍵字 [ " + keyword + " ] 返回記錄 [ " + total_records + " ] 筆";
    msg += (max_page_number > 0) ? "，目前在第 [ " + page_number + " ] 頁，共有 [ " + max_page_number + " ] 頁" : "";
    msg += (total_records == 0) ? "，沒有符合的記錄存在 ... 請重新搜尋其他關鍵字" : "";
	$("#msgDiv").empty();
	$("#msgDiv").html(msg);
	
	//render column title buttons for sorting records
	var title_tr, th1, th2, th3, th4;
	if((order_column == "name") && (order_type == "asc")) {
	    th1 = $('<th>').append('<b style="font-size:22px;">&#9650;</b>' + '[ 名 稱 ]' + '<a href="name:desc" class="sort" style="font-size:22px; text-decoration: none;">&#9661;</a>');
	} else if((order_column == "name") && (order_type == "desc")){
		th1 = $('<th>').append('<a href="name:asc" class="sort" style="font-size:22px; text-decoration: none;">&#9651;</a>' + '[ 名 稱 ]' + '<b style="font-size:22px;">&#9660;</b>');
	} else{
		th1 = $('<th>').append('<a href="name:asc" class="sort" style="font-size:22px; text-decoration: none;">&#9651;</a>' + '[ 名 稱 ]' + '<a href="name:desc" class="sort" style="font-size:22px; text-decoration: none;">&#9661;</a>');
	}
	
	if((order_column == "price") && (order_type == "asc")) {
	    th2 = $('<th>').append('<b style="font-size:22px;">&#9650;</b>' + '[ 價 格 ]' + '<a href="price:desc" class="sort" style="font-size:22px; text-decoration: none;">&#9661;</a>');
	} else if((order_column == "price") && (order_type == "desc")){
		th2 = $('<th>').append('<a href="price:asc" class="sort" style="font-size:22px; text-decoration: none;">&#9651;</a>' + '[ 價 格 ]' + '<b style="font-size:22px;">&#9660;</b>');
	} else{
		th2 = $('<th>').append('<a href="price:asc" class="sort" style="font-size:22px; text-decoration: none;">&#9651;</a>' + '[ 價 格 ]' + '<a href="price:desc" class="sort" style="font-size:22px; text-decoration: none;">&#9661;</a>');
	}
	
	if((order_column == "amount") && (order_type == "asc")) {
	    th3 = $('<th>').append('<b style="font-size:22px;">&#9650;</b>' + '[ 數 量 ]' + '<a href="amount:desc" class="sort" style="font-size:22px; text-decoration: none;">&#9661;</a>');
	} else if((order_column == "amount") && (order_type == "desc")){
		th3 = $('<th>').append('<a href="amount:asc" class="sort" style="font-size:22px; text-decoration: none;">&#9651;</a>' + '[ 數 量 ]' + '<b style="font-size:22px;">&#9660;</b>');
	} else{
		th3 = $('<th>').append('<a href="amount:asc" class="sort" style="font-size:22px; text-decoration: none;">&#9651;</a>' + '[ 數 量 ]' + '<a href="amount:desc" class="sort" style="font-size:22px; text-decoration: none;">&#9661;</a>');
	}
	
	th4 = $('<th>').text('[ 描 述 ]');
	title_tr = $('<tr>').append(th1,th2,th3,th4);
	$("#dataTable thead").append(title_tr);
    
    //render [page_number] [order_column] [order_type] hidden in form
    $("#keyword").val(keyword);
    $("#page_number").val(page_number);
    $("#order_column").val(order_column);
    $("#order_type").val(order_type);

    
    //render page number buttons like this :  |<<   < 1 2 (3) 4 5 6 7 8 9 10 >  >>|
    var start = (parseInt((page_number-1)/10)*10)+1;
    var end =((parseInt( (page_number-1) /10 ) +1)*10);
    if (max_page_number < end) {
    	end = max_page_number;
    }
    
    //go first and previous page
    if((page_number > start) || (page_number > min_page_number)){
    	$("#pages").append('<a href="1" class="page"> |<< </a>');
    	$("#pages").append('<a href="' + (page_number-1) + '" class="page"> < </a>');
    }
    
    for(var i=start;i<=end;i++){
       if(i==page_number){
    	   //current page , render a disable a link, css selector cannot match this a-tag , why?
           $("#pages").append('<a href="' + i + '" style="background-color:#FF6B33;">' + i + '</a>');
       }else{
    	   $("#pages").append('<a href="' + i + '" class="page">' + i + '</a>');
       }
    }
    
  //go next and last page
    if((page_number < end) || (page_number< max_page_number)){
    	$("#pages").append('<a href="' + (page_number+1) + '" class="page"> > </a>');
    	$("#pages").append('<a href="' + max_page_number + '" class="page"> >>| </a>');
    }
    
    //-------------------------------------------------------------------------------
    
    //render products as rows in table
    var tbody = $("<tbody />"),tr;
    $.each(products,function(i,product) {
    	   tr = $('<tr>').append(
                $('<td>').append('<a class = "one" href="betaServlet?id=' + product.id + '">' + product.name + '</a>'),
                $('<td>').text(product.price),
                $('<td>').text(product.amount),
                $('<td>').text(product.description)
            );
    	   tr.appendTo(tbody);
    });
    $("#dataTable tbody").empty();
    tbody.appendTo("#dataTable"); // only DOM insertion
    
    console.log(data);
}

function showERROR(jqXHR, exception) {
	
        var msg = '';
        if (jqXHR.status === 0) {
            msg = 'Not connect.\n Verify Network.';
        } else if (jqXHR.status == 404) {
            msg = 'Requested page not found. [404]';
        } else if (jqXHR.status == 500) {
            msg = 'Internal Server Error [500].';
        } else if (exception === 'parsererror') {
            msg = 'Requested JSON parse failed.';
        } else if (exception === 'timeout') {
            msg = 'Time out error.';
        } else if (exception === 'abort') {
            msg = 'Ajax request aborted.';
        } else {
            msg = 'Uncaught Error.\n' + jqXHR.responseText;
        }
        $('#msgDiv').html(msg);
	
}

function clearTable() {
	$("#errorDiv").html("");
	$("#msgDiv").html("");
	$("#dataTable thead").empty();
	$("#dataTable tbody").empty();
	$("#pages").empty();
}

function makeAjaxCall(keyword, page_number, order_column, order_type){
    $.ajax({
        type: "GET",
        dataType: "json",
        contentType : "application/json; charset=utf-8",
        url: "productServlet",
        data: {
      	   keyword: keyword,
           page_number: page_number,
           order_column: order_column,
           order_type: order_type
        },
        success: function(data)
        {
      	    clearTable();
      	    renderHTML(data);
        },
        error: function (jqXHR, exception) {
      	    showERROR(jqXHR, exception);
        }
     });
}

function count_page_test() {
	var page_number = 22;
    var max_page_number = 23;
    var start = (parseInt((page_number-1)/10)*10)+1;
    var end =((parseInt( (page_number-1) /10 ) +1)*10);
    if (max_page_number < end) {
    	end = max_page_number;
    }

    var debug_msg = "page_number = " + page_number + " start = " + start + " end = " + end;
    console.log(debug_msg);
}

</script>
<title>產品查詢頁面</title>
</head>
<body>
    
    
       <h1>請輸入產品關鍵字</h1>
    <form id="myForm" action="productServlet" method="GET">
      產品關鍵字: <input type="text" id="keyword" name="keyword" size="20">
      <input type="hidden" id="page_number" name="page_number" value="1">
      <input type="hidden" id="order_column" name="order_column" value="name">
      <input type="hidden" id="order_type" name="order_type" value="asc">
      <input id="submit" type="submit" value="查詢" />
    </form>
    <br/>
    <div id="errorDiv" class="errorTxt"></div><br/>
    <div id="msgDiv"></div>
    
    <br><br><p><p>
    
    <table class="blueTable" id="dataTable">
       <thead>
           <tr>
             <th>名 稱</th>
             <th>價 格</th>
             <th>數 量</th>
             <th>產品描述</th>
           </tr>
       </thead>
       
       <tfoot>
         <tr>
           <td colspan="4">
           <div id="pages" class="links"><a href="#" class="links">&laquo;</a> <a href="#" class="links">1</a> <a href="#" class="links">2</a> <a href="#" class="links">3</a> <a href="#" class="links">4</a> <a href="#" >&raquo;</a></div>
          </td>
        </tr>
       </tfoot>
       
       <tbody>
          <tr>
             <td>cell1_1</td>
             <td>cell2_1</td>
             <td>cell3_1</td>
             <td>cell4_1</td>
          </tr>
          
          <tr>
             <td>cell1_2</td>
             <td>cell2_2</td>
             <td>cell3_2</td>
             <td>cell4_2</td>
          </tr>
          
          <tr>
             <td>cell1_3</td>
             <td>cell2_3</td>
             <td>cell3_3</td>
             <td>cell4_3</td>
          </tr>
          
          <tr>
             <td>cell1_4</td>
             <td>cell2_4</td>
             <td>cell3_4</td>
             <td>cell4_4</td>
          </tr>
       </tbody>
    </table>
        
    
    <br><p><p>
    <div id="initial_flag">yes</div>
    <div id="show_infomation">溫馨提示：26個英文字母都可以搜，只有英文資料 ( Hint: use 26 English letters as keyword )</div>
    
    <h1>
    </h1>
</body>
</html>
