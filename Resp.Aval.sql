ATIVIDADE BANCO DE DADOS - SQL
1. Considere o seguinte banco de dados de uma Empresa.
ESQUEMA DO BANCO DE DADOS
Produtos Fornecedores
Coluna Tipo Coluna Tipo
id(PK) SERIAL id(PK) SERIAL
NOME VARCHAR (255) NOME VARCHAR (255)
QUANTIDADE INTEGER RUA VARCHAR (255)
PRECO NUMERIC(10,2) CIDADE VARCHAR (255)
idFORNECEDOR (FK) INTEGER ESTADO CHAR (2)
idCATEGORIA(FK) INTEGER
Categorias
Coluna Tipo
id (PK) SERIAL
NOME VARCHAR (255)
BASE DE DADOS
Produtos
id NOME QUANTIDADE PRECO IdFORNECEDOR idCATEGORIAS
1 Cadeira azul 30 300.00 5 5
2 Cadeira vermelha 50 2150.00 2 1
3 Guarda-roupa Disney 400 829.50 4 1
4 Torradeira Azul 20 9.90 3 1
5 TV 30 3000.25 2 2
Fornecedores
id NOME RUA CIDADE ESTADO
1 Ajax SA Rua Presidente Castelo Branco Porto Alegre RS
2 Sansul SA Av Brasil Rio de Janeiro RJ
3 South Chairs Rua do Moinho Santa Maria RS
4 Elon Electro Rua Apolo São Paulo SP
5 Mike electro Rua Pedro da Cunha Curitiba PR
Categorias
id NOME
1 Super Luxo
2 Importado
3 Tecnologia
4 Vintage
5 Supremo
ESCREVA OS COMANDOS SQL NECESSÁRIOS PARA:
Após criar as tabelas:
1. Crie uma regra para garantir que o nome de um produto seja único na tabela produtos.
2. Defina uma constraint para garantir que o preço dos produtos nunca seja menor que zero.
3. Implemente uma constraint que assegure que a coluna quantidade na tabela produtos nunca seja
nula.
4. Adicione uma constraint para garantir que o estado dos fornecedores sempre siga o padrão de
duas letras, como "SP" ou "RJ".
5. Crie uma constraint para que o nome das categorias na tabela categorias seja único.
6. INSERIR dados de 2 produtos de categoria 3 e qualquer fornecedor
7. INSERIR dados de 2 fornecedores distintas, sendo do Estado do RN e outro do estado
da PB;
8. INSERIR dados de mais 1 categoria de nome Nacional
9. ATUALIZE a tabela produtos, aumentando o preço do produto cujo id é 4, para R$ 298.00;
RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no RJ;
10. RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado no RS;
11. RECUPERE da tabela produtos, todos os produtos do Fornecedor localizado em SP;
12. RECUPERE da tabela produtos e fornecedores o nome do produto mais caro e o nome do
fornecedor deste produto;
13. ATUALIZE a tabela fornecedores, alterando a cidade para Parnamirim, o estado para RN e a Rua
para Abel Cabral, do Fornecedor cujo nome é Elon Electro;
14. ATUALIZE a tabela produtos, alterando o preço dos produtos em 10% de aumento, cujo
fornecedor seja Sansul SA.
15. ATUALIZE a tabela produtos, alterando o preço dos produtos em 10% de diminuição, cujo
fornecedor seja Mike electro e a categoria seja Supremo.
16. RECUPERE da tabela produtos, todos os produtos que tenham o preço entre 8 e 2.000,
ordenados a partir do maior preço.
17. RECUPERE da tabela produtos, todos os produtos que tenham o preço entre maior que 2.000,
ordenados a partir do menor preço.
18. RECUPERE da tabela fornecedor, o nome de todos os fornecedores que iniciam com a letra
A.
19. RECUPERE da tabela fornecedor, o nome de todos os fornecedores que contenham a letra
S.
20. ATUALIZE a tabela produtos, aumentando em 15% a quantidade de produtos que tenham o
preço inferior a 300.
21. APAGUE da tabela produtos todas os produtos da categoria 5;
22. RECUPERE da tabela fornecedores, todos os registros cadastrados;
23. RECUPERE da tabela produtos, o nome dos produtos que iniciam com a letra T e tenham o preço
acima de 400.
24. APAGUE a tabela produtos;

