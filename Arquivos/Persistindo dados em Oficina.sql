-- PERSISTINDO OS DADOS EM OFICINA

use oficina;

insert into Cliente (Nome_cliente, Endereço_Cliente, CPF_Cliente)
	values ('Alberto O. Martins', 'Avenida Delfim Moreira, Teresópolis - RJ', 11111111111),
		   ('Junior O. Silva', 'Avenida Feliciano Sodré, Teresópolis - RJ', 11111111112),
           ('Ana Bela F. Souza', 'Estrada Parque do Imbuí, Teresópolis - RJ', 11111111113),
           ('Juarez S. Pimentel', 'Vila Acácio Borges - Centro - Nova Friburgo, RJ', 11111111114),
           ('Alex P. dos Santos', 'Est Acedimiro Bussinger - Mury - Nova Friburgo, RJ', 11111111115),
           ('Rodrigo O. Pinto', 'Estrada Vargem Grande, Teresópolis - RJ', 11111111116),
           ('Leonardo F. Silva', 'Rua Comary, Teresópolis - RJ', 11111111117);

insert into Veiculo (idCliente_V, Modelo, Ano, Cor)
	values (7, 'Fiat Strada', 2020, 'Preta'),
		   (7, 'Volkswagen T-Cross', 2024, 'Branca'),
           (1, 'Chevrolet Onix', 2025, 'Vermelha'),
           (3, 'Chevrolet Onix', 2019, 'Preta'),
           (2, 'Chevrolet Onix', 2023, 'Prata'),
           (4, 'Hyundai Creta', 2024, 'Preta'),
           (6, 'Chevrolet Tracker', 2022, 'Preta'),
           (5, 'Chevrolet Tracker', 2015, 'Branca');
           
insert into Oficina (Nome_Oficina, Endereço_Oficina)
	values ('Oficina Nacional', 'Avenida Delfim Moreira, Teresópolis - RJ'),
		   ('Mecânica São José', 'Vila Acácio Borges - Centro - Nova Friburgo, RJ');
          
insert into Equipe_oficina (idEquipe_Oficina, Nome_Equipe_Oficina, idOficina_EO, idVeiculo_EO)
	values ('CTTMNT05', 'Manut. Elet.', 1, null),
		   ('CTTMNT06', 'Manut. Mec.', 1, null),
           ('CTTMNT01', 'Manut. Elet.', 2, null),
           ('CTTMNT02', 'Manut. Mec.', 2, null),
           ('CTTMNT10', 'Manut. Pintura', 1, null);
            
insert into Orcamento_MO (idEquipe_Oficina_MO, Tb_Preco_MO, Quantidade_MO)
	values ('CTTMNT06', 560.50, 2),
		   ('CTTMNT05', 1200, 3),
           ('CTTMNT10', 800, default),
           ('CTTMNT05', 850, 1),
           ('CTTMNT05', 2650, 4),
           ('CTTMNT06', 159.99, default);
           
insert into Orcamento_PE (idPE, Descricao_PE, TB_Preco_PE, Quantidade_Pe)
	values (1000001, 'Biela forjada 144mm', 50.99, 2),
		   (1000002, 'Virabrequim 1.6 8V', 500, 1),
           (1000003, 'Rolamento 6203 ZZ', 25.50, 4),
           (1000004, 'Pastilha de Freio Cerâmica', 199.99, 2),
           (1000005, 'Amortecedor Pressurizado Cofap', 450.50, 2),
           (1000006, 'Relé de Partida 4 Pinos', 99.99, 1),
           (1000007, 'Fusível Lâmina 30A', 15.60, 6),
           (1000008, 'Bobina de Ignição', 650, default);

insert into Orcamento(idORcamento_MO_O, idOrcamento_PE_O)
	values (1, 1),
		   (1, 4),
           (2, 7),
           (4, 6),
           (5, 8),
           (6, 3),
           (1, 2);

insert into Ordem_Servico (idVeiculo_OS, idOrcamento_OS, Data_Emissao, Status_OS)
	values (2, 1, '2025-02-01', 'Concluído'),
		   (2, 3, '2025-02-01', 'Concluído'),
		   (1, 3, '2025-02-02', 'Concluído'),
           (3, 4, '2025-02-03', 'Iniciado'),
           (6, 2, '2025-01-22', 'Em Atraso'),
           (4, 5, '2025-01-15', default),
           (7, 6, '2025-01-10', default);

insert into Kanban_Servicos (idOS_Entrega, Descricao, Data_conclusao)
	values (1, 'Serviço já Concluído, trocado peças conforme OS', '2025-02-02'),
		   (2, 'Serviço já Concluído, trocado peças conforme OS', '2025-02-02'),
           (3, 'Serviço já Concluído, trocado peças conforme OS', '2025-02-03'),
           (4, 'Serviço já iniciado, Previsão de 3 dias para conclusão', null),
           (5, 'Aguardando peça chegar', null),
           (6, 'Aguardando aprovação do Cliente', null);

select * from Cliente;

select * from Cliente, Veiculo 
	where idCliente = idCliente_V;

select Nome_Oficina, Endereço_Oficina, idEquipe_Oficina, Nome_Equipe_oficina from Oficina, Equipe_oficina
	where idOficina = idOficina_EO;
    
select count(*) from Cliente, Veiculo 
	where idCliente = idCliente_V;

select * from Orcamento left outer join Orcamento_MO on idOrcamento = idMO;

-- Quais veículos tiveram manutenções?
select idVeiculo, Modelo, Ano, Cor, Data_Emissao, Status_OS, Descricao from Ordem_Servico
	inner join Kanban_Servicos on idOrdem_Servico = idOS_Entrega
    inner join Veiculo on idVeiculo = idVeiculo_OS;

-- Quais veículos cada Cliente tem?
select * from Cliente left outer join Veiculo on idCliente = idCliente_V
	order by Nome_cliente;

-- Carros de cada cliente que está na oficina, com orçamento (M.O e Peças), e Status de cada Serviço
select idCliente_V, Nome_cliente, idVeiculo, Modelo,Ano, idOrcamento_OS, Status_OS, idEquipe_Oficina_MO, TB_PReco_MO, idPE, Descricao_PE, TB_Preco_PE, Quantidade_PE
	from Ordem_servico, Veiculo, Orcamento, Orcamento_MO, Orcamento_PE, Cliente
		where idVeiculo_OS = idVeiculo and idorcamento_os = idorcamento and idOrcamento_MO_O = idMO and idORcamento_PE_O = idOrc_PE and idCliente_V = idCliente
			Order by Status_Os;
