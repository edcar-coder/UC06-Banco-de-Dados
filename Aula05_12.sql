--TABLE USUARIO
 CREATE TABLE IF NOT EXISTS USUARIO(
  ID SERIAL PRIMARY KEY,
  NOME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100)  NOT NULL UNIQUE,
  DATA_CADASTRO TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--table EDITORA
 CREATE TABLE IF NOT EXISTS EDITORA(
 ID INT PRIMARY KEY,
 NOME VARCHAR(100) NOT NULL UNIQUE
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
\d USUARIO

INSERT INTO USUARIO (id, nome, email, TELEFONE)
VALUES(1, 'Valtemir', 'valtemir@senac.br', '9999-9999');   

INSERT INTO USUARIO(id, nome, email, telefone)
VALUES (2, 'Valtemir Junior', 'valtemirjr@senac.br', '9999-9999');    --1 registro(;), mais de um (,)
SELECT *FROM USUARIO;

INSERT INTO EDITORA(ID, NOME)
VALUES (1, 'SENAC'), (2, 'Sesc'), (3, 'Mundo'), (4, 'Dark Side');
SELECT *FROM EDITORA;

INSERT INTO GENERO(ID, DESCRICAO)
VALUES(1, 'Terror'), (2, 'Drama'), (3, 'Romance'), (4, 'Ficcao'), (5, 'Infantil');
SELECT *FROM GENERO;

INSERT INTO LIVRO( titulo,quantidade_disponivel,id_editora,id_genero)
VALUES
('A volta dos que nao foram', 8, 1, 4),
('Te pedo la fora', 3, 3, 5),
('Moana', 7, 4, 1),
('O pequeno principe', 9, 4, 2), 
('Muana', 8, 3, 3);
SELECT *FROM LIVRO;

INSERT INTO EMPRESTIMO(ID_USUARIO, ID_LIVRO, DATA_DEVOLUCAO)
VALUES
(1, 4, '2024-12-06'),
(1, 4, '2024-12-06');

SELECT *FROM EMPRESTIMO;



--\d livro







\dt;
\d usuario;
\d editora;
\d genero;
\d livro;
\d emprestimo
