SELECT
    cadastro.cpf,
    cadastro.nome,
    vendas.mes_ano,
    cadastro.volume_de_compra,
    vendas.volume_vendido
FROM
         (
        SELECT
            nf.cpf,
            to_char(nf.data_venda, 'YYYY-MM') AS mes_ano,
            SUM(inf.quantidade)               AS volume_vendido
        FROM
                 notas_fiscais nf
            INNER JOIN itens_notas_fiscais inf ON nf.numero = inf.numero
        GROUP BY
            nf.cpf,
            to_char(nf.data_venda, 'YYYY-MM')
    ) vendas
    INNER JOIN (
        SELECT
            cpf,
            nome,
            volume_de_compra
        FROM
            tabela_de_clientes
    ) cadastro ON vendas.cpf = cadastro.cpf
    WHERE vendas.mes_ano like '2018-01';
    
ALTER TABLE ITENS_NOTAS_FISCAIS RENAME TO TABELA_DE_ITENS;
    
CREATE TABLE PRODUTOS
(CODIGO VARCHAR(10) NOT NULL,
DESCRITOR VARCHAR(100) NULL,
SABOR VARCHAR(50) NULL,
TAMANHO VARCHAR(50) NULL,
EMBALAGEM VARCHAR(50) NULL,
PRECO_LISTA FLOAT NULL,
PRIMARY KEY (CODIGO));

CREATE TABLE VENDEDORES
(MATRICULA VARCHAR(5) NOT NULL,
NOME VARCHAR(100) NULL,
BAIRRO VARCHAR(50) NULL,
COMISSAO FLOAT NULL,
DATA_ADIMISSAO DATE NULL,
FERIAS INTEGER NULL,
PRIMARY KEY (MATRICULA));

ALTER TABLE VENDEDORES RENAME COLUMN DATA_ADIMISSAO TO DATA_ADMISSAO;

CREATE TABLE CLIENTES
(CPF VARCHAR(11) NOT NULL,
NOME VARCHAR(100) NULL,
ENDERECO VARCHAR(150) NULL,
BAIRRO  VARCHAR(50) NULL,
CIDADE VARCHAR(50) NULL,
ESTADO VARCHAR(50) NULL,
CEP  VARCHAR(10) NULL,
DATA_NASCIMENTO DATE NULL,
IDADE INTEGER NULL,
SEXO VARCHAR(1) NULL,
LIMITE_CREDITO FLOAT NULL,
VOLUME_COMPRA FLOAT NULL,
PRIMEIRA_COMPRA INTEGER NULL,
PRIMARY KEY (CPF));

DROP TABLE CLIENTES;

CREATE TABLE TB_VENDAS
(
  NUMERO VARCHAR(5) NOT NULL
, DATA_VENDA DATE NULL
, CPF  VARCHAR(11) NOT NULL
, MATRICULA  VARCHAR(5) NOT NULL
, IMPOSTO FLOAT NULL
, PRIMARY KEY(NUMERO)
);

-- CHAVE ESTRANGEIRA, FOCO NA TABELA INFERIOR, QUE É A TABELA FILHA, TABELA NOTAS (ALTER TABLE)
-- TODA A CHAVE ESTRANGEIRA, É CONSIDERADA UMA RESTRIÇÃO, POIS VAI RESTRINGIR O CONTEÚDO DOS CAMPOS DESTA LIGAÇÃO, TERÁ UMA REGRA.
ALTER TABLE TB_VENDAS
ADD CONSTRAINT FK_CLIENTES
FOREIGN KEY (CPF) REFERENCES CLIENTES (CPF);

ALTER TABLE TB_VENDAS
ADD CONSTRAINT FK_VENDEDORES
FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA);

ALTER TABLE VENDEDORES RENAME TO TB_VENDEDORES;

CREATE TABLE TB_ITEM_NOTAS
(NUMERO VARCHAR(5) NOT NULL,
CODIGO VARCHAR(10) NOT NULL,
QUANTIDADE INTEGER NULL,
PRECO FLOAT NULL,
PRIMARY KEY (NUMERO, CODIGO));

