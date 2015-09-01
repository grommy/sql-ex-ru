
select avg_table.type, avg_table.avg_price

FROM
	(
		select Product.model, product.type, avgt.avg_price
			FROM 
			(select model, avg(price) as avg_price
					FROM Printer 
					group by model

					union 

					select model,avg(price)  as avg_price
					from Laptop 
					group by model

					union

					select model, avg(price)  as avg_price
					from  PC 		
					group by model
				) as avgt
			Right JOIN Product on Product.model = avgt.model
	) as avg_table 

	where  avg_table.model in 
	(
		select t.model FROM
		(
			select model, ROW_NUMBER() OVER (ORDER BY model) AS rownum
			FROM Product 
		)as t where rownum % 5 = 0
	) 
