CREATE TABLE revistas (
	codigo_de_barras INTEGER NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	descripcion TEXT
);

CREATE TABLE ediciones (
	revista_rowid INTEGER NOT NULL,
	anio NOT NULL,
	numero INTEGER NOT NULL,
	precio_de_venta FLOAT NOT NULL,
	precio_de_compra FLOAT NOT NULL,
	stock INTEGER NOT NULL,
	FOREIGN KEY (revista_rowid) REFERENCES revista (rowid) ON DELETE CASCADE
);

CREATE TABLE movimientos (
	tipo CHAR(4) NOT NULL,
	fecha DATETIME NOT NULL
);

CREATE TABLE movimiento_detalles (
	movimiento_rowid INTEGER NOT NULL,
	edicion_rowid INTEGER NOT NULL,
	FOREIGN KEY (movimiento_rowid) REFERENCES movimiento (rowid) ON DELETE CASCADE
	FOREIGN KEY (edicion_rowid) REFERENCES edicion (rowid) ON DELETE CASCADE
);
