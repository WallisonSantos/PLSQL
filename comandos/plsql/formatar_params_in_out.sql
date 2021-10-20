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

-- A expressão 'P_CNPJ' não pode ser usada como um destino de designação: (p_cnpj IN cliente.cnpj%TYPE) não posso designar esta variavel p_cnpj, um valor,
-- por que se esta variavel esta recebendo o parametro IN, ela não receber valor na procedure, ela esta como entrada. Logo é necessário outra variavel para receber este valor
-- Desta forma será criado uma outra variavel, p_cnpj_saida out cliente.cnpj%type, que terá seu tipo OUT, assim esta variavel pode sair da procedure com o valor de saida,
-- Diferente de IN ... Qual é o modo de passagem padrão, e quando omitido o IN ou o OUT o padrão será o IN !
-- Porém uma variavel pode ser IN e OUT ao mesmo tempo !

VARIABLE g_cnpj VARCHAR2(10)        ----------- variavel que vai passar o parametro / e variavel que vai receber a resposta da procedure
EXECUTE :g_cnpj := '12345'          ----------- Inicializa a variavel com o valor parametro
print :g_cnpj                       ---------- verificando a saida da procedure
EXECUTE formatar_cnpj(:g_cnpj)      ----------- executa a procedure
print :g_cnpj                       ----------- varificando a formatação aplicada pela procedure


                             





