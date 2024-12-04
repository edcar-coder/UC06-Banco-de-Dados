-- TABLE USUARIO
CREATE TABLE IF NOT EXISTS USUARIO(
  ID SERIAL PRIMARY KEY,
  NOME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100)  NOT NULL UNIQUE,
  DATA_CADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--table EDITORA
 CREATE TABLE IF NOT EXISTS EDITORA(
 ID INT PRIMARY KEY,
 NOME VARCHAR(100) NOT NULL
);
--table GENERO
 CREATE TABLE IF NOT EXISTS GENERO(
 ID SERIAL PRIMARY KEY,
 DESCRICAO VARCHAR(50) NOT NULL UNIQUE
);
--TABLE LIVROS
 CREATE TABLE IF NOT EXISTS LIVRO(
 ID SERIAL PRIMARY KEY,
 TITULO VARCHAR(150) UNIQUE NOT NULL,
 QUANTIDADE_DISPONIVEL INT NOT NULL CHECK (quantidade_disponivel >= 0),
  ID_EDITORA INT NOT NULL,
 ID_GENERO INT NOT NULL,
 CONSTRAINT fk_livros_editora FOREIGN KEY (id_editora) REFERENCES editora (id) ON DELETE CASCADE,
 CONSTRAINT fk_livrtos_genero FOREIGN KEY (id_genero) REFERENCES genero (id) ON DELETE CASCADE
);
--TABLE EMPRESTIMO
CREATE TABLE IF NOT EXISTS EMPRESTIMO(
ID SERIAL PRIMARY KEY,
ID_USUARIO INT NOT NULL,
ID_LIVRO INT NOT NULL,
DATA_EMPRESTIMO  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DATA_DEVOLUCAO TIMESTAMP NOT NULL,
CONSTRAINT fk_emprestimo_usuario FOREIGN KEY(id_usuario) REFERENCES usuario (id) ON DELETE CASCADE,
CONSTRAINT fk_emprestimo_livro FOREIGN KEY(id_livro) REFERENCES livro(id) ON DELETE CASCADE
);


--\d usuario
--ADICIONAR UMMCAMPO PARA ARMAZENAR O TELEFONE DOS USUARIOS.
--ALTER TABLE USUARIOS ADD TELEFONE CHAR(11);
ALTER TABLE USUARIO ADD  COLUMN TELEFONE CHAR(11) NOT NULL DEFAULT 'NENHUM';

--altere o Tamanho do campo titulo na tablea livros para comportar ate 200 caracteres.
ALTER TABLE LIVRO ALTER COLUMN TITULO TYPE VARCHAR(200);
--\d LIVRO


--Remova  o campo data cadastro da tabela usuario, pois ele ão será mais utilizado.
ALTER TABLE USUARIO DROP DATA_CADASTRO;

--Garanta que o mesmo titulo de livro não possa ser registrado na mesma editora.
ALTER TABLE LIVRO ADD CONSTRAINT uq_livro_titulo_editora UNIQUE(TITULO, id_editora);

--Garantir que as datas de emprestimo e devolução sejam distintas a validas.
ALTER TABLE EMPRESTIMO ADD CONSTRAINT chk_data_devolucao CHECK (data_devolucao >= data_emprestimo);


INSERT INTO USUARIO (id, nome, email);
VALUES(1, 'Valtemir', 'valtemir@senac.br', '9999-9999');   
INSERT INTO USUARIO(id, nomr, email, telefone)
VALUES(2, 'Valtemir Junior', 'valtemirjr@senac.br');    --1 registro(;), mais de um (,)


SELECT *FROM USUARIO;


--\d livro







\dt;
\d usuario;
\d editora;
\d genero;
\d livro;
\d emprestimo
