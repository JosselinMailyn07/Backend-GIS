-- tablas hansel: Base de datos GIS

-- Tabla: Auditoria
DROP TABLE IF EXISTS auditoria;
CREATE TABLE auditoria (
    empresa char(3),
    usuario char(40),
    fecha timestamp,
    gestion char(3),
    opcion char(25),
    operacion char(25),
    documento char(30),
    estacion char(8),
    registro serial PRIMARY KEY
);


-- Tabla: AuditoriaParametros
DROP TABLE IF EXISTS auditoriaParametros;
CREATE TABLE auditoriaParametros (
    dias integer,
    activar boolean
);
-- Tabla: CausaNOventa
DROP TABLE IF EXISTS causaNOventa;
CREATE TABLE causaNOventa (
    codigo char(5) PRIMARY KEY,
    nombre varchar(300)
);


-- Tabla: CausaNOventa
DROP TABLE IF EXISTS causaNOventa;
CREATE TABLE causaNOventa (
    codigo char(5) PRIMARY KEY,
    nombre varchar(300)
);


-- Tabla: Ciudades
DROP TABLE IF EXISTS ciudades;
CREATE TABLE ciudades (
    codigo char(6) PRIMARY KEY,
    nombre char(50) NOT NULL,
    rowguid UUID DEFAULT gen_random_uuid() NOT NULL
);

-- Tabla: ComprobantesFiscales
DROP TABLE IF EXISTS comprobantesFiscales;
CREATE TABLE comprobantesFiscales (
    comprobante char(20),
    xml text
);

-- Tabla: Conceptos
DROP TABLE IF EXISTS conceptos;
CREATE TABLE conceptos (
    codigo char(5) PRIMARY KEY,
    nombre text NOT NULL,
    rowguid UUID DEFAULT gen_random_uuid() NOT NULL
);

-- Tabla: DiasHabiles
DROP TABLE IF EXISTS diasHabiles;
CREATE TABLE diasHabiles (
    mes char(2),
    año char(4),
    diasHabiles integer
);

-- Tabla: DiasNoHabiles
DROP TABLE IF EXISTS diasNoHabiles;
CREATE TABLE diasNoHabiles (
    mes char(2),
    año char(4),
    diaNoHabil timestamp
);

-- Tabla: Empresas
DROP TABLE IF EXISTS empresas;
CREATE TABLE empresas (
    codigoEmpresa char(3) PRIMARY KEY,
    nombre char(50) NOT NULL,
    baseDeDatos VARCHAR(100) NOT NULL,
    direccion text,
    telefono char(50),
    rif char(22),
    fechaInicio timestamp,
    fechaCierre timestamp,
    mascaraContable char(40),
    contribuyenteEspecial boolean,
    activa boolean NOT NULL,
    nit varchar(50),
    comercial char(20),
    centro char(20),
    segmento char(20)
);
-- TABLA DE USUARIOS PARA LOGIN (Ajustada a la PK de empresas)
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'usuario',
    activo BOOLEAN DEFAULT TRUE,
    -- Clave foránea que apunta a empresas.codigoEmpresa. Debe ser del mismo tipo.
    empresa_codigo char(3) NOT NULL,
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- La relación ahora apunta a la columna correcta (codigoEmpresa)
    CONSTRAINT fk_empresa_usuario
        FOREIGN KEY(empresa_codigo)
        REFERENCES empresas(codigoEmpresa)
        ON DELETE CASCADE
);

-- Índice para la tabla usuarios
CREATE INDEX idx_usuarios_nombre ON usuarios(nombre);
CREATE INDEX idx_usuarios_email ON usuarios(email);


-- Tabla: Estaciones64846886
DROP TABLE IF EXISTS estaciones64846886;
CREATE TABLE estaciones64846886 (
    estacion char(5) NOT NULL,
    intKey char(30) NOT NULL,
    usuario char(50),
    fechaConexion timestamp,
    ultimaConexion timestamp
);


-- Tabla: Estaciones67340997
DROP TABLE IF EXISTS estaciones67340997;
CREATE TABLE estaciones67340997 (
    estacion char(5) NOT NULL,
    intKey char(30) NOT NULL,
    usuario char(50),
    fechaConexion timestamp,
    ultimaConexion timestamp
);


-- Tabla: Estaciones67341024
DROP TABLE IF EXISTS estaciones67341024;
CREATE TABLE estaciones67341024 (
    estacion char(5) NOT NULL,
    intKey char(30) NOT NULL,
    usuario char(50),
    fechaConexion timestamp,
    ultimaConexion timestamp
);


-- Tabla: Estaciones69835080
DROP TABLE IF EXISTS estaciones69835080;
CREATE TABLE estaciones69835080 (
    estacion char(5) NOT NULL,
    intKey char(30) NOT NULL,
    usuario char(50),
    fechaConexion timestamp,
    ultimaConexion timestamp
);


-- Tabla: Estaciones72329219
DROP TABLE IF EXISTS estaciones72329219;
CREATE TABLE estaciones72329219 (
    estacion char(5) NOT NULL,
    intKey char(30) NOT NULL,
    usuario char(50),
    fechaConexion timestamp,
    ultimaConexion timestamp
);

