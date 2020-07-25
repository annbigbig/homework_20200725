# Searching, Sorting and Paging with Java Servlet / jQuery


**Note:** all of codes in this repository were only for my personal practice purposes, some design patterns maybe not so correct, DO NOT use it as your tutorial

**注意:** 這裡的所有代碼只是我拿來自我練習，裡面許多設計模式也許不那麼正確，請勿拿來當你的編程教材


## Requirements
The user enter a keyword in textbox , then press [Search] button,  
system responses a page with search results , if too many results were found ,  
then just load parts of them (maybe  just 10 rows per page),  
and place (page number) buttons for linking to another page  
  
用戶會在文字框輸入關鍵字，然後按下 [ 查詢 ] 按鈕，  
系統回應用戶搜尋結果頁，如果符合關鍵字的記錄太多，  
那麼請只取回部分（也許每頁10筆記錄），  
然後在頁面上渲染頁碼按鈕，方便用戶連結到別的頁面  

![Requirements Description](images/Requirements.jpg?raw=true "Title")  


## How to build this project ?

Via Maven command:

``` bash
$ mvn clean
$ mvn package
```
then you will find My-project-02.war in target sub-directory  


## Database Structure
this project's need one table for its persistent entity ( Product ) ,   
and this [products.sql](src/main/resources/sql/products.sql "Title") is the SQL you could use it to generate table,   
and this [data.sql](src/main/resources/sql/data.sql "Title") is the SQL you could use it to populate 1000 rows mock data,  
persistent entity ( Product ) uses database table structure like this :

此專案需要一個資料表來存儲它的持久化資料（Product），  
這裡 [products.sql](src/main/resources/sql/products.sql "Title") 的SQL可以讓你產生資料表，  
而這裡 [data.sql](src/main/resources/sql/data.sql "Title") 的SQL可以讓你產生1000筆假資料，  
持久化類別（Product）使用的資料表 TB_YOAN_PRODUCT 結構如下：  

``` 
MariaDB [db_spring]> desc TB_YOAN_PRODUCT;
+-------------+------------------+------+-----+---------+-------------------+
| Field       | Type             | Null | Key | Default | Extra             |
+-------------+------------------+------+-----+---------+-------------------+
| id_bin      | binary(16)       | NO   | PRI | NULL    |                   |
| id_text     | varchar(36)      | YES  |     | NULL    | VIRTUAL GENERATED |
| name        | varchar(128)     | NO   |     | NULL    |                   |
| price       | int(11)          | NO   |     | NULL    |                   |
| amount      | int(10) unsigned | NO   |     | NULL    |                   |
| description | varchar(1024)    | NO   |     | NULL    |                   |
+-------------+------------------+------+-----+---------+-------------------+
6 rows in set (0.005 sec)

```

## System Design (roughly UML models)

Please see 
![UMLmodels](images/UMLmodels.jpg?raw=true "Title")

## Play it on dq5rocks.com  && ScreenShot
click [here](https://www.dq5rocks.com/My-project-02/ "Title") try it out  
this link probobaly may become unavailable in someday future,   
if i could not pay for domain name or vps payment

在 [這裡](https://www.dq5rocks.com/My-project-02/ "Title") 直接玩  
連結可能在未來有天會失效，如果我繳不出域名或VPS主機的錢  

![Screenshot](images/Screenshot.jpg?raw=true "Title")  


## Contributing
就…我一個  
only me ... (ಥ﹏ಥ)  
( system design / programming / documentation )

## Donate me

可以捐錢給我喔，i need your support  

- [國泰世華銀行收款帳號](#CathayBank) **銀行代碼 013 帳號 001-50-235346-9 戶名 KUN AN HSU 館前分行**  

- [Alipay(支付寶)](#alipay) **annbigbig@gmail.com**  

- [BitCoin](#Bitcoin)  ![BitcoinIcon](images/Bitcoin.png?raw=true "Thank you")

  **1FGEtWkZpo3WHzQqDw6aJvsaDyxNmX4H9**

- [Ethereum](#Ethereum)  ![EthereeumIcon](images/Ethereum.png?raw=true "Thank you")  
  **0x36077A217819cf747F938EbFad26Ec50e44cDC48**

## Contact me

- **annbigbig@gmail.com**   
2020年7月，又開始寫扣，祝我好運

## License

None. 無

