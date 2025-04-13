
-- =======================================
-- Criação do Banco de Dados Oficina Mecânica
-- =======================================
DROP DATABASE IF EXISTS OficinaMecanica;
CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;

-- ========================
-- Tabelas
-- ========================

CREATE TABLE Cliente (
    CPF CHAR(11) PRIMARY KEY,
    Nome VARCHAR(100),
    Telefone VARCHAR(20),
    Endereco VARCHAR(255)
);

CREATE TABLE Veiculo (
    Placa CHAR(7) PRIMARY KEY,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    Tipo VARCHAR(30),
    CPF_Cliente CHAR(11),
    FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF)
);

CREATE TABLE Equipe (
    Cod_Equipe INT PRIMARY KEY,
    Nome_Equipe VARCHAR(100)
);

CREATE TABLE Mecanico (
    Cod_Mecanico INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100),
    Cod_Equipe INT,
    FOREIGN KEY (Cod_Equipe) REFERENCES Equipe(Cod_Equipe)
);

CREATE TABLE OrdemServico (
    Numero_OS INT PRIMARY KEY,
    Data_Emissao DATE,
    Data_Conclusao_Prevista DATE,
    Valor_Total DECIMAL(10,2),
    Status VARCHAR(50),
    Placa_Veiculo CHAR(7),
    FOREIGN KEY (Placa_Veiculo) REFERENCES Veiculo(Placa)
);

CREATE TABLE Servico (
    Cod_Servico INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Valor_Referencia DECIMAL(10,2)
);

CREATE TABLE Peca (
    Cod_Peca INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Preco_Unitario DECIMAL(10,2)
);

CREATE TABLE ServicoExecutado (
    Numero_OS INT,
    Cod_Servico INT,
    Quantidade INT,
    Subtotal DECIMAL(10,2),
    PRIMARY KEY (Numero_OS, Cod_Servico),
    FOREIGN KEY (Numero_OS) REFERENCES OrdemServico(Numero_OS),
    FOREIGN KEY (Cod_Servico) REFERENCES Servico(Cod_Servico)
);

CREATE TABLE PecaUtilizada (
    Numero_OS INT,
    Cod_Peca INT,
    Quantidade INT,
    Subtotal DECIMAL(10,2),
    PRIMARY KEY (Numero_OS, Cod_Peca),
    FOREIGN KEY (Numero_OS) REFERENCES OrdemServico(Numero_OS),
    FOREIGN KEY (Cod_Peca) REFERENCES Peca(Cod_Peca)
);

CREATE TABLE Executa (
    Cod_Equipe INT,
    Numero_OS INT,
    PRIMARY KEY (Cod_Equipe, Numero_OS),
    FOREIGN KEY (Cod_Equipe) REFERENCES Equipe(Cod_Equipe),
    FOREIGN KEY (Numero_OS) REFERENCES OrdemServico(Numero_OS)
);

-- ========================
-- Inserts de Teste
-- ========================

INSERT INTO Cliente VALUES ('12345678901', 'João Silva', '11999999999', 'Rua A, 123');
INSERT INTO Cliente VALUES ('98765432100', 'Maria Souza', '11988888888', 'Av B, 456');

INSERT INTO Veiculo VALUES ('ABC1234', 'Civic', 'Honda', 2018, 'Carro', '12345678901');
INSERT INTO Veiculo VALUES ('XYZ5678', 'CG 160', 'Honda', 2020, 'Moto', '98765432100');

INSERT INTO Equipe VALUES (1, 'Equipe Alfa');
INSERT INTO Equipe VALUES (2, 'Equipe Beta');

INSERT INTO Mecanico VALUES (1, 'Carlos Lima', 'Rua X', 'Motor', 1);
INSERT INTO Mecanico VALUES (2, 'Paula Santos', 'Rua Y', 'Freios', 2);

INSERT INTO OrdemServico VALUES (101, '2025-04-01', '2025-04-05', 0.00, 'Em andamento', 'ABC1234');
INSERT INTO OrdemServico VALUES (102, '2025-04-03', '2025-04-06', 0.00, 'Concluída', 'XYZ5678');

INSERT INTO Servico VALUES (1, 'Troca de óleo', 100.00);
INSERT INTO Servico VALUES (2, 'Revisão de freios', 200.00);

INSERT INTO Peca VALUES (1, 'Filtro de óleo', 50.00);
INSERT INTO Peca VALUES (2, 'Pastilha de freio', 120.00);

INSERT INTO ServicoExecutado VALUES (101, 1, 1, 100.00);
INSERT INTO ServicoExecutado VALUES (102, 2, 1, 200.00);

INSERT INTO PecaUtilizada VALUES (101, 1, 1, 50.00);
INSERT INTO PecaUtilizada VALUES (102, 2, 1, 120.00);

INSERT INTO Executa VALUES (1, 101);
INSERT INTO Executa VALUES (2, 102);

-- ========================
-- Consultas SQL Avançadas
-- ========================

-- Clientes cadastrados
SELECT Nome, Telefone FROM Cliente;

-- Veículos do tipo Carro
SELECT * FROM Veiculo WHERE Tipo = 'Carro';

-- Dias estimados de execução
SELECT Numero_OS, DATEDIFF(Data_Conclusao_Prevista, Data_Emissao) AS Dias_Execucao
FROM OrdemServico;

-- OS ordenadas por valor total
SELECT Numero_OS, Valor_Total FROM OrdemServico ORDER BY Valor_Total DESC;

-- Serviços executados com descrição
SELECT os.Numero_OS, s.Descricao, se.Quantidade, s.Valor_Referencia, se.Subtotal
FROM ServicoExecutado se
JOIN Servico s ON se.Cod_Servico = s.Cod_Servico
JOIN OrdemServico os ON se.Numero_OS = os.Numero_OS;

-- Equipes que executaram mais de 1 OS
SELECT e.Cod_Equipe, COUNT(ex.Numero_OS) AS Total_OS
FROM Executa ex
JOIN Equipe e ON e.Cod_Equipe = ex.Cod_Equipe
GROUP BY e.Cod_Equipe
HAVING COUNT(ex.Numero_OS) > 1;