EXPECTATIVAS DE RESPOSTAS
-- Criação das Tabelas
CREATE TABLE IF NOT EXISTS Fornecedores (
id SERIAL PRIMARY KEY,
NOME VARCHAR(255),
RUA VARCHAR(255),
CIDADE VARCHAR(255),
ESTADO CHAR(2)
);
CREATE TABLE IF NOT EXISTS Categorias (
id SERIAL PRIMARY KEY,
NOME VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Produtos (
id SERIAL PRIMARY KEY,
NOME VARCHAR(255),
QUANTIDADE INTEGER,
PRECO NUMERIC(10, 2),
idFORNECEDOR INTEGER,
idCATEGORIA INTEGER,
CONSTRAINT fk_fornecedor
FOREIGN KEY (idFORNECEDOR)
REFERENCES Fornecedores(id)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_categoria
FOREIGN KEY (idCATEGORIA)
REFERENCES Categorias(id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
-- 1. Garantir que o nome de um produto seja único na tabela produtos
ALTER TABLE produtos
ADD CONSTRAINT unique_nome_produto UNIQUE (nome);
-- 2. Garantir que o preço dos produtos nunca seja menor que zero
ALTER TABLE produtos
ADD CONSTRAINT check_preco_produto CHECK (preco >= 0);
-- 3. Garantir que a coluna quantidade na tabela produtos nunca seja nula
ALTER TABLE produtos
ALTER COLUMN quantidade SET NOT NULL;
-- 4. Garantir que o estado dos fornecedores siga o padrão de duas letras
ALTER TABLE fornecedores
ADD CONSTRAINT check_estado_fornecedor CHECK (estado ~ '^[A-Z]{2}$');
-- 5. Garantir que o nome das categorias seja único
ALTER TABLE categorias
ADD CONSTRAINT unique_nome_categoria UNIQUE (nome);
-- Inserir dados de 2 produtos na categoria 3 e qualquer fornecedor (Questão 6)
INSERT INTO produtos (nome, quantidade, preco, idFornecedor, idCategoria)
VALUES
('Notebook Gamer', 10, 4500.00, 1, 3),
('Mouse Óptico', 50, 150.00, 2, 3);
-- Inserir dados de 2 fornecedores distintos, sendo um do RN e outro da PB (Questão 7)
INSERT INTO fornecedores (nome, rua, cidade, estado)
VALUES
('Tech RN', 'Av. Rio Branco', 'Natal', 'RN'),
('Distribuidora PB', 'Rua das Flores', 'João Pessoa', 'PB');
-- Inserir uma nova categoria de nome "Nacional" (Questão 8)
INSERT INTO categorias (nome)
VALUES ('Nacional');
-- Atualizar o preço do produto com id = 4 para R$ 298,00 (Questão 9)
UPDATE produtos
SET preco = 298.00
WHERE id = 4;
-- Recuperar todos os produtos do fornecedor localizado no RJ (Questão 10)
SELECT * FROM produtos
WHERE idFornecedor IN (
SELECT id FROM fornecedores WHERE estado = 'RJ'
);
-- Recuperar todos os produtos do fornecedor localizado no RS (Questão 11)
SELECT * FROM produtos
WHERE idFornecedor IN (
SELECT id FROM fornecedores WHERE estado = 'RS'
);
-- Recuperar todos os produtos do fornecedor localizado em SP (Questão 12)
SELECT * FROM produtos
WHERE idFornecedor IN (
SELECT id FROM fornecedores WHERE estado = 'SP'
);
-- Recuperar o nome do produto mais caro e o nome do fornecedor deste produto (Questão 13)
SELECT p.nome AS produto, f.nome AS fornecedor
FROM produtos p
JOIN fornecedores f ON p.idFornecedor = f.id
ORDER BY p.preco DESC
LIMIT 1;
-- Atualizar o fornecedor "Elon Electro" para cidade Parnamirim, estado RN e rua Abel Cabral (Questão
14)
UPDATE fornecedores
SET cidade = 'Parnamirim', estado = 'RN', rua = 'Abel Cabral'
WHERE nome = 'Elon Electro';
-- Atualizar os preços dos produtos em 10% de aumento cujo fornecedor seja Sansul SA (Questão 15)
UPDATE produtos
SET preco = preco * 1.10
WHERE idFornecedor IN (
SELECT id FROM fornecedores WHERE nome = 'Sansul SA'
);
-- Atualizar os preços dos produtos em 10% de diminuição cujo fornecedor seja Mike Electro e categoria
seja Supremo (Questão 16)
UPDATE produtos
SET preco = preco * 0.90
WHERE idFornecedor IN (
SELECT id FROM fornecedores WHERE nome = 'Mike Electro'
) AND idCategoria IN (
SELECT id FROM categorias WHERE nome = 'Supremo'
);
-- Recuperar todos os produtos com preço entre 8 e 2000, ordenados do maior para o menor preço
(Questão 17)
SELECT * FROM produtos
WHERE preco BETWEEN 8 AND 2000
ORDER BY preco DESC;
-- Recuperar todos os produtos com preço maior que 2000, ordenados do menor para o maior preço
(Questão 18)
SELECT * FROM produtos
WHERE preco > 2000
ORDER BY preco ASC;
-- Recuperar o nome de todos os fornecedores que iniciam com a letra A (Questão 19)
SELECT nome FROM fornecedores
WHERE nome LIKE 'A%';
-- Recuperar o nome de todos os fornecedores que contenham a letra S (Questão 20)
SELECT nome FROM fornecedores
WHERE nome LIKE '%S%';
-- Atualizar a quantidade dos produtos em 15% cujo preço seja inferior a 300 (Questão 21)
UPDATE produtos
SET quantidade = quantidade * 1.15
WHERE preco < 300;
-- Apagar todos os produtos da categoria 5 (Questão 22)
DELETE FROM produtos
WHERE idCategoria = 5;
-- Recuperar todos os registros da tabela fornecedores (Questão 23)
SELECT * FROM fornecedores;
-- Recuperar o nome dos produtos que iniciam com a letra T e tenham o preço acima de 400 (Questão
24)
SELECT nome FROM produtos
WHERE nome LIKE 'T%' AND preco > 400;
-- Apagar todos os registros da tabela produtos (Questão 25)
DELETE FROM produtos;
