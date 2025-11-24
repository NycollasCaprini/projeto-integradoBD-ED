
CREATE TABLE cliente (
	id_cliente SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100)NOT NULL,
	telefone VARCHAR(20)NOT NULL
);

CREATE TABLE veiculo(
	id_veiculo SERIAL PRIMARY KEY,
	modelo VARCHAR(100) NOT NULL,
	cor VARCHAR(12) NOT NULL,
	placa VARCHAR(7) NOT NULL UNIQUE,
	id_cliente INT NOT NULL,
	CONSTRAINT fk_veiculo_cliente 
		FOREIGN KEY (id_cliente) 
		REFERENCES cliente(id_cliente) 
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE vaga(
	id_vaga SERIAL PRIMARY KEY,
	status VARCHAR(50)
);

CREATE table operacao(
	id_operacao SERIAL PRIMARY KEY,
	horario_entrada TIMESTAMP NOT NULL,
	horario_saida TIMESTAMP,
	valor_total DECIMAL(10, 2),
	id_veiculo INT NOT NULL,
	id_vaga INT NOT NULL,
	CONSTRAINT  fk_operacao_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo (id_veiculo)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT fk_operacao_vaga FOREIGN KEY (id_vaga) REFERENCES vaga (id_vaga) 
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);