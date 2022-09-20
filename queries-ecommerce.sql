SELECT * FROM Clientes;
SELECT * FROM Cliente_Fisico;
SELECT * FROM Cliente_Juridico;
SELECT * FROM Produtos;
SELECT * FROM Pedidos;
SELECT * FROM Pagamento;
SELECT * FROM forma_de_pagamento;
SELECT * FROM Estoque;
SELECT * FROM Fornecedor;
SELECT * FROM Vendedor;
SELECT * FROM produtos_vendedor;
SELECT * FROM produtos_fornecedor;
SELECT * FROM produtos_pedidos;
SELECT * FROM produtos_em_estoque;

-- Espaçamento 

SELECT CONCAT(fnome, ' ', lnome) AS Clientes, ID_Pedidos AS Pedidos, descricao_do_pedido AS Acesso, status_do_pedido AS Situação
FROM Clientes C, Pedidos P
WHERE c.ID_Clientes = ID_PedidosClientes
ORDER BY fnome;

-- Espaçamento 

SELECT *
FROM Clientes
LEFT OUTER JOIN Pedidos
ON ID_Clientes = ID_PedidosClientes;

-- Espaçamento

SELECT *
FROM Produtos
WHERE price <=1000
ORDER BY lnome;

-- Espaçamento 

SELECT SUM(preco) Faturamento, MAX(preco) maior_compra, MIN(preco) menor_compra, ROUND(AVG(preco),2)media,
SUM(envio) total_frete, MAX(envio) maior_frete, MIN(envio) menor_frete, AVG(envio) media_de_fretes
FROM Produtos, Pedidos
WHERE categoria ='Segurança Pessoal';

-- Espaçamento

SELECT CONCAT(fnome, ' ', lnome) AS Clientes, endereco AS fnome AS Produtos,
valor_do_produto AS Quantidade, Categoria AS Categoria, preco AS preco, envio AS Frete
FROM Clientes
INNER JOIN Pedidos ON ID_Clientes = ID_PedidosClientes
INNER JOIN produtos_pedidos ON ID_Pedidos = ID_Produtos
INNER JOIN Produtos ON ID_Produtos = ID_Pedidos
ORDER BY fnome;

-- Espaçamento 

SELECT fnome AS Produtos, Localizacao AS centro_de_distribuicao
FROM Produtos, local_de_armazenamento
WHERE ID_Produtos = ID_LocalizacaoDoProduto AND Localizacao LIKE '%RJ - Brasil%';

-- Espaçamento 

SELECT DISTINCT ID_Produtos, fnome FROM Produtos WHERE ID_Produtos IN
(SELECT DISTINCT tipo_de_pagamento FROM Pedidos, Clientes WHERE ID_PedidosClientes = ID_Clientes)
OR
(SELECT ID_Produto FROM Produtos, Pedidos WHERE pname = 'Bat_rang'));

-- Espaçamento 

SELECT CONCAT(fnome, ' ', lnome) AS Clientes, ID_Pedidos AS numero_do_pedido, fnome AS Produto, valor_do_produto AS Quantidade,
price AS preco, tipo_de_pagamento AS forma_de_pagamento, envio AS Frete, status_de_pagamento AS situacao
FROM Clientes
INNER JOIN Pedidos ON ID_Clientes = ID_PedidosClientes
INNER JOIN Pagamento ON ID_Pedidos = ID_OrdemDePagamento
INNER JOIN tipo_de_pagamento ON ID_Pagamento = ID_Pagamento
INNER JOIN produtos_pedidos ON ID_Produtos = ID_Pedidos
INNER JOIN Produtos ON ID_Produtos = ID_Pedidos
GROUP BY fnome;

-- Espaçamento 

SELECT DISTINCT CONCAT(fnome, ' ', lnome) AS Clientes, ID_Pedidos AS numero_do_pedido, fnome AS Produtos, valor_do_produto AS Quantidade,
price AS preco, tipo_de_pagamento AS forma_de_pagamento, envio AS Frete, status_de_pagamento AS situacao
FROM Clientes
INNER JOIN Pedidos ON ID_Clientes = ID_PedidosClientes
INNER JOIN Pagamento ON ID_Pedidos = ID_OrdemDePagamento
INNER JOIN tipo_de_pagamento ON ID_Pagamento = ID_Pagamento
INNER JOIN produtos_pedidos ON ID_Produtos = ID_Pedidos
INNER JOIN Produtos ON ID_Produtos = ID_Pedidos

-- Espaçamento 

SELECT *
FROM Clientes
INNER JOIN Pedidos ON ID_Clientes = ID_Pedidos
INNER JOIN Pagamento ON ID_Produtos = ID_FormaDePagamento
INNER JOIN forma_de_pagamento ON ID_Pagamento = ID_Pagamento
INNER JOIN produtos_pedidos ON ID_Pedidos = ID_Produtos
INNER JOIN Produto ON ID_Produtos = ID_Pedidos;
