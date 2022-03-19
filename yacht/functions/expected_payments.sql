CREATE OR REPLACE FUNCTION expected_payments(bound_date DATE) RETURNS 
TABLE (
    pay_amount MONEY,
    _date DATE,
    customer_name VARCHAR,
    banc_account CHAR(16)
)
LANGUAGE plpgsql AS
$$
DECLARE
    rent_row record;
    start_day DATE;
    price_daily MONEY;
    penalty MONEY;
BEGIN
    IF bound_date < CURRENT_DATE THEN
        RAISE EXCEPTION 'Date must not be in the past';
    END iF;
    FOR rent_row IN (
        SELECT 
            Rent.id AS id,
            Rent.customer_id AS cust_id,
            Rent.amount AS amount,
            Rent.init_date AS init_d,
            Rent.length AS len,
            MAX(Payment._date) AS last_pay
        FROM ActiveRent
        JOIN Rent ON Rent.id = ActiveRent.rent_id
        LEFT JOIN Payment ON Payment.rent_id = Rent.id
        WHERE Rent.amount > CAST(0 AS MONEY)
        GROUP BY Rent.id, Rent.customer_id, Rent.amount
    ) LOOP 
        SELECT CONCAT(name, ' ', patronymic, ' ', surename), banc_acc
        FROM Customer WHERE Customer.id = rent_row.cust_id
        INTO customer_name, banc_account;

        SELECT price INTO price_daily
        FROM Rent
        JOIN Yacht ON Yacht.id = Rent.yacht_id
        JOIN YachtType ON YachtType.id = Yacht.yacht_type
        WHERE Rent.id = rent_row.id;

        IF rent_row.init_d + rent_row.len < CURRENT_DATE THEN
            -- outdated rent --
            _date := CURRENT_DATE;
            pay_amount := rent_row.amount;
            RETURN NEXT;
            CONTINUE;
        END IF;

        IF rent_row.len < 31 THEN
            -- short rent --
            IF rent_row.last_pay IS NULL THEN
                RAISE NOTICE 'There was no initial payment by %s for rent %d',
                    customer_name, rent_row.id;
            END IF;
            penalty := GREATEST(0, CURRENT_DATE - (rent_row.init_d + rent_row.len)) * price_daily;
            _date := GREATEST(CURRENT_DATE, rent_row.init_d + rent_row.len);
            pay_amount := rent_row.amount + penalty;
            IF _date <= bound_date THEN
                RETURN NEXT;
            END IF;
        ELSE
            IF rent_row.last_pay IS NULL THEN 
                RAISE NOTICE 'There was no initial payment by %s for rent %d',
                    customer_name, rent_row.id;
                start_day := rent_row.init_d - 1;
            ELSE
                start_day := rent_row.last_pay + 31;
            END IF;
            WHILE start_day <= bound_date AND start_day <= rent_row.init_d + rent_row.len
            LOOP
                _date := LEAST(start_day + 31, rent_row.init_d + rent_row.len);
                _date := GREATEST(_date, CURRENT_DATE);
                pay_amount := (_date - start_day) * price_daily;
                EXIT WHEN _date > bound_date;
                RETURN NEXT;
                start_day := _date + 31;
            END LOOP;
        END IF;
    END LOOP;
END
$$