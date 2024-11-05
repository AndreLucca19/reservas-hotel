CREATE DATABASE hotel

CREATE TABLE hospedes (
id_hospede SERIAL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
email VARCHAR(250) UNIQUE NOT NULL
);

CREATE TABLE quartos (
id_quarto SERIAL PRIMARY KEY,
numero_quarto INT NOT NULL,
camas INT
);

CREATE TABLE reservas (
id_reserva SERIAL PRIMARY KEY,
data_reserva DATE NOT NULL DEFAULT CURRENT_DATE,
horario_reserva TIME NOT NULL,
data_inicio DATE NOT NULL,
data_fim DATE NOT NULL,
id_hospede INT NOT NULL,
id_quarto INT NOT NULL,
CONSTRAINT fk_hospedes FOREIGN KEY (id_hospede) REFERENCES hospedes (id_hospede),
CONSTRAINT fk_quartos FOREIGN KEY (id_quarto) REFERENCES quartos (id_quarto)
);

INSERT INTO hospedes (nome, email) 
VALUES 
('Luiz', 'luiz@gmail.com'),
('Andre', 'andre@gmail.com');

INSERT INTO quartos (numero_quarto, camas) 
VALUES
(186, 2),
(193, 1),
(134, 2),
(172, 4);

INSERT INTO reservas (id_hospede, id_quarto, horario_reserva) VALUES 
(1,3, '00:20'),
(2,4, '01:10');

SELECT 
	r.id_reserva,
	h.nome AS hospede,
	h.email,
	q.numero_quarto,
	q.camas AS quantidade_cama,
	r.data_reserva,
	r.horario_reserva
FROM	
	reservas r
JOIN
	hospedes h ON r.id_hospede = h.id_hospede
JOIN
	quartos q ON r.id_quarto = q.id_quarto;