-- Tabla: Estados
DROP TABLE IF EXISTS estados;
CREATE TABLE estados (
    codigo char(5) PRIMARY KEY,
    nombre char(50) NOT NULL,
    rowguid UUID DEFAULT gen_random_uuid() NOT NULL
);

-- Tabla: ImpuestoRenta
DROP TABLE IF EXISTS impuestoRenta;
CREATE TABLE impuestoRenta (
    fecha timestamp,
    tipo char(1),
    porcentaje decimal(10, 4),
    registro serial NOT NULL
);


-- Tabla: IVA
DROP TABLE IF EXISTS iva;
CREATE TABLE iva (
    fecha timestamp,
    tipo char(1),
    porcentaje decimal(10, 4),
    registro serial NOT NULL
);


DROP TABLE IF EXISTS municipios;

CREATE TABLE municipios (
    codigo char(5) PRIMARY KEY NOT NULL,
    nombre char(50) NOT NULL,
    rowguid uuid DEFAULT gen_random_uuid() NOT NULL,
    UNIQUE (rowguid)
);

DROP TABLE IF EXISTS nombresProyectos;

CREATE TABLE nombresProyectos (
    codigo char(5) NOT NULL,
    nombre char(50)
);


DROP TABLE IF EXISTS opcionesMenu;

CREATE TABLE opcionesMenu (
    codigo char(10),
    nombre char(50),
    nivel integer
);


DROP TABLE IF EXISTS opcionesUsuarios;

CREATE TABLE opcionesUsuarios (
    usuario char(50),
    opcionDenegada char(10)
);


DROP TABLE IF EXISTS operacionesCaja;

CREATE TABLE operacionesCaja (
    tipo char(2) PRIMARY KEY NOT NULL,
    descripcion text,
    valor decimal(10,4),
    signo char(1),
    editable char(1)
);



DROP TABLE IF EXISTS referenciaBancos;

CREATE TABLE referenciaBancos (
    nombre char(40),
    rowguid uuid NOT NULL DEFAULT gen_random_uuid(),
    UNIQUE (rowguid)
);


DROP TABLE IF EXISTS referenciaTarjetas;

CREATE TABLE referenciaTarjetas (
    nombre char(50),
    rowguid uuid DEFAULT gen_random_uuid() UNIQUE
);


drop table if exists reportes;

create table reportes (
	registro serial primary key,
    reporte char(50),
    descripcion char(50),
    ordenes text,
    codigoReporte char(10) not null,
    nivel integer,
    codigoCriterio char(30),
    codigoParametros char(30),
    tipo char(1),
    gestion char(3) default 'GIS',
    servidor char(40),
    preproceso text,
    datosEmpresa char(1) default 'N',
    otrosDatos char(1) default 'N'
);


drop table if exists reportesCatalogos;

create table reportesCatalogos (
    catalogo char(30) not null primary key,
    tituloCatalogo char(50),
    comandoSeleccion text,
    tipo char(1),
    campos text,
    gestion char(3) default 'GIS'
);


drop table if exists reportesCriterios;

create table reportesCriterios (
	registro serial primary key,
    codigoCriterio char(30),
    secuencial char(3),
    campo char(50),
    descripcion char(50),
    tipo char(1),
    catalogo char(30),
    seleccionarColumna int,
    desde char(50),
    hasta char(50),
    igual char(50),
    gestion char(3) default 'GIS'
);


drop table if exists reportesParametros;

create table reportesParametros (
    registro serial primary key,
    codigoParametros char(30) not null,
    secuencial char(3),
    parametro char(30) not null,
    descripcion char(50) not null,
    valor char(100),
    tipo char(1) not null,
    catalogo char(30),
    seleccionarColumna int,
    gestion char(3) default 'GIS'
);


drop table if exists retenciones;

create table retenciones (
    codigoRetencion char(5) not null,
    codigoContable char(30),
    numeroDocumento char(50),
    codigoProducto char(19),
    fecha timestamp,
    valorRetencion decimal(10,4),
    ejercicioFiscal char(19)
);


drop table if exists tasaCambio;

create table tasaCambio (
    fecha timestamp,
    cambio decimal(14,7)
);


drop table if exists tipoCredito;

create table tipoCredito (
    codigo char(5) primary key,
    nombre text,
    documento char(2) not null,
    dias int not null default 0,
    cuotas int not null default 0,
    anos int not null default 0,
    interes decimal(10,4) not null default 0,
    limite decimal(10,4) not null default 0
);


drop table if exists tiposRetenciones;

create table tiposRetenciones (
    codigoRetencion char(20) primary key,
    tipoImpuesto char(30) not null,
    concepto char(250),
    porcentaje decimal(10,4),
    vigenciaDesde varchar(50),
    vigenciaHasta varchar(50),
    baseImponible decimal(10,4),
    codigoContable char(30),
    tipo int
);


drop table if exists unidadMedida;

create table unidadMedida (
    unidad0 char(12) primary key,
    unidad1 char(12),
    conversion1 real,
    unidad2 char(12),
    conversion2 real,
    unidad3 char(12),
    conversion3 real
);


drop table if exists unidadTributaria;

create table unidadTributaria (
    fecha timestamp,
    valor decimal(10,4)
);