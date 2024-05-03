/* Rental History of all customers */

SELECT first_name || ' ' || last_name as Full_Name, title, checkout_dt, return_dt
FROM customers JOIN rentals USING (ctr_id) JOIN items USING (itm_id) JOIN movies USING (mve_id);

/* Update Actors Real Name */

UPDATE actors
SET real_name = 'Saravanan Sivakumar'
WHERE first_name = 'Suriya';

/* Update Actors Birthday */

UPDATE actors
SET dob = '06/01/1937'
WHERE atr_id = 2;

/* Retrieve an Actor's Birthday */
SELECT first_name, last_name, dob
FROM actors
WHERE first_name = 'Morgan' AND last_name = 'Freeman';

/* Retrieve all in-stock items. Items that are not marked missing,
and items that are not currently checked out */
SELECT itm_id, type_format, title 
FROM items JOIN movies USING (mve_id)
WHERE miss NOT LIKE 'Y'
MINUS
SELECT itm_id, type_format, title
FROM rentals JOIN items USING (itm_id) JOIN movies USING (mve_id)
WHERE return_dt IS NULL;

/* Find a movie by genre */
SELECT title
FROM movies
WHERE genre = 'Action';

/* Find movie by actor */
SELECT title
FROM movies JOIN appearances USING (mve_id) JOIN actors USING (atr_id)
WHERE last_name = 'Freeman'; 