-- Criação do Banco de Dados para cenário de E-commerce

CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Criação da Tabela Clientes

CREATE TABLE Clientes(
ID_Clientes INT AUTO_INCREMENT PRIMARY KEY,
fnome VARCHAR(25) NOT NULL,
lnome VARCHAR(50) NOT NULL,
Email VARCHAR(70)
);

-- Criação da Tabela Cliente Físico

CREATE TABLE Cliente_Fisico(
ID_ClienteFisico INT AUTO_INCREMENT PRIMARY KEY,
CPF BIGINT(11) NOT NULL,
RG VARCHAR(8) NOT NULL,
orgao_emissor_RG VARCHAR(15) NOT NULL,
data_emissao_RG DATE NOT NULL,
data_nascimento DATE NOT NULL,
Sexo ENUM('Feminino', 'Masculino') NOT NULL
);

-- Criação da Tabela Cliente Jurídico

CREATE TABLE Cliente_Juridico(
ID_ClienteJuridico INT AUTO_INCREMENT PRIMARY KEY,
CNPJ BIGINT(14) NOT NULL,
nome_fantasia VARCHAR(115) NOT NULL,
razao_social VARCHAR(255) NOT NULL,
inscricao_estadual BIGINT(14) NOT NULL,
inscricao_municipal BIGINT(15) NOT NULL
);

-- Criação da Tabela Produto

CREATE TABLE Produtos(
ID_Produtos INT AUTO_INCREMENT PRIMARY KEY,
fnome VARCHAR(25) NOT NULL,
classificacao_criancas BOOL DEFAULT FALSE,
Categoria ENUM('Eletrônicos', 'Casa e Cozinha', 'Vestuário', 'Fitness', 'Brinquedos e Jogos', 'Ferramentas', 'Comida e Bebida',
'Livros e Kindle', 'Segurança Pessoal', 'Mercado', 'Mercadoria', 'Automotivo') NOT NULL,
Avaliacao FLOAT DEFAULT 0,
Preco DECIMAL NOT NULL,
Descricao VARCHAR(250)
);

-- Criação da Tabela Pedidos

CREATE TABLE Pedidos(
ID_Pedidos INT AUTO_INCREMENT PRIMARY KEY,
ID_Clientes INT NOT NULL,
status_do_pedido ENUM('Confirmado', 'Cancelado', 'Em Processo', 'Entregue') DEFAULT 'Em processo',
Descricao VARCHAR(250),
Envio FLOAT DEFAULT 0,
tipo_de_pagamento ENUM('Ticket', 'Cartão de Crédito', 'Transferência Bancária', 'Pix', 'Dinheiro'),
PRIMARY KEY (ID_Pedidos, ID_Clientes),
ON UPDATE CASCADE
);

-- Criação da Tabela Pagamento

CREATE TABLE Pagamento(
ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
ID_OrdemDePagamento INT,
Valor DECIMAL,
status_do_pagamento ENUM('Confirmado', 'Em Processo', 'Cancelado'),
PRIMARY KEY (ID_Pagamento, ID_OrdemDePagamento),
ON UPDATE CASCADE
);

-- Criação da Tabela Forma de Pagamento

CREATE TABLE forma_de_pagamento(
ID_forma_de_pagamento INT AUTO_INCREMENT PRIMARY KEY,
cartao_de_credito DECIMAL,
Ticket DECIMAL,
transferencia_bancaria DECIMAL,
Pix DECIMAL,
Dinheiro DECIMAL
);

-- Criação da Tabela Estoque

CREATE TABLE Estoque(
ID_Estoque INT AUTO_INCREMENT PRIMARY KEY,
local_de_armazenamento VARCHAR(255),
Quantidade INT DEFAULT 0
);

-- Criação da Tabela Fornecedor

CREATE TABLE Fornecedor(
ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
nome_da_corporacao VARCHAR(120) NOT NULL,
CNPJ BIGINT(14) NOT NULL,
Contato BIGINT(11) NOT NULL
);

-- Criação da Tabela Vendedor

CREATE TABLE Vendedor(
ID_Vendedor INT AUTO_INCREMENT PRIMARY KEY,
nome_da_companhia VARCHAR(120) NOT NULL,
nome_do_vendedor VARCHAR(120) NOT NULL,
CNPJ BIGINT(14) NOT NULL,
CPF BIGINT(11) NOT NULL,
Contato BIGINT(11) NOT NULL,
Localizacao VARCHAR(100)
);

-- Criação da Tabela Produtos/Vendedor

CREATE TABLE produtos_vendedor(
ID_ProdutosVendedor INT AUTO_INCREMENT PRIMARY KEY,
ID_Produtos INT,
quantidade_de_produtos INT DEFAULT 1,
PRIMARY KEY (ID_ProdutosVendedor, ID_Produtos)
);

-- Criação da Tabela Produto/Fornecedor


