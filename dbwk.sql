-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18-Abr-2022 às 03:53
-- Versão do servidor: 10.4.11-MariaDB
-- versão do PHP: 7.3.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `dbwk`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `cod_cliente` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `uf` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`cod_cliente`, `nome`, `cidade`, `uf`) VALUES
(1, 'Fernando Silva', 'Manaus', 'AM'),
(2, 'Joao Mendes', 'Manaus', 'RR'),
(3, 'Jorge Jesus', 'Manaus', 'SP'),
(4, 'Pedro Marques', 'Manaus', 'RO'),
(5, 'Jose Abreu', 'Manaus', 'AC'),
(6, 'Maria Gilda', 'Manaus', 'PB'),
(7, 'Ana Julia', 'Manaus', 'PA'),
(8, 'Ana Paula', 'Manaus', 'AM'),
(9, 'Marcos Silva', 'Manaus', 'AM'),
(10, 'Jonas Inacio', 'Manaus', 'PR'),
(11, 'Alberto Silva', 'Manaus', 'GO'),
(12, 'Antonio Jose', 'Manaus', 'TO'),
(13, 'Rayane Silva', 'Manaus', 'MS'),
(14, 'Silvio Santos', 'Manaus', 'MT'),
(15, 'Souza Aguiar', 'Manaus', 'RJ'),
(16, 'Paulo Andre', 'Manaus', 'SP'),
(17, 'Denis Junior', 'Manaus', 'SP'),
(18, 'Edson Silva', 'Manaus', 'PA'),
(19, 'Marlucia Santos', 'Manaus', 'RS'),
(20, 'Fernando Abreu', 'Manaus', 'AM');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `nro_pedido` int(11) NOT NULL,
  `data_emissao` date NOT NULL,
  `cod_cliente` int(11) NOT NULL,
  `valor_total` double(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `pedidos`
--

INSERT INTO `pedidos` (`nro_pedido`, `data_emissao`, `cod_cliente`, `valor_total`) VALUES
(116, '2022-04-17', 11, 1.00),
(117, '0000-00-00', 2, 1202.00),
(118, '0000-00-00', 2, 1.00),
(119, '0000-00-00', 1, 1.00),
(120, '0000-00-00', 1, 1073.40),
(121, '0000-00-00', 2, 762.60),
(122, '0000-00-00', 2, 1102.20),
(123, '0000-00-00', 1, 214.20),
(124, '0000-00-00', 1, 40104.60),
(125, '0000-00-00', 2, 10312.20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos_produtos`
--

CREATE TABLE `pedidos_produtos` (
  `id` int(11) NOT NULL,
  `nro_pedido` int(11) NOT NULL,
  `cod_produto` int(11) NOT NULL,
  `quantidade` double(15,2) NOT NULL,
  `vlr_unitario` double(15,2) NOT NULL,
  `vlr_total` double(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `pedidos_produtos`
--

INSERT INTO `pedidos_produtos` (`id`, `nro_pedido`, `cod_produto`, `quantidade`, `vlr_unitario`, `vlr_total`) VALUES
(38, 117, 3, 12.00, 100.00, 1202.00),
(39, 118, 4, 1.00, 1.00, 1.00),
(80, 125, 2, 3.00, 100.20, 300.60),
(81, 125, 4, 1.00, 10000.20, 10000.20),
(82, 125, 5, 1.00, 5.30, 5.30),
(83, 125, 1, 2.00, 10.20, 20.40);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `cod_produto` int(11) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `preco_venda` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `cod_produto`, `descricao`, `preco_venda`) VALUES
(1, 1, 'Feijao', 10.2),
(2, 1, 'Feijao', 10.2),
(3, 2, 'Arroz', 100.2),
(4, 3, 'Sal', 1.2),
(5, 4, 'Farinha', 10000.2),
(6, 5, 'Iogurte', 1.2),
(7, 6, 'Leite', 100.2),
(8, 7, 'Laranja', 80.2),
(9, 8, 'Tomate', 12.2),
(10, 9, 'Coca-Cola', 13.2),
(11, 10, 'Sandalia', 20.2),
(12, 11, 'Chocolate', 14.2),
(13, 12, 'Militos', 19.2),
(14, 13, 'Conserva', 21.2),
(15, 14, 'Feijao', 120.2),
(16, 15, 'Papel Higienico', 1.2),
(17, 16, 'Sabonete', 0.2),
(18, 17, 'Sabao', 1500.2),
(19, 18, 'Macarrao', 0.21),
(20, 19, 'Pilhas', 0.1);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cod_cliente`);

--
-- Índices para tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`nro_pedido`),
  ADD KEY `fk_pedidos_cod_cliente` (`cod_cliente`);

--
-- Índices para tabela `pedidos_produtos`
--
ALTER TABLE `pedidos_produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pedidos_produtos_cod_produtos` (`cod_produto`),
  ADD KEY `fk_pedidos_produtos_nro_pedido` (`nro_pedido`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_produtos_cod_produto` (`cod_produto`) USING BTREE;

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `nro_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT de tabela `pedidos_produtos`
--
ALTER TABLE `pedidos_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_pedidos_cod_cliente` FOREIGN KEY (`cod_cliente`) REFERENCES `clientes` (`cod_cliente`);

--
-- Limitadores para a tabela `pedidos_produtos`
--
ALTER TABLE `pedidos_produtos`
  ADD CONSTRAINT `fk_pedidos_produtos_cod_produtos` FOREIGN KEY (`cod_produto`) REFERENCES `produtos` (`cod_produto`),
  ADD CONSTRAINT `fk_pedidos_produtos_nro_pedido` FOREIGN KEY (`nro_pedido`) REFERENCES `pedidos` (`nro_pedido`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
