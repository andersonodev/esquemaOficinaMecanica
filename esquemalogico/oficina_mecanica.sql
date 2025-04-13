
-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS OficinaMecanica;
USE OficinaMecanica;

-- Tabela Cliente
CREATE TABLE Cliente (
    CPF CHAR(11) PRIMARY KEY,
    Nome VARCHAR(100),
    Telefone VARCHAR(20),
    Endereco VARCHAR(255)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    Placa CHAR(7) PRIMARY KEY,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    Tipo VARCHAR(30),
    CPF_Cliente CHAR(11),
    FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    Cod_Equipe INT PRIMARY KEY,
    Nome_Equipe VARCHAR(100)
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    Cod_Mecanico INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100),
    Cod_Equipe INT,
    FOREIGN KEY (Cod_Equipe) REFERENCES Equipe(Cod_Equipe)
);

-- Tabela OrdemServico
CREATE TABLE OrdemServico (
    Numero_OS INT PRIMARY KEY,
    Data_Emissao DATE,
    Data_Conclusao_Prevista DATE,
    Valor_Total DECIMAL(10,2),
    Status VARCHAR(50),
    Placa_Veiculo CHAR(7),
    FOREIGN KEY (Placa_Veiculo) REFERENCES Veiculo(Placa)
);

-- Tabela Servico
CREATE TABLE Servico (
    Cod_Servico INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Valor_Referencia DECIMAL(10,2)
);

-- Tabela Peca
CREATE TABLE Peca (
    Cod_Peca INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Preco_Unitario DECIMAL(10,2)
);

-- Relacionamento ServicoExecutado
CREATE TABLE ServicoExecutado (
    Numero_OS INT,
    Cod_Servico INT,
    Quantidade INT,
    Subtotal DECIMAL(10,2),
    PRIMARY KEY (Numero_OS, Cod_Servico),
    FOREIGN KEY (Numero_OS) REFERENCES OrdemServico(Numero_OS),
    FOREIGN KEY (Cod_Servico) REFERENCES Servico(Cod_Servico)
);

-- Relacionamento PecaUtilizada
CREATE TABLE PecaUtilizada (
    Numero_OS INT,
    Cod_Peca INT,
    Quantidade INT,
    Subtotal DECIMAL(10,2),
    PRIMARY KEY (Numero_OS, Cod_Peca),
    FOREIGN KEY (Numero_OS) REFERENCES OrdemServico(Numero_OS),
    FOREIGN KEY (Cod_Peca) REFERENCES Peca(Cod_Peca)
);

-- Relacionamento Executa (Equipe executa OS)
CREATE TABLE Executa (
    Cod_Equipe INT,
    Numero_OS INT,
    PRIMARY KEY (Cod_Equipe, Numero_OS),
    FOREIGN KEY (Cod_Equipe) REFERENCES Equipe(Cod_Equipe),
    FOREIGN KEY (Numero_OS) REFERENCES OrdemServico(Numero_OS)
);
