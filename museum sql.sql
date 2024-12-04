use museum_data;

-- 1) Fetch all the paintings which are not displayed on any museums?
select *
from work
where work_id is null;

-- 2.Are there museuems without any paintings?
select *
from museum m
left join work w
on m.museum_id = w.museum_id
where work_id is null;

-- 3.How many paintings have an asking price of more than their regular price? 
select count(*) as total
from product_size
where  regular_price < sale_price;

-- 4.Identify the paintings whose asking price is less than 50% of its regular price
select *
from work w
left join product_size ps
on w.work_id = ps.work_id
where sale_price < (0.5* regular_price);

-- 5.Which canva size costs the most?
select  ps.sale_price, c.label
from product_size ps
join canvas_size c
on ps.size_id = c.size_id
group by ps.sale_price, c.label
having (sale_price)
order by sale_price DESC
limit 1;

-- 6.Delete duplicate records from work, product_size, subject and image_link tables

-- 7.Identify the museums with invalid city information in the given dataset
select city
from museum
where city regexp '^[0-9]';


-- 8.Museum_Hours table has 1 invalid entry. Identify it and remove it.
select *
from museum_hours;

-- 9) Fetch the top 10 most famous painting subject
select distinct(subject), count(*) total
from subject s
join work w
on s.work_id = w.work_id
group by s.subject
order by total DESC
LIMIT 10;

-- 10.Identify the museums which are open on both Sunday and Monday. Display museum name, city.
select m.name, m.city, m.state, m.country, mh.day, mh.open, mh.close
from museum_hours mh
join museum m
on mh.museum_id = m.museum_id
where day in ('sunday','monday');

-- 11.How many museums are open every single day?
SELECT museum_id, COUNT(*)
FROM museum_hours
GROUP BY museum_id
HAVING COUNT(*) = 7;

-- 12.Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)
select m.museum_id, m.name, count(*) as no_of_painting
from museum m
join work w
on m.museum_id = w.museum_id
group by m.museum_id, m.name
order by  no_of_painting desc
limit 5;

-- 13.Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)
select a.full_name, a.nationality, count(*) as popular_artist
from artist a
join work w
on a.artist_id = w.artist_id
group by a.full_name, a.nationality
order by popular_artist desc
limit 5;

-- 14.Display the 3 least popular canva sizes
select c.label, count(*) AS COUNT
from canvas_size c
join product_size p
on c.size_id = p.size_id
group by label
order by COUNT ASC
LIMIT 8;

-- 15.Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?
select m.name, m.state, mh.close-mh.open as longest
from museum_hours mh
join museum m
on m.museum_id = mh.museum_id
order by longest DESC;

-- select *
-- from museum_hours mh
-- join museum m
-- on m.museum_id = mh.museum_id
-- where name = 'Walters Art Museum';

-- 16. Which museum has the most no of most popular painting style?
select m.name, w.style, count(*) as no_of_painting
from museum m
join work w
on m.museum_id = w.museum_id
group by m.name, w.style
order by no_of_painting desc
limit 1;

-- 17.Identify the artists whose paintings are displayed in multiple countries
select a.full_name, count(country) as total_country
from museum m
join work w
on m.museum_id = w.museum_id
join artist a
on w.artist_id = a.artist_id
group by a.full_name
order by total_country desc
limit 1;

-- 18.Display the country and the city with most no of museums. Output 2 seperate columns to mention the city and country. If there are multiple value, seperate them with comma.
select city, country, count(*) as total_museum
from museum
group by city, country
order by  total_museum desc;

-- 19. Identify the artist and the museum where the most expensive and least expensive painting is placed. Display the artist name, sale_price, painting name, museum name, museum city and canvas label
-- select *
-- from work w
-- join artist a
-- on w.artist_id = a.artist_id
-- join museum m
-- on w.museum_id =m.museum_id
-- join


-- 20. Which country has the 5th highest no of paintings?
select m.country, count(*) as no_of_painting
from museum m
join work w
on m.museum_id = w.museum_id
join artist a
on w.artist_id = a.artist_id
group by country
order by  no_of_painting desc
limit 1
offset 4;