ALTER TABLE TB_ITEM_NOTAS
ADD CONSTRAINT FK_NOTAS
FOREIGN KEY (NUMERO) REFERENCES TB_VENDAS (NUMERO);

ALTER TABLE TB_ITEM_NOTAS
ADD CONSTRAINT  FK_PRODUTOS
FOREIGN KEY (CODIGO) REFERENCES TB_PRODUTOS (CODIGO);

-- Inserir varias linhas na tabela:
INSERT ALL
INTO TB_PRODUTOS (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
VALUES ('1141414', 'Light - 350 ml - Guarana', 'Guarana', '350 ml', 'Lata', 5.6)
INTO TB_PRODUTOS (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
VALUES ('1141415', 'Light - 350 ml - Uva', 'Uva', '350 ml', 'Lata', 5.6)
INTO TB_PRODUTOS (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
VALUES ('1141416', 'Light - 350 ml - Limao', 'Limao', '350 ml', 'Lata', 5.6)
SELECT * FROM DUAL;

SELECT * FROM tb_produtos;

-- Inserir uma tabela da base de dados, em outra tabela da base de dados (com exceção de Primary Key)
INSERT INTO TB_PRODUTOS
SELECT
    codigo_do_produto as codigo,
    nome_do_produto as descritor,
    sabor,
    tamanho,
    embalagem,
    preco_de_lista as preco_lista
FROM
    tabela_de_produtos
WHERE codigo_do_produto <> 1040107;

select * from tabela_de_clientes WHERE SABOR = 'Maracuja';

UPDATE tb_produtos SET preco_lista = 5 WHERE CODIGO LIKE '%1141414%';
UPDATE tb_produtos SET preco_lista = 5 WHERE PRECO_LISTA >= 5;
UPDATE tb_produtos SET preco_lista = preco_lista * 1.10 WHERE SABOR = 'Maracuja';

UPDATE tabela_de_clientes
    SET
        ENDERECO_1 = 'Rua Emilio Jorge, 23'
        , BAIRRO = 'Santo Amaro'
        , CIDADE = 'Sao Paulo'
        , ESTADO = 'SP'
        , CEP = '8833233'
    WHERE CPF = '19290992743';

select * from tabela_de_vendedores;

UPDATE tb_vendedores set matricula = '238' WHERE matricula LIKE '%00238%';

UPDATE tabela_de_vendedores SET DE_FERIAS = 1 WHERE matricula IN ('00236','00237');
UPDATE tabela_de_vendedores SET DE_FERIAS = 1 WHERE matricula IN ('00235','00238');

-- USANDO SUBSTRING NA PRATICA
SELECT
    A.MATRICULA
    , B.MATRICULA
    , A.NOME
    , A.FERIAS
    , B.DE_FERIAS
FROM
    tb_vendedores A
    INNER JOIN tabela_de_vendedores B
    ON A.MATRICULA = SUBSTR(B.MATRICULA, 3, 3);

-- TABELAS SINCORNIZADAS, POR UPDATE, ATUALIZAÇÃO (EXISTS)
SELECT
    A.MATRICULA
    , A.NOME
    , A.FERIAS
FROM
    tb_vendedores A
WHERE EXISTS
    (SELECT 1 FROM tabela_de_vendedores B
    WHERE A.MATRICULA = SUBSTR(B.MATRICULA, 3,3));

-- FAZER ATUALIZAÇÕES/ALTERAR CAMPOS DE ACORDO COM OUTRA TABELA
UPDATE tb_vendedores A SET a.ferias = 
(SELECT b.de_ferias FROM tabela_de_vendedores B
WHERE A.matricula = SUBSTR(b.matricula, 3, 3))
WHERE EXISTS (SELECT 1 FROM tabela_de_vendedores B
WHERE a.matricula = SUBSTR(b.matricula, 3, 3));

INSERT INTO tabela_de_vendedores
    (matricula
    , nome
    , percentual_comissao
    , data_admissao
    , de_ferias
    , bairro)
values
    ('00239'
    , 'jose'
    , 0.12
    , TO_DATE('2018-01-01', 'YYYY-MM-DD')
    , 1
    , 'Tijuca');

select * from tb_produtos where substr(descritor, 1, 19) = 'Festival de Sabores';

select
    b.nome_do_produto
    , sum(preco_lista)
from
    tb_produtos a
        INNER JOIN tabela_de_produtos b
        ON a.descritor = b.nome_do_produto
            where b.nome_do_produto like '%Videira do Campo%'
                group by
                    b.nome_do_produto;

-- Quantidade de caracteres na Coluna Nome do Produto
SELECT nome_do_produto, length(nome_do_produto) FROM tabela_de_produtos;

-- Selecionando as linhas onde no Campo Nome do Produto temos Videira do Campo
select
    *
from
    tabela_de_produtos
    where substr(nome_do_produto, 1, 39)
    like '%Videira do Campo%';

-- Selecionando as chaves primarias Código, da tabela copia (Tb Produtos), onde na tabela original (Tabela de Produtos) não existe, depois dando DELETE
SELECT
    *
FROM
    TB_PRODUTOS
WHERE
    CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM TABELA_DE_PRODUTOS);

DELETE
FROM
    TB_PRODUTOS
WHERE
    CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM TABELA_DE_PRODUTOS);

delete from tb_produtos where codigo = '243083';
select count(*) from tb_produtos; -- 31
select count(*) from tabela_de_produtos; -- 31

select
    table_name
    , iot_name
    , iot_type
    , external
    , partitioned
    , temporary
    , cluster_name
from
    dba_tables;

-- CRIAR UMA TABELA CÓPIA DA TABELA TB PRODUTOS;
CREATE TABLE t_produtos AS ( SELECT * FROM tb_produtos);

UPDATE t_produtos SET preco_lista = 10.90;

DELETE FROM t_produtos;

UPDATE tb_vendedores SET COMISSAO = COMISSAO * 1.15;
SELECT * FROM TB_VENDEDORES;

update tb_vendedores set nome = 'Wallison Tiago Assis' where matricula = '238';

COMMIT;
ROLLBACK;

-- Campo com Auto Incremento (usando ID nas colunas) 'Quando encontrar nulo substituir por identity.'
CREATE TABLE tab_identity (
    id        NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY,
    descritor VARCHAR(20),
    PRIMARY KEY ( id )
);

SELECT * FROM tab_identity;
DESC tab_identity;

-- AO INCREMENTAR ID, ELE SEMPRE IRÁ MANTER A SEQUENCIA QUE É GERENCIADA INTERNAMENTE, MESMO APÓS SER DELETADO,
-- ELE MANTÉM A SEQUENCIA
INSERT INTO tab_identity (DESCRITOR) VALUES ('CLIENTE 1');
INSERT INTO tab_identity (DESCRITOR) VALUES ('CLIENTE 2');
INSERT INTO tab_identity (descritor) VALUES ('CLIENTE 3');
DELETE FROM tab_identity WHERE ID LIKE '%3%';
INSERT INTO tab_identity (DESCRITOR) VALUES ('CLIENTE 4');
DELETE FROM tab_identity WHERE ID LIKE '%4%';
INSERT INTO tab_identity (DESCRITOR) VALUES ('CLIENTE 5');

-- AO TENTAR FORÇAR UMA NUMERAÇÃO MANUALMENTE NO ID, APESAR DO ORACLE PERMITIR, TEREMOS PROBLEMA QUANDO O GERENCIADOR 
-- GERAR AUTOMATICAMENTE A MESMA NUMERAÇÃO QUE FORÇAMOS INICIALMENTE POIS ESTE CAMPO É PRIMARY KEY
INSERT INTO tab_identity (ID, DESCRITOR) VALUES (7, 'CLIENTE 7');
INSERT INTO tab_identity (DESCRITOR) VALUES ('CLIENTE 6');
INSERT INTO tab_identity (DESCRITOR) VALUES ('CLIENTE 7A');

-- FAZENDO A EXCLUSÃO DA INSERÇÃO AUTOMATICA, PORÉM A SEQUENCIA 7 SERÁ PERDIDA,
DELETE FROM tab_identity WHERE ID LIKE '%7%';

-- AUTO INCREMENTO
INSERT INTO tab_identity (ID, DESCRITOR) VALUES (NULL, 'CLIENTE A');

-- aprendemos antes que: Campo com Auto Incremento (usando ID nas colunas) 'Quando encontrar nulo substituir por identity.'
-- más podemos forçar que a coluna tenha um certo valor caso seja omitido este valor durante o comando de insert
-- (definir outros padrões caso Null) se não encrontrar nada inserir Rio de Janeiro = DEFAULT ON NULL 'Rio de Janeiro'
CREATE TABLE TAB_PADRAO
(ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
DESCRITOR VARCHAR(10) NOT NULL,
ENDERECO VARCHAR(100) NULL,
CIDADE VARCHAR(50) DEFAULT ON NULL 'Rio de Janeiro',
DATA_CRIACAO DATE DEFAULT ON NULL SYSDATE, -- DATA DO SISTEMA
PRIMARY KEY (ID));

INSERT INTO TAB_PADRAO (DESCRITOR, ENDERECO, CIDADE, DATA_CRIACAO)
VALUES
('CLIENTE 1', 'RUA UM', 'SAO PAULO', TO_DATE('2019-01-01','YYYY-MM-DD'));

-------------------------------------------------------------------------------------------------------------------------

DROP TABLE TB;

CREATE TABLE TB
(ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
DESCRITOR VARCHAR(100) NOT NULL,
ENDERECO VARCHAR(100) DEFAULT ON NULL 'Sem Logradouro',
CIDADE VARCHAR(100) DEFAULT ON NULL 'Sao Paulo',
DATA_CRIACAO DATE DEFAULT ON NULL SYSDATE,
PRIMARY KEY(ID));

INSERT INTO TB
    (DESCRITOR
    , ENDERECO
    , CIDADE
    , DATA_CRIACAO)
VALUES
    ('CLIENTE Y'
    , 'RUA PROJETADA'
    , 'SAO PAULO'
    , TO_DATE('2021-01-01','YYYY-MM-DD'));

INSERT INTO TB
    (DESCRITOR)
VALUES
    ('CLIENTE Y');

SELECT * FROM TB;

UPDATE TB SET ID = 1 WHERE ID LIKE '%3%';

-- Trigger (Gatilho): Uma trigger é um tipo especial de procedimento armazenado executado automaticamente quando
-- um evento ocorre no servidor de banco de dados. Evento pode ser, Incluir, Recuperar, Atualizar ou Deletar.
-- Ex.: ao incluir dados em uma tabela, é atualizado um log com data e hora.
CREATE TABLE TB_FATUR
(DATA_VENDA DATE NULL, TOTAL_VENDA FLOAT);

CREATE TABLE TB_NOTAS
(
    NUMERO INTEGER NOT NULL
    , DATA_VENDA DATE NULL
    , CPF VARCHAR(20) NOT NULL
    , MATRICULA VARCHAR(10) NOT NULL
    , IMPOSTO FLOAT NOT NULL
    , PRIMARY KEY (NUMERO)
);

INSERT INTO TB_NOTAS
(
    NUMERO
    , DATA_VENDA
    , CPF
    , MATRICULA
    , IMPOSTO
) VALUES
(
    '0110'
    , TO_DATE('2019-06-05', 'YYYY-MM-DD')
    , '1471156710'
    , '235'
    , 0.10
);
    
SELECT * FROM TABELA_DE_CLIENTES;


















