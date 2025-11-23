-- 1. DROP TABLES (Remoção segura e ordenada)
-------------------------------------------------------------
DROP TABLE IF EXISTS tb_operacao;
DROP TABLE IF EXISTS tb_veiculo;
DROP TABLE IF EXISTS tb_vaga;
DROP TABLE IF EXISTS tb_cliente;

---
-- 2. CRIAÇÃO DAS TABELAS COM CHAVES PRIMÁRIAS
-------------------------------------------------------------

CREATE TABLE tb_cliente (
    id_cliente INTEGER PRIMARY KEY,
    nome_cliente CHARACTER(255) NOT NULL,
	email_cliente CHARACTER(100) NOT NULL,
	telefone_cliente CHARACTER(12) NOT NULL
);

CREATE TABLE tb_veiculo (
    id_veiculo INTEGER PRIMARY KEY,
    modelo CHARACTER(100) NOT NULL,
    cor CHARACTER(50),
    placa CHARACTER(10) NOT NULL,
    id_cliente INTEGER NOT NULL
);

CREATE TABLE tb_vaga (
    id_vaga INTEGER PRIMARY KEY,
    status CHARACTER(50) NOT NULL
);


CREATE TABLE tb_operacao (
    id_operacao INTEGER PRIMARY KEY,
    horario_entrada TIME NOT NULL,
    horario_saida TIME,
    valor_total DECIMAL(10, 2),
    status_pagamento CHARACTER(50),
    id_veiculo INTEGER NOT NULL,
    id_vaga INTEGER NOT NULL
    -- id_usuario REMOVIDO
);

---
-- 3. CRIAÇÃO DAS CHAVES ESTRANGEIRAS (FOREIGN KEYS)
-------------------------------------------------------------

-- tb_veiculo
ALTER TABLE tb_veiculo
ADD CONSTRAINT fk_veiculo_cliente FOREIGN KEY (id_cliente)
REFERENCES tb_cliente(id_cliente);

-- tb_operacao
ALTER TABLE tb_operacao
ADD CONSTRAINT fk_operacao_veiculo FOREIGN KEY (id_veiculo)
REFERENCES tb_veiculo(id_veiculo);

ALTER TABLE tb_operacao
ADD CONSTRAINT fk_operacao_vaga FOREIGN KEY (id_vaga)
REFERENCES tb_vaga(id_vaga);

-- A FOREIGN KEY para tb_funcionario foi REMOVIDA.

---
-- 4. CRIAÇÃO DAS CONSTRAINTS ADICIONAIS (UNIQUE e CHECK)
-------------------------------------------------------------

-- tb_veiculo
ALTER TABLE tb_veiculo
ADD CONSTRAINT uc_placa_veiculo UNIQUE (placa);

-- tb_vaga
ALTER TABLE tb_vaga
ADD CONSTRAINT chk_status_vaga CHECK (status IN ('ocupada', 'livre', 'manutencao'));

-- tb_operacao
ALTER TABLE tb_operacao
ADD CONSTRAINT chk_horario_saida_valido CHECK (horario_saida IS NULL OR horario_saida >= horario_entrada);

ALTER TABLE tb_operacao
ADD CONSTRAINT chk_valor_total_positivo CHECK (valor_total IS NULL OR valor_total >= 0.00);

ALTER TABLE tb_operacao
ADD CONSTRAINT chk_status_pagamento CHECK (status_pagamento IN ('pendente', 'pago', 'cancelado', 'cortesia'));


select * from tb_cliente;
select * from tb_veiculo;
select * from tb_vaga;
select * from tb_operacao;