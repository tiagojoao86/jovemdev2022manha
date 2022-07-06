--- #COMANDOS DTL (CONTROLE DE TRANSAÇÃO)
BEGIN; -- INICIA A TRANSAÇÃO
    delete from payment where customer_id = 1;
    delete from rental where customer_id = 1;
    delete from customer where customer_id = 1;
ROLLBACK; -- VOLTA A TRANSAÇÃO
COMMIT; -- CONFIRMA A TRANSAÇÃO
