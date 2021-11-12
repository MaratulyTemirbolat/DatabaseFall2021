


-- 2 What is the difference between privilege, role and user?

-- A. create accountant, administrator, support roles and grant appropriate privileges
-- Roles:
CREATE ROLE accountant; -- Бухгалтер ( Просмотреть аккаунты, просмотреть транзакции, изменение баланса)
CREATE ROLE administrator; -- Администратор ( ВСЕ ПРАВА НА БАЗУ ДАННЫХ )
CREATE ROLE support; -- Служба поддержки ( Просмотреть все, но ничего не менять )
-- Privileges to Accountant ( SELECT - Бух Учет, Update - Закидывать зарплату)
GRANT SELECT, UPDATE (balance) ON accounts TO accountant;
GRANT SELECT ON transactions TO accountant;
-- Privileges to Administrator ( All the privileges ON Database since it is Administrator)
GRANT ALL PRIVILEGES ON DATABASE lab_seven TO administrator;
-- Privileges to Support ( Can see all the info but don't influence them)
GRANT SELECT ON accounts,customers,transactions TO support;

SELECT * FROM pg_roles;

-- B Create some users and assign them roles,
CREATE USER zarina_kairatova;
CREATE USER temirbolat_maratuly;
CREATE USER alexander_luchin;

GRANT support to temirbolat_maratuly;
GRANT administrator to alexander_luchin;
GRANT accountant to zarina_kairatova;

-- C Give to some of them permission to grant roles to other users

CREATE ROLE role_creator CREATEROLE;
GRANT role_creator to temirbolat_maratuly;

SELECT * FROM pg_roles;

-- D revoke some privilege from particular user

REVOKE SELECT ON customers FROM temirbolat_maratuly;
REVOKE UPDATE(balance) ON accounts FROM zarina_kairatova;


-- 3 Add appropriate constraints
-- A. check if transaction has same currency for source and destination accounts (use assertion)

CREATE ASSERTION currency_assertion CHECK ( NOT EXISTS (
SELECT tr.src_account,tr.dst_account,ac.currency as source_currency,ac_two.currency as destination_currency
FROM transactions tr
JOIN accounts ac
    ON tr.src_account = ac.account_id
JOIN accounts ac_two
    ON tr.dst_account = ac_two.account_id
WHERE ac.currency != ac_two.currency
) );

-- B  add not null consraints
SELECT * FROM transactions;
-- First thought
ALTER TABLE transactions
ALTER COLUMN date SET NOT NULL;

ALTER TABLE transactions
ALTER COLUMN src_account SET NOT NULL;

ALTER TABLE transactions
ALTER COLUMN dst_account SET NOT NULL;

ALTER TABLE transactions
ALTER COLUMN amount SET NOT NULL;

ALTER TABLE transactions
ALTER COLUMN status SET NOT NULL;

-- Second thought
CREATE ASSERTION not_null_assertion CHECK ( NOT EXISTS (
SELECT *
FROM transactions
WHERE date IS NULL OR src_account IS NULL OR dst_account IS NULL OR amount IS NULL OR status IS NULL;
) );


-- 4 Change currency column type to user-defined in accounts table
CREATE TYPE Valuta AS (param CHAR(5));

ALTER TABLE accounts
ALTER COLUMN currency TYPE Valuta USING currency::valuta;


-- 5 Create indexes
-- A. index so that each customer can only have one account of one currency
CREATE UNIQUE INDEX account_index ON accounts(customer_id,currency);

-- B.  index for searching transactions by currency and balance
CREATE INDEX currency_balance_index ON accounts(currency,balance);



-- 6  Write a SQL transaction that illustrates money transaction from one account to another:
CREATE OR REPLACE PROCEDURE transfer_money(
    source_account varchar(40),
    destination_account varchar(40),
    money_number double precision,
    new_transaction_id integer
)
    LANGUAGE plpgsql
AS
    $$
DECLARE
    balance_sum double precision = (SELECT balance FROM accounts WHERE account_id = source_account LIMIT 1);
DECLARE
    account_limit double precision = (SELECT "limit" FROM accounts WHERE account_id = source_account LIMIT 1);
BEGIN
    -- create transaction with “init” status
    INSERT INTO transactions VALUES (new_transaction_id,clock_timestamp(),source_account,destination_account,money_number,'init');
    SAVEPOINT just_created_transaction_row;

    --  increase balance for destination account and decrease for source account
    UPDATE accounts
    SET balance = balance + money_number
    WHERE account_id = destination_account;

    UPDATE accounts
    SET balance = balance - money_number
    WHERE account_id = source_account;

    --  if in source account balance becomes below limit, then make rollback
    IF balance_sum - money_number < account_limit THEN
        ROLLBACK TO SAVEPOINT just_created_transaction_row;

        UPDATE transactions
        SET status = 'rollback'
        WHERE id = new_transaction_id;
    ELSE
        UPDATE transactions
        SET status = 'commit'
        WHERE id = new_transaction_id;
    END IF;

    RELEASE SAVEPOINT just_created_transaction_row;
    COMMIT;
END;
    $$;

call transfer_money('RS88012','NT10204',100,4);
