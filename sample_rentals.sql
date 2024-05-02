/* Returned Movies */
INSERT INTO rentals (itm_id, ctr_id, checkout_dt, return_dt)
    VALUES (1, 1, '01/01/2024', '01/02/2024');

INSERT INTO rentals (itm_id, ctr_id, checkout_dt, return_dt)
    VALUES (4, 2, '01/01/2024', '01/02/2024');

INSERT INTO rentals (itm_id, ctr_id, checkout_dt, return_dt)
    VALUES (7, 3, '01/01/2024', '01/02/2024');

INSERT INTO rentals (itm_id, ctr_id, checkout_dt, return_dt)
    VALUES (7, 1, '01/10/2024', '01/11/2024');

INSERT INTO rentals (itm_id, ctr_id, checkout_dt, return_dt)
    VALUES (2, 3, '01/10/2024', '01/11/2024');

/*Not Returned*/
INSERT INTO rentals (itm_id, ctr_id, checkout_dt)
    VALUES (10, 10, '01/10/2024');

INSERT INTO rentals (itm_id, ctr_id, checkout_dt)
    VALUES (11, 11, '01/10/2024');