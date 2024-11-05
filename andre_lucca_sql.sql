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
('Pedro', 'pedro@gmail.com'),
('Joao', 'joao@gmail.com'),
('Andre', 'andre@gmail.com'),
('Caio', 'caio@gmail.com'),
('Lucca', 'lucca@gmail.com'),
('Luana', 'luana@gmail.com');


INSERT INTO quartos (numero_quarto, camas) 
VALUES
(186, 2),
(193, 1),
(134, 2),
(172, 4),
(191, 2);
(192, 4),
(194, 2);

INSERT INTO reservas (id_hospede, id_quarto, horario_reserva, data_inicio, data_fim) 
VALUES 
(1, 1, '01:20', '2024-01-01', '2024-01-04'),
(2, 2, '01:00', '2024-12-25', '2025-01-03'),
(3, 5, '09:30', '2024-01-01', '2024-01-04'),
(5, 3, '12:00', '2024-02-16', '2024-02-19'),
(4, 4, '10:00', '2024-06-01', '2024-06-09'),

/* Pega todos os reservados*/
SELECT 
	r.id_reserva,
	h.nome AS hospede,
	h.email,
	q.numero_quarto,
	q.camas AS quantidade_cama,
    r.data_inicio,
    r.data_fim,
	r.data_reserva,
	r.horario_reserva
FROM	
	reservas r
JOIN
	hospedes h ON r.id_hospede = h.id_hospede
JOIN
	quartos q ON r.id_quarto = q.id_quarto;

/*mostra todos os hóspedes, incluindo aqueles que ainda não estão reservados*/
SELECT 
        r.id_reserva,
        h.nome AS hospede,
        h.email,
        q.numero_quarto,
        q.camas AS quantidade_cama,
        r.data_inicio,
        r.data_fim,
        r.data_reserva,
        r.horario_reserva
FROM	
        reservas r
LEFT JOIN
        quartos q ON r.id_quarto = q.id_quarto
RIGHT JOIN
        hospedes h ON r.id_hospede = h.id_hospede;

/*mostra apenas os quartos que ainda não estão reservados*/
SELECT 
        r.id_reserva,
        h.nome AS hospede,
        h.email,
        q.numero_quarto,
        q.camas AS quantidade_cama,
        r.data_inicio,
        r.data_fim,
        r.data_reserva,
        r.horario_reserva
FROM	
    quartos q
LEFT JOIN
    reservas r ON q.id_quarto = r.id_quarto
LEFT JOIN
    hospedes h ON r.id_hospede = h.id_hospede
WHERE
    r.id_reserva IS NULL;