BEGIN;

-- Criando a tabela autor
CREATE TABLE autor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    data_nascimento DATE,
    CONSTRAINT chk_data_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);

-- Criando a tabela livro
CREATE TABLE livro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(60) NOT NULL,
    id_autor INT,
    ano_publicacao INT,
    CONSTRAINT fk_autor_livro FOREIGN KEY (id_autor) REFERENCES autor(id),
    CONSTRAINT chk_ano_publicacao CHECK (ano_publicacao >= 1500 AND ano_publicacao <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Criando a tabela usuario
CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(60) UNIQUE,
    data_adesao DATE,
    CONSTRAINT chk_data_adesao CHECK (data_adesao <= CURRENT_DATE)
);

-- Criando a tabela emprestimo
CREATE TABLE emprestimo (
    id SERIAL PRIMARY KEY,
    id_livro INT,
    id_usuario INT,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE NOT NULL,
    CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES livro(id),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    CONSTRAINT chk_data_emprestimo CHECK (data_emprestimo <= data_devolucao),
    CONSTRAINT uq_livro_emprestimo UNIQUE (id_livro, data_emprestimo)
);

-- Inserindo dados na tabela autor
INSERT INTO autor(nome, data_nascimento)
VALUES
('Joao de Souza', '1959-05-17'),
('Maria Bonita', '1978-07-26'),
('Fernando Goss', '1994-02-21'),
('Eron Carter', '2001-11-09'),
('Joao Manoel', '2000-04-03');

-- Inserindo dados na tabela livro
INSERT INTO livro(titulo, id_autor, ano_publicacao)
VALUES
('Ó paio ó', 1, 2009),
('Madagascar', 2, 2022),
('Quem matou Ruth', 3, 1999),
('Sopraram o telhado', 4, 2021),
('Meu Cachorro comeu almoço', 5, 2023);

-- Inserindo dados na tabela usuario
INSERT INTO usuario(nome, email, data_adesao)
VALUES
('Paulo Jose', 'paulo@email.com', '2002-10-16'),
('George Gomes', 'george@email.com', '2018-08-04'),
('Joel Santos', 'joel@email.com', '1996-06-20'),
('Vilas Boas', 'vilas@email.com', '2021-05-27'),
('Naruto Pain', 'naruto@email.com', '2023-07-23');

-- Corrigindo os dados de id_usuario para IDs válidos
INSERT INTO emprestimo(id_livro, id_usuario, data_emprestimo, data_devolucao)
VALUES
(2, 3, '2020-12-20', '2021-10-20'),
(3, 4, '2019-03-19', '2022-04-24'),
(3, 4, '2016-09-23', '2019-11-29'),
(1, 2, '2011-03-06', '2012-03-06'),
(4, 5, '2015-12-19', '2017-04-18');

-- Listar autores
SELECT * FROM autor;

-- Listar livros
SELECT * FROM livro;

-- Listar empréstimos
SELECT * FROM emprestimo;

-- Listar todos os livros com seus respectivos autores
SELECT livro.titulo, autor.nome
FROM autor
JOIN livro ON livro.id_autor = autor.id;

-- Listar os livros que ainda não foram devolvidos
SELECT livro.titulo, emprestimo.data_devolucao
FROM emprestimo
JOIN livro ON emprestimo.id_livro = livro.id
WHERE emprestimo.data_devolucao IS NULL;

-- Listar os usuários e seus emails
SELECT nome, email FROM usuario;

-- Mostrar todos os empréstimos realizados, incluindo as informações do livro, do usuário e das datas
SELECT usuario.nome, livro.titulo, emprestimo.data_emprestimo, emprestimo.data_devolucao
FROM emprestimo
JOIN livro ON emprestimo.id_livro = livro.id
JOIN usuario ON emprestimo.id_usuario = usuario.id;

-- Listar os livros que ainda não foram devolvidos
SELECT livro.titulo, emprestimo.data_devolucao
FROM emprestimo
JOIN livro ON emprestimo.id_livro = livro.id
JOIN usuario ON emprestimo.id_usuario = usuario.id
JOIN autor ON livro.id_autor = autor.id
WHERE emprestimo.data_devolucao IS NULL;

-- Encontrar os usuários que pegaram emprestado livros do autor 'Paulo José'
SELECT usuario.nome AS nome_usuario, livro.titulo
FROM emprestimo
JOIN livro ON emprestimo.id_livro = livro.id
JOIN usuario ON emprestimo.id_usuario = usuario.id
JOIN livro_autor ON livro.id = livro_autor.id_livro
JOIN autor ON livro_autor.id_autor = autor.id
WHERE autor.nome = 'Paulo José';

COMMIT;
