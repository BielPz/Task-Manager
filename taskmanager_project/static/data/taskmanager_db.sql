-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 17/10/2026 às 20:19
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `taskmanager_db`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_tarefas_usuario` (IN `p_id_usuario` INT)   BEGIN
    SELECT *
    FROM vw_tarefas_usuario
    WHERE id_Usuario = p_id_usuario;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `task`
--

CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `realizado` tinyint(1) DEFAULT 0,
  `id_Usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nome` varchar(75) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` char(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_tarefas_usuario`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_tarefas_usuario` (
`id_Usuario` int(11)
,`nome_Usuario` varchar(75)
,`id_Task` int(11)
,`titulo` varchar(50)
,`realizado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_tarefas_usuario`
--
DROP TABLE IF EXISTS `vw_tarefas_usuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tarefas_usuario`  AS SELECT `u`.`id` AS `id_Usuario`, `u`.`nome` AS `nome_Usuario`, `t`.`id` AS `id_Task`, `t`.`titulo` AS `titulo`, `t`.`realizado` AS `realizado` FROM (`usuario` `u` left join `task` `t` on(`u`.`id` = `t`.`id_Usuario`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_TaskUsuario` (`id_Usuario`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `task`
--
ALTER TABLE `task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `fk_TaskUsuario` FOREIGN KEY (`id_Usuario`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
