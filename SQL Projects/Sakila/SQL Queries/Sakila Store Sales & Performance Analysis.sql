use sakila;
#monthly sales volume
SELECT
    s.store_id,
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    ROUND(SUM(p.amount), 2) AS total_sales
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id, month
ORDER BY month, s.store_id;
#MONTHLY RENTAL VOLUME BY STORE
SELECT
    s.store_id,
    DATE_FORMAT(r.rental_date, '%Y-%m') AS month,
    COUNT(*) AS rental_count
FROM rental r
JOIN staff st ON r.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id, month
ORDER BY month, s.store_id;
#MONTHLY SALES VOLUME BY CATAGORY IN EACH STORE
SELECT
    s.store_id,
    c.name AS category,
    ROUND(SUM(p.amount), 2) AS category_sales
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id, category
ORDER BY s.store_id, category_sales DESC;
# EMPLOYEE'S SALES VOLUME
SELECT
    st.staff_id,
    CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
    s.store_id,
    ROUND(SUM(p.amount), 2) AS staff_sales
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY st.staff_id, staff_name, s.store_id
ORDER BY s.store_id, staff_sales DESC;
