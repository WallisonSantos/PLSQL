-- Ajustando padrões de script 
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- Criando Usuario de interação com o Banco de Dados
CREATE USER cursoplsql IDENTIFIED BY cursoplsql DEFAULT TABLESPACE USERS;

-- Parametrizando acessos/conexões ao banco para o usuario
GRANT CONNECT, RESOURCE TO cursoplsql;

-- para se conectar acesse > Oracle Conexões, barra de opções(botão direito do mouse), Nova Conexão, Nomear Conexão,
-- nome do usuario precisa ser o usuario criado, senha especificar tbm o mesmo nome do usuario, demais configurar deixar o padrão.

-- INSTRUNÇÕES | FUNÇÕES
-- SELECT: Recuperação de dados,
-- INSERT, UPDATE, DELETE: Manipulação de dados,
-- CREATE, ALTER, DROP, RENAME, TRUNCATE: Definição de objetos,
-- COMMIT, ROLLBACK, SAVEPOINT: Controle de transações,
-- GRANT, REVOKE: Controle de acesso.
-- PL / SQL: Linguagem immperativa. Possibilita a criação de programas completos.
-- Linguagem proprietaria. Utilizada somente no ambiente SGBD Oracle

-- DECLARE: Entre o Declaire e o Begin, a gente vai fazer a declaração e definição de todos os componentes de trabalho do programa,
--- são váriaveis, constantes, e qualquer outro componente que vai ser utilizado e manipulado entre o Begin e End,
-- BEGIN: Entre o Begin e End irá ter os comandos de execução, componentes que serão utilizados e manipulados,
--- os comandos de execução podem ser comandos SQL ou comandos de Lógica, que vão criar a estrutura do nosso programa
-- END: finaliza a execução de um comando SQL ou comando de Lógica, pl/sql criado.

-- Sempre que usado a biblioteca: Por padrão esta opção é Off, ao usar On, o dbms pode escrever nesta area da saida do script;
set serveroutput on; 

-- Primeiro Bloco Pl/Sql (importante o uso correto do " ; ")
DECLARE
-- se declarado uma variavel mas não foi atribuido nenhum valor, neste caso o valor é nulo,
-- este valor atribuido poderá mudar durante a execução do programa, basta escrever a variavel dentro de Begin :=
    v_ID number(5) := 1; 
BEGIN
-- Exibir valores de uma variavel:
    v_ID := 2;
    dbms_output.put_line(v_ID);
END;

-- DIGITE E EXECUTE O COMANDO ABAIXO PARA CRIAR A CHAVE PRIARIA DA TABELA SEGMERCADO E CLIENTE:
ALTER TABLE SEGMERCADO ADD CONSTRAINT SEGMERCADO_ID_PK PRIMARY KEY (ID);
ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_ID_PK PRIMARY KEY (ID);

-- PARA CRIAR A CONEXÃO ENTRE AS DUAS TABELAS DIGITE E EXECUTE:
ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_SEGMERCADO_FK FOREIGN KEY (SEGMERCADO_ID) REFERENCES SEGMERCADO(ID);

-- CONCEDER PRIVILEGIOS ILIMITADOS AO USUARIO (PRECISA ESTAR COM ACESSO AO BANCO COMO SYSTEM DBA: 
ALTER USER cursoplsql QUOTA UNLIMITED ON USERS;

-- Declarando variaveis (v_id e v_descricao) e inserindo na tabela com o comando estruturado Declare, Begin e End:
DECLARE
    v_id        NUMBER(5) := 1;
    v_descricao VARCHAR(100) := 'Varejo';
BEGIN
    INSERT INTO segmercado (
        id,
        descricao
    ) VALUES (
        v_id,
        v_descricao
    );

    COMMIT;
END;


-- usando o Percent Type na declaração da variável, onde vai dizer, 
-- que a determinada variavel terá o msm tipo que existe num CAMPO de uma determinada tabela,
-- faça isto para precaver uma alteração do tipo da variavel, ex.: modificação do tamanho aceitavel nesse campo por um DBA,
DECLARE
    v_id segmercado.id%TYPE := 2;    -- Herdará o tipo de id,
    v_descricao segmercado.descricao%TYPE := 'Atacado';    -- Herdará o tipo de descricao
BEGIN
    INSERT INTO segmercado (
        id, -- tem o tipo definido como NUMBER(5,0)
        descricao -- tem o tipo definido como VARCHAR2(100 BYTE)
    ) VALUES (
        v_id,
        v_descricao
    );
    COMMIT;
END;

-- Por que é importante usarmos um padrão para salvar os dados textos em uma tabela?
-- Para não haver problemas na busca de um conteúdo de um campo texto
-- Como o Oracle distingue minúsculas de maiúsculas, se não usarmos um padrão específico 
-- (gravar tudo em minúsculos ou em maiúsculos), teremos problemas ao recuperar o dado, já que nunca saberemos como devemos 
-- fazer a busca. Assim, ficaremos dependendo da forma com que o campo texto foi digitado e gravado.
-- Forçar a caixa das letras, ao inserir texto, Caixa alta, ou baixa ou capitalizada (Upper, Lower)
DECLARE
    v_id        segmercado.id%TYPE := 2;
    v_descricao segmercado.descricao%TYPE := 'Atacado';
BEGIN
    INSERT INTO segmercado (
        id,
        descricao
    ) VALUES (
        v_id,
        upper(v_descricao)
    );
    COMMIT;
END;

-- fazer uma atualização no meu campo descrição usando update 
DECLARE
    v_id        segmercado.id%TYPE := 2;
    v_descricao segmercado.descricao%TYPE := 'Atacadista';
BEGIN
---------------------------------------------------------------------------------------------------------
    UPDATE segmercado
    SET
        descricao = upper(v_descricao)
    WHERE
        id = v_id; -- fazer isso somente para onde meu campo houver a variavel v_id = 2, informado acima,
----------------------------------------------------------------------------------------------------------    
    v_id := 1; -- definindo novo valor para as variaveis
    v_descricao := 'Varejista'; -- definindo novo valor para as variaveis
    UPDATE segmercado
    SET
        descricao = upper(v_descricao)
    WHERE
        id = v_id; -- fazer isso somente para onde meu campo houver a variavel v_id = 2, informado acima,
---------------------------------------------------------------------------------------------------------
    COMMIT;
END;


-- fazer a exclusão, deletar, no meu campo descrição usando delete 
DECLARE
    v_id segmercado.id%TYPE := 3;
BEGIN
    delete FROM segmercado WHERE ID = v_id; 
    commit;
END;


    



