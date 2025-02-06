-- CRIAÇÃO DE BANCO DE DADOS OFICINA

-- drop database Oficina;

create database Oficina;
use oficina;

-- CRIAR TABELA CLIENTE
create table Cliente(
	idCliente int auto_increment primary key,
    Nome_Cliente varchar(45) not null,
    Endereço_Cliente varchar(50) not null,
    CPF_Cliente char(11) not null,
    constraint unique_CPF_Cliente unique (CPF_Cliente)
);
alter table Cliente auto_increment=1;

-- CRIAR TABELA VEÍCULO
create table Veiculo(
	idVeiculo int auto_increment unique,
    idCliente_V int not null,
    Modelo varchar(25) not null,
    Ano int,
    Cor varchar(15),
    constraint primary key (idVeiculo, idCliente_V),
    constraint FK_idVeiculo_Veiculo foreign key (idCliente_V) references Cliente(idCliente)
    on update cascade
);
alter table Veiculo auto_increment=1;

-- CRIAR TABELA OFICINA
create table Oficina(
	idOficina int auto_increment primary key,
    Nome_Oficina varchar(30) not null,
    Endereço_Oficina varchar(100) not null,
    constraint unique_idOficina unique (idOficina)
);
alter table Oficina auto_increment=1;

-- CRIAR TABELA EQUIPE OFICINA / COLOCAR CTTMNT NOS ID DAS EQUIPES DE OFICINA PADRONIZANDO
create table Equipe_Oficina(
	idEquipe_Oficina char(8) not null unique,
	Nome_Equipe_Oficina varchar(30) not null,
    idOficina_EO int not null,
    idVeiculo_EO int,
    constraint primary key (idEquipe_Oficina, idOficina_EO),
    constraint FK_Equipe_Oficina_idOficina_EO foreign key (idOficina_EO) references Oficina(idOficina),
    constraint FK_Equipe_Oficina_idVeiculo_EO foreign key (idVeiculo_EO) references Veiculo(idVeiculo)
    on update cascade
);

-- CRIAR TABELA ORÇAMENTO MÃO DE OBRA - LEMBRAR DE AMARRAR OS MESMOS ID DE EQUIPE OFICINA, ASSIM GERANDO O LINK COM O CUSTO
create table Orcamento_MO(
	idMO int auto_increment unique,
    idEquipe_Oficina_MO char(8) not null,
    Tb_Preco_MO decimal(10,2) not null,
    Quantidade_MO int not null default 1,
    constraint primary key (idMO, idEquipe_Oficina_MO),
    constraint FK_Orcamento_MO foreign key (idEquipe_Oficina_MO) references Equipe_Oficina(idEquipe_Oficina)
    on update cascade
);
alter table Orcamento_MO auto_increment=1;

-- CRIAR TABELA ORÇAMENTO PEÇAS -> TALVEZ EU POSSA TER PROBLEMAS DEVIDO AO UNIQUE TEORICAMENTO EM DOIS ATRIBUTOS DA TABELA
create table Orcamento_PE(
	idOrc_PE int auto_increment primary key,
    idPE char(7) not null unique,
    Descricao_PE varchar(30) not null,
    TB_Preco_PE decimal(10,2) not null,
    Quantidade_PE int not null default 1
);
alter table Orcamento_PE auto_increment=1;

-- CRIAR TABELA ORÇAMENTO
create table Orcamento(
	idOrcamento int auto_increment unique,
    idOrcamento_MO_O int not null,
    idOrcamento_PE_O int not null default 0,
    constraint PK_Orcamento primary key (idOrcamento, idOrcamento_MO_O, idOrcamento_PE_O),
    constraint FK_Orcamento_MO_O foreign key (idOrcamento_MO_O) references Orcamento_MO(idMO),
    constraint FK_Orcamento_PE_O foreign key (idOrcamento_PE_O) references Orcamento_PE(idOrc_PE)
    on update cascade    
);
alter table Orcamento auto_increment=1;

-- CRIAR TABELA ORDEM DE SERVIÇO
create table Ordem_Servico(
	idOrdem_Servico int auto_increment primary key,
    idVeiculo_OS int not null,
    idOrcamento_OS int not null,
    Data_Emissao date not null,
    Status_OS enum('Aguardando Liberação', 'Iniciado', 'Cancelado', 'Concluído', 'Em Atraso') not null default 'Aguardando Liberação',
    constraint FK_idVeiculo_OS foreign key (idVeiculo_OS) references Veiculo(idVeiculo),
    constraint FK_idOrcamento_OS foreign key (idOrcamento_OS) references Orcamento(idOrcamento)
    on update cascade    
);
alter table Ordem_Servico auto_increment=1;

-- CRIAR TABELA ENTREGA
create table Kanban_Servicos(
	idKanban int auto_increment,
    idOS_Entrega int not null,
    Descricao varchar(255) not null,
    Data_Conclusao date,
    constraint PK_Entrega primary key (idKanban, idOS_Entrega),
    constraint FK_Entrega foreign key (idOS_Entrega) references Ordem_Servico(idOrdem_Servico)
    on update cascade
);
alter table Kanban_Servicos auto_increment=1;

show tables;
desc Equipe_oficina;