CREATE TABLE produtos_fornecedor(
ID_ProdutosFornecedor INT AUTO_INCREMENT PRIMARY KEY,
ID_Fornecedor INT,
Quantidade INT NOT NULL,
PRIMARY KEY (ID_ProdutosFornecedor, ID_Fornecedor)
);

-- Criação da Tabela Produtos/Pedidos

CREATE TABLE produtos_pedidos(
ID_ProdutosPedidos INT AUTO_INCREMENT PRIMARY KEY,
ID_Pedidos INT,
quantidade_de_produtos INT DEFAULT 1,
status_do_produto ENUM('Disponível', 'Indisponível') DEFAULT 'Disponível',
PRIMARY KEY (ID_ProdutosPedidos, ID_Produtos)
);

-- Criação da Tabela Produtos em Estoque

CREATE TABLE produtos_em_estoque(
ID_ProdutosEmEstoque INT AUTO_INCREMENT PRIMARY KEY,
ID_LocalizacaoDoProduto INT,
Localizacao VARCHAR(100) NOT NULL,
PRIMARY KEY (ID_ProdutosEmEstoque, ID_LocalizacaoDoProduto)
);

-- Alteração das Tabelas

ALTER TABLE Clientes ADD CONSTRAINT FOREIGN KEY (fk_Cliente_Fisico_ID_ClienteFisico) REFERENCES cliente_fisico (ID_ClienteFisico)
ALTER TABLE Clientes ADD CONSTRAINT FOREIGN KEY (fk_Cliente_Juridico_ID_ClienteJuridico) REFERENCES cliente_juridico (ID_ClienteJuridico)
ALTER TABLE Pedidos ADD CONSTRAINT FOREIGN KEY (fk_Produtos_ID_Produtos) REFERENCES Produtos (ID_Produtos)
ALTER TABLE Pedidos ADD CONSTRAINT FOREIGN KEY (fk_Pagamento_ID_Pagamento) REFERENCES Pagamento (ID_Pagamento)
ALTER TABLE Pedidos ADD CONSTRAINT FOREIGN KEY (fk_Pagamento_ID_OrdemDePagamento) REFERENCES Pagamento (ID_OrdemDePagamento)
ALTER TABLE cliente_fisico ADD CONSTRAINT FOREIGN KEY (Pedidos_ID_Pedidos) REFERENCES Pedidos (ID_Pedidos)
ALTER TABLE cliente_fisico ADD CONSTRAINT FOREIGN KEY (Pedidos_ID_Clientes) REFERENCES Clientes (ID_Clientes)
ALTER TABLE cliente_juridico ADD CONSTRAINT FOREIGN KEY (Pedidos_ID_Pedidos) REFERENCES Pedidos (ID_Pedidos)
ALTER TABLE cliente_juridico ADD CONSTRAINT FOREIGN KEY (Pedidos_ID_Clientes) REFERENCES Clientes (ID_Clientes)
ALTER TABLE Estoque ADD CONSTRAINT FOREIGN KEY (Produtos_ID_Produtos) REFERENCES Produtos (ID_Produtos)
ALTER TABLE Produtos ADD CONSTRAINT FOREIGN KEY (Fornecedor_ID_Fornecedor) REFERENCES Fornecedor (ID_Fornecedor)
ALTER TABLE Pagamento ADD CONSTRAINT FOREIGN KEY (forma_de_pagamento_ID_FormaDePagamento) REFERENCES forma_de_pagamento (ID_FormaDePagamento)
ALTER TABLE Fornecedor ADD CONSTRAINT FOREIGN KEY (Vendedor_ID_Vendedor) REFERENCES Vendedor (ID_Vendedor)
ALTER TABLE Vendedor ADD CONSTRAINT FOREIGN KEY (produtos_vendedor_ID_ProdutosVendedor, produtos_vendedor_ID_Produtos) REFERENCES produtos_vendedor (ID_ProdutosVendedor, ID_Produtos)
ALTER TABLE Vendedor ADD CONSTRAINT FOREIGN KEY (produtos_fornecedor_ID_ProdutosFornecedor, produtos_fornecedor_ID_Fornecedor) REFERENCES produtos_fornecedor (ID_ProdutosFornecedor, ID_Fornecedor)
ALTER TABLE Vendedor ADD CONSTRAINT FOREIGN KEY (produtos_pedidos_ID_ProdutosPedidos, produtos_pedidos_ID_Pedidos) REFERENCES produtos_pedidos (ID_ProdutosPedidos, ID_Pedidos)
ALTER TABLE Vendedor ADD CONSTRAINT FOREIGN KEY (produtos_em_estoque_ID_ProdutosEmEstoque, produtos_em_estoque_ID_LocalizacaoDoProduto) REFERENCES produtos_em_estoque (ID_ProdutosEmEstoque, ID_LocalizacaoDoProduto)