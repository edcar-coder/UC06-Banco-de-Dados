-- Database: Bblioteca
begin;                 --verifique, espere
create table autor(
    id serial primary key,
    nome varchar(60) not null,
    data_nascimento date,
    constraint chk_data_nascimento check (data_nascimento <= CURRENT_DATE)
);


create table livro(
    id serial primary key,
    titulo varchar(60) not null,
    id_autor int,
    ano_publicacao int,
    constraint fk_autor_livro foreign key (id_autor) references autor(id),
    constraint chk_ano_publicacao check (ano_publicacao >= 1500 and ano_publicacao <= extract(year from CURRENT_DATE))
);

create table usuario(
id serial primary key,
nome varchar(60) not null,
email varchar (60) unique,
data_adesao date,
constraint chk_data_adesao check (data_adesao <= CURRENT_DATE)
);

create table emprestimo(
is serial primary key,   --1 a 2mil regsitros
id_livro int,
id_usuario int,
data_emprestimo date not null,
data_devolucao not null,
constraint fk_livro foreign key (id_livro) references livro(id),
constraint fk_usuario foreign key (id_usuario) references usuario(id),
constraint chk_data_entrega check (data_emprestimo <= data_devolucao)
constraint 
);


rollback;              --retorna apenas 1° vez
commit;                  --comentar apenas no final
