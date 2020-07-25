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
<link rel="shortcut icon" href="favicon.ico"/>
<script type="text/javascript">
$(document).ready(function() {
    
});
</script>
<title>BETA jsp PAGE</title>
</head>
<body>
    
    <h1>請輸入產品關鍵字</h1>
    <form id="myForm" action="productServlet" method="GET">
      產品關鍵字: <input type="text" id="keyword" name="keyword" size="20">
      <input type="hidden" id="page_number" name="page_number" value="1">
      <input id="submit" type="submit" value="查詢" />
    </form>
    
    <br><br><p><p>
    
    <table class="blueTable">
       <thead>
         <tr>
           <th>head1</th>
           <th>head2</th>
           <th>head3</th>
           <th>head4</th>
         </tr>
       </thead>
       
       <tfoot>
         <tr>
           <td colspan="4">
           <div class="links"><a href="#">&laquo;</a> <a class="active" href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">&raquo;</a></div>
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
    
    <h1>
        我是BETA頁面
    </h1>

</body>
</html>
