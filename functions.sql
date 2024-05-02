/* Rental History of all customers */

SELECT first_name || ' ' || last_name as Full_Name, title, checkout_dt, return_dt
FROM customers JOIN rentals USING (ctr_id) JOIN items USING (itm_id) JOIN movies USING (mve_id);