SELECT * FROM tb_clientes;

SELECT NOME FROM TB_CLIENTES;

SELECT * FROM TB_PRODUTOS WHERE PRODUTO = '1037797';

SELECT * FROM tb_clientes WHERE CIDADE = 'Rio de Janeiro'; 

select * from tb_produtos where sabor = 'Laranja';

UPDATE tb_produtos SET sabor = 'CItrico' where sabor = 'Limão';

select * from tb_produtos where sabor = 'CItrico';

select * from tb_clientes where idade <> 22;

select * from tb_produtos where preco_lista >= 16.008

select * from tb_produtos where preco_lista <> 16.008;

select * from tb_produtos where preco_lista <= 16.008;

select * from tb_clientes where data_nascimento = TO_DATE('07/10/1995', 'DD/MM/YYYY');

SELECT * FROM tb_clientes WHERE data_nascimento <> TO_DATE('07/10/1995', 'DD/MM/YYYY');

SELECT * FROM tb_clientes WHERE data_nascimento > TO_DATE('07/10/1995', 'DD/MM/YYYY');

SELECT * FROM tb_clientes WHERE TO_CHAR(data_nascimento, 'MM') = 11;

SELECT * FROM tb_produtos WHERE PRECO_LISTA >= 16 AND preco_lista <=18;






