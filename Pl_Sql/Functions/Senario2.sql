CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount IN NUMBER,
    p_annual_interest_rate IN NUMBER,
    p_loan_duration_years IN NUMBER
) 
RETURN NUMBER
IS
    v_monthly_interest_rate NUMBER;
    v_total_payments NUMBER;
    v_monthly_installment NUMBER;
BEGIN
    -- Calculate the monthly interest rate
    v_monthly_interest_rate := p_annual_interest_rate / 12 / 100;

    -- Calculate the total number of payments
    v_total_payments := p_loan_duration_years * 12;
    
    -- Calculate the monthly installment
    IF v_monthly_interest_rate = 0 THEN
        -- Handle the case of zero interest rate
        v_monthly_installment := p_loan_amount / v_total_payments;
    ELSE
        v_monthly_installment := (p_loan_amount * v_monthly_interest_rate * 
                                  POWER(1 + v_monthly_interest_rate, v_total_payments)) /
                                 (POWER(1 + v_monthly_interest_rate, v_total_payments) - 1);
    END IF;
    
    RETURN v_monthly_installment;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred while calculating the monthly installment.');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        RETURN NULL;
END CalculateMonthlyInstallment;
/
