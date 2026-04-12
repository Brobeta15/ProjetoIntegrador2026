create database coolertrack;
use coolertrack;

CREATE TABLE USUARIO (
    id_usuario   INT          NOT NULL AUTO_INCREMENT,
    nome         VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    senha        VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_usuario)
);

CREATE TABLE FREEZER (
    id_freezer   INT          NOT NULL AUTO_INCREMENT,
    nome         VARCHAR(100) NOT NULL,
    id_usuario   INT          NOT NULL,
    PRIMARY KEY (id_freezer),
    CONSTRAINT fk_freezer_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE SENSOR_TEMPERATURA (
    id_serial    INT          NOT NULL AUTO_INCREMENT,
    nome         VARCHAR(100) NOT NULL,
    id_freezer   INT          NOT NULL,
    PRIMARY KEY (id_serial),
    CONSTRAINT fk_sensor_freezer
        FOREIGN KEY (id_freezer) REFERENCES FREEZER (id_freezer)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE HISTORICO_TEMPERATURA (
    id_log       INT          NOT NULL AUTO_INCREMENT,
    temperatura  FLOAT        NOT NULL,
    timestamp    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_serial    INT          NOT NULL,
    PRIMARY KEY (id_log),
    CONSTRAINT fk_historico_sensor
        FOREIGN KEY (id_serial) REFERENCES SENSOR_TEMPERATURA (id_serial)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE PRODUTO (
    id_produto     INT          NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(100) NOT NULL,
    data_validade  DATE,
    temp_minima    FLOAT        NOT NULL,
    temp_maxima    FLOAT        NOT NULL,
    PRIMARY KEY (id_produto)
);

CREATE TABLE FREEZER_PRODUTO (
    id_freezer   INT NOT NULL,
    id_produto   INT NOT NULL,
    PRIMARY KEY (id_freezer, id_produto),
    CONSTRAINT fk_fp_freezer
        FOREIGN KEY (id_freezer) REFERENCES FREEZER (id_freezer)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_fp_produto
        FOREIGN KEY (id_produto) REFERENCES PRODUTO (id_produto)
        ON DELETE CASCADE ON UPDATE CASCADE
);