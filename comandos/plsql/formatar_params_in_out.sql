CREATE OR REPLACE PROCEDURE formatar_cnpj (
    p_cnpj IN OUT cliente.cnpj%TYPE
) IS
BEGIN
    p_cnpj := substr(p_cnpj, 1, 2)
              || '.'
              || substr(p_cnpj, 3, 3)
              || '.'
              || substr(p_cnpj, 6, 3)
              || '/'
              || substr(p_cnpj, 9, 4)
              || '-'
              || substr(p_cnpj, 13, 2);
-- 23 . 314 . 992 / 0001 - 21
END;

-- A express�o 'P_CNPJ' n�o pode ser usada como um destino de designa��o: (p_cnpj IN cliente.cnpj%TYPE) n�o posso designar esta variavel p_cnpj, um valor,
-- por que se esta variavel esta recebendo o parametro IN, ela n�o receber valor na procedure, ela esta como entrada. Logo � necess�rio outra variavel para receber este valor
-- Desta forma ser� criado uma outra variavel, p_cnpj_saida out cliente.cnpj%type, que ter� seu tipo OUT, assim esta variavel pode sair da procedure com o valor de saida,
-- Diferente de IN ... Qual � o modo de passagem padr�o, e quando omitido o IN ou o OUT o padr�o ser� o IN !
-- Por�m uma variavel pode ser IN e OUT ao mesmo tempo !

VARIABLE g_cnpj VARCHAR2(10)        ----------- variavel que vai passar o parametro / e variavel que vai receber a resposta da procedure
EXECUTE :g_cnpj := '12345'          ----------- Inicializa a variavel com o valor parametro
print :g_cnpj                       ---------- verificando a saida da procedure
EXECUTE formatar_cnpj(:g_cnpj)      ----------- executa a procedure
print :g_cnpj                       ----------- varificando a formata��o aplicada pela procedure


                             





