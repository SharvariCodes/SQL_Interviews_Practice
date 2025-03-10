CREATE TABLE Myntra_Problem (
    Product_Id INT,
    Category VARCHAR(512),
    Price INT
);

INSERT INTO Myntra_Problem (Product_Id, Category, Price) VALUES
 ('1', 'Home & living', '2000'),
 ('2', 'Home & living', '3500'),
 ('3', 'Home & living', '15000'),
 ('4', 'Kids', '1200'),
 ('5', 'Kids', '1500'),
 ('6', 'Kids', '6000'),
 ('7', 'Gifts', '500'),
 ('8', 'Gifts', '600'),
 ('9', 'Gifts', '4500');

 --total budget should be less than 8800

 with cte as (select *,
 sum(price) over(partition by Category order by price
 rows between unbounded preceding and current row) as running_price
 from Myntra_Problem),
cte2 as(
 select * 
 from cte 
 where category = 'Home & Living' and running_price <= 8800),
 cte3 as (
 select * 
 from cte
 where category = 'Kids' and running_price <= 8800 - (select Max(running_price) from cte2))

 select Product_Id, Category, Price from cte2
 union
 select Product_Id, Category, Price from cte3




