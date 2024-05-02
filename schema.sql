CREATE TABLE movies
(
    mve_id NUMBER PRIMARY KEY,
    title VARCHAR2(400) NOT NULL,
    genre VARCHAR2(20) DEFAULT NULL,
    release_dt CHAR(4) DEFAULT NULL
);

CREATE SEQUENCE itm_seq;

CREATE TABLE items
(
    itm_id NUMBER DEFAULT itm_seq.NEXTVAL PRIMARY KEY,
    type_format CHAR(3) NOT NULL,
    miss CHAR  DEFAULT 'N' NOT NULL,
    mve_id NUMBER NOT NULL,
        CONSTRAINT items_missing_ck CHECK (miss IN ('Y', 'N')),
        CONSTRAINT items_mve_id_fk FOREIGN KEY (mve_id)
            REFERENCES movies (mve_id)      
);


CREATE TABLE actors
(
    atr_id NUMBER PRIMARY KEY,
    last_name VARCHAR2(30),
    first_name VARCHAR2(30) NOT NULL,
    dob DATE DEFAULT NULL,
    real_name VARCHAR2(30) DEFAULT NULL,
);

CREATE TABLE appearances
(
    mve_id NUMBER,
    atr_id NUMBER,
        CONSTRAINT appearances_mve_id_atr_id_pk PRIMARY KEY (mve_id, atr_id),
        CONSTRAINT appearances_mve_id_fk FOREIGN KEY (mve_id)
            REFERENCES movies (mve_id),
        CONSTRAINT appearances_atr_id_fk FOREIGN KEY (atr_id)
            REFERENCES actors (atr_id)
);

CREATE SEQUENCE ctr_seq;

CREATE TABLE customers
(
    ctr_id NUMBER DEFAULT ctr_seq.NEXTVAL PRIMARY KEY,
    last_name VARCHAR2(30) NOT NULL,
    first_name VARCHAR2(30) NOT NULL,
    phone CHAR(10) NOT NULL,
    address VARCHAR2(400) NOT NULL,
        CONSTRAINT customers_phone_ck CHECK (REGEXP_LIKE(phone, '[0-9]{10}'))
);

CREATE TABLE rentals
(
    itm_id NUMBER,
    ctr_id NUMBER,
    checkout_dt DATE DEFAULT SYSDATE,
    return_dt DATE DEFAULT NULL,
    CONSTRAINT rentals_itm_id_ctr_id_checkout_dt_pk
        PRIMARY KEY (itm_id, ctr_id, checkout_dt),
    CONSTRAINT rentals_itm_id_fk FOREIGN KEY (itm_id)
        REFERENCES items (itm_id),
    CONSTRAINT rentals_ctr_id_fk FOREIGN KEY (ctr_id)
        REFERENCES customers (ctr_id)
);