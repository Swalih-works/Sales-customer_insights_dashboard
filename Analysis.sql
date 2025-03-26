select * from sales;
select * from products;
select * from customers;

-- Total Sales & Revenue
select sum(revenue) as Total_revenue from sales;

-- Top 5 Best-Selling Products
select products.productName, sum(quantity) as Total_sold from sales
inner join products on products.product_ID = sales.product_ID
group by products.ProductName 
order by Total_sold Desc
limit 5;

-- Monthly Sales Trend
select Date_Format(SalesDate, '%Y - %m') as S_Month, sum(Revenue) as Total_Revenue from sales
group by S_Month
order by S_Month ;

-- Customer Segmentation (e.g., Sales by Gender, Location)
select customers.gender, sum(Revenue) as Total_Revenue from sales
join customers on customers.Customer_ID = Sales.Customer_ID
group by Customers.Gender;

-- Stored Procedure for Daily Sales Report
delimiter //
create procedure getdailysalesreport()
begin
	select SalesDate, count(SaleID) as TotalOrders, sum(Revenue) as TotalRevenue from sales group by SalesDate order by SalesDate Desc;
end//
delimiter ;

call getdailysalesreport;

-- Stored Procedure for Monthly Sales by Location
delimiter //
create procedure getmonthlysalesreport()
Begin
	 select customers.location, Date_FORMAT(SalesDate, '%Y-%M') as SaleMonth, count(SaleID) as TotalOrders, sum(sales.revenue) as TotalRevenue from sales 
    join customers on sales.Customer_ID = customers.Customer_ID 
    group by SaleMonth, customers.location
    order by SaleMonth Desc, TotalRevenue Desc;
end //
delimiter ;

call getmonthlysalesreport;

-- Stored Procedure for Top 5 Best-Selling Products
delimiter //
create procedure gettopsellingproducts()
begin
	select products.ProductName, sum(sales.quantity) as TotalSold from sales
    join products on sales.Product_ID = products.Product_ID
    group by ProductName
    order by TotalSold Desc limit 5;   
end //    
delimiter ;

call gettopsellingproducts;

-- Stored Procedure for Customer Purchase History
delimiter //
create procedure customerpurchasehistory(in CustomerID int)
begin
	select sales.SalesDate, products.ProductName, sales.Quantity, sales.Revenue from sales
    join products on sales.Product_ID = products.Product_ID
    where sales.Customer_ID = CustomerID
    order by sales.SalesDate Desc;
end //
delimiter ;

call customerpurchasehistory(5);
call customerpurchasehistory(118);
	