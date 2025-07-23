-- Tabla: alarma
DROP TABLE IF EXISTS alarma;
CREATE TABLE alarma (
  meses INTEGER NOT NULL
);

-- Tabla: bancos
DROP TABLE IF EXISTS bancos;
CREATE TABLE bancos (
  codigoBanco VARCHAR(5) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  cuenta VARCHAR(20),
  codigoContable VARCHAR(30),
  direccion TEXT,
  telefonos VARCHAR(30),
  fax VARCHAR(15),
  email VARCHAR(50),
  contacto VARCHAR(50),
  agencia VARCHAR(30),
  comision DECIMAL(10,4),
  saldo DECIMAL(10,4) DEFAULT 0.0000,
  PRIMARY KEY (codigoBanco)
);

-- Tabla: bancoschequeras
DROP TABLE IF EXISTS bancoschequeras;
CREATE TABLE bancoschequeras (
  codigoBanco VARCHAR(5) NOT NULL,
  numeroChequera VARCHAR(8) NOT NULL,
  fecha TIMESTAMP,
  inicial VARCHAR(12),
  final VARCHAR(12),
  PRIMARY KEY (numeroChequera)
);

-- Tabla: bancoscheques
DROP TABLE IF EXISTS bancoscheques;
CREATE TABLE bancoscheques (
  registro SERIAL PRIMARY KEY,
  numeroChequera VARCHAR(8) NOT NULL,
  numeroCheque VARCHAR(12) NOT NULL,
  estatus VARCHAR(1) NOT NULL,
  codigoBanco VARCHAR(5) NOT NULL
);

-- Tabla: bancosconciliacion
DROP TABLE IF EXISTS bancosconciliacion;
CREATE TABLE bancosconciliacion (
  codigoBanco VARCHAR(5) NOT NULL,
  mes VARCHAR(2) NOT NULL,
  ano VARCHAR(4) NOT NULL,
  cerrada BOOLEAN NOT NULL DEFAULT FALSE,
  UNIQUE (codigoBanco, mes, ano)
);

-- Tabla: bancosconciliacionmovimientos
DROP TABLE IF EXISTS bancosconciliacionmovimientos;
CREATE TABLE bancosconciliacionmovimientos (
  codigoBanco VARCHAR(5) NOT NULL,
  numero VARCHAR(12),
  fecha TIMESTAMP NOT NULL,
  tipo VARCHAR(2) NOT NULL,
  concepto VARCHAR(70),
  importe DECIMAL(19,4) NOT NULL,
  concilia BOOLEAN NOT NULL DEFAULT FALSE,
  manual BOOLEAN NOT NULL DEFAULT FALSE,
  mes VARCHAR(2) NOT NULL,
  ano VARCHAR(4) NOT NULL
);

-- Tabla: bancosdistribuciongasto
DROP TABLE IF EXISTS bancosdistribuciongasto;
CREATE TABLE bancosdistribuciongasto (
  codigoBanco VARCHAR(5) NOT NULL,
  tipo VARCHAR(2) NOT NULL,
  numero VARCHAR(12) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  codigoContable VARCHAR(30) NOT NULL,
  centroCosto VARCHAR(20),
  codigoPresupuesto VARCHAR(30),
  concepto VARCHAR(70),
  importe DECIMAL(19,4) NOT NULL,
  asiento VARCHAR(8),
  origen VARCHAR(3) NOT NULL,
  valorAnterior DECIMAL(19,4)
);

-- Tabla: bancosmovimientos
DROP TABLE IF EXISTS bancosmovimientos;
CREATE TABLE bancosmovimientos (
  registro SERIAL PRIMARY KEY,
  codigoBanco VARCHAR(5) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  tipo VARCHAR(2) NOT NULL,
  numero VARCHAR(12) NOT NULL,
  concepto VARCHAR(70),
  importe DECIMAL(19,4),
  origen VARCHAR(3),
  tipoOrigen VARCHAR(2),
  numeroOrigen VARCHAR(8),
  concilia BOOLEAN NOT NULL DEFAULT FALSE,
  beneficiario VARCHAR(50),
  codigoBenef VARCHAR(20),
  cambio DECIMAL(10,4),
  asiento VARCHAR(8),
  anulada BOOLEAN,
  comisionBan DECIMAL(19,4),
  UNIQUE (codigoBanco, tipo, numero)
);

-- Tabla: boletasproduccion
DROP TABLE IF EXISTS boletasproduccion;
CREATE TABLE boletasproduccion (
  numero VARCHAR(8) PRIMARY KEY,
  fechaInicio TIMESTAMP,
  fechaTermino TIMESTAMP,
  codigoProducto VARCHAR(50),
  cantidad DECIMAL(19,4),
  comentarios TEXT,
  totalBoleta DECIMAL(19,4),
  estatus VARCHAR(2),
  lineaProduccion VARCHAR(5),
  factorUso DECIMAL(10,4),
  almacenEntrada VARCHAR(5),
  almacenSalida VARCHAR(5),
  desglose BOOLEAN,
  generarSalida BOOLEAN,
  ordenProduccion VARCHAR(8)
);

-- Tabla: boletasproduccionrenglones
DROP TABLE IF EXISTS boletasproduccionrenglones;
CREATE TABLE boletasproduccionrenglones (
  registro SERIAL PRIMARY KEY,
  numero VARCHAR(8) NOT NULL,
  codigoProducto VARCHAR(50) NOT NULL,
  descripcion VARCHAR(50),
  unidadMedida VARCHAR(12),
  almacen VARCHAR(5),
  cantidad DECIMAL(19,4),
  costoUnitario DECIMAL(19,4)
);

-- Tabla: boletastrabajo
DROP TABLE IF EXISTS boletastrabajo;
CREATE TABLE boletastrabajo (
  numero VARCHAR(10) PRIMARY KEY,
  fechaInicio TIMESTAMP,
  fechaTermino TIMESTAMP,
  empleado VARCHAR(5),
  comentarios TEXT,
  totalBoleta DECIMAL(19,4),
  estatus VARCHAR(2),
  lineaTrabajo VARCHAR(5),
  factorUso DECIMAL(10,4),
  almacenSalida VARCHAR(5),
  desglose BOOLEAN,
  generarSalida BOOLEAN,
  ordenTrabajo VARCHAR(10)
);

-- Tabla: boletastrabajorenglones
DROP TABLE IF EXISTS boletastrabajorenglones;
CREATE TABLE boletastrabajorenglones (
  registro SERIAL PRIMARY KEY,
  numero VARCHAR(10) NOT NULL,
  codigoProducto VARCHAR(50) NOT NULL,
  descripcion VARCHAR(50),
  unidadMedida VARCHAR(12),
  almacen VARCHAR(5),
  cantidad DECIMAL(19,4),
  costoUnitario DECIMAL(19,4)
);

-- Tabla: cajacajeros
DROP TABLE IF EXISTS cajacajeros;
CREATE TABLE cajacajeros (
  codigo VARCHAR(5) PRIMARY KEY,
  rif VARCHAR(15),
  nombre VARCHAR(250),
  clave VARCHAR(50) DEFAULT '*',
  direccion TEXT,
  telefonos VARCHAR(30),
  email VARCHAR(50),
  fechaRegistro TIMESTAMP
);

-- Tabla: cajacajerosmovimientos
DROP TABLE IF EXISTS cajacajerosmovimientos;
CREATE TABLE cajacajerosmovimientos (
  codigoCajero VARCHAR(5) NOT NULL,
  codigoCaja VARCHAR(5) NOT NULL,
  codigoTurno VARCHAR(5) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  hora TIMESTAMP,
  tipo VARCHAR(1) NOT NULL,
  saldo DECIMAL(19,4) NOT NULL
);

-- Tabla: cajadistribuciongasto
DROP TABLE IF EXISTS cajadistribuciongasto;
CREATE TABLE cajadistribuciongasto (
  codigoCaja VARCHAR(5) NOT NULL,
  tipo VARCHAR(2) NOT NULL,
  numero VARCHAR(12) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  codigoContable VARCHAR(30) NOT NULL,
  centroCosto VARCHAR(20) NOT NULL,
  concepto VARCHAR(70),
  importe DECIMAL(19,4) NOT NULL,
  origen VARCHAR(3) NOT NULL,
  asiento VARCHAR(8)
);

-- Tabla: cajaliquidacion
DROP TABLE IF EXISTS cajaliquidacion;
CREATE TABLE cajaliquidacion (
  codigoCaja VARCHAR(5) NOT NULL,
  tipo VARCHAR(2) NOT NULL,
  numero VARCHAR(12) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  codigoContable VARCHAR(30),
  descripcion VARCHAR(100),
  valor DECIMAL(19,4) NOT NULL,
  cantidad DECIMAL(19,4) NOT NULL,
  origen VARCHAR(3) NOT NULL,
  asiento VARCHAR(8),
  codigoCajero VARCHAR(15)
);

-- Tabla: cajamovimientos
DROP TABLE IF EXISTS cajamovimientos;
CREATE TABLE cajamovimientos (
  registro SERIAL PRIMARY KEY,
  codigoCaja VARCHAR(5) NOT NULL,
  codigoTurno VARCHAR(5),
  tipo VARCHAR(2),
  referencia VARCHAR(20),
  banco VARCHAR(100),
  cuenta VARCHAR(20),
  beneficiario VARCHAR(50),
  concepto VARCHAR(70),
  importe DECIMAL(19,4),
  fecha TIMESTAMP,
  origen VARCHAR(3),
  numero VARCHAR(8),
  numeroOrigen VARCHAR(8),
  tipoOrigen VARCHAR(2),
  depositoNumero VARCHAR(12),
  depositoBanco VARCHAR(5),
  depositoImporte DECIMAL(19,4),
  anulada BOOLEAN,
  asiento VARCHAR(8),
  valorAnterior DECIMAL(19,4)
);

-- Tabla: servicios
DROP TABLE IF EXISTS servicios;
CREATE TABLE servicios (
  codigo VARCHAR(14) NOT NULL,
  nombre VARCHAR(250) NOT NULL,
  iva VARCHAR(1),
  impuestorenta VARCHAR(1),
  precio DECIMAL(10,4),
  costo DECIMAL(10,4),
  codigocontable VARCHAR(30),
  contacosto VARCHAR(30),
  PRIMARY KEY (codigo)
);

-- Tabla: vehiculos
DROP TABLE IF EXISTS vehiculos;
CREATE TABLE vehiculos (
  codigovehiculo VARCHAR(50) PRIMARY KEY,
  matricula VARCHAR(50) NOT NULL,
  modelo VARCHAR(50),
  anio VARCHAR(30),
  chasis VARCHAR(30),
  motor VARCHAR(30),
  disco VARCHAR(30),
  odometro VARCHAR(30),
  color VARCHAR(30),
  marca VARCHAR(5),
  comentarios TEXT,
  fecharegistro TIMESTAMP,
  foto BYTEA
);

-- 1. Tablas de Caja
DROP TABLE IF EXISTS cajas CASCADE;
CREATE TABLE cajas (
    codigoCaja CHAR(5) PRIMARY KEY,
    nombre VARCHAR(250),
    codigoContable CHAR(30),
    proximo CHAR(8) DEFAULT '00000001'
);

DROP TABLE IF EXISTS cajaTurnos CASCADE;
CREATE TABLE cajaTurnos (
    codigoTurno CHAR(5) PRIMARY KEY,
    descripcion VARCHAR(50),
    horaInicial TIMESTAMP,
    horaFinal TIMESTAMP
);

DROP TABLE IF EXISTS cajaMovimientos CASCADE;
CREATE TABLE cajaMovimientos (
    codigoCaja CHAR(5) NOT NULL,
    codigoTurno CHAR(5),
    tipo CHAR(2),
    referencia CHAR(20),
    banco VARCHAR(100),
    cuenta CHAR(20),
    beneficiario CHAR(50),
    concepto CHAR(70),
    importe DECIMAL(10,4),
    fecha TIMESTAMP,
    origen CHAR(3),
    numero CHAR(8),
    numeroOrigen CHAR(8),
    tipoOrigen CHAR(2),
    depositoNumero CHAR(12),
    depositoBanco CHAR(5),
    depositoImporte DECIMAL(10,4),
    registro SERIAL,
    anulada BOOLEAN,
    asiento CHAR(8),
    valoranterior DECIMAL(10,4)
);

-- 2. Tabla de Cierre
DROP TABLE IF EXISTS cierre CASCADE;
CREATE TABLE cierre (
    gestion VARCHAR(50),
    fechaCierre TIMESTAMP
);

-- 3. Tablas de Clientes
DROP TABLE IF EXISTS clientesGrupos CASCADE;
CREATE TABLE clientesGrupos (
    codigoGrupo CHAR(5) PRIMARY KEY,
    nombre VARCHAR(250),
    codigoContable CHAR(30)
);

DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes (
    codigoCliente VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    razonSocial VARCHAR(50),
    rif CHAR(22),
    nit CHAR(22),
    documentoFiscal CHAR(1),
    direccion TEXT,
    direccionEnvio TEXT,
    ciudad CHAR(6),
    estado CHAR(5),
    municipio CHAR(5),
    email VARCHAR(50),
    telefonos VARCHAR(30),
    fax VARCHAR(30),
    codigoGrupo CHAR(5),
    zona CHAR(5),
    limiteCredito DECIMAL(10,4),
    estatus CHAR(2),
    transporte CHAR(5),
    descuento DECIMAL(10,4),
    observaciones VARCHAR(50),
    regimenIVA CHAR(1),
    tarifa CHAR(5),
    tipoCredito CHAR(5),
    personaContacto VARCHAR(30),
    vendedor CHAR(5),
    cobrador CHAR(5),
    bancoDomicilia CHAR(25),
    cuentaDomicilia CHAR(20),
    titularDomicilia VARCHAR(30),
    codigoContable CHAR(30),
    fechaRegistro TIMESTAMP,
    diasVisita CHAR(6),
    diasEntrega CHAR(12),
    empresa CHAR(3),
    saldo DECIMAL(10,4) DEFAULT 0,
    ultimopago TIMESTAMP,
    registro SERIAL,
    web VARCHAR(200)
);

DROP TABLE IF EXISTS clientesCausaNoVenta CASCADE;
CREATE TABLE clientesCausaNoVenta (
    codigoCliente CHAR(20),
    causaNoVenta CHAR(5),
    fecha TIMESTAMP
);

DROP TABLE IF EXISTS clienteMovimientosGeneral CASCADE;
CREATE TABLE clienteMovimientosGeneral (
    codigoCliente CHAR(20),
    tipo CHAR(2),
    referencia CHAR(20),
    importe DECIMAL(10,4),
    fecha TIMESTAMP,
    numero CHAR(8)
);

DROP TABLE IF EXISTS clientesMovimientos CASCADE;
CREATE TABLE clientesMovimientos (
    codigoCliente VARCHAR(50),
    tipo CHAR(2) NOT NULL,
    nTipo CHAR(1),
    numero CHAR(8),
    emision TIMESTAMP,
    vencimiento TIMESTAMP,
    comprobante CHAR(8),
    referencia CHAR(20),
    referenciaContable CHAR(30),
    centroCosto CHAR(20),
    concepto VARCHAR(30),
    importe DECIMAL(10,4) NOT NULL,
    origen CHAR(3),
    numeroOrigen CHAR(8),
    tipoDocCancela CHAR(2),
    intereses DECIMAL(10,4),
    vendedor CHAR(5),
    cobrador CHAR(5),
    registro SERIAL,
    asiento CHAR(8),
    anulada BOOLEAN
);

-- 4. Tablas de Compras
DROP TABLE IF EXISTS compras CASCADE;
CREATE TABLE compras (
    numero CHAR(8) PRIMARY KEY,
    referencia CHAR(20),
    referenciaControl CHAR(20),
    fechaEmision TIMESTAMP NOT NULL,
    vencimiento TIMESTAMP,
    codigoProveedor CHAR(20),
    totalBruto DECIMAL(10,4),
    retenciones DECIMAL(10,4),
    descuento DECIMAL(10,4),
    impuesto DECIMAL(10,4),
    cargo DECIMAL(10,4),
    totalCompra DECIMAL(10,4),
    porcentajeDescuento DECIMAL(10,4),
    transportista CHAR(5),
    comentarios TEXT,
    almacen CHAR(5),
    tipoPago CHAR(1),
    peso DECIMAL(10,4),
    devolucionCompra CHAR(8),
    referenciaContable CHAR(30),
    codigoCaja CHAR(5),
    giroAno REAL,
    giroCuota REAL,
    giroSerie CHAR(3),
    giroInteres REAL,
    centroCosto CHAR(20),
    centroCosto2 CHAR(20),
    numRetIVA CHAR(20),
    numRetISRL CHAR(20),
    fechaRegistroIVA TIMESTAMP,
    fechaRegistro TIMESTAMP,
    importacion BOOLEAN DEFAULT false,
    importacionPlanilla CHAR(20),
    importacionExpediente CHAR(20),
    anulada BOOLEAN,
    gara BOOLEAN,
    asiento CHAR(8),
    comision DECIMAL(10,4),
    tipo INTEGER,
    tpro INTEGER,
    autor VARCHAR(25),
    establo INTEGER,
    emision INTEGER,
    secuencia NUMERIC(18,0)
);

DROP TABLE IF EXISTS comprasRenglones CASCADE;
CREATE TABLE comprasRenglones (
    numero CHAR(8),
    almacen CHAR(5),
    codigoProducto CHAR(50),
    descripcion CHAR(50),
    unidadMedida CHAR(12),
    iva CHAR(1),
    porcentajeIva NUMERIC(5,2),
    bultos REAL,
    cantidad NUMERIC(15,2),
    precio NUMERIC(19,7),
    descuento NUMERIC(5,2),
    totalRenglon DECIMAL(10,4),
    ordenCompra CHAR(8),
    recepcion CHAR(8),
    registro SERIAL,
    codigoContable CHAR(30),
    codigoPresupuesto CHAR(30),
    centroCosto CHAR(20),
    centroCosto2 CHAR(20),
    anulada BOOLEAN
);

-- 5. Tablas de Contabilidad
DROP TABLE IF EXISTS contabilidadAsientos CASCADE;
CREATE TABLE contabilidadAsientos (
    numero CHAR(8) PRIMARY KEY,
    fecha TIMESTAMP,
    descripcion VARCHAR(70),
    debitos DECIMAL(10,4),
    creditos DECIMAL(10,4),
    anulada BOOLEAN,
    tipo CHAR(1),
    bene VARCHAR(50)
);

DROP TABLE IF EXISTS contabilidadAsientosRenglones CASCADE;
CREATE TABLE contabilidadAsientosRenglones (
    numero CHAR(8),
    fecha TIMESTAMP,
    codigoContable CHAR(30),
    referencia CHAR(20),
    concepto VARCHAR(70),
    centroCosto CHAR(20),
    centroCosto2 CHAR(20),
    importe DECIMAL(10,4),
    registro SERIAL,
    anulada BOOLEAN,
    codigo NUMERIC(18,0),
    tipo CHAR(4),
    nombre VARCHAR(50),
    numcheq VARCHAR(25),
    cuenta VARCHAR(25)
);

DROP TABLE IF EXISTS contabilidadBalanceControl CASCADE;
CREATE TABLE contabilidadBalanceControl (
    activo CHAR(30),
    pasivo CHAR(30),
    capital CHAR(30),
    ingreso CHAR(30),
    egreso CHAR(30),
    gasto CHAR(30),
    ordenActivo CHAR(30),
    ordenPasivo CHAR(30),
    resultado CHAR(30),
    definicion CHAR(5)
);

DROP TABLE IF EXISTS contabilidadBalances CASCADE;
CREATE TABLE contabilidadBalances (
    codigoBalance CHAR(5) PRIMARY KEY,
    nombre VARCHAR(70)
);

DROP TABLE IF EXISTS contabilidadBalancesRenglones CASCADE;
CREATE TABLE contabilidadBalancesRenglones (
    codigoBalance CHAR(5),
    nivel INTEGER,
    codigoContable CHAR(30),
    nombre VARCHAR(70),
    impresion CHAR(1),
    registro SERIAL
);

DROP TABLE IF EXISTS contabilidadCentroCosto CASCADE;
CREATE TABLE contabilidadCentroCosto (
    centroCosto CHAR(20) PRIMARY KEY,
    nombre CHAR(70)
);

DROP TABLE IF EXISTS contabilidadCentroCosto2 CASCADE;
CREATE TABLE contabilidadCentroCosto2 (
    centroCosto CHAR(20) PRIMARY KEY,
    nombre CHAR(70)
);

DROP TABLE IF EXISTS tpvClientes;
CREATE TABLE tpvClientes (
  codigoCliente VARCHAR(22) PRIMARY KEY,
  nombre VARCHAR(50),
  direccion TEXT,
  telefonos VARCHAR(30),
  porDefecto BOOLEAN
);

DROP TABLE IF EXISTS tpvFacturas;
CREATE TABLE tpvFacturas (
  numero VARCHAR(8) PRIMARY KEY,
  fechaEmision TIMESTAMP NOT NULL,
  codigoCliente VARCHAR(22),
  regimenIva VARCHAR(1),
  totalBruto DECIMAL(19,4),
  descuento DECIMAL(19,4),
  impuesto DECIMAL(19,4),
  cargo DECIMAL(19,4),
  totalFactura DECIMAL(19,4),
  porcentajeDescuento DECIMAL(10,4),
  vendedor VARCHAR(5),
  tarifa VARCHAR(5),
  peso DECIMAL(19,4),
  devolucionFactura VARCHAR(8),
  codigoCaja VARCHAR(5),
  recibeEfectivo DECIMAL(19,4),
  comentarios TEXT,
  cuadre BOOLEAN
);


-- 1. Tablas de Caja
DROP TABLE IF EXISTS cajas CASCADE;
CREATE TABLE cajas (
    codigoCaja CHAR(5) PRIMARY KEY,
    nombre VARCHAR(250),
    codigoContable CHAR(30),
    proximo CHAR(8) DEFAULT '00000001'
);

DROP TABLE IF EXISTS cajaTurnos CASCADE;
CREATE TABLE cajaTurnos (
    codigoTurno CHAR(5) PRIMARY KEY,
    descripcion VARCHAR(50),
    horaInicial TIMESTAMP,
    horaFinal TIMESTAMP
);

DROP TABLE IF EXISTS cajaMovimientos CASCADE;
CREATE TABLE cajaMovimientos (
    codigoCaja CHAR(5) NOT NULL,
    codigoTurno CHAR(5),
    tipo CHAR(2),
    referencia CHAR(20),
    banco VARCHAR(100),
    cuenta CHAR(20),
    beneficiario CHAR(50),
    concepto CHAR(70),
    importe DECIMAL(10,4),
    fecha TIMESTAMP,
    origen CHAR(3),
    numero CHAR(8),
    numeroOrigen CHAR(8),
    tipoOrigen CHAR(2),
    depositoNumero CHAR(12),
    depositoBanco CHAR(5),
    depositoImporte DECIMAL(10,4),
    registro SERIAL,
    anulada BOOLEAN,
    asiento CHAR(8),
    valoranterior DECIMAL(10,4)
);

-- 2. Tabla de Cierre
DROP TABLE IF EXISTS cierre CASCADE;
CREATE TABLE cierre (
    gestion VARCHAR(50),
    fechaCierre TIMESTAMP
);

-- 3. Tablas de Clientes
DROP TABLE IF EXISTS clientesGrupos CASCADE;
CREATE TABLE clientesGrupos (
    codigoGrupo CHAR(5) PRIMARY KEY,
    nombre VARCHAR(250),
    codigoContable CHAR(30)
);

DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes (
    codigoCliente VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    razonSocial VARCHAR(50),
    rif CHAR(22),
    nit CHAR(22),
    documentoFiscal CHAR(1),
    direccion TEXT,
    direccionEnvio TEXT,
    ciudad CHAR(6),
    estado CHAR(5),
    municipio CHAR(5),
    email VARCHAR(50),
    telefonos VARCHAR(30),
    fax VARCHAR(30),
    codigoGrupo CHAR(5),
    zona CHAR(5),
    limiteCredito DECIMAL(10,4),
    estatus CHAR(2),
    transporte CHAR(5),
    descuento DECIMAL(10,4),
    observaciones VARCHAR(50),
    regimenIVA CHAR(1),
    tarifa CHAR(5),
    tipoCredito CHAR(5),
    personaContacto VARCHAR(30),
    vendedor CHAR(5),
    cobrador CHAR(5),
    bancoDomicilia CHAR(25),
    cuentaDomicilia CHAR(20),
    titularDomicilia VARCHAR(30),
    codigoContable CHAR(30),
    fechaRegistro TIMESTAMP,
    diasVisita CHAR(6),
    diasEntrega CHAR(12),
    empresa CHAR(3),
    saldo DECIMAL(10,4) DEFAULT 0,
    ultimopago TIMESTAMP,
    registro SERIAL,
    web VARCHAR(200)
);

DROP TABLE IF EXISTS clientesCausaNoVenta CASCADE;
CREATE TABLE clientesCausaNoVenta (
    codigoCliente CHAR(20),
    causaNoVenta CHAR(5),
    fecha TIMESTAMP
);

DROP TABLE IF EXISTS clienteMovimientosGeneral CASCADE;
CREATE TABLE clienteMovimientosGeneral (
    codigoCliente CHAR(20),
    tipo CHAR(2),
    referencia CHAR(20),
    importe DECIMAL(10,4),
    fecha TIMESTAMP,
    numero CHAR(8)
);

DROP TABLE IF EXISTS clientesMovimientos CASCADE;
CREATE TABLE clientesMovimientos (
    codigoCliente VARCHAR(50),
    tipo CHAR(2) NOT NULL,
    nTipo CHAR(1),
    numero CHAR(8),
    emision TIMESTAMP,
    vencimiento TIMESTAMP,
    comprobante CHAR(8),
    referencia CHAR(20),
    referenciaContable CHAR(30),
    centroCosto CHAR(20),
    concepto VARCHAR(30),
    importe DECIMAL(10,4) NOT NULL,
    origen CHAR(3),
    numeroOrigen CHAR(8),
    tipoDocCancela CHAR(2),
    intereses DECIMAL(10,4),
    vendedor CHAR(5),
    cobrador CHAR(5),
    registro SERIAL,
    asiento CHAR(8),
    anulada BOOLEAN
);

-- 4. Tablas de Compras
DROP TABLE IF EXISTS compras CASCADE;
CREATE TABLE compras (
    numero CHAR(8) PRIMARY KEY,
    referencia CHAR(20),
    referenciaControl CHAR(20),
    fechaEmision TIMESTAMP NOT NULL,
    vencimiento TIMESTAMP,
    codigoProveedor CHAR(20),
    totalBruto DECIMAL(10,4),
    retenciones DECIMAL(10,4),
    descuento DECIMAL(10,4),
    impuesto DECIMAL(10,4),
    cargo DECIMAL(10,4),
    totalCompra DECIMAL(10,4),
    porcentajeDescuento DECIMAL(10,4),
    transportista CHAR(5),
    comentarios TEXT,
    almacen CHAR(5),
    tipoPago CHAR(1),
    peso DECIMAL(10,4),
    devolucionCompra CHAR(8),
    referenciaContable CHAR(30),
    codigoCaja CHAR(5),
    giroAno REAL,
    giroCuota REAL,
    giroSerie CHAR(3),
    giroInteres REAL,
    centroCosto CHAR(20),
    centroCosto2 CHAR(20),
    numRetIVA CHAR(20),
    numRetISRL CHAR(20),
    fechaRegistroIVA TIMESTAMP,
    fechaRegistro TIMESTAMP,
    importacion BOOLEAN DEFAULT false,
    importacionPlanilla CHAR(20),
    importacionExpediente CHAR(20),
    anulada BOOLEAN,
    gara BOOLEAN,
    asiento CHAR(8),
    comision DECIMAL(10,4),
    tipo INTEGER,
    tpro INTEGER,
    autor VARCHAR(25),
    establo INTEGER,
    emision INTEGER,
    secuencia NUMERIC(18,0)
);

DROP TABLE IF EXISTS comprasRenglones CASCADE;
CREATE TABLE comprasRenglones (
    numero CHAR(8),
    almacen CHAR(5),
    codigoProducto CHAR(50),
    descripcion CHAR(50),
    unidadMedida CHAR(12),
    iva CHAR(1),
    porcentajeIva NUMERIC(5,2),
    bultos REAL,
    cantidad NUMERIC(15,2),
    precio NUMERIC(19,7),
    descuento NUMERIC(5,2),
    totalRenglon DECIMAL(10,4),
    ordenCompra CHAR(8),
    recepcion CHAR(8),
    registro SERIAL,
    codigoContable CHAR(30),
    codigoPresupuesto CHAR(30),
    centroCosto CHAR(20),
    centroCosto2 CHAR(20),
    anulada BOOLEAN
);

-- 5. Tablas de Contabilidad
DROP TABLE IF EXISTS contabilidadAsientos CASCADE;
CREATE TABLE contabilidadAsientos (
    numero CHAR(8) PRIMARY KEY,
    fecha TIMESTAMP,
    descripcion VARCHAR(70),
    debitos DECIMAL(10,4),
    creditos DECIMAL(10,4),
    anulada BOOLEAN,
    tipo CHAR(1),
    bene VARCHAR(50)
);

DROP TABLE IF EXISTS contabilidadAsientosRenglones CASCADE;
CREATE TABLE contabilidadAsientosRenglones (
    numero CHAR(8),
    fecha TIMESTAMP,
    codigoContable CHAR(30),
    referencia CHAR(20),
    concepto VARCHAR(70),
    centroCosto CHAR(20),
    centroCosto2 CHAR(20),
    importe DECIMAL(10,4),
    registro SERIAL,
    anulada BOOLEAN,
    codigo NUMERIC(18,0),
    tipo CHAR(4),
    nombre VARCHAR(50),
    numcheq VARCHAR(25),
    cuenta VARCHAR(25)
);

DROP TABLE IF EXISTS contabilidadBalanceControl CASCADE;
CREATE TABLE contabilidadBalanceControl (
    activo CHAR(30),
    pasivo CHAR(30),
    capital CHAR(30),
    ingreso CHAR(30),
    egreso CHAR(30),
    gasto CHAR(30),
    ordenActivo CHAR(30),
    ordenPasivo CHAR(30),
    resultado CHAR(30),
    definicion CHAR(5)
);

DROP TABLE IF EXISTS contabilidadBalances CASCADE;
CREATE TABLE contabilidadBalances (
    codigoBalance CHAR(5) PRIMARY KEY,
    nombre VARCHAR(70)
);

DROP TABLE IF EXISTS contabilidadBalancesRenglones CASCADE;
CREATE TABLE contabilidadBalancesRenglones (
    codigoBalance CHAR(5),
    nivel INTEGER,
    codigoContable CHAR(30),
    nombre VARCHAR(70),
    impresion CHAR(1),
    registro SERIAL
);

DROP TABLE IF EXISTS contabilidadCentroCosto CASCADE;
CREATE TABLE contabilidadCentroCosto (
    centroCosto CHAR(20) PRIMARY KEY,
    nombre CHAR(70)
);

DROP TABLE IF EXISTS contabilidadCentroCosto2 CASCADE;
CREATE TABLE contabilidadCentroCosto2 (
    centroCosto CHAR(20) PRIMARY KEY,
    nombre CHAR(70)
);

drop table if exists contabilidadCuentas;

create table contabilidadCuentas (
    codigoContable char(30) primary key,
    nombre char(70) not null,
    nivel integer not null,
    detalle boolean not null,
    codigoPresupuesto char(30)
);

drop table if exists contabilidadIntegracion;

create table contabilidadIntegracion (
    numero char(8) primary key,
    descripcion char(70)
);

drop table if exists contabilidadIntegracionRenglones;

create table contabilidadIntegracionRenglones (
    numero char(8),
    regla char(5),
    signo char(1),
    registro serial not null,
    anulada boolean
);

drop table if exists contabilidadPendiente;

create table contabilidadPendiente (
    numero char(8) not null unique,
    fecha timestamp,
    descripcion char(70),
    debitos decimal(10,4),
    creditos decimal(10,4),
    anulada boolean
);

drop table if exists contabilidadPendienteRenglones;

create table contabilidadPendienteRenglones (
    numero char(8),
    fecha timestamp,
    codigoContable char(30),
    referencia char(20),
    concepto char(70),
    centroCosto char(20),
    centroCosto2 char(20),
    importe decimal(10,4),
    registro serial not null,
    anulada boolean
);

drop table if exists contabilidadReglas;

create table contabilidadReglas (
    condigoRegla char(5) primary key,
    descripcion char(50),
    consulta text,
    tabla text,
    condicion text,
    campoFecha char(40),
    codigoContable char(120),
    centroCosto char(120),
    centroCosto2 char(120),
    referencia char(120),
    concepto char(120),
    importe char(120),
    sumar boolean
);

drop table if exists contabilidadUltimaContabilizacion;

create table contabilidadUltimaContabilizacion (
    desde timestamp,
    hasta timestamp
);

drop table if exists contadores;

create table contadores (
    documento char(10),
    numero char(8)
);

drop table if exists cotizaciones;

create table cotizaciones (
    numero char(8) primary key,
    fechaEmision timestamp not null,
    fechaEntrega timestamp,
    codigoCliente varchar(50),
    totalBruto decimal(10,4),
    descuento decimal(10,4),
    impuesto decimal(10,4),
    cargo decimal(10,4),
    totalCotizacion decimal(10,4),
    porcentajeDescuento decimal(10,4),
    vendedor char(5),
    direccionEnvio text,
    comentarios text,
    tarifa char(5),
    almacen char(5),
    peso decimal(10,4),
    estatus char(2)
);

drop table if exists cotizacionesRenglones;

create table cotizacionesRenglones (
    numero char(8) not null,
    almacen char(5),
    codigoProducto char(50),
    descripcion char(50),
    unidadMedida char(12),
    iva char(1),
    porcentajeIva decimal(10,4),
    bultos decimal(10,4),
    cantidad decimal(10,4),
    despacho decimal(10,4),
    precio decimal(10,4),
    descuento decimal(10,4),
    totalRenglon decimal(10,4),
    estatus char(2),
    comision char(5),
    porcentajeComision decimal(10,4),
    registro serial not null
);

drop table if exists cuentasExtras;

create table cuentasExtras (
    codigo varchar(50),
    nombre varchar(50)
);

drop table if exists documentosEnLinea;

create table documentosEnLinea (
    documento char(10),
    nombreInforme char(20)
);

drop table if exists donantes;

create table donantes (
    codigoDonante char(20) not null,
    nombre char(50) not null,
    ruc char(22),
    documentoFiscal char(1),
    direccion text,
    email char(50),
    telefonos char(30),
    fax char(30),
    codigoGrupo char(5),
    origenDonante char(5),
    estatus char(2),
    observaciones char(50),
    tarifa char(5),
    bancoDomicilia char(25),
    titularDomicilia char(30),
    cuentaDomicilia char(20),
    codigoContable char(30),
    fechaRegistro timestamp,
    empresa char(3),
    saldo decimal(10,4),
    ultimoPago timestamp,
    autorizSri char(15),
    fechaValFac timestamp,
    registro serial not null,
    web varchar(200),
    vinculacion char(50)
);

drop table if exists donantesGrupos;

create table donantesGrupos (
    codigoGrupo char(5) not null,
    nombre char(50),
    codigoContable char(30)
);

drop table if exists donantesMovimientos;

create table donantesMovimientos (
    codigoDonante char(20) not null,
    tipo char(2) not null,
    codigoProyecto char(8),
    fechaEmision timestamp,
    fechaInicio timestamp,
    fechaVencimiento timestamp,
    referenciaContable char(30),
    concepto char(30),
    donacion decimal(10,4),
    origen char(3),
    formaAbono varchar(100),
    anulada boolean,
    saldo decimal(10,4)
);

drop table if exists empresa;

create table empresa (
    codigoEmpresa char(3) not null,
    nombre char(50) not null,
    baseDeDatos char(50) not null,
    direccion text,
    telefono char(50),
    rif char(22),
    nit varchar(50),
    fechaInicio timestamp,
    fechaCierre timestamp,
    mascaraContable char(40),
    contribuyenteEspecial boolean,
    activa boolean not null
);

drop table if exists ensamble;

create table ensamble (
    codigo varchar(50) not null,
    nombre varchar(50),
    serie varchar(50),
    garantia numeric(18,0),
    proveedor varchar(50),
    gara boolean default false
);

drop table if exists ensambleCuerpo;

create table ensambleCuerpo (
    codigo varchar(50),
    codigoProducto varchar(50),
    serie varchar(50)
);


DROP TABLE IF EXISTS tpvClientes;
CREATE TABLE tpvClientes (
  codigoCliente VARCHAR(22) PRIMARY KEY,
  nombre VARCHAR(50),
  direccion TEXT,
  telefonos VARCHAR(30),
  porDefecto BOOLEAN
);

DROP TABLE IF EXISTS tpvFacturas;
CREATE TABLE tpvFacturas (
  numero VARCHAR(8) PRIMARY KEY,
  fechaEmision TIMESTAMP NOT NULL,
  codigoCliente VARCHAR(22),
  regimenIva VARCHAR(1),
  totalBruto DECIMAL(19,4),
  descuento DECIMAL(19,4),
  impuesto DECIMAL(19,4),
  cargo DECIMAL(19,4),
  totalFactura DECIMAL(19,4),
  porcentajeDescuento DECIMAL(10,4),
  vendedor VARCHAR(5),
  tarifa VARCHAR(5),
  peso DECIMAL(19,4),
  devolucionFactura VARCHAR(8),
  codigoCaja VARCHAR(5),
  recibeEfectivo DECIMAL(19,4),
  comentarios TEXT,
  cuadre BOOLEAN
);

drop table if exists facturas;

create table facturas (
    numero char(8) primary key not null,
    fechaEmision timestamp not null,
    vencimiento timestamp,
    codigoCliente varchar(50),
    referencia char(22),
    totalBruto decimal(10,4),
    descuento decimal(10,4),
	impuesto decimal(10,4),
	cargo decimal(10,4),
	totalFactura decimal(10,4),
	porcentajeDescuento decimal(10,4),
	transportista char (5),
	vendedor char(5),
	direccionEnvio text,
	comentarios text,
	tarifa char(5),
	almacen char(5),
	tipoPago char(1),
	ventadeContado boolean,
	peso decimal(10,4),
	devolucionFactura char(8),
	codigoCaja char(5),
	giroSerie char(3),
	giroAno decimal(10,4),
	giroCuota decimal(10,4),
	giroInteres decimal(10,4),
	empresa char(3),
	anulada boolean,
	retencion boolean,
	fechaLimite timestamp(8),
	fechaMaxima timestamp(8),
	asiento char(8),
	gara boolean,
	comision decimal(10,4),
	remision char(30),
	requisicion char(30),
	efectivo decimal(10,4)
);

drop table if exists facturasRenglones;
create table facturasRenglones (
    numero char(8) not null,
	almacen char(5),
	codigoProducto char(50),
	descripcion char(50),
	unidadMedida char(12),
	iva char (1),
	porcentajeIva decimal(10,4),
	bultos decimal(10,4),
	cantidad decimal(10,4),
	precio decimal(10,4),
	descuento decimal(10,4),
	totalRenglon decimal(10,4),
	pedido char(8),
	notaEntrega char(8),
	comision char(5),
	porcentajeComision decimal(10,4),
	registro int not null,
	anulada boolean,
	larga text
);

drop table if exists guiaRemision;

create table guiaRemision (
    numeroFact char(15) not null,
	numeroGuia char(15),
	fechaIniTra timestamp(8),
	fechaFinTra timestamp(8),
	fechaFact timestamp(8),
	motivoTras int,
	fechaEmision timestamp(8),
	puntoPart char(200),
	codigoCliente char(50),
	puntoLlega char(200),
	transportista char(100),
	rucCl char(15)
);

drop table if exists inventarioFisico;

create table inventarioFisico (
    numero char(8) primary key not null,
	fecha timestamp(8),
	comentarios text,
	almacen char(5),
	estatus char(2)
);

drop table if exists inventarioFisicoRenglones;
create table inventarioFisicoRenglones (
    numero char(8),
	codigoProducto char(50),
	cantidad decimal(10,4),
	existencia decimal(10,4),
	costo decimal(10,4),
	registro int not null
);

drop table if exists manteCuerpo;

create table manteCuerpo (
	codigo decimal(10,4) not null,
	serie varchar(50),
	nombre varchar(100),
	observacion varchar(200),
	daño varchar(200),
	descripDaño varchar(200),
	salio int
);

drop table if exists mantenimiento;

create table mantenimiento (
	codigo decimal(10,4) not null,
	fechaIngreso timestamp(8),
	opcion boolean,
	fechaSalida timestamp(8),
	cedula varchar(50) not null
);

drop table if exists marcas;

create table marcas (
	codigoMarca char (5) not null,
	nombre char(80) not null
);

drop table if exists nombresProyectos;

create table nombresProyectos (
	codigo char (5) not null,
	nombre char(50)
);

drop table if exists notasEntrega;

create table notasEntrega (
    numero char(8) primary key not null,
	fechaEmision timestamp(8) not null,
	codigoCliente varchar(50),
	totalBruto decimal(10,4),
	descuento decimal(10,4),
	impuesto decimal(10,4),
	cargo decimal(10,4),
	totalNotaEntrega decimal(10,4),
	portcentajeDescuento decimal(10,4),
	transportista char(5),
	vendedor char(5),
	direccionEnvio text,
	comentarios text,
	tarifa char(5),
	almacen char(5),
	peso decimal(10,4),
	estatus char(2),
	empresa char(3)
);

drop table if exists notasEntregaRenglones;

create table notasEntregaRenglones (
	numero char(8) not null,
	almacen char(5),
	codigoProducto char(50),
	descripcion char(50),
	unidadMedida char(12),
	iva char(1),
	porcentajeIva decimal(10,4),
	bultos decimal(10,4),
	cantidad decimal(10,4),
	entregado decimal(10,4),
	precio decimal(10,4),
	descuento decimal(10,4),
	totalRenglon decimal(10,4),
	pedido char(8),
	estatus char(2),
	registro int not null,
	empresa char(3)
);

drop table if exists notaVenta;

create table notaVenta (
	numero char(50),
	fecha timestamp(8),
	vendedor char(5),
	cliente varchar(50),
	codigoContable char(30),
	tarifa char(5),
	comentario varchar(254),
	total decimal(10,4),
	gara boolean,
	ruc varchar(22),
	direccion varchar(200)
);

drop table if exists notaVentaCuerpo;

create table notaVentaCuerpo (
	numero char(50),
	descripcion varchar(50),
	codigoProducto char(50),
	almacen char(5),
	unidad char(10),
	precio decimal(10,4),
	total decimal(10,4),
	cantidad decimal(10,4)
);

drop table if exists ordenesCompra;

create table ordenesCompra (
	numero char (8) primary key not null,
	referencia char (20),
	fechaEmision  timestamp (8) not null,
	fechaEntrega timestamp (8),
	codigoProveedor char (20),
	totalBruto decimal(10,4),
	descuento decimal(10,4),
	impuesto decimal(10,4),
	cargo decimal(10,4),
	totalOrdenCompra decimal(10,4),
	porcentajeDescuento decimal(10,4),
	transportista char(5),
	comentarios text,
	almacen char(5),
	peso decimal(10,4),
	estatus char(2),
	cambio decimal(10,4),
	moneda char(3),
	solicitud char(10),
	aprobadoPor char(40),
	centroCosto char(20),
	centroCosto2 char(20)
);

drop table if exists ordenesCompraRenglones;

create table ordenesCompraRenglones (
	numero char(8) not null,
	almacen char(5),
	codigoProducto char(50),
	descripcion char(50),
	unidadMedida char(12),
	iva char(1),
	porcentajeIva decimal(10,4),
	bultos decimal(10,4),
	cantidad decimal(10,4),
	despacho decimal(10,4),
	sinDespachar decimal(10,4),
	precio decimal(10,4),
	descuento decimal(10,4),
	totalRenglon decimal(10,4),
	estatus char(2),
	requisicion char(8),
	codigoContable char(30),
	centroCosto char(20),
	centroCosto2 char(20),
	codigoPresupuesto char(30),
	fechaEntrega timestamp(8),
	registro int not null	
);

drop table if exists ordenesProduccion;

create table ordenesProduccion (
	numero char(8) primary key not null,
	fechaInicio timestamp(8),
	fechaTermino timestamp(8),
	codigoProducto varchar(50),
	cantidad decimal(10,4),
	comentarios text,
	totalOrden decimal(10,4),
	estatus char(2),
	lineaProduccion char(5),
	factorUso timestamp(4),
	almacenEntrada char(5),
	almacenSalida char(5),
	desglose boolean,
	generarSalida boolean
);

drop table if exists ordenesProduccionCostosAdicionales;

create table ordenesProduccionCostosAdicionales (
	codigo char(5),
	nombre varchar(250),
	costo decimal(10,4),
	codigoContable char(30)
);


-- Version final de tablas hansel
-- en este caso, las PK añadidas directamente, y también las restricciones unique.


-- Tabla: ordenesProduccionLineas
DROP TABLE IF EXISTS ordenesProduccionLineas;
CREATE TABLE ordenesProduccionLineas (
    codigo char(5) PRIMARY KEY,
    nombre varchar(250)
);

-- Tabla: ordenesProduccionRenglones
DROP TABLE IF EXISTS ordenesProduccionRenglones;
CREATE TABLE ordenesProduccionRenglones (
    numero char(8) NOT NULL,
    codigoProducto char(50) NOT NULL,
    descripcion char(50),
    unidadMedida char(12),
    almacen char(5),
    cantidad decimal(10, 4),
    costoUnitario decimal(10, 4),
    registro serial NOT NULL
);

-- Tabla: ordenesTrabajo
DROP TABLE IF EXISTS ordenesTrabajo;
CREATE TABLE ordenesTrabajo (
    numero char(10) PRIMARY KEY,
    fechaInicio timestamp,
    fechaTermino timestamp,
    codigoCliente varchar(50),
    codigoVehiculo varchar(50),
    comentarios text,
    totalOrden numeric(19, 4),
    estatus char(2),
    lineaTrabajo char(5),
    desglose boolean
);

-- Tabla: ordenesTrabajoLineas
DROP TABLE IF EXISTS ordenesTrabajoLineas;
CREATE TABLE ordenesTrabajoLineas (
    codigo char(5) PRIMARY KEY,
    nombre char(100)
);

-- Tabla: ordenesTrabajoRenglones
DROP TABLE IF EXISTS ordenesTrabajoRenglones;
CREATE TABLE ordenesTrabajoRenglones (
    numero char(10) NOT NULL,
    codigoProducto char(50) NOT NULL,
    descripcion char(50),
    unidadMedida char(12),
    almacen char(5),
    cantidad decimal(10, 4),
    costoUnitario decimal(10, 4),
    registro serial NOT NULL
);

-- Tabla: origenDonates
DROP TABLE IF EXISTS origenDonates;
CREATE TABLE origenDonates (
    codigo char(5) NOT NULL,
    nombre char(50),
    proximo char(8)
);

-- Tabla: parametros
DROP TABLE IF EXISTS parametros;
CREATE TABLE parametros (
    documento char(10),
    param1 boolean NOT NULL,
    param2 boolean NOT NULL,
    param3 boolean NOT NULL,
    param4 boolean NOT NULL,
    param5 boolean NOT NULL,
    param6 boolean NOT NULL,
    param7 boolean NOT NULL,
    param8 boolean NOT NULL,
    param9 boolean NOT NULL,
    param10 boolean NOT NULL,
    param11 boolean NOT NULL,
    param12 boolean NOT NULL,
    param13 boolean NOT NULL,
    param14 boolean NOT NULL,
    param15 boolean NOT NULL,
    param16 boolean NOT NULL,
    param17 char(20),
    param18 char(20),
    param19 decimal(10, 4),
    param20 decimal(10, 4),
    param21 boolean,
    param22 boolean,
    param23 boolean,
    param24 boolean,
    param25 boolean,
    param26 boolean,
    param27 char(20),
    param28 char(10),
    param29 decimal(10, 4),
    param30 decimal(10, 4)
);

-- Tabla: pedidos
DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos (
    numero char(8) PRIMARY KEY,
    fechaEmision timestamp NOT NULL,
    fechaEntrega timestamp,
    codigoCliente varchar(50),
    totalBruto decimal(10, 4),
    descuento decimal(10, 4),
    impuesto decimal(10, 4),
    cargo decimal(10, 4),
    totalPedido decimal(10, 4),
    porcentajeDescuento decimal(10, 4),
    transportista char(5),
    vendedor char(5),
    direccionEnvio text,
    comentarios text,
    tarifa char(5),
    almacen char(5),
    peso decimal(10, 4),
    estatus char(2)
);

-- Tabla: pedidosRenglones
DROP TABLE IF EXISTS pedidosRenglones;
CREATE TABLE pedidosRenglones (
    numero char(8) NOT NULL,
    almacen char(5),
    codigoProducto char(50),
    descripcion char(50),
    unidadMedida char(12),
    iva char(1),
    porcentajeIva decimal(10, 4),
    bultos decimal(10, 4),
    cantidad decimal(10, 4),
    despacho decimal(10, 4) DEFAULT 0,
    despachoBultos decimal(10, 4),
    precio decimal(10, 4),
    descuento decimal(10, 4),
    totalRenglon decimal(10, 4),
    estatus char(2),
    comision char(5),
    porcentajeComision decimal(10, 4),
    cotizacion char(8),
    registro serial NOT NULL
);

-- Tabla: presupuestoAsientos
DROP TABLE IF EXISTS presupuestoAsientos;
CREATE TABLE presupuestoAsientos (
    numero char(8) NOT NULL,
    fecha timestamp,
    descripcion char(70),
    debitos decimal(10, 4),
    creditos decimal(10, 4),
    anulada boolean
);

-- Tabla: presupuestoAsientosRenglones
DROP TABLE IF EXISTS presupuestoAsientosRenglones;
CREATE TABLE presupuestoAsientosRenglones (
    numero char(8),
    fecha timestamp,
    codigoContable char(30),
    referencia char(20),
    concepto char(70),
    centroCosto char(20),
    centroCosto2 char(20),
    importe decimal(10, 4),
    registro serial NOT NULL,
    anulada boolean
);

-- Tabla: presupuestoBalances
DROP TABLE IF EXISTS presupuestoBalances;
CREATE TABLE presupuestoBalances (
    codigoBalance char(5) PRIMARY KEY,
    nombre char(70)
);

-- Tabla: presupuestoBalancesRenglones
DROP TABLE IF EXISTS presupuestoBalancesRenglones;
CREATE TABLE presupuestoBalancesRenglones (
    codigoBalance char(5),
    nivel integer,
    codigoContable char(30),
    nombre char(70),
    impresion char(1),
    registro serial NOT NULL
);

-- Tabla: presupuestoCuentas
DROP TABLE IF EXISTS presupuestoCuentas;
CREATE TABLE presupuestoCuentas (
    codigoContable char(30) PRIMARY KEY,
    nombre char(70) NOT NULL,
    nivel integer NOT NULL,
    detalle boolean NOT NULL
);

-- Tabla: presupuestoIntegracion
DROP TABLE IF EXISTS presupuestoIntegracion;
CREATE TABLE presupuestoIntegracion (
    numero char(8) PRIMARY KEY,
    descripcion char(70)
);

-- Tabla: presupuestoIntegracionRenglones
DROP TABLE IF EXISTS presupuestoIntegracionRenglones;
CREATE TABLE presupuestoIntegracionRenglones (
    numero CHAR(8),
    regla CHAR(5),
    signo CHAR(1),
    registro SERIAL
);


-- tabla PresupuestoPendiente
DROP TABLE IF EXISTS presupuestoPendiente;
CREATE TABLE presupuestoPendiente (
    numero char(8) NOT NULL,
    fecha timestamp,
    descripcion char(70),
    debitos decimal(10, 4),
    creditos decimal(10, 4),
    UNIQUE (fecha, numero)
);


-- Tabla: presupuestoPendienteRenglones
DROP TABLE IF EXISTS presupuestoPendienteRenglones;
CREATE TABLE presupuestoPendienteRenglones (
  numero VARCHAR(8),
  fecha TIMESTAMP,
  codigoContable CHAR(30),
  referencia CHAR(20),
  concepto CHAR(70),
  centroCosto CHAR(20),
  centroCosto2 CHAR(20),
  importe DECIMAL(10,4),
  registro SERIAL PRIMARY KEY
);

-- Tabla: presupuestoUltimaContabilizacion
DROP TABLE IF EXISTS presupuestoUltimaContabilizacion;
CREATE TABLE presupuestoUltimaContabilizacion (
  desde TIMESTAMP,
  hasta TIMESTAMP
);

-- Tabla: productos
DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
  codigoProducto VARCHAR(50) PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  descripcionLarga TEXT,
  codigoAlterno VARCHAR(50),
  codigoGrupo CHAR(5),
  iva CHAR(1),
  impuestoRenta CHAR(1),
  fechaCreacion TIMESTAMP,
  existenciaMinima DECIMAL(10,4),
  existenciaMaxima DECIMAL(10,4),
  ubicacionFisica CHAR(8),
  unidadMedida CHAR(12),
  cantidadXBulto DECIMAL(10,4),
  peso DECIMAL(10,4),
  alto DECIMAL(10,4),
  ancho DECIMAL(10,4),
  profundidad DECIMAL(10,4),
  empaque CHAR(30),
  codigoContable CHAR(30),
  existencia DECIMAL(10,4),
  ultimoCosto DECIMAL(10,4),
  ultimoProveedor CHAR(20),
  costo DECIMAL(10,4),
  acCostoEntrada DECIMAL(10,4),
  acCostoSalida DECIMAL(10,4),
  acCantidadEntrada DECIMAL(10,4),
  acCantidadSalida DECIMAL(10,4),
  pedidoCompra DECIMAL(10,4),
  pedidoVenta DECIMAL(10,4),
  tipoCosteo CHAR(1),
  compuesto BOOLEAN,
  foto CHAR(20),
  recosteo BOOLEAN,
  producir DECIMAL(10,4),
  foto1 BYTEA,
  garantia NUMERIC(10,4),
  especificacion VARCHAR(250),
  contaCosto CHAR(30),
  contaInven CHAR(30)
);

-- Tabla: productosAlmacenes
DROP TABLE IF EXISTS productosAlmacenes;
CREATE TABLE productosAlmacenes (
  almacen VARCHAR(5) PRIMARY KEY,
  nombre VARCHAR(250),
  codigoContable VARCHAR(30)
);

-- Tabla: productosAlmacenesAcceso
DROP TABLE IF EXISTS productosAlmacenesAcceso;
CREATE TABLE productosAlmacenesAcceso (
  usuario CHAR(50),
  almacenDenegado CHAR(5)
);

-- Tabla: productosComisiones
DROP TABLE IF EXISTS productosComisiones;
CREATE TABLE productosComisiones (
  codigo CHAR(5) PRIMARY KEY,
  porcentaje DECIMAL(10,4)
);

-- Tabla: productosComposicion
DROP TABLE IF EXISTS productosComposicion;
CREATE TABLE productosComposicion (
  codigoProducto VARCHAR(50) NOT NULL,
  codigoComponente CHAR(15) NOT NULL,
  cantidad DECIMAL(10,4) NOT NULL,
  registro SERIAL PRIMARY KEY
);

-- Tabla: productosExistencias
DROP TABLE IF EXISTS productosExistencias;
CREATE TABLE productosExistencias (
  codigoProducto VARCHAR(50) NOT NULL,
  almacen CHAR(5) NOT NULL,
  existencia DECIMAL(10,4) NOT NULL,
  PRIMARY KEY (codigoProducto, almacen)
);

-- Tabla: productosFisico
DROP TABLE IF EXISTS productosFisico;
CREATE TABLE productosFisico (
  numero VARCHAR(50) PRIMARY KEY,
  fecha TIMESTAMP,
  almacen CHAR(5),
  estatus VARCHAR(5),
  comentario VARCHAR(254),
  contable CHAR(30)
);

-- Tabla: productosFisicoCuerpo
DROP TABLE IF EXISTS productosFisicoCuerpo;
CREATE TABLE productosFisicoCuerpo (
  numero VARCHAR(50),
  codigoProducto VARCHAR(50),
  descrip VARCHAR(50),
  unidad CHAR(12),
  cantidad DECIMAL(10,4),
  almacen CHAR(5),
  costo DECIMAL(10,4)
);

-- Tabla: productosGrupos
DROP TABLE IF EXISTS productosGrupos;
CREATE TABLE productosGrupos (
  codigoGrupo CHAR(5) PRIMARY KEY,
  codigoContable CHAR(30),
  nombre VARCHAR(250)
);

-- Tabla: productosMovimientos
DROP TABLE IF EXISTS productosMovimientos;
CREATE TABLE productosMovimientos (
  codigoProducto VARCHAR(50) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  tipo CHAR(2) NOT NULL,
  numero CHAR(8) NOT NULL,
  unidadMedida CHAR(12),
  cantidad DECIMAL(10,4) NOT NULL,
  costoTotal DECIMAL(10,4) NOT NULL,
  origen CHAR(3) NOT NULL,
  proveedorCliente CHAR(20),
  almacen CHAR(5) NOT NULL,
  cantidadUsada DECIMAL(10,4),
  registro SERIAL PRIMARY KEY,
  anulada BOOLEAN,
  comentario VARCHAR(26),
  responsable VARCHAR(80)
);

-- Tabla: productoPrecios
DROP TABLE IF EXISTS productoPrecios;
CREATE TABLE productoPrecios (
  codigoProducto VARCHAR(50) NOT NULL,
  tarifa CHAR(5) NOT NULL,
  precio DECIMAL(10,4) NOT NULL,
  descuento DECIMAL(10,4) NOT NULL,
  descuento2 DECIMAL(10,4),
  cantidad DECIMAL(10,4) NOT NULL,
  comision CHAR(5),
  registro SERIAL PRIMARY KEY
);

-- Tabla: productosPromociones
DROP TABLE IF EXISTS productosPromociones;
CREATE TABLE productosPromociones (
  codigoProducto CHAR(50) NOT NULL,
  porCada DECIMAL(10,4),
  otorgar DECIMAL(10,4),
  desde TIMESTAMP,
  hasta TIMESTAMP
);

-- Tabla: productosTarifas
DROP TABLE IF EXISTS productosTarifas;
CREATE TABLE productosTarifas (
  codigo CHAR(5) PRIMARY KEY,
  nombre VARCHAR(250)
);

-- Tabla: programa
DROP TABLE IF EXISTS programa;
CREATE TABLE programa (
  opcion INTEGER,
  nombre CHAR(30),
  ruta CHAR(100)
);

-- Tabla: proveedores
DROP TABLE IF EXISTS proveedores;
CREATE TABLE proveedores (
  codigoProveedor CHAR(20) PRIMARY KEY,
  nombre CHAR(50) NOT NULL,
  rif CHAR(22),
  nit CHAR(22),
  documentoFiscal CHAR(1),
  direccion TEXT,
  email CHAR(50),
  telefonos CHAR(30),
  fax CHAR(30),
  codigoGrupo CHAR(5),
  zona CHAR(5),
  limiteCredito DECIMAL(10,4),
  estatus CHAR(2),
  transporte CHAR(5),
  descuento DECIMAL(10,4),
  observaciones CHAR(50),
  regimenIva CHAR(1),
  tarifa CHAR(5),
  tipoCredito CHAR(5),
  personaContacto CHAR(30),
  bancoDomicilia CHAR(25),
  titularDomicilia CHAR(30),
  cuentaDomicilia CHAR(20),
  codigoContable CHAR(30),
  fechaRegistro TIMESTAMP,
  empresa CHAR(3),
  saldo DECIMAL(10,4),
  ultimoPago TIMESTAMP,
  imprentaNombre CHAR(50),
  imprentaRuc CHAR(20),
  imprentaAutoriz CHAR(15),
  numeroSerieFac CHAR(5),
  autorizSRI CHAR(15),
  fechaValFac TIMESTAMP,
  registro SERIAL,
  web VARCHAR(200)
);


DROP TABLE IF EXISTS proveedoresGrupos;

CREATE TABLE proveedoresGrupos (
    codigoGrupo     CHAR(5) primary key NOT NULL,
    nombre          VARCHAR(250) NULL,
    codigoContable  CHAR(30)    NULL
);



DROP TABLE IF EXISTS proveedoresMovimientos;

CREATE TABLE proveedoresMovimientos (
    codigoProveedor       CHAR(20)     NOT NULL ,
    tipo                  CHAR(2)      NOT NULL,
    nTipo                 CHAR(1)      NULL,
    numero                CHAR(8)      NULL,
    emision               timestamp     NULL,
    vencimiento           timestamp     NULL,
    comprobante           CHAR(8)      NULL,
    referencia            CHAR(20)     NULL,
    referenciaContable    CHAR(30)     NULL,
    centroCosto           CHAR(20)     NULL,
    centroCosto2          CHAR(20)     NULL,
    codigoPresupuesto     CHAR(30)     NULL,
    concepto              CHAR(30)     NULL,
    importe               decimal(10,4)        NULL,
    origen                CHAR(3)      NULL,
    numeroOrigen          CHAR(8)      NULL,
    tipoDocCancela        CHAR(2)      NULL,
    intereses             decimal(10,4)        NULL,
    registro              INT		GENERATED ALWAYS AS IDENTITY,
    asiento               CHAR(8)      NULL,
    anulada               BIT          NULL
);


DROP TABLE IF EXISTS proyectoAdendum;

CREATE TABLE proyectoAdendum (
    codigo              CHAR(20)      NOT NULL,
    codigoProyecto      CHAR(8)       NOT NULL,
    fechaEmision        TIMESTAMP     NULL,
    fechaInicio         TIMESTAMP     NULL,
    fechaVencimiento    TIMESTAMP     NULL,
    fechaAdendum        TIMESTAMP     NULL,
    referenciaContable  CHAR(30)      NULL,
    concepto            CHAR(30)      NULL,
    valorAdendum        DECIMAL(10,4) NULL,
    valorTotal          DECIMAL(10,4) NULL,
    formaAbono          INT           NULL,
    donante             CHAR(20)      NULL,
    anulada             BOOLEAN       NULL
);


DROP TABLE IF EXISTS proyectos;

CREATE TABLE proyectos (
    codigoProyecto      CHAR(20)      NOT NULL,
    codigoAdendum       CHAR(20)      NOT NULL,
    nombre              CHAR(50)      NOT NULL,
    comentario          CHAR(50)      NULL,
    codigoContable      CHAR(30)      NULL,
    fechaInicio         TIMESTAMP     NULL,
    fechaFinal          TIMESTAMP     NULL,
    codigoResp          VARCHAR(20)   NULL,
    totalPresupuesto    DECIMAL(10,4) NULL,
    cantidadRestante    DECIMAL(10,4) NULL,
    ultimoPago          TIMESTAMP     NULL,
    fechaAdendum        TIMESTAMP     NULL,
    valorAdendum        DECIMAL(10,4) NULL,
    terminado           INT           NULL,
    fechaTermino        TIMESTAMP     NULL
);


DROP TABLE IF EXISTS proyectosMovimientos;

CREATE TABLE proyectosMovimientos (
    codigoProyecto       VARCHAR    NOT NULL,
    tipo                 CHAR(2)         NOT NULL,
    fechaEmision         TIMESTAMP       NOT NULL,
    fechaInicio          TIMESTAMP       NULL,
    fechaVencimiento     TIMESTAMP       NULL,
    referenciaContable   CHAR(30)        NULL,
    valorTotal           DECIMAL(10,4)   NOT NULL,
    origen               CHAR(3)         NOT NULL,
    concepto             CHAR(30)        NULL,
    donanteResponsable   CHAR(20)        NULL,
    cantidadUsada        DECIMAL(10,4)   NULL,
    codigoPresupuesto    CHAR(30)        NULL,
    referencia           CHAR(30)        NULL,
    formaAbono           VARCHAR   NULL,
    anulada              BOOLEAN         NULL
);


DROP TABLE IF EXISTS proyectosRenglones;

CREATE TABLE proyectosRenglones (
    codigoProyecto   CHAR(20)      NOT NULL,
    codigoDonante    CHAR(20)      NOT NULL,
    nombreDonante    CHAR(50)      NULL,
    codigoContable   CHAR(30)      NULL,
    totalRenglon     DECIMAL(10,4) NULL
);


DROP TABLE IF EXISTS recepciones;

CREATE TABLE recepciones (
    numero                CHAR(8)        NOT NULL PRIMARY KEY,
    referencia            CHAR(10)       NULL,
    fechaEmision          TIMESTAMP      NOT NULL,
    codigoProveedor       CHAR(20)       NULL,
    totalBruto            DECIMAL(10,4)  NULL,
    descuento             DECIMAL(10,4)  NULL,
    impuesto              DECIMAL(10,4)  NULL,
    cargo                 DECIMAL(10,4)  NULL,
    totalRecepcion        DECIMAL(10,4)  NULL,
    porcentajeDescuento   DECIMAL(10,4)  NULL,
    transportista         CHAR(5)        NULL,
    comentarios           TEXT           NULL,
    almacen               CHAR(5)        NULL,
    peso                  DECIMAL(10,4)  NULL,
    estatus               CHAR(2)        NULL,
    referenciaContable    CHAR(20)       NULL,
    centroCosto           CHAR(20)       NULL,
    centroCosto2          CHAR(20)       NULL,
    cambio                DECIMAL(10,4)  NULL,
    moneda                CHAR(3)        NULL
);

DROP TABLE IF EXISTS recepcionesRenglones;

CREATE TABLE recepcionesRenglones (
    numero             CHAR(8)         NOT NULL,
    almacen            CHAR(5)         NULL,
    codigoProducto     CHAR(50)        NULL,
    descripcion        CHAR(50)        NULL,
    unidadMedida       CHAR(12)        NULL,
    iva                CHAR(1)         NULL,
    porcentajeIva      DECIMAL(10,4)   NULL,
    bultos             DECIMAL(10,4)   NULL,
    cantidad           DECIMAL(10,4)   NULL,
    entregado          DECIMAL(10,4)   NULL DEFAULT 0,
    precio             DECIMAL(19,7)   NULL,
    descuento          DECIMAL(10,4)   NULL,
    totalRenglon       DECIMAL(10,4)   NULL,
    ordenCompra        CHAR(8)         NULL,
    estatus            CHAR(2)         NULL,
    codigoContable     CHAR(30)        NULL,
    centroCosto        CHAR(20)        NULL,
    centroCosto2       CHAR(20)        NULL,
    codigoPresupuesto  CHAR(30)        NULL,
    registro           INT GENERATED ALWAYS AS IDENTITY NOT NULL
);


DROP TABLE IF EXISTS requisiciones;

CREATE TABLE requisiciones (
    numero            CHAR(8)        NOT NULL PRIMARY KEY,
    referencia        CHAR(20)       NULL,
    fechaEmision      TIMESTAMP      NULL,
    solicitadoPor     CHAR(40)       NULL,
    aprobadoPor       CHAR(40)       NULL,
    comentarios       TEXT           NULL,
    estatus           CHAR(2)        NULL,
    estatusB          CHAR(2)        NULL,
    almacen           CHAR(5)        NULL,
    peso              DECIMAL(10,4)  NULL,
    impuesto          DECIMAL(10,4)  NULL,
    centroCosto       CHAR(20)       NULL,
    centroCosto2      CHAR(20)       NULL,
    totalBruto        DECIMAL(10,4)  NULL,
    totalRequisicion  DECIMAL(10,4)  NULL
);


DROP TABLE IF EXISTS requisicionesRenglones;

CREATE TABLE requisicionesRenglones (
    numero            CHAR(8)         NOT NULL,
    almacen           CHAR(5)         NULL,
    codigoProducto    CHAR(50)        NULL,
    descripcion       CHAR(50)        NULL,
    unidadMedida      CHAR(12)        NULL,
    iva               CHAR(1)         NULL,
    porcentajeIva     DECIMAL(10,4)   NULL,
    bultos            DECIMAL(10,4)   NULL,
    cantidad          DECIMAL(10,4)   NULL,
    precio            DECIMAL(19,7)   NULL,
    descuento         DECIMAL(10,4)   NULL,
    totalRenglon      DECIMAL(10,4)   NULL,
    estatus           CHAR(2)         NULL,
    codigoContable    CHAR(30)        NULL,
    codigoPresupuesto CHAR(30)        NULL,
    centroCosto       CHAR(20)        NULL,
    centroCosto2      CHAR(20)        NULL,
    registro          SERIAL
);


DROP TABLE IF EXISTS respContraMovimientos;

CREATE TABLE respContraMovimientos (
    codigo            CHAR(20)       NOT NULL,
    tipo              CHAR(2)        NOT NULL,
    codigoProyecto    CHAR(8)        NULL,
    fechaEmision      TIMESTAMP      NULL,
    fechaInicio       TIMESTAMP      NULL,
    fechaVencimiento  TIMESTAMP      NULL,
    referenciaContable CHAR(30)      NULL,
    concepto          CHAR(30)       NULL,
    valor             DECIMAL(10,4)  NULL,
    origen            CHAR(3)        NULL,
    formaAbono        VARCHAR(100)   NULL,
    codigoPresupuesto CHAR(30)       NULL,
    referencia        CHAR(30)       NULL,
    anulada           BOOLEAN        NULL,
    saldo             DECIMAL(10,4)  NULL,
    nombre            VARCHAR(100)   NULL,
    fechaJustificacion TIMESTAMP     NULL
);


DROP TABLE IF EXISTS responsablesContratistas;

CREATE TABLE responsablesContratistas (
    codigo          CHAR(5)       NOT NULL,
    nombre          CHAR(50)      NOT NULL,
    direccion       TEXT          NULL,
    telefonos       CHAR(30)      NULL,
    fax             CHAR(15)      NULL,
    ruc             CHAR(15)      NULL,
    email           CHAR(50)      NULL,
    fechaRegistro   TIMESTAMP     NULL,
    vinculacion     CHAR(50)      NULL
);


DROP TABLE IF EXISTS retenciones;

CREATE TABLE retenciones (
    codigoRetencion   CHAR(5)         NOT NULL,
    codigoContable    CHAR(30)        NULL,
    numeroDocumento   CHAR(50)        NULL,
    codigoProducto    CHAR(50)        NULL,
    fecha             TIMESTAMP       NULL,
    valorRetencion    DECIMAL(10,4)   NULL,
    ejercicioFiscal   CHAR(19)        NULL,
    tipoImpuesto      CHAR(10)        NULL,
    concepto          CHAR(150)       NULL,
    porcentaje        NUMERIC(18,0)   NULL,
    tipoDocumento     CHAR(10)        NULL,
    numDocVen         CHAR(10)        NULL,
    tipoDocu          VARCHAR(50)     NULL,
    fechaLimite       TIMESTAMP       NULL,
    fechaValides      TIMESTAMP       NULL,
    autSRI            CHAR(30)        NULL,
    rucImpren         CHAR(30)        NULL,
    numCompro         CHAR(30)        NULL,
    estable           CHAR(30)        NULL,
    puntoVenta        CHAR(30)        NULL,
    tipo              INT             NULL DEFAULT 0,
    producto          VARCHAR(50)     NULL,
    tipoRetencion     VARCHAR(50)     NULL,
    nombre            VARCHAR(250)    NULL
);



DROP TABLE IF EXISTS retencionesVentas;

CREATE TABLE retencionesVentas (
    codigoRetencion   CHAR(5)        NOT NULL,
    codigoContable    CHAR(30)       NULL,
    autSRI            CHAR(30)       NULL,
    numeroDocumento   CHAR(50)       NULL,
    rucImprenta       CHAR(50)       NULL,
    fechaEmicion      TIMESTAMP      NULL,
    fechaValidesDoc   TIMESTAMP      NULL,
    valorRetencion    DECIMAL(19,4)  NULL,
    ejercicioFiscal   CHAR(19)       NULL,
    tipoRetencion     CHAR(30)       NULL,
    concepto          CHAR(50)       NULL,
    producto          CHAR(50)       NULL,
    tipoDocumento     CHAR(10)       NULL,
    numDocVen         CHAR(10)       NULL,
    fechaLimite       TIMESTAMP      NULL,
    numCompro         CHAR(30)       NULL,
    estable           CHAR(30)       NULL,
    puntoVenta        CHAR(30)       NULL,
    tipo              INT            NULL DEFAULT 0,
    asiento           CHAR(8)        NULL
);



DROP TABLE IF EXISTS rutas;

CREATE TABLE rutas (
    codigoRuta CHAR(12) NOT NULL PRIMARY KEY,
    zona       CHAR(5)  NOT NULL,
    diasVisita CHAR(6)  NOT NULL
);


DROP TABLE IF EXISTS rutasRenglones;

CREATE TABLE rutasRenglones (
    codigoRuta     CHAR(12) NOT NULL,
    codigoCliente  CHAR(20) NOT NULL,
    codigoNoVenta  CHAR(5)  NULL,
    secuencia      INT      NOT NULL

);


DROP TABLE IF EXISTS serieCuerpo;

CREATE TABLE serieCuerpo (
    codigoProducto VARCHAR(50) NULL,
    serie          VARCHAR(50)  NULL,
    fecha          TIMESTAMP     NULL,
    proveedor      VARCHAR(50)  NULL,
    seFue          BIT          NULL,
    nomDoc         VARCHAR(50)  NULL,
    nomEnt         NUMERIC(10, 0) NULL,
    nota           VARCHAR(300) NULL,
    numeroC        VARCHAR(50)  NULL
);


DROP TABLE IF EXISTS seriestmp;

CREATE TABLE seriestmp (
    numero                  numeric(18, 0)          NULL,
    fechaEmision            timestamp               NULL,
    codigoCliente           char(20)                NULL,
    nombre                  char(50)                NULL,
    rif                     char(22)                NULL,
    nit                     char(22)                NULL,
    direccion               text                    NULL,
    telofonos               text                    NULL,
    fax                     text                    NULL,
    totalBruto              decimal(10,4)           NULL,
    descuento               decimal(10,4)           NULL,
    impuesto                decimal(10,4)           NULL,
    cargo                   char(22)                NULL,
    totalNotaEntrega        decimal(10,4)           NULL,
    porcentajeDescuento     char(80)                NULL,
    vendedor                char(5)                 NULL,
    nombre1                 text                    NULL,
    direccionEnvio          text                    NULL,
    comentarios             text                    NULL,
    estatus                 text                    NULL,
    codigoProducto          char(50)                NULL,
    descripcion             char(50)                NULL,
    unidadMedida            char(12)                NULL,
    porcentajeIva           char(200)               NULL,
    bultos                  real                    NULL,
    cantidad                decimal(10,4)           NULL,
    precio                  decimal(10,4)           NULL,
    renDesc                 decimal(10,4)           NULL,
    totalRenglon            decimal(10,4)           NULL,
    empNom                  text                    NULL,
    empDir                  text                    NULL,
    telefono                text                    NULL,
    empRif                  text                    NULL,
    empNit                  text                    NULL,
    nota                    char(300)               NULL
);

DROP TABLE IF EXISTS servicios;
CREATE TABLE servicios (
  codigo VARCHAR(14) NOT NULL,
  nombre VARCHAR(250) NOT NULL,
  iva VARCHAR(1),
  impuestoRenta VARCHAR(1),
  precio DECIMAL(10,4),
  costo DECIMAL(10,4),
  codigoContable VARCHAR(30),
  contaCosto VARCHAR(30),
  PRIMARY KEY (codigo)
);

DROP TABLE IF EXISTS tiposRetenciones;
CREATE TABLE tiposRetenciones (
  codigoRetencion VARCHAR(20) NOT NULL,
  tipoImpuesto VARCHAR(30) NOT NULL,
  concepto VARCHAR(250),
  porcentaje DECIMAL(19,4),
  vigenciaDesde VARCHAR(50),
  vigenciaHasta VARCHAR(50),
  baseImponible DECIMAL(19,4),
  codigoContable VARCHAR(30),
  tipo INTEGER
);

DROP TABLE IF EXISTS tmpEdocTaCliente;
CREATE TABLE tmpEdocTaCliente (
  registro SERIAL PRIMARY KEY,
  codigoCliente VARCHAR(20),
  tipo VARCHAR(2),
  emision TIMESTAMP NOT NULL,
  vencimiento TIMESTAMP NOT NULL,
  numero VARCHAR(12) NOT NULL,
  concepto VARCHAR(30),
  importe DECIMAL(19,4),
  origen VARCHAR(3),
  saldoAnterior DECIMAL(19,4),
  saldoActual DECIMAL(19,4)
);

DROP TABLE IF EXISTS tmpMayor;
CREATE TABLE tmpMayor (
  numero VARCHAR(8),
  codigo VARCHAR(30) NOT NULL,
  fecha TIMESTAMP NOT NULL,
  referencia VARCHAR(20),
  concepto VARCHAR(70),
  saldoAnterior DECIMAL(19,4),
  debitos DECIMAL(19,4),
  creditos DECIMAL(19,4),
  saldoActual DECIMAL(19,4),
  registro INTEGER
);

DROP TABLE IF EXISTS tmpRetenciones;
CREATE TABLE tmpRetenciones (
  codigoRetencion VARCHAR(5) NOT NULL,
  codigoContable VARCHAR(30),
  concepto VARCHAR(50),
  baseImponible DECIMAL(19,4),
  tarifa DECIMAL(19,4),
  pagoMinimo DECIMAL(19,4),
  sustraendo DECIMAL(19,4),
  acumulador VARCHAR(1)
);

DROP TABLE IF EXISTS tpvClientes;
CREATE TABLE tpvClientes (
  codigoCliente VARCHAR(22) PRIMARY KEY,
  nombre VARCHAR(50),
  direccion TEXT,
  telefonos VARCHAR(30),
  porDefecto BOOLEAN
);

DROP TABLE IF EXISTS tpvFacturas;
CREATE TABLE tpvFacturas (
  numero VARCHAR(8) PRIMARY KEY,
  fechaEmision TIMESTAMP NOT NULL,
  codigoCliente VARCHAR(22),
  regimenIva VARCHAR(1),
  totalBruto DECIMAL(19,4),
  descuento DECIMAL(19,4),
  impuesto DECIMAL(19,4),
  cargo DECIMAL(19,4),
  totalFactura DECIMAL(19,4),
  porcentajeDescuento DECIMAL(10,4),
  vendedor VARCHAR(5),
  tarifa VARCHAR(5),
  peso DECIMAL(19,4),
  devolucionFactura VARCHAR(8),
  codigoCaja VARCHAR(5),
  recibeEfectivo DECIMAL(19,4),
  comentarios TEXT,
  cuadre BOOLEAN
);

DROP TABLE IF EXISTS tpvFacturasRenglones;
CREATE TABLE tpvFacturasRenglones (
  registro SERIAL PRIMARY KEY,
  numero VARCHAR(8) NOT NULL,
  almacen VARCHAR(5),
  codigoProducto VARCHAR(50),
  iva VARCHAR(1),
  porcentajeIva DECIMAL(10,4),
  bultos DECIMAL(19,4),
  cantidad DECIMAL(19,4),
  precio DECIMAL(19,4),
  descuento DECIMAL(10,4),
  totalRenglon DECIMAL(19,4)
);

DROP TABLE IF EXISTS transferencias;
CREATE TABLE transferencias (
  numero VARCHAR(8) PRIMARY KEY,
  fechaEmision TIMESTAMP,
  concepto VARCHAR(50),
  comentarios TEXT,
  peso DECIMAL(19,4),
  totalTransferencia DECIMAL(19,4),
  hora TIMESTAMP,
  anulada BOOLEAN,
  gara BOOLEAN DEFAULT FALSE
);

DROP TABLE IF EXISTS transferenciasRenglones;
CREATE TABLE transferenciasRenglones (
  registro SERIAL PRIMARY KEY,
  numero VARCHAR(8),
  codigoProducto VARCHAR(50),
  almacenOrigen VARCHAR(5),
  almacenDestino VARCHAR(5),
  bultos DECIMAL(19,4),
  cantidad DECIMAL(19,4),
  costo DECIMAL(19,4),
  anulada BOOLEAN
);

DROP TABLE IF EXISTS transportistas;
CREATE TABLE transportistas (
  codigo VARCHAR(5) PRIMARY KEY,
  nombre VARCHAR(250)
);

DROP TABLE IF EXISTS vehiculos;
CREATE TABLE vehiculos (
  codigoVehiculo VARCHAR(50) PRIMARY KEY,
  matricula VARCHAR(50) NOT NULL,
  modelo VARCHAR(50),
  anio VARCHAR(30),
  chasis VARCHAR(30),
  motor VARCHAR(30),
  disco VARCHAR(30),
  odometro VARCHAR(30),
  color VARCHAR(30),
  marca VARCHAR(5),
  comentarios TEXT,
  fechaRegistro TIMESTAMP,
  foto BYTEA
);

DROP TABLE IF EXISTS vendedores;
CREATE TABLE vendedores (
  codigo VARCHAR(5) PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  comision1 DECIMAL(10,4),
  comision2 DECIMAL(10,4),
  comision3 DECIMAL(10,4),
  comision4 DECIMAL(10,4),
  zona VARCHAR(5),
  direccion TEXT,
  telefonos VARCHAR(30),
  fax VARCHAR(15),
  ruc VARCHAR(15),
  rif VARCHAR(15),
  nit VARCHAR(15),
  email VARCHAR(50),
  fechaRegistro TIMESTAMP
);

DROP TABLE IF EXISTS vendedoresEstimados;
CREATE TABLE vendedoresEstimados (
  mes VARCHAR(2),
  ano VARCHAR(4),
  vendedor VARCHAR(5),
  codigoProducto VARCHAR(50),
  cantidad DECIMAL(19,4)
);

DROP TABLE IF EXISTS zonas;
CREATE TABLE zonas (
  codigo VARCHAR(5) PRIMARY KEY,
  nombre VARCHAR(250),
  proximo VARCHAR(8) DEFAULT '00000001'
);


-- FK para bancosChequeras
ALTER TABLE bancosChequeras
ADD CONSTRAINT fk_bancosChequeras_bancos
FOREIGN KEY (codigoBanco) REFERENCES bancos(codigoBanco);

-- FK para bancosCheques (codigoBanco)
ALTER TABLE bancosCheques
ADD CONSTRAINT fk_bancosCheques_bancos
FOREIGN KEY (codigoBanco) REFERENCES bancos(codigoBanco);

-- FK para bancosCheques (numeroChequera)
ALTER TABLE bancosCheques
ADD CONSTRAINT fk_bancosCheques_chequeras
FOREIGN KEY (numeroChequera) REFERENCES bancosChequeras(numeroChequera);

-- FK para bancosConciliacion
ALTER TABLE bancosConciliacion
ADD CONSTRAINT fk_bancosConciliacion_bancos
FOREIGN KEY (codigoBanco) REFERENCES bancos(codigoBanco);

-- FK para bancosConciliacionMovimientos
ALTER TABLE bancosConciliacionMovimientos
ADD CONSTRAINT fk_bancosConcmov_bancos
FOREIGN KEY (codigoBanco) REFERENCES bancos(codigoBanco);

-- FK para bancosDistribucionGasto (codigoBanco)
ALTER TABLE bancosDistribucionGasto
ADD CONSTRAINT fk_bancosDistgasto_bancos
FOREIGN KEY (codigoBanco) REFERENCES bancos(codigoBanco);

-- FK para bancosDistribucionGasto (tipo, numero, codigoBanco)
ALTER TABLE bancosDistribucionGasto
ADD CONSTRAINT fk_bancosDistgasto_movimientos
FOREIGN KEY (codigoBanco, tipo, numero)
REFERENCES bancosMovimientos(codigoBanco, tipo, numero);

-- FK para bancosMovimientos
ALTER TABLE bancosMovimientos
ADD CONSTRAINT fk_bancosMovimientos_bancos
FOREIGN KEY (codigoBanco) REFERENCES bancos(codigoBanco);

-- FK para boletasProduccionRenglones
ALTER TABLE boletasProduccionRenglones
ADD CONSTRAINT fk_boletaProdReng_prod
FOREIGN KEY (numero) REFERENCES boletasProduccion(numero);

-- FK para boletasTrabajoRenglones
ALTER TABLE boletasTrabajoRenglones
ADD CONSTRAINT fk_boletasTrabajoReng_trabajo
FOREIGN KEY (numero) REFERENCES boletasTrabajo(numero);

-- FK para cajaCajerosMovimientos (codigoCajero)
ALTER TABLE cajaCajerosMovimientos
ADD CONSTRAINT fk_cajaCajerosMov_cajeros
FOREIGN KEY (codigoCajero) REFERENCES cajaCajeros(codigo);

-- ClientesMovimientos → Clientes
ALTER TABLE clientesMovimientos
ADD CONSTRAINT fk_clientesMovimientos_clientes
FOREIGN KEY (codigoCliente) REFERENCES clientes(codigoCliente);

-- Clientes → ClientesGrupos
ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_clientesGrupos
FOREIGN KEY (codigoGrupo) REFERENCES clientesGrupos(codigoGrupo);

-- ComprasRenglones → numero
ALTER TABLE comprasRenglones
ADD CONSTRAINT fk_comprasRenglones_compra
FOREIGN KEY (numero) REFERENCES compras(numero);

-- ContabilidadAsientosRenglones → numero
ALTER TABLE contabilidadAsientosRenglones
ADD CONSTRAINT fk_contabilidadAsientosRenglones_asiento
FOREIGN KEY (numero) REFERENCES contabilidadAsientos(numero);

-- ContabilidadBalancesRenglones → codigoBalance
ALTER TABLE contabilidadBalancesRenglones
ADD CONSTRAINT fk_contabilidadBalancesRenglones_balance
FOREIGN KEY (codigoBalance) REFERENCES contabilidadBalances(codigoBalance);

-- TpvFacturas → TpvClientes
ALTER TABLE tpvFacturas
ADD CONSTRAINT fk_tpvFacturas_tpvClientes
FOREIGN KEY (codigoCliente) REFERENCES tpvClientes(codigoCliente);

-- FacturasRenglones → Facturas
ALTER TABLE facturasRenglones
ADD CONSTRAINT fk_facturasRenglones_numero
FOREIGN KEY (numero) REFERENCES facturas(numero);

-- InventarioFisicoRenglones → InventarioFisico
ALTER TABLE inventarioFisicoRenglones
ADD CONSTRAINT fk_inventarioFisicoRenglones_numero
FOREIGN KEY (numero) REFERENCES inventarioFisico(numero);

-- NotasEntregaRenglones → NotasEntrega
ALTER TABLE notasEntregaRenglones
ADD CONSTRAINT fk_notasEntregaRenglones_numero
FOREIGN KEY (numero) REFERENCES notasEntrega(numero);

-- OrdenesCompraRenglones → OrdenesCompra
ALTER TABLE ordenesCompraRenglones
ADD CONSTRAINT fk_ordenesCompraRenglones_numero
FOREIGN KEY (numero) REFERENCES ordenesCompra(numero);

-- OrdenesProduccion → Productos
ALTER TABLE ordenesProduccion
ADD CONSTRAINT fk_ordenesProduccion_codigoProducto
FOREIGN KEY (codigoProducto) REFERENCES productos(codigoProducto);

-- PresupuestoPendienteRenglones → PresupuestoPendiente
ALTER TABLE presupuestoPendienteRenglones
ADD CONSTRAINT fk_presupuestoPendienteRenglones_presupuestoPendiente
FOREIGN KEY (fecha, numero) REFERENCES presupuestoPendiente(fecha, numero);

-- ProductosComposicion → Productos
ALTER TABLE productosComposicion
ADD CONSTRAINT fk_productosComposicion_productos
FOREIGN KEY (codigoProducto) REFERENCES productos(codigoProducto);

-- ProductosExistencias → Productos
ALTER TABLE productosExistencias
ADD CONSTRAINT fk_productosExistencias_productos
FOREIGN KEY (codigoProducto) REFERENCES productos(codigoProducto);

-- ProductosExistencias → ProductosAlmacenes
ALTER TABLE productosExistencias
ADD CONSTRAINT fk_productosExistencias_productosAlmacenes
FOREIGN KEY (almacen) REFERENCES productosAlmacenes(almacen);

-- ProductosMovimientos → Productos
ALTER TABLE productosMovimientos
ADD CONSTRAINT fk_productosMovimientos_productos
FOREIGN KEY (codigoProducto) REFERENCES productos(codigoProducto);

-- ProductoPrecios → Productos
ALTER TABLE productoPrecios
ADD CONSTRAINT fk_productoPrecios_productos
FOREIGN KEY (codigoProducto) REFERENCES productos(codigoProducto);

-- Proveedores → ProductosGrupos
ALTER TABLE proveedores
ADD CONSTRAINT fk_proveedores_productosGrupos
FOREIGN KEY (codigoGrupo) REFERENCES productosGrupos(codigoGrupo);

-- RequisicionesRenglones → Requisiciones
ALTER TABLE requisicionesRenglones
ADD CONSTRAINT fk_requisicionesRenglones_requisiciones
FOREIGN KEY (numero) REFERENCES requisiciones(numero);

-- RecepcionesRenglones → Recepciones
ALTER TABLE recepcionesRenglones
ADD CONSTRAINT fk_recepcionesRenglones_recepciones
FOREIGN KEY (numero) REFERENCES recepciones(numero);

-- RutasRenglones → Rutas
ALTER TABLE rutasRenglones
ADD CONSTRAINT fk_rutasRenglones_rutas
FOREIGN KEY (codigoRuta) REFERENCES rutas(codigoRuta);

-- TransferenciasRenglones → Transferencias
ALTER TABLE transferenciasRenglones
ADD CONSTRAINT fk_transferenciasRenglones_transferencias
FOREIGN KEY (numero) REFERENCES transferencias(numero);
-------------------------------------------------------
-- VISTAS--
-------------------------------------------------------

drop view if exists comproban;
create view comproban as
select
    ca.numero,
    ca.fecha,
    ca.descripcion,
    ca.debitos,
    ca.creditos,
    car.codigocontable,
    car.referencia,
    car.concepto,
    car.importe,
    cc.nombre,
    e.nombre as empre,
    car.tipo,
    car.nombre as nom,
    car.numcheq,
    car.cuenta,
    ca.bene,
    ca.tipo as expr1
from contabilidadasientos ca
inner join contabilidadasientosrenglones car
    on ca.fecha = car.fecha and ca.numero = car.numero
inner join contabilidadcuentas cc
    on car.codigocontable = cc.codigocontable
cross join empresa e
where ca.tipo = 'I';

drop view if exists existenciaxalmacen;
create view existenciaxalmacen as
select
    codigoproducto,
    almacen,
    sum(
        case
            when tipo in ('en', 'ae', 'dv') then cantidad
            when tipo in ('sa', 'as', 'dc') then -cantidad
        end
    ) as existencia
from productosmovimientos
group by codigoproducto, almacen;

drop view if exists factreten;
create view factreten as
select
    f.numero,
    to_char(f.fechaemision, 'dd/mm/yyyy') as fechaemision,
    f.retencion,
    c.nombre,
    c.codigocliente,
    to_char(f.fechalimite, 'dd/mm/yyyy') as fechalimite,
    c.rif,
    f.anulada,
    f.totalfactura
from facturas f
inner join clientes c
    on f.codigocliente = c.codigocliente
where f.retencion = true
  and f.numero not in (
      select rv.numdocven
      from retencionesventas rv
  )
  and f.anulada is null;

drop view if exists items;
create view items as
select
    codigoproducto,
    nombre,
    ultimocosto
from productos
union
select
    codigo,
    nombre,
    costo
from servicios;

drop view if exists movimientocliente1;
create view movimientocliente1 as
select
    f.numero,
    f.fechaemision,
    f.totalfactura,
    f.referencia,
    c.nombre,
    cm.tipo
from facturas f
inner join cajamovimientos cm
    on f.numero = cm.numeroorigen
inner join clientes c
    on f.codigocliente = c.codigocliente;

drop view if exists productopreciostarifas;
create view productopreciostarifas as
select
    pp.codigoproducto,
    pp.tarifa,
    pp.precio,
    pp.descuento,
    pp.cantidad,
    pt.nombre
from productoprecios pp
inner join productostarifas pt
    on pp.tarifa = pt.codigo
order by pp.codigoproducto, pp.tarifa;

drop view if exists productosproveedores;
create view productosproveedores as
select
    pm.codigoproducto,
    pm.proveedorcliente,
    p.nombre,
    sum(pm.cantidad) as cantidad,
    sum(pm.costototal) as costo,
    sum(pm.costototal) / sum(pm.cantidad) as promedio
from productosmovimientos pm
inner join proveedores p
    on pm.proveedorcliente = p.codigoproveedor
group by pm.codigoproducto, pm.proveedorcliente, p.nombre
order by pm.codigoproducto, sum(pm.cantidad) desc;

drop view if exists comingreso;
create view comingreso as
select
    ca.numero,
    ca.fecha,
    ca.descripcion,
    ca.debitos,
    ca.creditos,
    car.codigocontable,
    car.referencia,
    car.concepto,
    car.importe,
    cc.nombre,
    e.nombre as empre,
    car.numcheq,
    car.nombre as expr1,
    car.cuenta,
    ca.bene,
    ca.tipo,
    car.tipo as expr2
from contabilidadasientos ca
inner join contabilidadasientosrenglones car
    on ca.fecha = car.fecha and ca.numero = car.numero
inner join contabilidadcuentas cc
    on car.codigocontable = cc.codigocontable
cross join empresa e
where ca.tipo = 'I';

drop view if exists retencion1;
CREATE OR REPLACE VIEW retencion1 AS
SELECT
    numerodocumento,
    codigoretencion,
    fecha,
    ejerciciofiscal,
    SUM(valorretencion) AS valorretencion,
    tipodocumento,
    numdocven
FROM retenciones
GROUP BY numerodocumento, codigoretencion, fecha, ejerciciofiscal, tipodocumento, numdocven;

drop view if exists retencioncompra1;
CREATE OR REPLACE VIEW retencioncompra1 AS
SELECT
    numerodocumento,
    codigoretencion,
    fecha,
    ejerciciofiscal,
    SUM(valorretencion) AS valorretencion,
    tipodocumento,
    numdocven
FROM retenciones
GROUP BY numerodocumento, codigoretencion, fecha, ejerciciofiscal, tipodocumento, numdocven;

drop view if exists retencionescompra1;
CREATE OR REPLACE VIEW retencionescompra1 AS
SELECT
    rc.numerodocumento,
    rc.codigoretencion,
    rc.fecha,
    rc.ejerciciofiscal,
    rc.valorretencion,
    rc.tipodocumento,
    rc.numdocven,
    tr.tipoimpuesto,
    tr.concepto,
    tr.porcentaje,
    tr.codigocontable,
    c.totalbruto,
    c.impuesto,
    c.totalcompra,
    p.nombre,
    p.rif,
    c.referencia
FROM retencioncompra1 rc
INNER JOIN tiposretenciones tr ON rc.codigoretencion = tr.codigoretencion
INNER JOIN compras c ON rc.numerodocumento = c.numero
INNER JOIN proveedores p ON c.codigoproveedor = p.codigoproveedor;

drop view if exists retencionventa;
CREATE OR REPLACE VIEW retencionventa AS
SELECT
    rv.codigoretencion,
    rv.codigocontable,
    rv.autsri,
    rv.numerodocumento,
    rv.rucimprenta,
    rv.fechaemicion,
    rv.fechavalidesdoc,
    rv.valorretencion,
    rv.ejerciciofiscal,
    TO_CHAR(rv.fechaemicion, 'MM') AS mes,
    TO_CHAR(rv.fechaemicion, 'YYYY') AS anio,
    tr.concepto,
    c.nombre,
    rv.tiporetencion
FROM retencionesventas rv
INNER JOIN tiposretenciones tr ON rv.codigoretencion = tr.codigoretencion
INNER JOIN clientes c ON rv.numdocven = c.codigocliente;

drop view if exists todositems;
CREATE OR REPLACE VIEW todositems AS
SELECT DISTINCT
    codigoproducto AS codigo,
    nombre,
    ultimocosto
FROM items;

drop view if exists vistanota;
CREATE OR REPLACE VIEW vistanota AS
SELECT
    nv.numero,
    nv.fecha,
    nv.cliente,
    nv.total,
    nvc.cantidad,
    nvc.precio,
    nv.total AS tproducto,
    nvc.codigoproducto,
    nvc.descripcion
FROM notaventa nv
INNER JOIN notaventacuerpo nvc ON nv.numero = nvc.numero;

drop view if exists vistanotaventa;
CREATE OR REPLACE VIEW vistanotaventa AS
SELECT
    nv.numero,
    nvc.codigoproducto AS codigo,
    nvc.precio,
    nvc.cantidad,
    nv.fecha,
    ti.nombre,
    ti.ultimocosto,
    ROUND(nvc.precio - ti.ultimocosto, 2) AS utilidad,
    ROUND((nvc.precio - ti.ultimocosto) * nvc.cantidad, 2) AS total
FROM notaventa nv
INNER JOIN notaventacuerpo nvc ON nv.numero = nvc.numero
INNER JOIN todositems ti ON nvc.codigoproducto = ti.codigo;

drop view if exists vistaretenciones;
CREATE OR REPLACE VIEW vistaretenciones AS
SELECT
    r.numerodocumento,
    r.codigoretencion,
    r.ejerciciofiscal,
    r.tipodocumento,
    r.valorretencion,
    r.fecha,
    p.nombre,
    p.rif,
    p.direccion,
    p.telefonos,
    c.referencia,
    c.fechaemision,
    c.totalbruto,
    c.impuesto,
    c.totalcompra,
    r.tipoimpuesto,
    r.concepto,
    r.porcentaje,
    p.codigoproveedor,
    r.tipodocu,
    r.codigocontable,
    r.producto::money AS valor,
    c.tipo
FROM retenciones r
INNER JOIN compras c ON r.numerodocumento = c.numero
INNER JOIN proveedores p ON c.codigoproveedor = p.codigoproveedor;

------------------------------------------------------
--PROCEDIMIENTOS ALMACENADOS--
------------------------------------------------------

-- Procedimiento para insertar un registro en la tabla Retenciones
CREATE OR REPLACE FUNCTION ingresaRetenciones(
    codigoRetencion VARCHAR(15),
    codigoContable VARCHAR(30),
    numeroDocumento VARCHAR(30),
    codigoProducto VARCHAR(20),
    fecha TIMESTAMP,
    valorRetencion NUMERIC,
    ejercicioFiscal VARCHAR(20),
    producto VARCHAR(50),
    tipoRetencion VARCHAR(50),
    concepto VARCHAR(50),
    tipoDocumento VARCHAR(10)
) RETURNS VOID AS $$
BEGIN
    INSERT INTO retenciones (
        codigoRetencion, 
        codigoContable, 
        numeroDocumento, 
        codigoProducto, 
        fecha, 
        valorRetencion, 
        ejercicioFiscal, 
        producto, 
        tipoRetencion, 
        concepto, 
        tipoDocumento
    ) 
    VALUES (
        codigoRetencion, 
        codigoContable, 
        numeroDocumento, 
        codigoProducto, 
        fecha, 
        valorRetencion, 
        ejercicioFiscal, 
        producto, 
        tipoRetencion, 
        concepto, 
        tipoDocumento
    );
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para generar un reporte de movimientos de productos (cardex)
CREATE OR REPLACE FUNCTION jodasCardex(
    codProDesde VARCHAR(20),
    codProHasta VARCHAR(20),
    fecDesde VARCHAR(12),
    fecHasta VARCHAR(12)
) RETURNS VOID AS $$
BEGIN
    -- Establece el formato de fecha a DD/MM/YYYY
    SET datestyle = 'DMY';

    -- Elimina la tabla temporal si existe
    DROP TABLE IF EXISTS tmpJodasCardex;

    -- Crea la tabla temporal tmpJodasCardex
    CREATE TEMP TABLE tmpJodasCardex (
        codigoProducto CHAR(50),
        fecha TIMESTAMP,
        numero CHAR(18),
        producto CHAR(50),
        cantidad NUMERIC,
        origen CHAR(3),
        proveedorCliente CHAR(30),
        almacen CHAR(20),
        tipo CHAR(2),
        unidadMedida CHAR(10),
        costoTotal NUMERIC,
        almacenNombre CHAR(30),
        proveedorNombre CHAR(50),
        clienteNombre CHAR(50),
        costo NUMERIC,
        precio NUMERIC,
        ultimoCosto NUMERIC,
        registro SERIAL PRIMARY KEY
    );

    -- Inserta el saldo anterior
    INSERT INTO tmpJodasCardex (
        codigoProducto,
        fecha,
        numero,
        producto,
        cantidad,
        origen,
        proveedorCliente,
        almacen,
        tipo,
        unidadMedida,
        costoTotal,
        almacenNombre,
        proveedorNombre,
        clienteNombre,
        costo,
        precio,
        ultimoCosto
    )
    SELECT 
        t1.codigoProducto,
        MIN(t1.fecha) AS fecha,
        NULL AS numero,
        t1.nombre AS producto,
        SUM(t1.cantidad1) AS cantidad,
        NULL AS origen,
        NULL AS proveedorCliente,
        NULL AS almacen,
        'JO' AS tipo,
        NULL AS unidadMedida,
        0 AS costoTotal,
        NULL AS almacenNombre,
        'SALDO ANTERIOR' AS proveedorNombre,
        NULL AS clienteNombre,
        0 AS costo,
        0 AS precio,
        0 AS ultimoCosto
    FROM (
        SELECT 
            p.codigoProducto,
            CASE pm.tipo 
                WHEN 'SA' THEN pm.cantidad * -1
                WHEN 'S' THEN pm.cantidad * -1
                WHEN 'AS' THEN pm.cantidad * -1
                WHEN 'DC' THEN pm.cantidad * -1
                WHEN 'EN' THEN pm.cantidad
                WHEN 'E' THEN pm.cantidad
                WHEN 'AE' THEN pm.cantidad
                WHEN 'DV' THEN pm.cantidad
            END AS cantidad1,
            pm.fecha,
            p.nombre
        FROM productos p
        INNER JOIN productosMovimientos pm ON p.codigoProducto = pm.codigoProducto
        INNER JOIN productosPrecios pp ON p.codigoProducto = pp.codigoProducto
        WHERE UPPER(pp.tarifa) = 'A'
            AND pm.codigoProducto BETWEEN codProDesde AND codProHasta
            AND pm.fecha < TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY')
    ) t1
    GROUP BY t1.codigoProducto, t1.nombre
    ORDER BY t1.codigoProducto, t1.fecha;

    -- Inserta los movimientos en el rango de fechas
    INSERT INTO tmpJodasCardex (
        codigoProducto,
        fecha,
        numero,
        producto,
        cantidad,
        origen,
        proveedorCliente,
        almacen,
        tipo,
        unidadMedida,
        costoTotal,
        almacenNombre,
        proveedorNombre,
        clienteNombre,
        costo,
        precio,
        ultimoCosto
    )
    SELECT 
        pm.codigoProducto,
        pm.fecha,
        pm.numero,
        p.nombre AS producto,
        pm.cantidad,
        pm.origen,
        pm.proveedorCliente,
        pm.almacen,
        pm.tipo,
        pm.unidadMedida,
        pm.costoTotal,
        pa.nombre AS almacenNombre,
        c.nombre AS clienteNombre,
        pr.nombre AS proveedorNombre,
        p.costo,
        pp.precio,
        p.ultimoCosto
    FROM productosPrecios pp
    INNER JOIN productos p ON pp.codigoProducto = p.codigoProducto
    RIGHT OUTER JOIN productosMovimientos pm
        LEFT OUTER JOIN productosAlmacenes pa ON pm.almacen = pa.almacen
        LEFT OUTER JOIN clientes c ON pm.proveedorCliente = c.codigoCliente
        LEFT OUTER JOIN proveedores pr ON pm.proveedorCliente = pr.codigoProveedor
        ON p.codigoProducto = pm.codigoProducto
    WHERE UPPER(pp.tarifa) = 'A'
        AND pm.codigoProducto BETWEEN codProDesde AND codProHasta
        AND pm.fecha BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY') + INTERVAL '1 day'
    ORDER BY pm.codigoProducto, pm.fecha;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para generar movimientos de clientes
CREATE OR REPLACE FUNCTION jodasMoviClientes(
    fecDesde VARCHAR(12),
    fecHasta VARCHAR(12)
) RETURNS VOID AS $$
DECLARE
    mov RECORD;
    fac RECORD;
    ret RECORD;
BEGIN
    -- Elimina la tabla temporal si existe
    DROP TABLE IF EXISTS tmpMoviCliente;

    -- Crea la tabla temporal tmpMoviCliente
    CREATE TEMP TABLE tmpMoviCliente (
        codigoCliente CHAR(30) NOT NULL,
        tipo CHAR(5),
        numero CHAR(30),
        emision TIMESTAMP,
        vencimiento TIMESTAMP,
        referencia CHAR(30),
        concepto CHAR(60),
        importe NUMERIC,
        nombre CHAR(250)
    );

    -- Procesa movimientos
    FOR mov IN (
        SELECT 
            cm.codigoCliente,
            cm.tipo,
            cm.numero,
            cm.emision,
            cm.vencimiento,
            cm.referencia,
            cm.concepto,
            cm.importe,
            c.nombre
        FROM clientesMovimientos cm
        INNER JOIN clientes c ON cm.codigoCliente = c.codigoCliente
        WHERE cm.emision BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY')
    ) LOOP
        INSERT INTO tmpMoviCliente (
            codigoCliente,
            tipo,
            numero,
            emision,
            vencimiento,
            referencia,
            concepto,
            importe,
            nombre
        )
        VALUES (
            mov.codigoCliente,
            mov.tipo,
            mov.numero,
            mov.emision,
            mov.vencimiento,
            mov.referencia,
            mov.concepto,
            mov.importe,
            mov.nombre
        );
    END LOOP;

    -- Procesa facturas
    FOR fac IN (
        SELECT 
            f.codigoCliente,
            'FC' AS tipo,
            f.numero,
            f.fechaEmision AS emision,
            f.vencimiento,
            f.referencia,
            'Por Facturacion' AS concepto,
            f.totalFactura AS importe,
            c.nombre
        FROM clientes c
        INNER JOIN facturas f ON c.codigoCliente = f.codigoCliente
        WHERE f.fechaEmision BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY')
            AND f.totalFactura > 0
            AND f.numero NOT IN (SELECT numero FROM clientesMovimientos)
    ) LOOP
        INSERT INTO tmpMoviCliente (
            codigoCliente,
            tipo,
            numero,
            emision,
            vencimiento,
            referencia,
            concepto,
            importe,
            nombre
        )
        VALUES (
            fac.codigoCliente,
            fac.tipo,
            fac.numero,
            fac.emision,
            fac.vencimiento,
            fac.referencia,
            fac.concepto,
            fac.importe,
            fac.nombre
        );
    END LOOP;

    -- Procesa retenciones
    FOR ret IN (
        SELECT 
            f.codigoCliente,
            'RET' AS tipo,
            rv.numeroDocumento AS numero,
            rv.fechaEmicion AS emision,
            rv.fechaValidesDoc AS vencimiento,
            rv.numDocVen AS referencia,
            'Por Retencion' AS concepto,
            rv.valorRetencion AS importe,
            c.nombre
        FROM clientes c
        INNER JOIN facturas f ON c.codigoCliente = f.codigoCliente
        INNER JOIN retencionesVentas rv ON f.numero = rv.numDocVen
        WHERE rv.fechaEmicion BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY')
    ) LOOP
        INSERT INTO tmpMoviCliente (
            codigoCliente,
            tipo,
            numero,
            emision,
            vencimiento,
            referencia,
            concepto,
            importe,
            nombre
        )
        VALUES (
            ret.codigoCliente,
            ret.tipo,
            ret.numero,
            ret.emision,
            ret.vencimiento,
            ret.referencia,
            ret.concepto,
            ret.importe,
            ret.nombre
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para generar movimientos de proveedores
CREATE OR REPLACE FUNCTION jodasMoviProvee(
    fecDesde VARCHAR(12),
    fecHasta VARCHAR(12)
) RETURNS VOID AS $$
DECLARE
    mov RECORD;
    cmp RECORD;
    ret RECORD;
BEGIN
    -- Ejecuta el procedimiento spEdoCtaProveedor (debe estar definido en PostgreSQL)
    PERFORM spEdoCtaProveedor('0', 'z', fecDesde, fecHasta);

    -- Elimina la tabla temporal si existe
    DROP TABLE IF EXISTS tmpMoviProvee;

    -- Crea la tabla temporal tmpMoviProvee
    CREATE TEMP TABLE tmpMoviProvee (
        codigoProvee CHAR(30) NOT NULL,
        tipo CHAR(5),
        numero CHAR(30),
        emision TIMESTAMP,
        vencimiento TIMESTAMP,
        referencia CHAR(30),
        concepto CHAR(60),
        importe NUMERIC,
        nombre CHAR(250)
    );

    -- Procesa movimientos
    FOR mov IN (
        SELECT 
            tep.codigoProveedor,
            tep.tipo,
            tep.numero,
            tep.emision,
            tep.vencimiento,
            '' AS referencia,
            tep.concepto,
            tep.importe,
            p.nombre
        FROM tmpEdoCtaProveedor tep
        INNER JOIN proveedores p ON tep.codigoProveedor = p.codigoProveedor
        LEFT OUTER JOIN tmpComprasRetencionesII tcr ON tep.numero = tcr.numero
        WHERE tep.emision BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY')
    ) LOOP
        INSERT INTO tmpMoviProvee (
            codigoProvee,
            tipo,
            numero,
            emision,
            vencimiento,
            referencia,
            concepto,
            importe,
            nombre
        )
        VALUES (
            mov.codigoProveedor,
            mov.tipo,
            mov.numero,
            mov.emision,
            mov.vencimiento,
            mov.referencia,
            mov.concepto,
            mov.importe,
            mov.nombre
        );
    END LOOP;

    -- Procesa compras
    FOR cmp IN (
        SELECT 
            c.codigoProveedor,
            'FC' AS tipo,
            c.numero,
            c.fechaEmision AS emision,
            c.vencimiento,
            c.referencia,
            'Por Compra' AS concepto,
            c.totalCompra AS importe,
            p.nombre
        FROM compras c
        INNER JOIN proveedores p ON c.codigoProveedor = p.codigoProveedor
        WHERE c.fechaEmision BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY')
            AND c.totalCompra > 0
            AND c.numero NOT IN (SELECT numero FROM proveedoresMovimientos)
    ) LOOP
        INSERT INTO tmpMoviProvee (
            codigoProvee,
            tipo,
            numero,
            emision,
            vencimiento,
            referencia,
            concepto,
            importe,
            nombre
        )
        VALUES (
            cmp.codigoProveedor,
            cmp.tipo,
            cmp.numero,
            cmp.emision,
            cmp.vencimiento,
            cmp.referencia,
            cmp.concepto,
            cmp.importe,
            cmp.nombre
        );
    END LOOP;

    -- Procesa retenciones
    FOR ret IN (
        SELECT 
            c.codigoProveedor,
            'RET' AS tipo,
            r.tipoDocu AS numero,
            r.fecha AS emision,
            r.fecha AS vencimiento,
            r.numeroDocumento AS referencia,
            'Por Retencion' AS concepto,
            r.valorRetencion AS importe,
            p.nombre
        FROM proveedores p
        INNER JOIN compras c ON p.codigoProveedor = c.codigoProveedor
        INNER JOIN retenciones r ON c.numero = r.numeroDocumento
        WHERE r.fecha BETWEEN TO_TIMESTAMP(fecDesde, 'DD/MM/YYYY') AND TO_TIMESTAMP(fecHasta, 'DD/MM/YYYY')
    ) LOOP
        INSERT INTO tmpMoviProvee (
            codigoProvee,
            tipo,
            numero,
            emision,
            vencimiento,
            referencia,
            concepto,
            importe,
            nombre
        )
        VALUES (
            ret.codigoProveedor,
            ret.tipo,
            ret.numero,
            ret.emision,
            ret.vencimiento,
            ret.referencia,
            ret.concepto,
            ret.importe,
            ret.nombre
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para ejecutar recalculaciones generales
CREATE OR REPLACE FUNCTION recalcular() RETURNS VOID AS $$
BEGIN
    PERFORM recalcularCxc();
    PERFORM recalcularCxp();
    PERFORM recalcularBancos();
    PERFORM recalcularInventario();
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular los saldos de bancos
CREATE OR REPLACE FUNCTION recalcularBancos() RETURNS VOID AS $$
BEGIN
    UPDATE bancos
    SET saldo = (
        SELECT COALESCE(SUM(importe), 0)
        FROM bancosMovimientos bm
        WHERE bm.codigoBanco = bancos.codigoBanco
        AND bm.tipo <> 'AN'
    );

    UPDATE bancos
    SET saldo = 0
    WHERE saldo IS NULL;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular los saldos de cuentas por cobrar
CREATE OR REPLACE FUNCTION recalcularCxc() RETURNS VOID AS $$
BEGIN
    UPDATE clientes
    SET saldo = (
        SELECT COALESCE(SUM(importe), 0)
        FROM clientesMovimientos cm
        WHERE cm.codigoCliente = clientes.codigoCliente
    );

    UPDATE clientes
    SET saldo = 0
    WHERE saldo IS NULL;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular los saldos de cuentas por pagar
CREATE OR REPLACE FUNCTION recalcularCxp() RETURNS VOID AS $$
BEGIN
    UPDATE proveedores
    SET saldo = (
        SELECT COALESCE(SUM(importe), 0)
        FROM proveedoresMovimientos pm
        WHERE pm.codigoProveedor = proveedores.codigoProveedor
    );

    UPDATE proveedores
    SET saldo = 0
    WHERE saldo IS NULL;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular el inventario
CREATE OR REPLACE FUNCTION recalcularInventario() RETURNS VOID AS $$
BEGIN
    PERFORM recosteoInventario();
    PERFORM recalcularPedidos();
    PERFORM recalcularPedidosCompra();
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular pedidos de venta
CREATE OR REPLACE FUNCTION recalcularPedidos() RETURNS VOID AS $$
BEGIN
    UPDATE productos
    SET pedidoVenta = (
        SELECT COALESCE(SUM(pr.cantidad * pr.bultos - pr.despacho), 0)
        FROM pedidosRenglones pr
        WHERE pr.codigoProducto = productos.codigoProducto
        AND pr.estatus = 'PE'
    );

    UPDATE productos
    SET pedidoVenta = 0
    WHERE pedidoVenta IS NULL;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular pedidos de compra
CREATE OR REPLACE FUNCTION recalcularPedidosCompra() RETURNS VOID AS $$
BEGIN
    UPDATE productos
    SET pedidoCompra = 0;

    UPDATE productos
    SET pedidoCompra = (
        SELECT COALESCE(SUM(pr.cantidad * pr.bultos - pr.despacho), 0)
        FROM ordenesCompraRenglones pr
        WHERE pr.codigoProducto = productos.codigoProducto
        AND pr.estatus = 'PE'
    );

    UPDATE productos
    SET pedidoCompra = 0
    WHERE pedidoCompra IS NULL;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular existencias de un producto
CREATE OR REPLACE FUNCTION recalculoExistencias(
    codigoProducto CHAR(50),
    OUT existencia NUMERIC
) AS $$
DECLARE
    mov RECORD;
    entrada NUMERIC := 0;
    salida NUMERIC := 0;
BEGIN
    -- Elimina las existencias previas para el producto
    DELETE FROM productosExistencias WHERE codigoProducto = codigoProducto;

    -- Procesa los movimientos
    FOR mov IN (
        SELECT tipo, cantidad, almacen
        FROM productosMovimientos
        WHERE codigoProducto = codigoProducto
        AND tipo <> 'AC'
        ORDER BY fecha
    ) LOOP
        -- Inserta un registro en productosExistencias si no existe
        IF NOT EXISTS (
            SELECT 1
            FROM productosExistencias
            WHERE codigoProducto = codigoProducto
            AND almacen = mov.almacen
        ) THEN
            INSERT INTO productosExistencias (codigoProducto, almacen, existencia)
            VALUES (codigoProducto, mov.almacen, 0);
        END IF;

        -- Actualiza existencias según el tipo de movimiento
        IF LEFT(mov.tipo, 1) = 'E' OR mov.tipo = 'AE' OR mov.tipo = 'DV' THEN
            entrada := entrada + mov.cantidad;
            UPDATE productosExistencias
            SET existencia = existencia + mov.cantidad
            WHERE codigoProducto = codigoProducto
            AND almacen = mov.almacen;
        ELSE
            salida := salida + mov.cantidad;
            UPDATE productosExistencias
            SET existencia = existencia - mov.cantidad
            WHERE codigoProducto = codigoProducto
            AND almacen = mov.almacen;
        END IF;
    END LOOP;

    -- Calcula la existencia total y actualiza productos
    existencia := entrada - salida;
    UPDATE productos
    SET existencia = existencia
    WHERE codigoProducto = codigoProducto;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para realizar el recosteo de un producto
CREATE OR REPLACE FUNCTION recosteo(codigoProducto CHAR(50)) RETURNS VOID AS $$
BEGIN
    UPDATE productos
    SET recosteo = 1
    WHERE codigoProducto = codigoProducto;

    PERFORM recosteoEliminacion(codigoProducto);
    PERFORM recosteoProducto(codigoProducto);
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recostear productos de una compra
CREATE OR REPLACE FUNCTION recosteoCompra(numero CHAR(8)) RETURNS VOID AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN (
        SELECT fr.codigoProducto
        FROM comprasRenglones fr
        INNER JOIN productos p ON fr.codigoProducto = p.codigoProducto
        WHERE fr.numero = numero
        AND fr.recepcion IS NULL
    ) LOOP
        PERFORM recosteo(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recalcular costos de eliminación de un producto
CREATE OR REPLACE FUNCTION recosteoEliminacion(codigoProducto CHAR(50)) RETURNS VOID AS $$
DECLARE
    ultimoCosto NUMERIC;
    costo NUMERIC;
    ultimoProveedor CHAR(20);
    tipoCosteo CHAR(1);
BEGIN
    -- Obtiene el tipo de costeo
    SELECT tipoCosteo INTO tipoCosteo
    FROM productos
    WHERE codigoProducto = codigoProducto;

    -- Obtiene el último costo
    SELECT costototal / cantidad INTO ultimoCosto
    FROM productosMovimientos
    WHERE codigoProducto = codigoProducto
    AND (LEFT(tipo, 1) = 'E' OR tipo = 'AE' OR tipo = 'DV')
    ORDER BY fecha DESC
    LIMIT 1;

    -- Calcula el costo según el tipo de costeo
    IF tipoCosteo = 'L' THEN
        SELECT costototal / cantidad INTO costo
        FROM productosMovimientos
        WHERE codigoProducto = codigoProducto
        AND (LEFT(tipo, 1) = 'E' OR tipo = 'AE' OR tipo = 'DV')
        AND cantidad >= cantidadUsada
        ORDER BY fecha DESC, registro DESC
        LIMIT 1;
    ELSIF tipoCosteo = 'F' THEN
        SELECT costototal / cantidad INTO costo
        FROM productosMovimientos
        WHERE codigoProducto = codigoProducto
        AND (LEFT(tipo, 1) = 'E' OR tipo = 'AE' OR tipo = 'DV')
        AND cantidad >= cantidadUsada
        ORDER BY fecha, registro
        LIMIT 1;
    ELSIF tipoCosteo = 'P' THEN
        PERFORM costoPromedio(codigoProducto, '30000101', costo);
    ELSIF tipoCosteo = 'U' THEN
        costo := ultimoCosto;
    END IF;

    -- Obtiene el último proveedor
    SELECT proveedorCliente INTO ultimoProveedor
    FROM productosMovimientos
    WHERE codigoProducto = codigoProducto
    AND (origen = 'CPA' OR origen = 'REC')
    AND tipo = 'EN'
    ORDER BY fecha DESC
    LIMIT 1;

    -- Establece valores predeterminados si son nulos
    costo := COALESCE(costo, 0);
    ultimoCosto := COALESCE(ultimoCosto, 0);

    -- Actualiza los costos en la tabla productos
    UPDATE productos
    SET costo = costo,
        ultimoCosto = ultimoCosto,
        ultimoProveedor = ultimoProveedor
    WHERE codigoProducto = codigoProducto;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recostear productos de una factura
CREATE OR REPLACE FUNCTION recosteoFactura(numero CHAR(8)) RETURNS VOID AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN (
        SELECT fr.codigoProducto
        FROM facturasRenglones fr
        INNER JOIN productos p ON fr.codigoProducto = p.codigoProducto
        WHERE fr.numero = numero
        AND fr.notaEntrega IS NULL
    ) LOOP
        PERFORM recosteo(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recostear productos de una factura TPV
CREATE OR REPLACE FUNCTION recosteoFacturaTpv(numero CHAR(8)) RETURNS VOID AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN (
        SELECT fr.codigoProducto
        FROM tpvFacturasRenglones fr
        INNER JOIN productos p ON fr.codigoProducto = p.codigoProducto
        WHERE fr.numero = numero
    ) LOOP
        PERFORM recosteo(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recostear todo el inventario
CREATE OR REPLACE FUNCTION recosteoInventario() RETURNS VOID AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN (
        SELECT p.codigoProducto
        FROM productos p
    ) LOOP
        PERFORM recosteoProducto(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recostear productos de una nota de entrega
CREATE OR REPLACE FUNCTION recosteoNotaEntrega(numero CHAR(8)) RETURNS VOID AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN (
        SELECT nr.codigoProducto
        FROM notasEntregaRenglones nr
        INNER JOIN productos p ON nr.codigoProducto = p.codigoProducto
        WHERE nr.numero = numero
    ) LOOP
        PERFORM recosteo(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento para recostear productos de una orden de producción
CREATE OR REPLACE FUNCTION recosteoProduccion(numero CHAR(8)) RETURNS VOID AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN (
        SELECT fr.codigoProducto
        FROM ordenesProduccionRenglones fr
        INNER JOIN productos p ON fr.codigoProducto = p.codigoProducto
        WHERE fr.numero = numero
    ) LOOP
        PERFORM recosteo(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedimiento: sp_analisis_cxp
CREATE OR REPLACE PROCEDURE sp_analisis_cxp(
    CodProDesde VARCHAR(20),
    CodProHasta VARCHAR(20),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCodigoProveedor VARCHAR(20);
    xNumero VARCHAR(8);
    xImporte NUMERIC;
    xFetch_Status INTEGER;
    xPorVencer NUMERIC := 0;
    x30dias NUMERIC := 0;
    x60dias NUMERIC := 0;
    x90dias NUMERIC := 0;
    x120dias NUMERIC := 0;
    x180dias NUMERIC := 0;
    xM180dias NUMERIC := 0;
    xDV NUMERIC := 0;
    query TEXT;
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS TmpAnalisisCXP;
    CREATE TEMP TABLE TmpAnalisisCXP (
        CodigoProveedor CHAR(20),
        Numero CHAR(12) NOT NULL,
        NumeroOrigen CHAR(8),
        Vencimiento TIMESTAMP,
        Importe NUMERIC,
        DV NUMERIC,
        PorVencer NUMERIC,
        V30dias NUMERIC,
        V60dias NUMERIC,
        V90dias NUMERIC,
        V120dias NUMERIC,
        V180dias NUMERIC,
        M180dias NUMERIC,
        Registro SERIAL PRIMARY KEY
    );

    -- Usar un cursor para iterar sobre los resultados de la consulta
    FOR xCodigoProveedor, xNumero, xImporte IN
        SELECT CodigoProveedor, Numero, SUM(Importe)
        FROM ProveedoresMovimientos
        WHERE CodigoProveedor BETWEEN CodProDesde AND CodProHasta
        AND Emision <= (TO_TIMESTAMP(FecHasta, 'DDMMYYYY') + INTERVAL '1 day')
        GROUP BY CodigoProveedor, Numero
    LOOP
        -- Reiniciar valores
        xPorVencer := 0;
        x30dias := 0;
        x60dias := 0;
        x90dias := 0;
        x120dias := 0;
        x180dias := 0;
        xM180dias := 0;

        IF xImporte <> 0 THEN
            INSERT INTO TmpAnalisisCXP (CodigoProveedor, Numero, Importe)
            VALUES (xCodigoProveedor, xNumero, xImporte);
        END IF;
    END LOOP;

    -- Actualizar la tabla temporal con los datos de vencimiento y origen
    UPDATE TmpAnalisisCXP
    SET Vencimiento = subquery.Vencimiento
    FROM (
        SELECT CodigoProveedor, Numero, MIN(Vencimiento) as Vencimiento
        FROM ProveedoresMovimientos
        GROUP BY CodigoProveedor, Numero
    ) subquery
    WHERE TmpAnalisisCXP.CodigoProveedor = subquery.CodigoProveedor
    AND TmpAnalisisCXP.Numero = subquery.Numero;

    UPDATE TmpAnalisisCXP
    SET NumeroOrigen = COALESCE((
        SELECT Referencia
        FROM Compras
        WHERE TmpAnalisisCXP.CodigoProveedor = Compras.CodigoProveedor
        AND TmpAnalisisCXP.Numero = Compras.Numero
    ), '0');

    -- Llamar al segundo procedimiento
    CALL sp_analisis_cxp_ii(FecHasta);
END;
$$;

-- Procedimiento: sp_analisis_cxp_ii
CREATE OR REPLACE PROCEDURE sp_analisis_cxp_ii(
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCodigoProveedor VARCHAR(20);
    xNumero VARCHAR(8);
    xVencimiento TIMESTAMP;
    xImporte NUMERIC;
    xDV INTEGER;
    xPorVencer NUMERIC := 0;
    x30dias NUMERIC := 0;
    x60dias NUMERIC := 0;
    x90dias NUMERIC := 0;
    x120dias NUMERIC := 0;
    x180dias NUMERIC := 0;
    xM180dias NUMERIC := 0;
BEGIN
    FOR xCodigoProveedor, xNumero, xVencimiento, xImporte, xDV IN
        SELECT CodigoProveedor, Numero, Vencimiento, Importe,
               (TO_TIMESTAMP(FecHasta, 'DDMMYYYY') + INTERVAL '1 day') - Vencimiento AS DiasV
        FROM TmpAnalisisCXP
    LOOP
        -- Reiniciar valores
        xPorVencer := 0;
        x30dias := 0;
        x60dias := 0;
        x90dias := 0;
        x120dias := 0;
        x180dias := 0;
        xM180dias := 0;

        IF xImporte <> 0 THEN
            IF xDV <= 0 THEN
                xPorVencer := xImporte;
            ELSIF xDV > 0 AND xDV <= 30 THEN
                x30dias := xImporte;
            ELSIF xDV > 30 AND xDV <= 60 THEN
                x60dias := xImporte;
            ELSIF xDV > 60 AND xDV <= 90 THEN
                x90dias := xImporte;
            ELSIF xDV > 90 AND xDV <= 120 THEN
                x120dias := xImporte;
            ELSIF xDV > 120 AND xDV <= 180 THEN
                x180dias := xImporte;
            ELSIF xDV > 180 THEN
                xM180dias := xImporte;
            END IF;

            -- Actualizar la tabla temporal
            UPDATE TmpAnalisisCXP
            SET
                DV = xDV,
                PorVencer = xPorVencer,
                V30Dias = x30dias,
                V60Dias = x60dias,
                V90Dias = x90dias,
                V120Dias = x120dias,
                V180Dias = x180dias,
                M180Dias = xM180dias
            WHERE
                CodigoProveedor = xCodigoProveedor AND Numero = xNumero;
        END IF;
    END LOOP;
END;
$$;

-- Procedimiento: sp_compras_retenciones
CREATE OR REPLACE PROCEDURE sp_compras_retenciones()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Llamar al primer procedimiento almacenado
    CALL sp_compras_retenciones_i();

    -- Llamar al segundo procedimiento almacenado
    CALL sp_compras_retenciones_ii();
END;
$$;

-- Procedimiento: sp_compras_retenciones_i
CREATE OR REPLACE PROCEDURE sp_compras_retenciones_i()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS tmpComprasRetenciones_I;

    CREATE TEMP TABLE tmpComprasRetenciones_I (
        Numero CHAR(8) NOT NULL,
        CodigoRetencion CHAR(15) NOT NULL,
        Ret_Iva NUMERIC,
        Ret_Islr NUMERIC
    );

    -- Inserción de registros de retenciones de IVA
    INSERT INTO tmpComprasRetenciones_I
    SELECT
        vistaRetenciones.numeroDocumento AS Numero,
        vistaRetenciones.codigoRetencion AS CodigoRetencion,
        vistaRetenciones.valorRetencion AS Ret_Iva,
        0 AS Ret_Islr
    FROM
        vistaRetenciones
    WHERE
        UPPER(vistaRetenciones.tipoImpuesto) = 'IVA';

    -- Inserción de registros de retenciones de IR
    INSERT INTO tmpComprasRetenciones_I
    SELECT
        vistaRetenciones.numeroDocumento AS Numero,
        vistaRetenciones.codigoRetencion AS CodigoRetencion,
        0 AS Ret_Iva,
        vistaRetenciones.valorRetencion AS Ret_Islr
    FROM
        vistaRetenciones
    WHERE
        UPPER(vistaRetenciones.tipoImpuesto) = 'IR';

    -- Inserción de registros con datos vacíos
    INSERT INTO tmpComprasRetenciones_I
    SELECT
        vistaRetenciones.numeroDocumento AS Numero,
        vistaRetenciones.codigoRetencion AS CodigoRetencion,
        0 AS Ret_Iva,
        0 AS Ret_Islr
    FROM
        vistaRetenciones
    WHERE
        UPPER(vistaRetenciones.tipoImpuesto) NOT IN ('IR', 'IVA');
END;
$$;

-- Procedimiento: sp_compras_retenciones_ii
CREATE OR REPLACE PROCEDURE sp_compras_retenciones_ii()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS tmpComprasRetenciones_II;

    CREATE TEMP TABLE tmpComprasRetenciones_II (
        Numero CHAR(8) NOT NULL,
        Ret_Iva NUMERIC,
        Ret_Islr NUMERIC
    );

    -- Inserción de registros de retenciones
    INSERT INTO tmpComprasRetenciones_II
    SELECT
        Numero,
        SUM(Ret_Iva) AS Ret_Iva,
        SUM(Ret_Islr) AS Ret_Islr
    FROM
        tmpComprasRetenciones_I
    GROUP BY
        Numero;
END;
$$;

-- Procedimiento: sp_conciliacion
CREATE OR REPLACE PROCEDURE sp_conciliacion(
    BcoDesde VARCHAR(30),
    BcoHasta VARCHAR(30),
    Fecha_Desde VARCHAR(12),
    Fecha_Hasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCodigoBanco VARCHAR(5);
    xNumero VARCHAR(12);
    xFecha TIMESTAMP;
    xTipo VARCHAR(2);
    xConcep VARCHAR(70);
    xImporte NUMERIC;
    xConcilia BOOLEAN;
    xManual BOOLEAN;
    xMes VARCHAR(2);
    xConci VARCHAR(10);
    xSaldo NUMERIC;
    xBeneficiario VARCHAR(50);
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS tmpConciliacion;
    CREATE TEMP TABLE tmpConciliacion (
        CodigoBanco CHAR(5) NOT NULL,
        Numero CHAR(12),
        Fecha TIMESTAMP NOT NULL,
        Tipo CHAR(2) NOT NULL,
        Concepto CHAR(70),
        Importe NUMERIC NOT NULL,
        Concilia BOOLEAN NOT NULL,
        Manual BOOLEAN NOT NULL,
        Mes CHAR(2) NOT NULL,
        Saldo NUMERIC,
        Conci CHAR(20),
        Beneficiario CHAR(50)
    );

    -- Calcular saldo
    SELECT SUM(importe) INTO xSaldo
    FROM BancosMovimientos
    WHERE fecha <= TO_TIMESTAMP(Fecha_Hasta, 'DDMMYYYY') + INTERVAL '1 day'
    AND tipo <> 'AN'
    AND codigoBanco = xCodigoBanco
    GROUP BY codigoBanco;

    -- Inserción de registros de SALDO A LA FECHA
    INSERT INTO tmpConciliacion
    SELECT
        xCodigoBanco,
        'S0001',
        TO_TIMESTAMP(Fecha_Hasta, 'DDMMYYYY'),
        'SA',
        'SALDO A LA FECHA',
        0,
        FALSE,
        FALSE,
        TO_CHAR(TO_TIMESTAMP(Fecha_Hasta, 'DDMMYYYY'), 'MM'),
        xSaldo,
        'SALDO',
        xBeneficiario;

    -- Inserción de registros ACTUALES
    INSERT INTO tmpConciliacion
    SELECT
        BancosConciliacionMovimientos.CodigoBanco,
        BancosConciliacionMovimientos.numero,
        BancosConciliacionMovimientos.fecha,
        BancosConciliacionMovimientos.tipo,
        BancosConciliacionMovimientos.concepto,
        BancosConciliacionMovimientos.importe,
        BancosConciliacionMovimientos.concilia,
        BancosConciliacionMovimientos.manual,
        BancosConciliacionMovimientos.mes,
        xSaldo,
        'ACTUAL',
        BancosMovimientos.Beneficiario
    FROM
        BancosConciliacionMovimientos
    INNER JOIN
        BancosMovimientos ON BancosConciliacionMovimientos.Numero = BancosMovimientos.Numero
    WHERE
        BancosMovimientos.Origen <> 'BAN'
        AND BancosConciliacionMovimientos.fecha >= TO_TIMESTAMP(Fecha_Desde, 'DDMMYYYY')
        AND BancosConciliacionMovimientos.fecha <= TO_TIMESTAMP(Fecha_Hasta, 'DDMMYYYY') + INTERVAL '1 day'
        AND BancosConciliacionMovimientos.concilia = FALSE;

    -- Inserción de registros ANTERIORES
    INSERT INTO tmpConciliacion
    SELECT
        BancosConciliacionMovimientos.CodigoBanco,
        BancosConciliacionMovimientos.numero,
        BancosConciliacionMovimientos.fecha,
        BancosConciliacionMovimientos.tipo,
        BancosConciliacionMovimientos.concepto,
        BancosConciliacionMovimientos.importe,
        BancosConciliacionMovimientos.concilia,
        BancosConciliacionMovimientos.manual,
        BancosConciliacionMovimientos.mes,
        xSaldo,
        'ANTERIOR',
        BancosMovimientos.Beneficiario
    FROM
        BancosConciliacionMovimientos
    INNER JOIN
        BancosMovimientos ON BancosConciliacionMovimientos.Numero = BancosMovimientos.Numero
    WHERE
        BancosMovimientos.Origen <> 'BAN'
        AND BancosConciliacionMovimientos.fecha < TO_TIMESTAMP(Fecha_Desde, 'DDMMYYYY')
        AND BancosConciliacionMovimientos.concilia = FALSE;

    -- Inserción de registros CONCILIADOS Y NO MOVIMIENTOS
    INSERT INTO tmpConciliacion
    SELECT
        BancosConciliacionMovimientos.CodigoBanco,
        BancosConciliacionMovimientos.numero,
        BancosConciliacionMovimientos.fecha,
        BancosConciliacionMovimientos.tipo,
        BancosConciliacionMovimientos.concepto,
        BancosConciliacionMovimientos.importe,
        BancosConciliacionMovimientos.concilia,
        BancosConciliacionMovimientos.manual,
        BancosConciliacionMovimientos.mes,
        xSaldo,
        '0NCB',
        BancosMovimientos.Beneficiario
    FROM
        BancosConciliacionMovimientos
    INNER JOIN
        BancosMovimientos ON BancosConciliacionMovimientos.Numero = BancosMovimientos.Numero
    WHERE
        BancosMovimientos.Origen <> 'BAN'
        AND BancosConciliacionMovimientos.fecha <= TO_TIMESTAMP(Fecha_Hasta, 'DDMMYYYY') + INTERVAL '1 day'
        AND BancosConciliacionMovimientos.concilia = FALSE
        AND BancosConciliacionMovimientos.manual = TRUE;
END;
$$;

-- Procedimiento: sp_cursor_saldo
CREATE OR REPLACE PROCEDURE sp_cursor_saldo(
    CtaDesde VARCHAR(30),
    CtaHasta VARCHAR(30),
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCta VARCHAR(30);
    xCta2 VARCHAR(30);
    xSaldoAnt NUMERIC;
    xDebe NUMERIC;
    xHaber NUMERIC;
    xConcep VARCHAR(70);
    xRef VARCHAR(20);
    xImporte NUMERIC;
    xSaldoAct NUMERIC;
    xFecha TIMESTAMP;
    xNumero VARCHAR(8);
    xReg INTEGER;
    xS NUMERIC;
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS TmpMayor;
    CREATE TEMP TABLE TmpMayor (
        Numero CHAR(8),
        Codigo CHAR(30) NOT NULL,
        Fecha TIMESTAMP NOT NULL,
        Referencia CHAR(20),
        Concepto CHAR(70),
        SaldoAnterior NUMERIC,
        Debitos NUMERIC,
        Creditos NUMERIC,
        SaldoActual NUMERIC,
        Registro INTEGER
    );

    -- Inicializar variables
    xSaldoAct := 0;
    xHaber := 0;
    xSaldoAnt := 0;

    -- Iterar sobre los resultados de la consulta
    FOR xNumero, xCta, xFecha, xRef, xConcep, xDebe, xHaber, xReg IN
        SELECT
            numero,
            codigoContable,
            fecha,
            referencia,
            concepto,
            CASE WHEN importe > 0 THEN importe ELSE 0 END AS debe,
            CASE WHEN importe < 0 THEN importe ELSE 0 END AS haber,
            registro
        FROM
            contabilidadAsientosRenglones
        WHERE
            codigoContable BETWEEN CtaDesde AND CtaHasta
            AND fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY') - INTERVAL '1 day'
            AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY')
        ORDER BY
            codigoContable, fecha, registro
    LOOP
        -- Calcular saldo anterior si la cuenta cambia
        IF xCta <> xCta2 THEN
            SELECT SUM(importe) INTO xSaldoAnt
            FROM contabilidadAsientosRenglones
            WHERE fecha < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND codigoContable = xCta
            GROUP BY codigoContable;

            xSaldoAnt := COALESCE(xSaldoAnt, 0);
            xCta2 := xCta;
            xSaldoAct := xSaldoAnt;
        END IF;

        -- Calcular saldo actual
        xSaldoAct := xSaldoAct + xDebe + xHaber;

        -- Insertar en la tabla temporal
        INSERT INTO TmpMayor (numero, codigo, fecha, referencia, concepto, saldoAnterior, debitos, creditos, saldoActual, registro)
        VALUES (xNumero, xCta, xFecha, xRef, xConcep, xSaldoAnt, xDebe, xHaber, xSaldoAct, xReg);
    END LOOP;
END;
$$;

-- Procedimiento: sp_edo_cta_banco
CREATE OR REPLACE PROCEDURE sp_edo_cta_banco(
    BcoDesde VARCHAR(30),
    BcoHasta VARCHAR(30),
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCodigoBanco VARCHAR(5);
    xCta2 VARCHAR(5);
    xSaldoAnt NUMERIC;
    xImporte NUMERIC;
    xConcep VARCHAR(70);
    xTipo VARCHAR(2);
    xOrigen VARCHAR(3);
    xBeneficiario VARCHAR(50);
    xSaldoAct NUMERIC;
    xFecha TIMESTAMP;
    xNumero VARCHAR(12);
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS TmpEdoCtaBanco;
    CREATE TEMP TABLE TmpEdoCtaBanco (
        CodigoBanco CHAR(5),
        Fecha TIMESTAMP NOT NULL,
        Tipo CHAR(2),
        Numero CHAR(12) NOT NULL,
        Concepto VARCHAR(70),
        Importe NUMERIC,
        Origen CHAR(3),
        Beneficiario VARCHAR(50),
        SaldoAnterior NUMERIC,
        SaldoActual NUMERIC,
        Registro SERIAL PRIMARY KEY
    );

    -- Inicializar variables
    xSaldoAct := 0;
    xSaldoAnt := 0;

    -- Iterar sobre los resultados de la consulta
    FOR xCodigoBanco, xFecha, xTipo, xNumero, xConcep, xImporte, xOrigen, xBeneficiario IN
        SELECT
            CodigoBanco,
            Fecha,
            Tipo,
            Numero,
            Concepto,
            Importe,
            Origen,
            Beneficiario
        FROM
            BancosMovimientos
        WHERE
            CodigoBanco BETWEEN BcoDesde AND BcoHasta
            AND Fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY') + INTERVAL '1 day'
        ORDER BY
            CodigoBanco, Fecha
    LOOP
        -- Calcular saldo anterior si el código de banco cambia
        IF xCodigoBanco <> xCta2 THEN
            SELECT COALESCE(SUM(Importe), 0) INTO xSaldoAnt
            FROM BancosMovimientos
            WHERE Fecha < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND Tipo <> 'AN'
            AND CodigoBanco = xCodigoBanco
            GROUP BY CodigoBanco;

            xCta2 := xCodigoBanco;
            xSaldoAct := xSaldoAnt;
        END IF;

        -- Actualizar saldo actual si el tipo no es 'AN'
        IF xTipo <> 'AN' THEN
            xSaldoAct := xSaldoAct + xImporte;
        END IF;

        -- Insertar en la tabla temporal
        INSERT INTO TmpEdoCtaBanco (CodigoBanco, Fecha, Tipo, Numero, Concepto, Importe, Origen, Beneficiario, SaldoAnterior, SaldoActual)
        VALUES (xCodigoBanco, xFecha, xTipo, xNumero, xConcep, xImporte, xOrigen, xBeneficiario, xSaldoAnt, xSaldoAct);
    END LOOP;
END;
$$;

-- Procedimiento: sp_edo_cta_cliente
CREATE OR REPLACE PROCEDURE sp_edo_cta_cliente(
    CodCliDesde VARCHAR(20),
    CodCliHasta VARCHAR(20),
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCodigoCliente VARCHAR(20);
    xCta2 VARCHAR(5);
    xSaldoAnt NUMERIC;
    xImporte NUMERIC;
    xConcepto VARCHAR(30);
    xTipo VARCHAR(2);
    xOrigen VARCHAR(3);
    xSaldoAct NUMERIC;
    xEmision TIMESTAMP;
    xVencimiento TIMESTAMP;
    xNumero VARCHAR(8);
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS TmpEdoCtaCliente;
    CREATE TEMP TABLE TmpEdoCtaCliente (
        CodigoCliente CHAR(20),
        Tipo CHAR(2),
        Emision TIMESTAMP NOT NULL,
        Vencimiento TIMESTAMP NOT NULL,
        Numero CHAR(12) NOT NULL,
        Concepto VARCHAR(30),
        Importe NUMERIC,
        Origen CHAR(3),
        SaldoAnterior NUMERIC,
        SaldoActual NUMERIC,
        Registro SERIAL PRIMARY KEY
    );

    -- Inicializar variables
    xSaldoAct := 0;
    xSaldoAnt := 0;

    -- Iterar sobre los resultados de la consulta
    FOR xCodigoCliente, xTipo, xEmision, xVencimiento, xNumero, xConcepto, xImporte, xOrigen IN
        SELECT
            CodigoCliente,
            Tipo,
            Emision,
            Vencimiento,
            Numero,
            Concepto,
            Importe,
            Origen
        FROM
            ClientesMovimientos
        WHERE
            CodigoCliente BETWEEN CodCliDesde AND CodCliHasta
            AND Emision BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY') + INTERVAL '1 day'
        ORDER BY
            CodigoCliente, Emision
    LOOP
        -- Calcular saldo anterior si el código de cliente cambia
        IF xCodigoCliente <> xCta2 THEN
            SELECT COALESCE(SUM(Importe), 0) INTO xSaldoAnt
            FROM ClientesMovimientos
            WHERE Emision < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND CodigoCliente = xCodigoCliente
            GROUP BY CodigoCliente;

            xCta2 := xCodigoCliente;
            xSaldoAct := xSaldoAnt;
        END IF;

        -- Actualizar saldo actual
        xSaldoAct := xSaldoAct + xImporte;

        -- Insertar en la tabla temporal
        INSERT INTO TmpEdoCtaCliente (CodigoCliente, Tipo, Emision, Vencimiento, Numero, Concepto, Importe, Origen, SaldoAnterior, SaldoActual)
        VALUES (xCodigoCliente, xTipo, xEmision, xVencimiento, xNumero, xConcepto, xImporte, xOrigen, xSaldoAnt, xSaldoAct);
    END LOOP;
END;
$$;

-- Procedimiento: sp_edo_cta_proveedor
CREATE OR REPLACE PROCEDURE sp_edo_cta_proveedor(
    CodProDesde VARCHAR(20),
    CodProHasta VARCHAR(20),
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    xCodigoProveedor VARCHAR(20);
    xCta2 VARCHAR(20);
    xSaldoAnt NUMERIC;
    xImporte NUMERIC;
    xConcepto VARCHAR(30);
    xTipo VARCHAR(2);
    xOrigen VARCHAR(3);
    xSaldoAct NUMERIC;
    xEmision TIMESTAMP;
    xVencimiento TIMESTAMP;
    xNumero VARCHAR(8);
    xNumeroOrigen VARCHAR(8);
    xComprobante VARCHAR(8);
    xReferencia VARCHAR(20);
    xRet_Islr NUMERIC;
BEGIN
    -- Llamar a otros procedimientos almacenados
    CALL sp_compras_retenciones_i();
    CALL sp_compras_retenciones_ii();

    -- Crear tabla temporal
    DROP TABLE IF EXISTS TmpEdoCtaProveedor;
    CREATE TEMP TABLE TmpEdoCtaProveedor (
        CodigoProveedor CHAR(20),
        Tipo CHAR(2),
        Emision TIMESTAMP NOT NULL,
        Vencimiento TIMESTAMP NOT NULL,
        Numero CHAR(12) NOT NULL,
        NumeroOrigen CHAR(12) NOT NULL,
        Comprobante CHAR(12) NOT NULL,
        Referencia CHAR(20) NOT NULL,
        Concepto VARCHAR(30),
        Importe NUMERIC,
        Origen CHAR(3),
        SaldoAnterior NUMERIC,
        SaldoActual NUMERIC,
        Registro SERIAL PRIMARY KEY
    );

    -- Inicializar variables
    xSaldoAct := 0;
    xSaldoAnt := 0;

    -- Iterar sobre los resultados de la consulta
    FOR xCodigoProveedor, xTipo, xEmision, xVencimiento, xNumero, xNumeroOrigen, xComprobante, xReferencia, xConcepto, xImporte, xOrigen IN
        SELECT
            CodigoProveedor,
            Tipo,
            Emision,
            Vencimiento,
            Numero,
            NumeroOrigen,
            Comprobante,
            Referencia,
            Concepto,
            Importe,
            Origen
        FROM
            ProveedoresMovimientos
        WHERE
            CodigoProveedor BETWEEN CodProDesde AND CodProHasta
            AND Emision BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY') + INTERVAL '1 day'
        ORDER BY
            CodigoProveedor, Emision
    LOOP
        -- Calcular saldo anterior si el código de proveedor cambia
        IF xCodigoProveedor <> xCta2 THEN
            SELECT COALESCE(SUM(Importe), 0) INTO xSaldoAnt
            FROM ProveedoresMovimientos
            WHERE Emision < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
            AND CodigoProveedor = xCodigoProveedor
            GROUP BY CodigoProveedor, Emision;

            xCta2 := xCodigoProveedor;
            xSaldoAct := xSaldoAnt;
        END IF;

        -- Lógica para diferentes tipos y orígenes
        IF xTipo <> 'FC' AND xOrigen <> 'CPA' THEN
            xSaldoAnt := xSaldoAct;
            xSaldoAct := xSaldoAct + xImporte;
            INSERT INTO TmpEdoCtaProveedor (CodigoProveedor, Tipo, Emision, Vencimiento, Numero, NumeroOrigen, Comprobante, Referencia, Concepto, Importe, Origen, SaldoAnterior, SaldoActual)
            VALUES (xCodigoProveedor, xTipo, xEmision, xVencimiento, xNumero, xNumeroOrigen, COALESCE(xComprobante, '0'), xReferencia, xConcepto, xImporte, xOrigen, xSaldoAnt, xSaldoAct);
        END IF;

        IF xTipo = 'FC' AND xOrigen = 'CPA' THEN
            -- Ajustar importe con retención ISLR
            xImporte := xImporte + ABS(COALESCE((SELECT Ret_Islr FROM TmpComprasRetenciones_II WHERE Numero = xNumero), 0));
            xSaldoAnt := xSaldoAct;
            xSaldoAct := xSaldoAct + xImporte;
            INSERT INTO TmpEdoCtaProveedor (CodigoProveedor, Tipo, Emision, Vencimiento, Numero, NumeroOrigen, Comprobante, Referencia, Concepto, Importe, Origen, SaldoAnterior, SaldoActual)
            VALUES (xCodigoProveedor, xTipo, xEmision, xVencimiento, xNumero, xNumeroOrigen, COALESCE(xComprobante, '0'), xReferencia, xConcepto, xImporte, xOrigen, xSaldoAnt, xSaldoAct);

            xImporte := 0;
            xImporte := COALESCE((SELECT Ret_Islr FROM TmpComprasRetenciones_II WHERE Numero = xNumero), 0);
            xSaldoAnt := xSaldoAct;
            xSaldoAct := xSaldoAct + xImporte;

            IF xImporte <> 0 THEN
                INSERT INTO TmpEdoCtaProveedor (CodigoProveedor, Tipo, Emision, Vencimiento, Numero, NumeroOrigen, Comprobante, Referencia, Concepto, Importe, Origen, SaldoAnterior, SaldoActual)
                VALUES (xCodigoProveedor, 'NC', xEmision, xVencimiento, xNumero, xNumeroOrigen, COALESCE(xComprobante, '0'), xReferencia, 'Retención ISLR', xImporte, xOrigen, xSaldoAnt, xSaldoAct);
            END IF;
        END IF;
    END LOOP;
END;
$$;

-- Procedimiento: sp_libro_compras
CREATE OR REPLACE PROCEDURE sp_libro_compras(
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS tmpCompras;
    CREATE TEMP TABLE tmpCompras (
        Numero CHAR(8) NOT NULL,
        Referencia CHAR(20),
        ReferenciaControl CHAR(20),
        FechaEmision TIMESTAMP NOT NULL,
        FechaRegistro TIMESTAMP NOT NULL,
        Vencimiento TIMESTAMP,
        CodigoProveedor CHAR(20),
        TotalBruto NUMERIC,
        Descuento NUMERIC,
        Impuesto NUMERIC,
        Cargo NUMERIC,
        TotalCompra NUMERIC,
        PorcentajeDescuento NUMERIC,
        Transportista CHAR(5),
        Comentarios CHAR(100),
        Almacen CHAR(5),
        TipoPago CHAR(1),
        Peso NUMERIC,
        DevolucionCompra CHAR(8),
        ReferenciaContable CHAR(30),
        CodigoCaja CHAR(5),
        GiroAno FLOAT,
        GiroCuota FLOAT,
        GiroSerie CHAR(3),
        GiroInteres FLOAT,
        CentroCosto CHAR(20),
        Almacen1 CHAR(5),
        CodigoProducto CHAR(50),
        Descripcion CHAR(50),
        UnidadMedida CHAR(12),
        Iva CHAR(1),
        PorcentajeIva NUMERIC,
        Bultos FLOAT,
        Cantidad NUMERIC,
        Precio NUMERIC,
        DescuentoRenglon NUMERIC,
        TotalRenglon NUMERIC,
        OrdenCompra CHAR(8),
        Recepcion CHAR(8),
        Registro INTEGER NOT NULL,
        CodigoContable CHAR(30),
        CodigoPresupuesto CHAR(30),
        CentroCosto2 CHAR(20),
        TotalComprasIva NUMERIC,
        ComprasSinIva NUMERIC,
        BaseImponible NUMERIC,
        ImpuestoIva NUMERIC,
        Ajuste CHAR(2),
        RetencionIva NUMERIC
    );

    -- Pagos en Caja de Compras Libro de AJUSTE
    INSERT INTO tmpCompras
    SELECT
        Compras.Numero,
        Compras.Referencia,
        Compras.ReferenciaControl,
        Compras.FechaEmision,
        Compras.FechaRegistro,
        Compras.Vencimiento,
        Compras.CodigoProveedor,
        Compras.TotalBruto,
        Compras.Descuento,
        Compras.Impuesto,
        Compras.Cargo,
        Compras.TotalCompra,
        Compras.PorcentajeDescuento,
        Compras.Transportista,
        SUBSTRING(Compras.Comentarios FROM 1 FOR 100),
        Compras.Almacen,
        Compras.TipoPago,
        Compras.Peso,
        Compras.DevolucionCompra,
        Compras.ReferenciaContable,
        Compras.CodigoCaja,
        Compras.GiroAno,
        Compras.GiroCuota,
        Compras.GiroSerie,
        Compras.GiroInteres,
        Compras.CentroCosto,
        ComprasRenglones.Almacen,
        ComprasRenglones.CodigoProducto,
        ComprasRenglones.Descripcion,
        ComprasRenglones.UnidadMedida,
        ComprasRenglones.iva,
        ComprasRenglones.PorcentajeIva,
        ComprasRenglones.Bultos,
        ComprasRenglones.Cantidad,
        ComprasRenglones.Precio,
        ComprasRenglones.Descuento,
        ComprasRenglones.TotalRenglon,
        ComprasRenglones.OrdenCompra,
        ComprasRenglones.Recepcion,
        1,
        ComprasRenglones.CodigoContable,
        ComprasRenglones.CodigoPresupuesto,
        ComprasRenglones.CentroCosto,
        0,
        0,
        0,
        0,
        'SI',
        0
    FROM
        ComprasRenglones
    INNER JOIN
        Compras ON ComprasRenglones.Numero = Compras.Numero
    WHERE
        Compras.Numero NOT IN (SELECT numero FROM ComprasRenglones WHERE CodigoProducto = '*D')
        AND TO_CHAR(Compras.FechaRegistro, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta
        AND EXTRACT(MONTH FROM Compras.FechaEmision) <> EXTRACT(MONTH FROM Compras.FechaRegistro);

    -- Pagos en Caja de Compras
    INSERT INTO tmpCompras
    SELECT
        Compras.Numero,
        Compras.Referencia,
        Compras.ReferenciaControl,
        Compras.FechaEmision,
        Compras.FechaRegistro,
        Compras.Vencimiento,
        Compras.CodigoProveedor,
        Compras.TotalBruto,
        Compras.Descuento,
        Compras.Impuesto,
        Compras.Cargo,
        Compras.TotalCompra,
        Compras.PorcentajeDescuento,
        Compras.Transportista,
        SUBSTRING(Compras.Comentarios FROM 1 FOR 100),
        Compras.Almacen,
        Compras.TipoPago,
        Compras.Peso,
        Compras.DevolucionCompra,
        Compras.ReferenciaContable,
        Compras.CodigoCaja,
        Compras.GiroAno,
        Compras.GiroCuota,
        Compras.GiroSerie,
        Compras.GiroInteres,
        Compras.CentroCosto,
        ComprasRenglones.Almacen,
        ComprasRenglones.CodigoProducto,
        ComprasRenglones.Descripcion,
        ComprasRenglones.UnidadMedida,
        ComprasRenglones.iva,
        ComprasRenglones.PorcentajeIva,
        ComprasRenglones.Bultos,
        ComprasRenglones.Cantidad,
        ComprasRenglones.Precio,
        ComprasRenglones.Descuento,
        ComprasRenglones.TotalRenglon,
        ComprasRenglones.OrdenCompra,
        ComprasRenglones.Recepcion,
        1,
        ComprasRenglones.CodigoContable,
        ComprasRenglones.CodigoPresupuesto,
        ComprasRenglones.CentroCosto,
        0,
        0,
        0,
        0,
        'NO',
        0
    FROM
        ComprasRenglones
    INNER JOIN
        Compras ON ComprasRenglones.Numero = Compras.Numero
    WHERE
        Compras.Numero NOT IN (SELECT numero FROM ComprasRenglones WHERE CodigoProducto = '*D')
        AND TO_CHAR(Compras.FechaRegistro, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta
        AND EXTRACT(MONTH FROM Compras.FechaEmision) = EXTRACT(MONTH FROM Compras.FechaRegistro);

    -- NC No retencion IVA
    INSERT INTO tmpCompras
    SELECT
        Tipo || RIGHT(Numero, 6),
        Numero,
        Referencia,
        Emision,
        Emision,
        Vencimiento,
        codigoProveedor,
        Importe / 1.15,
        0,
        Importe - (Importe / 1.15),
        0,
        Importe,
        0,
        '',
        '',
        '',
        '',
        0,
        '',
        ReferenciaContable,
        '',
        0,
        0,
        0,
        0,
        CentroCosto,
        '',
        '*PP',
        Concepto,
        '',
        'A',
        15,
        0,
        0,
        0,
        0,
        0,
        Importe / 1.15,
        '',
        '',
        1,
        ReferenciaContable,
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0
    FROM
        ProveedoresMovimientos
    WHERE
        Tipo = 'NC' AND Origen = 'CXP'
        AND (Origen = 'cxp')
        AND TO_CHAR(Emision, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta;

    -- Pagos en banco de datos de compras con renglones para Libro de AJUSTE
    INSERT INTO tmpCompras
    SELECT
        Compras.Numero,
        Compras.Referencia,
        Compras.ReferenciaControl,
        Compras.FechaEmision,
        Compras.FechaRegistro,
        Compras.Vencimiento,
        Compras.CodigoProveedor,
        Compras.TotalBruto,
        Compras.Descuento,
        Compras.Impuesto,
        Compras.Cargo,
        Compras.TotalBruto,
        Compras.PorcentajeDescuento,
        Compras.Transportista,
        SUBSTRING(Compras.Comentarios FROM 1 FOR 100),
        Compras.Almacen,
        Compras.TipoPago,
        Compras.Peso,
        Compras.DevolucionCompra,
        Compras.ReferenciaContable,
        Compras.CodigoCaja,
        Compras.GiroAno,
        Compras.GiroCuota,
        Compras.GiroSerie,
        Compras.GiroInteres,
        Compras.CentroCosto,
        ComprasRenglones.Almacen,
        ComprasRenglones.CodigoProducto,
        ComprasRenglones.Descripcion,
        ComprasRenglones.UnidadMedida,
        ComprasRenglones.iva,
        ComprasRenglones.PorcentajeIva,
        ComprasRenglones.Bultos,
        ComprasRenglones.Cantidad,
        ComprasRenglones.Precio,
        ComprasRenglones.Descuento,
        ComprasRenglones.TotalRenglon,
        ComprasRenglones.OrdenCompra,
        ComprasRenglones.Recepcion,
        1,
        ComprasRenglones.CodigoContable,
        ComprasRenglones.CodigoPresupuesto,
        ComprasRenglones.CentroCosto,
        0,
        0,
        0,
        0,
        'SI',
        0
    FROM
        ComprasRenglones
    INNER JOIN
        Compras ON ComprasRenglones.Numero = Compras.Numero
    WHERE
        Compras.Numero IN (SELECT numero FROM ComprasRenglones WHERE CodigoProducto = '*D')
        AND TO_CHAR(Compras.FechaRegistro, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta
        AND EXTRACT(MONTH FROM Compras.FechaEmision) <> EXTRACT(MONTH FROM Compras.FechaRegistro);

    -- Pagos en banco de datos de compras con renglones para Libro
    INSERT INTO tmpCompras
    SELECT
        Compras.Numero,
        Compras.Referencia,
        Compras.ReferenciaControl,
        Compras.FechaEmision,
        Compras.FechaRegistro,
        Compras.Vencimiento,
        Compras.CodigoProveedor,
        Compras.TotalBruto,
        Compras.Descuento,
        Compras.Impuesto,
        Compras.Cargo,
        Compras.TotalBruto,
        Compras.PorcentajeDescuento,
        Compras.Transportista,
        SUBSTRING(Compras.Comentarios FROM 1 FOR 100),
        Compras.Almacen,
        Compras.TipoPago,
        Compras.Peso,
        Compras.DevolucionCompra,
        Compras.ReferenciaContable,
        Compras.CodigoCaja,
        Compras.GiroAno,
        Compras.GiroCuota,
        Compras.GiroSerie,
        Compras.GiroInteres,
        Compras.CentroCosto,
        ComprasRenglones.Almacen,
        ComprasRenglones.CodigoProducto,
        ComprasRenglones.Descripcion,
        ComprasRenglones.UnidadMedida,
        ComprasRenglones.iva,
        ComprasRenglones.PorcentajeIva,
        ComprasRenglones.Bultos,
        ComprasRenglones.Cantidad,
        ComprasRenglones.Precio,
        ComprasRenglones.Descuento,
        ComprasRenglones.TotalRenglon,
        ComprasRenglones.OrdenCompra,
        ComprasRenglones.Recepcion,
        1,
        ComprasRenglones.CodigoContable,
        ComprasRenglones.CodigoPresupuesto,
        ComprasRenglones.CentroCosto,
        0,
        0,
        0,
        0,
        'NO',
        0
    FROM
        ComprasRenglones
    INNER JOIN
        Compras ON ComprasRenglones.Numero = Compras.Numero
    WHERE
        Compras.Numero IN (SELECT numero FROM ComprasRenglones WHERE CodigoProducto = '*D')
        AND TO_CHAR(Compras.FechaRegistro, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta
        AND EXTRACT(MONTH FROM Compras.FechaEmision) = EXTRACT(MONTH FROM Compras.FechaRegistro);
END;
$$;

-- Procedimiento: sp_libro_compras1
CREATE OR REPLACE PROCEDURE sp_libro_compras1(
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    Numero CHAR(8);
    FechaEmision TIMESTAMP;
    TotalRenglon NUMERIC;
    CodigoProveedor CHAR(20);
    TotalCompra NUMERIC;
    Referencia CHAR(20);
    ReferenciaControl CHAR(20);
    Impuesto NUMERIC;
    PorcentajeIva NUMERIC;
    Nombre CHAR(250);
    Codigorete CHAR(5);
    Porcentaje NUMERIC;
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS tmpCompras;
    CREATE TEMP TABLE tmpCompras (
        Numero CHAR(8) NOT NULL,
        Referencia CHAR(20),
        ReferenciaControl CHAR(20),
        FechaEmision TIMESTAMP NOT NULL,
        FechaRegistro TIMESTAMP,
        Vencimiento TIMESTAMP,
        CodigoProveedor CHAR(20),
        Proveedor VARCHAR(50),
        Rif CHAR(22),
        TotalBruto NUMERIC,
        Descuento NUMERIC,
        Impuesto NUMERIC,
        Cargo NUMERIC,
        TotalCompra NUMERIC,
        PorcentajeDescuento NUMERIC,
        Transportista CHAR(5),
        Comentarios CHAR(100),
        Almacen CHAR(5),
        TipoPago CHAR(1),
        Peso NUMERIC,
        DevolucionCompra CHAR(8),
        ReferenciaContable CHAR(30),
        CodigoCaja CHAR(5),
        GiroAno FLOAT,
        GiroCuota FLOAT,
        GiroSerie CHAR(3),
        GiroInteres FLOAT,
        CentroCosto CHAR(20),
        Almacen1 CHAR(5),
        CodigoProducto CHAR(15),
        Descripcion CHAR(50),
        UnidadMedida CHAR(12),
        Iva CHAR(1),
        PorcentajeIva NUMERIC,
        Bultos FLOAT,
        Cantidad NUMERIC,
        Precio NUMERIC,
        DescuentoRenglon NUMERIC,
        TotalRenglon NUMERIC,
        OrdenCompra CHAR(8),
        Recepcion CHAR(8),
        Registro INTEGER NOT NULL,
        CodigoContable CHAR(30),
        CodigoPresupuesto CHAR(30),
        CentroCosto2 CHAR(20),
        TotalComprasIva NUMERIC,
        ComprasSinIva NUMERIC,
        BaseImponible NUMERIC,
        ImpuestoIva NUMERIC,
        Ajuste CHAR(2),
        RetencionIva NUMERIC,
        Valor NUMERIC,
        NombreRet CHAR(250),
        Codigorete CHAR(5),
        PorcentajeRet NUMERIC
    );

    -- Inserción de registros de compras para Libro de AJUSTE
    INSERT INTO tmpCompras
    SELECT
        Compras.Numero,
        Compras.Referencia,
        Compras.ReferenciaControl,
        Compras.FechaEmision,
        Compras.FechaRegistro,
        Compras.Vencimiento,
        Proveedores.CodigoProveedor,
        Proveedores.Nombre,
        Proveedores.Rif,
        Compras.TotalBruto,
        Compras.Descuento,
        Compras.Impuesto,
        Compras.Cargo,
        Compras.TotalCompra,
        Compras.PorcentajeDescuento,
        Compras.Transportista,
        SUBSTRING(Compras.Comentarios FROM 1 FOR 100),
        Compras.Almacen,
        Compras.TipoPago,
        Compras.Peso,
        Compras.DevolucionCompra,
        Compras.ReferenciaContable,
        Compras.CodigoCaja,
        Compras.GiroAno,
        Compras.GiroCuota,
        Compras.GiroSerie,
        Compras.GiroInteres,
        Compras.CentroCosto,
        ComprasRenglones.Almacen,
        ComprasRenglones.CodigoProducto,
        ComprasRenglones.Descripcion,
        ComprasRenglones.UnidadMedida,
        ComprasRenglones.Iva,
        ComprasRenglones.PorcentajeIva,
        ComprasRenglones.Bultos,
        ComprasRenglones.Cantidad,
        ComprasRenglones.Precio,
        ComprasRenglones.Descuento,
        ComprasRenglones.TotalRenglon,
        ComprasRenglones.OrdenCompra,
        ComprasRenglones.Recepcion,
        1,
        ComprasRenglones.CodigoContable,
        ComprasRenglones.CodigoPresupuesto,
        ComprasRenglones.CentroCosto,
        0,
        0,
        0,
        0,
        'SI',
        0,
        0,
        '',
        '',
        Compras.Tipo,
        Compras.Tpro,
        Compras.Autor,
        Compras.Establo,
        Compras.Emision,
        Compras.Secuencia,
        NULL
    FROM
        ComprasRenglones
    INNER JOIN
        Compras ON ComprasRenglones.Numero = Compras.Numero
    INNER JOIN
        Proveedores ON Compras.CodigoProveedor = Proveedores.CodigoProveedor
    WHERE
        Compras.Numero NOT IN (SELECT numero FROM ComprasRenglones WHERE CodigoProducto = '*D')
        AND TO_CHAR(Compras.FechaEmision, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta;

    -- Inserción de registros NC No retención IVA
    INSERT INTO tmpCompras
    SELECT
        Tipo || RIGHT(Numero, 6),
        Numero,
        Referencia,
        Emision,
        Emision,
        Vencimiento,
        Proveedores.CodigoProveedor,
        Proveedores.Nombre,
        Proveedores.Rif,
        Importe / 1.15,
        0,
        Importe - (Importe / 1.15),
        0,
        Importe,
        0,
        '',
        '',
        '',
        '',
        0,
        '',
        ReferenciaContable,
        '',
        0,
        0,
        0,
        0,
        CentroCosto,
        '',
        '*PP',
        Concepto,
        '',
        'A',
        15,
        0,
        0,
        0,
        0,
        0,
        Importe / 1.15,
        '',
        '',
        1,
        ReferenciaContable,
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL
    FROM
        ProveedoresMovimientos
    INNER JOIN
        Proveedores ON ProveedoresMovimientos.CodigoProveedor = Proveedores.CodigoProveedor
    WHERE
        Tipo = 'NC' AND Origen = 'CXP'
        AND TO_CHAR(Emision, 'YYYYMMDD') BETWEEN FecDesde AND FecHasta;

    -- Inserción de registros de retenciones de IVA
    FOR Numero, TotalRenglon, FechaEmision, CodigoProveedor, TotalCompra, Referencia, ReferenciaControl, Impuesto, PorcentajeIva, Nombre, Codigorete, Porcentaje IN
        SELECT
            NumeroDocumento,
            SUM(ValorRetencion),
            Fecha,
            Compras.CodigoProveedor,
            Compras.TotalCompra,
            Compras.Referencia,
            Compras.ReferenciaControl,
            Compras.Impuesto,
            ComprasRenglones.PorcentajeIva,
            Retenciones.Concepto,
            Retenciones.CodigoRetencion,
            Retenciones.Porcentaje
        FROM
            Retenciones
        INNER JOIN
            Compras ON Retenciones.NumeroDocumento = Compras.Numero
        INNER JOIN
            ComprasRenglones ON Compras.Numero = ComprasRenglones.Numero
        WHERE
            Fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY') AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY')
            AND TipoImpuesto = 'IVA'
        GROUP BY
            NumeroDocumento, Fecha, Compras.CodigoProveedor, Compras.TotalCompra, Compras.Referencia, Compras.ReferenciaControl, Compras.Impuesto, ComprasRenglones.PorcentajeIva, Retenciones.Concepto, Retenciones.CodigoRetencion, Retenciones.Porcentaje
    LOOP
        INSERT INTO tmpCompras (
            Numero, Referencia, ReferenciaControl, FechaEmision, FechaRegistro, Vencimiento,
            CodigoProveedor, TotalBruto, Descuento, Impuesto, Cargo, TotalCompra, PorcentajeDescuento,
            Transportista, Comentarios, Almacen, TipoPago, Peso, DevolucionCompra, ReferenciaContable,
            CodigoCaja, GiroAno, GiroCuota, GiroSerie, GiroInteres, CentroCosto, Almacen1, CodigoProducto,
            Descripcion, UnidadMedida, Iva, PorcentajeIva, Bultos, Cantidad, Precio, DescuentoRenglon,
            TotalRenglon, OrdenCompra, Recepcion, Registro, CodigoContable, CodigoPresupuesto,
            CentroCosto2, TotalComprasIva, ComprasSinIva, BaseImponible, ImpuestoIva, Ajuste, RetencionIva,
            Valor, NombreRet, Codigorete, PorcentajeRet
        )
        VALUES (
            Numero, Referencia, ReferenciaControl, FechaEmision, NULL, NULL, CodigoProveedor, 0, 0, Impuesto, 0, TotalCompra, 0, '', '', '', '', 0, '', ReferenciaContable, '', 0, 0, 0, 0, '', '', '(Ret)-IVA', '', '', '', PorcentajeIva, 0, 0, 0, 0, 0, '', '', 1, '', '', '', 0, 0, 0, 0, '', 0, TotalRenglon, Nombre, Codigorete, Porcentaje
        );
    END LOOP;

    -- Inserción de registros de retenciones de RET
    FOR Numero, TotalRenglon, FechaEmision, CodigoProveedor, TotalCompra, Referencia, ReferenciaControl, Impuesto, PorcentajeIva, Nombre, Codigorete, Porcentaje IN
        SELECT
            NumeroDocumento,
            SUM(ValorRetencion),
            Fecha,
            Compras.CodigoProveedor,
            Compras.TotalCompra,
            Compras.Referencia,
            Compras.ReferenciaControl,
            Compras.Impuesto,
            ComprasRenglones.PorcentajeIva,
            Retenciones.Concepto,
            Retenciones.CodigoRetencion,
            Retenciones.Porcentaje
        FROM
            Retenciones
        INNER JOIN
            Compras ON Retenciones.NumeroDocumento = Compras.Numero
        INNER JOIN
            ComprasRenglones ON Compras.Numero = ComprasRenglones.Numero
        WHERE
            Fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY') AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY')
            AND TipoImpuesto = 'RET'
        GROUP BY
            NumeroDocumento, Fecha, Compras.CodigoProveedor, Compras.TotalCompra, Compras.Referencia, Compras.ReferenciaControl, Compras.Impuesto, ComprasRenglones.PorcentajeIva, Retenciones.Concepto, Retenciones.CodigoRetencion, Retenciones.Porcentaje
    LOOP
        INSERT INTO tmpCompras (
            Numero, Referencia, ReferenciaControl, FechaEmision, FechaRegistro, Vencimiento,
            CodigoProveedor, TotalBruto, Descuento, Impuesto, Cargo, TotalCompra, PorcentajeDescuento,
            Transportista, Comentarios, Almacen, TipoPago, Peso, DevolucionCompra, ReferenciaContable,
            CodigoCaja, GiroAno, GiroCuota, GiroSerie, GiroInteres, CentroCosto, Almacen1, CodigoProducto,
            Descripcion, UnidadMedida, Iva, PorcentajeIva, Bultos, Cantidad, Precio, DescuentoRenglon,
            TotalRenglon, OrdenCompra, Recepcion, Registro, CodigoContable, CodigoPresupuesto,
            CentroCosto2, TotalComprasIva, ComprasSinIva, BaseImponible, ImpuestoIva, Ajuste, RetencionIva,
            Valor, NombreRet, Codigorete, PorcentajeRet
        )
        VALUES (
            Numero, Referencia, ReferenciaControl, FechaEmision, NULL, NULL, CodigoProveedor, 0, 0, Impuesto, 0, TotalCompra, 0, '', '', '', '', 0, '', ReferenciaContable, '', 0, 0, 0, 0, '', '', '(Ret)-RET', '', '', '', PorcentajeIva, 0, 0, 0, 0, 0, '', '', 1, '', '', '', 0, 0, 0, 0, '', 0, TotalRenglon, Nombre, Codigorete, Porcentaje
        );
    END LOOP;
END;
$$;

-- Procedimiento: sp_libro_compras2
CREATE OR REPLACE PROCEDURE sp_libro_compras2()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Actualizar TotalComprasIva
    UPDATE tmpCompras
    SET TotalComprasIva = TotalRenglon + (TotalRenglon * (PorcentajeIva / 100))
    WHERE PorcentajeIva <> 0 AND Registro <> 1 AND Impuesto > 0;

    -- Actualizar ComprasSinIva
    UPDATE tmpCompras
    SET ComprasSinIva = TotalCompra
    WHERE Impuesto = 0 AND LEFT(CodigoProducto, 5) <> '(Ret)';

    -- Actualizar BaseImponible
    UPDATE tmpCompras
    SET BaseImponible = TotalRenglon
    WHERE PorcentajeIva <> 0;

    -- Actualizar ImpuestoIva
    UPDATE tmpCompras
    SET ImpuestoIva = TotalRenglon * (PorcentajeIva / 100)
    WHERE Registro <> 1 AND PorcentajeIva <> 0;

    -- Actualizar TotalComprasIva para registros específicos
    UPDATE tmpCompras
    SET TotalComprasIva = TotalRenglon
    WHERE PorcentajeIva <> 0 AND Registro = 1;

    -- Actualizar TotalComprasIva para registros específicos con impuesto
    UPDATE tmpCompras
    SET TotalComprasIva = TotalComprasIva + (TotalComprasIva * (PorcentajeIva / 100))
    WHERE PorcentajeIva <> 0 AND Registro = 1 AND Impuesto > 0;

    -- Actualizar BaseImponible para registros específicos
    UPDATE tmpCompras
    SET BaseImponible = TotalRenglon
    WHERE PorcentajeIva <> 0 AND Registro = 1;

    -- Actualizar ImpuestoIva para registros específicos
    UPDATE tmpCompras
    SET ImpuestoIva = BaseImponible * (PorcentajeIva / 100)
    WHERE Registro = 1 AND PorcentajeIva <> 0;
END;
$$;

-- Procedimiento: sp_libro_inventario
CREATE OR REPLACE PROCEDURE sp_libro_inventario(
    FecDesde VARCHAR(12),
    FecHasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    codigoproducto VARCHAR(15);
    mes VARCHAR(2);
    ano VARCHAR(4);
    nombre VARCHAR(50);
    unidad VARCHAR(12);
    II_cantidad NUMERIC;
    II_costounitario NUMERIC;
    II_costototal NUMERIC;
    EN_cantidad NUMERIC;
    EN_costounitario NUMERIC;
    EN_costototal NUMERIC;
    SA_cantidad NUMERIC;
    SA_costounitario NUMERIC;
    SA_costototal NUMERIC;
    IF_cantidad NUMERIC;
    IF_costounitario NUMERIC;
    IF_costototal NUMERIC;
    entrada_cantidad NUMERIC;
    salida_cantidad NUMERIC;
    fecha TIMESTAMP;
    tipo VARCHAR(2);
    cantidad NUMERIC;
    costototal NUMERIC;
BEGIN
    -- Crear tabla temporal
    DROP TABLE IF EXISTS tmpLibroInventario;
    CREATE TEMP TABLE tmpLibroInventario (
        Mes CHAR(2),
        Ano CHAR(4),
        CodigoProducto CHAR(50) NOT NULL,
        Nombre CHAR(50),
        Unidad CHAR(12),
        II_Cantidad NUMERIC,
        II_CostoUnitario NUMERIC,
        II_CostoTotal NUMERIC,
        EN_Cantidad NUMERIC,
        EN_CostoUnitario NUMERIC,
        EN_CostoTotal NUMERIC,
        SA_Cantidad NUMERIC,
        SA_CostoUnitario NUMERIC,
        SA_CostoTotal NUMERIC,
        IF_Cantidad NUMERIC,
        IF_CostoUnitario NUMERIC,
        IF_CostoTotal NUMERIC
    );

    -- Iterar sobre los resultados de la consulta
    FOR codigoproducto, nombre, unidad IN
        SELECT CodigoProducto, Nombre, UnidadMedida
        FROM Productos
        ORDER BY CodigoProducto
    LOOP
        -- Variables de mes y año para el registro
        mes := TO_CHAR(TO_TIMESTAMP(FecDesde, 'DDMMYYYY'), 'MM');
        ano := TO_CHAR(TO_TIMESTAMP(FecDesde, 'DDMMYYYY'), 'YYYY');

        -- Cálculo de entradas de inventario inicial
        SELECT COALESCE(SUM(cantidad), 0) INTO entrada_cantidad
        FROM ProductosMovimientos
        WHERE (Tipo = 'E' OR Tipo = 'EN' OR Tipo = 'AE' OR Tipo = 'DV')
        AND Fecha < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
        AND CodigoProducto = codigoproducto;

        SELECT COALESCE(SUM(cantidad), 0) INTO salida_cantidad
        FROM ProductosMovimientos
        WHERE (Tipo = 'S' OR Tipo = 'SA' OR Tipo = 'AS' OR Tipo = 'AA')
        AND Fecha < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
        AND CodigoProducto = codigoproducto;

        II_cantidad := entrada_cantidad - salida_cantidad;

        -- Cálculo de entradas del mes
        SELECT COALESCE(SUM(cantidad), 0) INTO EN_cantidad
        FROM ProductosMovimientos
        WHERE (Tipo = 'E' OR Tipo = 'EN' OR Tipo = 'AE' OR Tipo = 'DV')
        AND Fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY') AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY')
        AND CodigoProducto = codigoproducto;

        -- Cálculo de salidas del mes
        SELECT COALESCE(SUM(cantidad), 0) INTO SA_cantidad
        FROM ProductosMovimientos
        WHERE (Tipo = 'S' OR Tipo = 'SA' OR Tipo = 'AS' OR Tipo = 'AA')
        AND Fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY') AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY')
        AND CodigoProducto = codigoproducto;

        -- Cálculo inventario final
        IF_cantidad := (II_cantidad + EN_cantidad) - SA_cantidad;

        -- Cálculo de costos promedios totales y unitarios de Inventario Inicial (II)
        SELECT COALESCE(SUM(costototal), 0) INTO II_costototal
        FROM ProductosMovimientos
        WHERE (Tipo = 'E' OR Tipo = 'EN' OR Tipo = 'AE' OR Tipo = 'DV')
        AND Fecha < TO_TIMESTAMP(FecDesde, 'DDMMYYYY')
        AND CodigoProducto = codigoproducto;

        II_costounitario := CASE WHEN entrada_cantidad > 0 THEN II_costototal / entrada_cantidad ELSE 0 END;
        II_costounitario := COALESCE(II_costounitario, 0);
        II_costototal := COALESCE(II_costototal, 0);

        -- Cálculo de costos promedios totales y unitarios de Inventario de entradas del mes (EN)
        SELECT COALESCE(SUM(costototal), 0) INTO EN_costototal
        FROM ProductosMovimientos
        WHERE (Tipo = 'E' OR Tipo = 'EN' OR Tipo = 'AE' OR Tipo = 'DV')
        AND Fecha BETWEEN TO_TIMESTAMP(FecDesde, 'DDMMYYYY') AND TO_TIMESTAMP(FecHasta, 'DDMMYYYY')
        AND CodigoProducto = codigoproducto;

        EN_costounitario := CASE WHEN EN_cantidad > 0 THEN EN_costototal / EN_cantidad ELSE 0 END;
        EN_costounitario := COALESCE(EN_costounitario, 0);
        EN_costototal := COALESCE(EN_costototal, 0);

        -- Cálculo de costos unitarios de salida y finales (SA / IF)
        IF II_costounitario = 0 AND EN_costounitario > 0 THEN
            SA_costounitario := EN_costounitario;
        ELSIF II_costounitario > 0 AND EN_costounitario = 0 THEN
            SA_costounitario := II_costounitario;
        ELSIF II_costounitario > 0 AND EN_costounitario > 0 THEN
            SA_costounitario := (II_costounitario + EN_costounitario) / 2;
        END IF;

        IF_costounitario := SA_costounitario;
        SA_costounitario := COALESCE(SA_costounitario, 0);
        IF_costounitario := COALESCE(IF_costounitario, 0);

        -- Cálculo de costos totales de salidas y finales
        SA_costototal := SA_costounitario * SA_cantidad;
        IF_costototal := IF_costounitario * IF_cantidad;

        -- Inserción en la tabla temporal
        INSERT INTO tmpLibroInventario (Mes, Ano, CodigoProducto, Nombre, Unidad, II_Cantidad, II_CostoUnitario, II_CostoTotal,
        EN_Cantidad, EN_CostoUnitario, EN_CostoTotal, SA_Cantidad, SA_CostoUnitario, SA_CostoTotal, IF_Cantidad, IF_CostoUnitario,
        IF_CostoTotal)
        VALUES (mes, ano, codigoproducto, nombre, unidad, II_cantidad, II_costounitario, II_costototal,
        EN_cantidad, EN_costounitario, EN_costototal, SA_cantidad, SA_costounitario, SA_costototal, IF_cantidad,
        IF_costounitario, IF_costototal);
    END LOOP;
END;
$$;

-- Procedimiento: sp_libro_ventas
CREATE OR REPLACE PROCEDURE sp_libro_ventas(
    fec_desde VARCHAR(12),
    fec_hasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    numero CHAR(8);
    fecha_emision TIMESTAMP;
    total_renglon DECIMAL(19, 4);
    total_factura DECIMAL(19, 4);
    referencia CHAR(20);
    impuesto DECIMAL(19, 4);
    porcentaje_iva DECIMAL(19, 4);
    movimiento_cursor CURSOR FOR
        SELECT
            numdocven,
            SUM(valorretencion) AS suma,
            fechaemicion,
            facturas.totalfactura,
            facturas.referencia,
            facturas.impuesto,
            facturasrenglones.porcentajeiva
        FROM
            retencionesventas
        INNER JOIN
            facturas ON retencionesventas.numdocven = facturas.numero
        INNER JOIN
            facturasrenglones ON facturas.numero = facturasrenglones.numero
        WHERE
            fechaemicion BETWEEN fec_desde AND fec_hasta
            AND tiporetencion = 'IVA'
        GROUP BY
            numdocven, fechaemicion, facturas.totalfactura, facturas.referencia, facturas.impuesto, facturasrenglones.porcentajeiva;
BEGIN
    -- Crear tabla temporal tmpfacturas
    DROP TABLE IF EXISTS tmpfacturas;

    CREATE TEMP TABLE tmpfacturas (
        numero CHAR(8) NOT NULL,
        fechaemision TIMESTAMP NOT NULL,
        vencimiento TIMESTAMP,
        codigocliente VARCHAR(50),
        nombre VARCHAR(50),
        rif CHAR(22),
        referencia CHAR(20),
        totalbruto DECIMAL(19, 4),
        descuento DECIMAL(19, 4),
        impuesto DECIMAL(19, 4),
        cargo DECIMAL(19, 4),
        totalfactura DECIMAL(19, 4),
        porcentajedescuento DECIMAL(19, 4),
        transportista CHAR(5),
        vendedor CHAR(5),
        direccionenvio TEXT,
        comentarios TEXT,
        tarifa CHAR(5),
        tipopago CHAR(1),
        peso DECIMAL(19, 4),
        devolucionfactura CHAR(8),
        codigocaja CHAR(5),
        giroserie CHAR(3),
        giroano DECIMAL(10, 4),
        girocuota DECIMAL(10, 4),
        girointeres DECIMAL(10, 4),
        empresa CHAR(3),
        almacen CHAR(5),
        codigoproducto VARCHAR(50),
        descripcion VARCHAR(50),
        unidadmedida CHAR(12),
        iva CHAR(1),
        porcentajeiva DECIMAL(19, 4),
        bultos DECIMAL(19, 4),
        cantidad DECIMAL(19, 4),
        precio DECIMAL(19, 4),
        descuentorenglon DECIMAL(19, 4),
        totalrenglon DECIMAL(19, 4),
        pedido CHAR(8),
        notaentrega CHAR(8),
        comision CHAR(5),
        porcentajekomision DECIMAL(19, 4),
        registro INT NOT NULL,
        totalventasiva DECIMAL(19, 4),
        ventassiniva DECIMAL(19, 4),
        baseimponible DECIMAL(19, 4),
        impuestoiva DECIMAL(19, 4),
        impuestoivab DECIMAL(19, 4),
        retencioniva DECIMAL(19, 4),
        valor DECIMAL(19, 4)
    );

    -- Insertar renglones de facturas de ventas
    INSERT INTO tmpfacturas
    SELECT
        facturas.numero,
        facturas.fechaemision,
        facturas.vencimiento,
        facturas.codigocliente,
        clientes.nombre,
        clientes.rif,
        facturas.referencia,
        facturas.totalbruto,
        facturas.descuento,
        facturas.impuesto,
        facturas.cargo,
        facturas.totalfactura,
        facturas.porcentajedescuento,
        facturas.transportista,
        facturas.vendedor,
        facturas.direccionenvio,
        facturas.comentarios,
        facturas.tarifa,
        facturas.tipopago,
        facturas.peso,
        facturas.devolucionfactura,
        facturas.codigocaja,
        facturas.giroserie,
        facturas.giroano,
        facturas.girocuota,
        facturas.girointeres,
        facturas.empresa,
        facturasrenglones.almacen,
        facturasrenglones.codigoproducto,
        facturasrenglones.descripcion,
        facturasrenglones.unidadmedida,
        facturasrenglones.iva,
        facturasrenglones.porcentajeiva,
        facturasrenglones.bultos,
        facturasrenglones.cantidad,
        facturasrenglones.precio,
        facturasrenglones.descuento AS descuentorenglon,
        facturasrenglones.totalrenglon,
        facturasrenglones.pedido,
        facturasrenglones.notaentrega,
        facturasrenglones.comision,
        facturasrenglones.porcentajekomision,
        0 AS registro,
        0 AS totalventasiva,
        0 AS ventassiniva,
        0 AS baseimponible,
        0 AS impuestoiva,
        0 AS impuestoivab,
        0 AS retencioniva,
        0 AS valor
    FROM
        facturasrenglones
    INNER JOIN
        facturas ON facturasrenglones.numero = facturas.numero
    INNER JOIN
        clientes ON facturas.codigocliente = clientes.codigocliente
    WHERE
        facturas.numero NOT IN (SELECT numero FROM facturasrenglones WHERE codigoproducto = '*D')
        AND TO_CHAR(facturas.fechaemision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta;

    -- Insertar NC de la Retención IVA aplicada por Contribuyentes Especiales
    INSERT INTO tmpfacturas
    SELECT
        tipo || RIGHT(numero, 6) AS numero,
        emision AS fechaemision,
        vencimiento,
        clientesmovimientos.codigocliente,
        clientes.nombre,
        clientes.rif,
        numero AS referencia,
        0 AS totalbruto,
        0 AS descuento,
        0 AS impuesto,
        0 AS cargo,
        0 AS totalfactura,
        0 AS porcentajedescuento,
        '' AS transportista,
        '' AS vendedor,
        '' AS direccionenvio,
        '' AS comentarios,
        '' AS tarifa,
        '' AS tipopago,
        0 AS peso,
        '' AS devolucionfactura,
        '' AS codigocaja,
        0 AS giroserie,
        0 AS giroano,
        0 AS girocuota,
        0 AS girointeres,
        '' AS empresa,
        '' AS almacen,
        '*PP' AS codigoproducto,
        concepto AS descripcion,
        '' AS unidadmedida,
        '' AS iva,
        0 AS porcentajeiva,
        0 AS bultos,
        0 AS cantidad,
        0 AS precio,
        0 AS descuentorenglon,
        0 AS totalrenglon,
        '' AS pedido,
        '' AS notaentrega,
        '0' AS comision,
        0 AS porcentajekomision,
        2 AS registro,
        0 AS totalventasiva,
        0 AS ventassiniva,
        0 AS baseimponible,
        0 AS impuestoiva,
        0 AS impuestoivab,
        importe AS retencioniva,
        0 AS valor
    FROM
        clientesmovimientos
    INNER JOIN
        clientes ON clientesmovimientos.codigocliente = clientes.codigocliente
    WHERE
        tipo = 'NC'
        AND origen = 'CXC'
        AND LEFT(concepto, 13) = 'RETENCION IVA'
        AND TO_CHAR(clientesmovimientos.emision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta;

    -- Insertar Descuentos
    INSERT INTO tmpfacturas
    SELECT
        facturas.numero,
        facturas.fechaemision,
        facturas.vencimiento,
        facturas.codigocliente,
        clientes.nombre,
        clientes.rif,
        facturas.referencia,
        facturas.totalbruto,
        facturas.descuento,
        facturas.impuesto,
        facturas.cargo,
        facturas.totalfactura,
        facturas.porcentajedescuento,
        facturas.transportista,
        facturas.vendedor,
        facturas.direccionenvio,
        facturas.comentarios,
        facturas.tarifa,
        facturas.tipopago,
        facturas.peso,
        facturas.devolucionfactura,
        facturas.codigocaja,
        facturas.giroserie,
        facturas.giroano,
        facturas.girocuota,
        facturas.girointeres,
        facturas.empresa,
        facturasrenglones.almacen,
        facturasrenglones.codigoproducto,
        facturasrenglones.descripcion,
        facturasrenglones.unidadmedida,
        facturasrenglones.iva,
        facturasrenglones.porcentajeiva,
        facturasrenglones.bultos,
        facturasrenglones.cantidad,
        facturasrenglones.precio,
        facturasrenglones.descuento AS descuentorenglon,
        facturasrenglones.totalrenglon,
        facturasrenglones.pedido,
        facturasrenglones.notaentrega,
        facturasrenglones.comision,
        facturasrenglones.porcentajekomision,
        1 AS registro,
        0 AS totalventasiva,
        0 AS ventassiniva,
        0 AS baseimponible,
        0 AS impuestoiva,
        0 AS impuestoivab,
        0 AS retencioniva,
        0 AS valor
    FROM
        facturasrenglones
    INNER JOIN
        facturas ON facturasrenglones.numero = facturas.numero
    INNER JOIN
        clientes ON facturas.codigocliente = clientes.codigocliente
    WHERE
        facturas.numero IN (SELECT numero FROM facturasrenglones WHERE codigoproducto = '*D')
        AND TO_CHAR(facturas.fechaemision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta;

    -- Abrir cursor para movimientos
    OPEN movimiento_cursor;
    FETCH NEXT FROM movimiento_cursor INTO numero, total_renglon, fecha_emision, total_factura, referencia, impuesto, porcentaje_iva;

    WHILE FOUND LOOP
        INSERT INTO tmpfacturas (
            numero,
            referencia,
            fechaemision,
            vencimiento,
            totalbruto,
            descuento,
            impuesto,
            cargo,
            totalfactura,
            porcentajedescuento,
            transportista,
            comentarios,
            tipopago,
            peso,
            devolucionfactura,
            codigocaja,
            giroano,
            girocuota,
            giroserie,
            girointeres,
            almacen,
            codigoproducto,
            descripcion,
            unidadmedida,
            iva,
            porcentajeiva,
            bultos,
            cantidad,
            precio,
            descuentorenglon,
            totalrenglon,
            pedido,
            notaentrega,
            registro,
            totalventasiva,
            ventassiniva,
            baseimponible,
            impuestoiva,
            impuestoivab,
            retencioniva,
            valor
        ) VALUES (
            numero,
            referencia,
            fecha_emision,
            NULL,
            NULL,
            0,
            impuesto,
            0,
            total_factura,
            0,
            '',
            '',
            0,
            0,
            '',
            0,
            0,
            '',
            0,
            '',
            '(Ret)-IVA',
            '',
            '',
            '',
            porcentaje_iva,
            0,
            0,
            0,
            0,
            0,
            '',
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            total_renglon,
            0
        );

        FETCH NEXT FROM movimiento_cursor INTO numero, total_renglon, fecha_emision, total_factura, referencia, impuesto, porcentaje_iva;
    END LOOP;

    CLOSE movimiento_cursor;
END;
$$;

-- Procedimiento: sp_libro_ventas2
CREATE OR REPLACE PROCEDURE sp_libro_ventas2()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Actualizar TotalVentasIva
    UPDATE tmpfacturas
    SET totalventasiva = ROUND((totalrenglon + (totalrenglon * (porcentajeiva / 100))), 2)
    WHERE porcentajeiva <> 0 AND registro <> 1;

    -- Actualizar VentasSinIva
    UPDATE tmpfacturas
    SET ventassiniva = ROUND(totalrenglon, 2)
    WHERE iva = '' OR iva = 'E';

    -- Actualizar BaseImponible
    UPDATE tmpfacturas
    SET baseimponible = ROUND(totalrenglon, 2)
    WHERE porcentajeiva <> 0;

    -- Actualizar ImpuestoIva para iva = 'A'
    UPDATE tmpfacturas
    SET impuestoiva = ROUND((totalrenglon * (porcentajeiva / 100)), 2)
    WHERE iva = 'A' AND (registro = 0 OR registro = 3);

    -- Actualizar ImpuestoIvaB para iva = 'B'
    UPDATE tmpfacturas
    SET impuestoivab = ROUND((totalrenglon * (porcentajeiva / 100)), 2)
    WHERE iva = 'B' AND (registro = 0 OR registro = 3);

    -- Actualizar TotalVentasIva para registro = 1
    UPDATE tmpfacturas
    SET totalventasiva = ROUND(totalrenglon - (totalrenglon * (descuentorenglon / 100)), 2)
    WHERE porcentajeiva <> 0 AND registro = 1;

    -- Actualizar TotalVentasIva con IVA para registro = 1
    UPDATE tmpfacturas
    SET totalventasiva = ROUND(totalventasiva + (totalventasiva * (porcentajeiva / 100)), 2)
    WHERE porcentajeiva <> 0 AND registro = 1;

    -- Actualizar BaseImponible para registro = 1
    UPDATE tmpfacturas
    SET baseimponible = ROUND(totalrenglon - (totalrenglon * (descuentorenglon / 100)), 2)
    WHERE porcentajeiva <> 0 AND registro = 1;

    -- Actualizar ImpuestoIva para registro = 1 y iva = 'A'
    UPDATE tmpfacturas
    SET impuestoiva = ROUND(totalrenglon * (porcentajeiva / 100), 2)
    WHERE registro = 1 AND iva = 'A';

    -- Actualizar ImpuestoIvaB para registro = 1 y iva = 'B'
    UPDATE tmpfacturas
    SET impuestoivab = ROUND(totalrenglon * (porcentajeiva / 100), 2)
    WHERE registro = 1 AND iva = 'B';

    -- Las siguientes actualizaciones están comentadas en el código original
    -- UPDATE tmpfacturas SET retencioniva = valor WHERE registro = 1 AND codigoproducto = '(Ret)-IVA' AND valor > 0;
    -- UPDATE tmpfacturas SET retencioniva = valor WHERE registro = 1 AND codigoproducto = '(Ret)-RET' AND valor > 0;
END;
$$;

-- Procedimiento: sp_retenciones
CREATE OR REPLACE PROCEDURE sp_retenciones()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Crear tabla temporal TmpRetenciones
    DROP TABLE IF EXISTS tmpretenciones;

    CREATE TEMP TABLE tmpretenciones (
        codigoretencion CHAR(5) NOT NULL,
        codigocontable CHAR(30),
        concepto CHAR(50),
        baseimponible DECIMAL(19, 4),
        tarifa DECIMAL(19, 4),
        pagominimo DECIMAL(19, 4),
        sustraendo DECIMAL(19, 4),
        acumulador CHAR(1)
    );

    -- Inserción de registros
    INSERT INTO tmpretenciones (
        codigoretencion,
        codigocontable,
        concepto,
        baseimponible,
        tarifa,
        pagominimo,
        sustraendo,
        acumulador
    )
    SELECT
        codigoretencion,
        codigocontable,
        concepto,
        baseimponible,
        tarifa,
        pagominimo,
        sustraendo,
        acumulador
    FROM
        retenciones;
END;
$$;

-- Procedimiento: sp_tasa_cambio
CREATE OR REPLACE PROCEDURE sp_tasa_cambio()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Crear tabla temporal TmpTasaCambio
    DROP TABLE IF EXISTS tmp_tasa_cambio;

    CREATE TEMP TABLE tmp_tasa_cambio (
        fecha TIMESTAMP,
        cambio DECIMAL(14, 7)
    );

    -- Inserción de registros
    INSERT INTO tmp_tasa_cambio (fecha, cambio)
    SELECT fecha, cambio
    FROM tasa_cambio;
END;
$$;

-- Procedimiento: sp_txt_compras
CREATE OR REPLACE PROCEDURE sp_txt_compras(
    fec_desde VARCHAR(12),
    fec_hasta VARCHAR(12)
)
LANGUAGE plpgsql
AS $$
DECLARE
    retencion DECIMAL(19, 4);
    comprasiva DECIMAL(19, 4);
    comprassiniva DECIMAL(19, 4);
    totalc DECIMAL(19, 4);
BEGIN
    -- Crear tabla temporal TmpTxtCompras
    DROP TABLE IF EXISTS tmp_txt_compras;

    CREATE TEMP TABLE tmp_txt_compras (
        numero CHAR(8) NOT NULL,
        referencia CHAR(20),
        referencia_control CHAR(20),
        fecha_emision TIMESTAMP NOT NULL,
        vencimiento TIMESTAMP,
        codigo_proveedor CHAR(20),
        rif CHAR(20),
        total_bruto DECIMAL(19, 4),
        retenciones DECIMAL(19, 4),
        descuento DECIMAL(19, 4),
        impuesto DECIMAL(19, 4),
        cargo DECIMAL(19, 4),
        total_compra DECIMAL(19, 4),
        devolucion_compra CHAR(8),
        total_compras_iva DECIMAL(19, 4),
        compras_sin_iva DECIMAL(19, 4),
        base_imponible DECIMAL(19, 4),
        impuesto_iva DECIMAL(19, 4),
        retencion_iva DECIMAL(19, 4),
        num_ret_iva CHAR(20)
    );

    -- Inserción de registros de retenciones de IVA
    INSERT INTO tmp_txt_compras (
        numero,
        referencia,
        referencia_control,
        fecha_emision,
        vencimiento,
        codigo_proveedor,
        rif,
        total_bruto,
        retenciones,
        descuento,
        impuesto,
        cargo,
        total_compra,
        devolucion_compra,
        total_compras_iva,
        compras_sin_iva,
        base_imponible,
        impuesto_iva,
        retencion_iva,
        num_ret_iva
    )
    SELECT
        compras.numero,
        compras.referencia,
        compras.referencia_control,
        compras.fecha_emision,
        compras.vencimiento,
        compras.codigo_proveedor,
        COALESCE((SELECT rif FROM proveedores WHERE proveedores.codigo_proveedor = compras.codigo_proveedor LIMIT 1), '0'),
        compras.total_bruto,
        compras.retenciones,
        compras.descuento,
        compras.impuesto,
        compras.cargo,
        compras.total_compra + compras.retenciones,
        compras.devolucion_compra,
        COALESCE((SELECT SUM(compras_renglones.total_renglon)
                  FROM compras AS c
                  INNER JOIN compras_renglones ON c.numero = compras_renglones.numero
                  WHERE TO_CHAR(c.fecha_emision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta
                  AND c.numero = compras.numero
                  AND compras_renglones.iva <> ''
                  AND compras_renglones.porcentaje_iva <> 0
                  AND codigoproducto <> LEFT('(Ret)', 5)
                  AND c.numero = compras.numero), 0),
        COALESCE((SELECT SUM(compras_renglones.total_renglon)
                  FROM compras AS d
                  INNER JOIN compras_renglones ON d.numero = compras_renglones.numero
                  WHERE TO_CHAR(d.fecha_emision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta
                  AND compras_renglones.iva = ''
                  AND codigoproducto NOT IN ('(Ret)-IVA', '(Ret)-01', '(Ret)-02', '(Ret)-03', '(Ret)-04', '(Ret)-05', '(Ret)-06', '(Ret)-07', '(Ret)-08', '(Ret)-09', '(Ret)-10', '(Ret)-11', '(Ret)-12', '(Ret)-13')
                  AND d.numero = compras.numero), 0),
        compras.total_bruto,
        compras.impuesto,
        COALESCE((SELECT SUM(compras_renglones.total_renglon)
                  FROM compras AS b
                  INNER JOIN compras_renglones ON b.numero = compras_renglones.numero
                  WHERE TO_CHAR(b.fecha_emision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta
                  AND compras_renglones.codigo_producto = LEFT('(Ret)-IVA', 9)
                  AND b.numero = compras.numero), 0),
        compras.num_ret_iva
    FROM
        compras
    INNER JOIN
        compras_renglones ON compras.numero = compras_renglones.numero
    WHERE
        TO_CHAR(compras.fecha_emision, 'YYYYMMDD') BETWEEN fec_desde AND fec_hasta
        AND compras.total_compra <> 0
        AND compras_renglones.codigo_producto = LEFT('(Ret)-IVA', 9)
    ORDER BY
        fecha_emision;
END;
$$;

-- Recosteo de producto
CREATE OR REPLACE FUNCTION recosteoProducto(codigoProducto CHAR(50))
RETURNS void AS $$
DECLARE
    fecha TIMESTAMP;
    unidadMedida CHAR(12);
    numero CHAR(8);
    cantidad NUMERIC;
    proveedorCliente CHAR(20);
    almacen CHAR(5);
    tipo CHAR(2);
    origen CHAR(3);
    tipoCosteo CHAR(1);
    costo NUMERIC := 0;
    ultimoProveedor CHAR(20);
    existencia NUMERIC := 0;
    ultimoCosto NUMERIC := 0;
    rec RECORD;
BEGIN
    SELECT tipocosteo INTO tipoCosteo FROM productos WHERE codigoproducto = codigoProducto;
    PERFORM recalculoExistencias(codigoProducto, existencia);
    UPDATE productosmovimientos SET cantidadusada = 0 WHERE codigoproducto = codigoProducto;

    IF tipoCosteo = 'P' THEN
        PERFORM recosteoPromedio(codigoProducto);
    ELSE
        FOR rec IN
            SELECT fecha, tipo, numero, unidadmedida, SUM(cantidad) AS cantidad, origen, proveedorcliente, almacen
            FROM productosmovimientos
            WHERE codigoproducto = codigoProducto
            GROUP BY fecha, tipo, numero, unidadmedida, origen, proveedorcliente, almacen
            HAVING tipo IN ('SA', 'DC', 'DV', 'AS')
            ORDER BY fecha
        LOOP
            DELETE FROM productosmovimientos
            WHERE codigoproducto = codigoProducto
              AND tipo = rec.tipo
              AND numero = rec.numero
              AND fecha = rec.fecha;

            PERFORM salidaInventario(
                tipoCosteo, codigoProducto, rec.fecha, rec.numero, rec.unidadmedida,
                rec.cantidad, rec.proveedorcliente, rec.almacen, rec.tipo, rec.origen
            );
        END LOOP;

        SELECT costototal / cantidad INTO ultimoCosto
        FROM productosmovimientos
        WHERE codigoproducto = codigoProducto
          AND (LEFT(tipo,1) = 'E' OR tipo IN ('AE','DV'))
        ORDER BY fecha DESC
        LIMIT 1;

        IF tipoCosteo = 'L' THEN
            SELECT costototal / cantidad INTO costo
            FROM productosmovimientos
            WHERE codigoproducto = codigoProducto
              AND (LEFT(tipo,1) = 'E' OR tipo IN ('AE','DV'))
              AND cantidad > cantidadusada
            ORDER BY fecha DESC, registro DESC
            LIMIT 1;
        ELSIF tipoCosteo = 'F' THEN
            SELECT costototal / cantidad INTO costo
            FROM productosmovimientos
            WHERE codigoproducto = codigoProducto
              AND (LEFT(tipo,1) = 'E' OR tipo IN ('AE','DV'))
              AND cantidad > cantidadusada
            ORDER BY fecha, registro
            LIMIT 1;
        ELSIF tipoCosteo = 'U' THEN
            costo := ultimoCosto;
        END IF;

        SELECT proveedorcliente INTO ultimoProveedor
        FROM productosmovimientos
        WHERE codigoproducto = codigoProducto
          AND origen IN ('CPA', 'REC')
          AND tipo = 'EN'
        ORDER BY fecha DESC
        LIMIT 1;

        IF existencia > 0 THEN
            UPDATE productos
            SET costo = costo,
                ultimocosto = ultimoCosto,
                ultimoproveedor = ultimoProveedor,
                recosteo = FALSE
            WHERE codigoproducto = codigoProducto;
        ELSE
            UPDATE productos
            SET ultimocosto = ultimoCosto,
                ultimoproveedor = ultimoProveedor,
                recosteo = FALSE
            WHERE codigoproducto = codigoProducto;
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Recosteo promedio
CREATE OR REPLACE FUNCTION recosteoPromedio(codigoProducto CHAR(50))
RETURNS void AS $$
DECLARE
    tipo CHAR(2);
    cantidad NUMERIC;
    costoTotal NUMERIC;
    registro INT;
    acCantidadEntrada NUMERIC := 0;
    acCostoEntrada NUMERIC := 0;
    acCantidadSalida NUMERIC := 0;
    acCostoSalida NUMERIC := 0;
    existencia NUMERIC := 0;
    costo NUMERIC := 0;
    ultimoProveedor CHAR(20);
    ultimoCosto NUMERIC := 0;
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT tipo, cantidad, costototal, registro
        FROM productosmovimientos
        WHERE codigoproducto = codigoProducto
        ORDER BY fecha
    LOOP
        IF LEFT(rec.tipo,1)='E' OR rec.tipo='AE' OR rec.tipo='DV' OR rec.tipo='AC' THEN
            acCantidadEntrada := acCantidadEntrada + rec.cantidad;
            acCostoEntrada := acCostoEntrada + rec.costototal;
        ELSE
            rec.costototal := costo * rec.cantidad;
            UPDATE productosmovimientos SET costototal = rec.costototal WHERE registro = rec.registro;
            acCantidadSalida := acCantidadSalida + rec.cantidad;
            acCostoSalida := acCostoSalida + rec.costototal;
        END IF;
        existencia := acCantidadEntrada - acCantidadSalida;
        costo := 0;
        IF existencia > 0 THEN
            costo := (acCostoEntrada - acCostoSalida) / existencia;
        END IF;
    END LOOP;

    existencia := acCantidadEntrada - acCantidadSalida;

    SELECT proveedorcliente INTO ultimoProveedor
    FROM productosmovimientos
    WHERE codigoproducto = codigoProducto
      AND (origen='CPA' OR origen='REC')
      AND tipo='EN'
    ORDER BY fecha DESC
    LIMIT 1;

    SELECT costototal/cantidad INTO ultimoCosto
    FROM productosmovimientos
    WHERE codigoproducto = codigoProducto
      AND tipo='EN'
    ORDER BY fecha DESC
    LIMIT 1;

    IF ultimoCosto IS NULL THEN
        ultimoCosto := 0;
    END IF;

    UPDATE productos SET
        ac_cantidadentrada = acCantidadEntrada,
        ac_costoentrada = acCostoEntrada,
        ac_cantidadsalida = acCantidadSalida,
        ac_costosalida = acCostoSalida,
        existencia = existencia,
        costo = costo,
        ultimocosto = ultimoCosto,
        ultimoproveedor = ultimoProveedor,
        recosteo = FALSE
    WHERE codigoproducto = codigoProducto;
END;
$$ LANGUAGE plpgsql;

-- Recosteo recepción
CREATE OR REPLACE FUNCTION recosteoRecepcion(numero CHAR(8))
RETURNS void AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN
        SELECT fr.codigoproducto
        FROM recepcionesrenglones fr
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = numero
    LOOP
        PERFORM recosteoProducto(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Recosteo transferencia
CREATE OR REPLACE FUNCTION recosteoTransferencia(numero CHAR(8))
RETURNS void AS $$
DECLARE
    codigoProducto CHAR(50);
BEGIN
    FOR codigoProducto IN
        SELECT nr.codigoproducto
        FROM transferenciasrenglones nr
        INNER JOIN productos p ON nr.codigoproducto = p.codigoproducto
        WHERE nr.numero = numero
    LOOP
        PERFORM recosteoProducto(codigoProducto);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Reducir existencia producto
CREATE OR REPLACE FUNCTION reducirExistenciaProducto(numero CHAR(8))
RETURNS void AS $$
DECLARE
    codigoProducto CHAR(50);
    cantidad NUMERIC;
    almacen CHAR(10);
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT fr.codigoproducto, fr.cantidad, fr.almacen
        FROM comprasrenglones fr
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = numero AND fr.recepcion IS NULL
    LOOP
        UPDATE productos SET existencia = existencia - rec.cantidad WHERE codigoproducto = rec.codigoproducto;
        UPDATE productosExistencias SET existencia = existencia - rec.cantidad WHERE codigoproducto = rec.codigoproducto AND almacen = rec.almacen;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SaldosBC
CREATE OR REPLACE FUNCTION saldosBc(codigoContable CHAR(30), fecha TIMESTAMP)
RETURNS TABLE(saldoAnterior NUMERIC, ingresosMes NUMERIC, egresosMes NUMERIC) AS $$
DECLARE
    primerDia DATE;
    mes CHAR(2);
BEGIN
    IF EXTRACT(MONTH FROM fecha) <= 9 THEN
        mes := '0' || EXTRACT(MONTH FROM fecha)::CHAR(1);
    ELSE
        mes := EXTRACT(MONTH FROM fecha)::CHAR(2);
    END IF;
    primerDia := TO_DATE(EXTRACT(YEAR FROM fecha)::TEXT || mes || '01', 'YYYYMMDD');
    RETURN QUERY
    SELECT
        SUM(CASE WHEN fecha < primerDia THEN importe END),
        SUM(CASE WHEN importe > 0 AND EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM $2) AND EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM $2) THEN importe END),
        SUM(CASE WHEN importe < 0 AND EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM $2) AND EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM $2) THEN importe END)
    FROM contabilidadasientosrenglones
    WHERE codigocontable = $1 AND fecha <= $2;
END;
$$ LANGUAGE plpgsql;

-- SaldosxFecha
CREATE OR REPLACE FUNCTION saldosxFecha(codigoContable CHAR(30), fecha1 TIMESTAMP, fecha2 TIMESTAMP, centroCosto CHAR(20))
RETURNS NUMERIC AS $$
DECLARE
    resultado NUMERIC;
BEGIN
    IF centroCosto = '' THEN
        SELECT SUM(importe) INTO resultado
        FROM contabilidadasientosrenglones
        WHERE LEFT(codigocontable, LENGTH(TRIM(LEADING FROM codigocontable))) = codigoContable
          AND fecha BETWEEN fecha1 AND fecha2;
    ELSE
        SELECT SUM(importe) INTO resultado
        FROM contabilidadasientosrenglones
        WHERE LEFT(codigocontable, LENGTH(TRIM(LEADING FROM codigocontable))) = codigoContable
          AND fecha BETWEEN fecha1 AND fecha2
          AND centrocosto = centroCosto;
    END IF;
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;

-- SaldosxFechaPresupuesto
CREATE OR REPLACE FUNCTION saldosxFechaPresupuesto(codigoContable CHAR(30), fecha1 TIMESTAMP, fecha2 TIMESTAMP, centroCosto CHAR(20))
RETURNS NUMERIC AS $$
DECLARE
    resultado NUMERIC;
BEGIN
    IF centroCosto = '' THEN
        SELECT SUM(importe) INTO resultado
        FROM presupuestoasientosrenglones
        WHERE LEFT(codigocontable, LENGTH(TRIM(LEADING FROM codigocontable))) = codigoContable
          AND fecha BETWEEN fecha1 AND fecha2;
    ELSE
        SELECT SUM(importe) INTO resultado
        FROM presupuestoasientosrenglones
        WHERE LEFT(codigocontable, LENGTH(TRIM(LEADING FROM codigocontable))) = codigoContable
          AND fecha BETWEEN fecha1 AND fecha2
          AND centrocosto = centroCosto;
    END IF;
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;

-- SalidaBoletaProduccion
CREATE OR REPLACE FUNCTION salidaBoletaProduccion(numero CHAR(8))
RETURNS void AS $$
DECLARE
    codigoproducto CHAR(50);
    fecha TIMESTAMP;
    unidadmedida CHAR(12);
    cantidadSalida NUMERIC;
    almacen CHAR(5);
    tipocosteo CHAR(1);
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT opr.codigoproducto, op.fechainicio, p.unidadmedida, opr.cantidad, opr.almacen, p.tipocosteo
        FROM boletasproduccionrenglones opr
        INNER JOIN boletasproduccion op ON opr.numero = op.numero
        INNER JOIN productos p ON opr.codigoproducto = p.codigoproducto
        WHERE opr.numero = numero
    LOOP
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fechainicio, numero, rec.unidadmedida,
            rec.cantidad, NULL, rec.almacen, 'SA', 'BDT'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SalidaBoletaProduccion2
CREATE OR REPLACE FUNCTION salidaBoletaProduccion2(numero CHAR(8), cantidad NUMERIC)
RETURNS void AS $$
DECLARE
    codigoproducto CHAR(50);
    fecha TIMESTAMP;
    unidadmedida CHAR(12);
    cantidadSalida NUMERIC;
    almacen CHAR(5);
    tipocosteo CHAR(1);
    producir NUMERIC;
    rec RECORD;
BEGIN
    SELECT codigoproducto INTO codigoproducto FROM ordenesproduccion WHERE numero = numero;
    SELECT producir INTO producir FROM productos WHERE codigoproducto = codigoproducto;
    IF producir IS NULL OR producir <= 0 THEN
        producir := 1;
    END IF;

    FOR rec IN
        SELECT pc.codigocomponente, op.fechainicio, p.unidadmedida, pc.cantidad, op.almacensalida, p.tipocosteo
        FROM productoscomposicion pc
        INNER JOIN boletasproduccion op ON pc.codigoproducto = op.codigoproducto
        INNER JOIN productos p ON pc.codigocomponente = p.codigoproducto
        WHERE op.numero = numero
    LOOP
        cantidadSalida := rec.cantidad * cantidad / producir;
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigocomponente, rec.fechainicio, numero, rec.unidadmedida,
            cantidadSalida, NULL, rec.almacensalida, 'SA', 'BDT'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SalidaFactura
CREATE OR REPLACE FUNCTION salidaFactura(numero CHAR(8))
RETURNS void AS $$
DECLARE
    rec RECORD;
    tipo CHAR(2);
BEGIN
    FOR rec IN
        SELECT fr.codigoproducto, f.fechaemision, fr.unidadmedida, fr.bultos * fr.cantidad AS cantidadSalida,
               f.codigocliente, fr.almacen, p.tipocosteo
        FROM facturasrenglones fr
        INNER JOIN facturas f ON fr.numero = f.numero
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = numero AND fr.notaentrega IS NULL
    LOOP
        IF rec.cantidadSalida >= 0 THEN
            tipo := 'SA';
        ELSE
            tipo := 'DV';
        END IF;
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fechaemision, numero, rec.unidadmedida,
            rec.cantidadSalida, rec.codigocliente, rec.almacen, tipo, 'FAC'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SalidaFacturaTPV
CREATE OR REPLACE FUNCTION salidaFacturaTpv(numero CHAR(8))
RETURNS void AS $$
DECLARE
    rec RECORD;
    tipo CHAR(2);
BEGIN
    FOR rec IN
        SELECT fr.codigoproducto, f.fechaemision, p.unidadmedida, fr.cantidad AS cantidadSalida,
               f.codigocliente, fr.almacen, p.tipocosteo
        FROM tpvfacturasrenglones fr
        INNER JOIN tpvfacturas f ON fr.numero = f.numero
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = numero
    LOOP
        IF rec.cantidadSalida >= 0 THEN
            tipo := 'SA';
        ELSE
            tipo := 'DV';
        END IF;
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fechaemision, numero, rec.unidadmedida,
            rec.cantidadSalida, rec.codigocliente, rec.almacen, tipo, 'TPV'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION salidaInventario(
    tipoCosteo CHAR(1),
    codigoProducto CHAR(50),
    fecha TIMESTAMP,
    numero CHAR(8),
    unidadMedida CHAR(12),
    cantidadSalida NUMERIC,
    proveedorCliente CHAR(20),
    almacen CHAR(5),
    tipo CHAR(2),
    origen CHAR(3)
)
RETURNS void AS $$
DECLARE
    costoTotal NUMERIC;
    cantidad NUMERIC;
    cantidadUsada NUMERIC;
    costo NUMERIC := 0;
    registro INT;
    disponible NUMERIC;
    xcant NUMERIC;
    existencia NUMERIC;
    rec RECORD;
BEGIN
    IF tipoCosteo = 'P' OR tipoCosteo = 'U' THEN
        IF tipoCosteo = 'P' THEN
            -- Debes crear la función costoPromedio en PostgreSQL si la necesitas
            PERFORM costoPromedio(codigoProducto, fecha, costo);
        END IF;
        IF tipoCosteo = 'U' OR costo = 0 THEN
            SELECT costototal/cantidad INTO costo
            FROM productosmovimientos
            WHERE codigoproducto = codigoProducto
              AND (LEFT(tipo,1) = 'E' OR tipo = 'AE' OR tipo = 'DV')
              AND fecha <= fecha
            ORDER BY fecha DESC
            LIMIT 1;
        END IF;

        INSERT INTO productosmovimientos (
            codigoproducto, fecha, tipo, numero, unidadmedida, cantidad, origen,
            proveedorcliente, almacen, costototal
        ) VALUES (
            codigoProducto, fecha, tipo, numero, unidadMedida, ABS(cantidadSalida), origen,
            proveedorCliente, almacen, ABS(costo * cantidadSalida)
        );
    ELSE
        IF tipoCosteo = 'L' THEN
            FOR rec IN
                SELECT cantidad, cantidadusada, costototal, registro
                FROM productosmovimientos
                WHERE codigoproducto = codigoProducto
                  AND (LEFT(tipo,1) = 'E' OR tipo = 'AE' OR tipo = 'DV')
                  AND cantidad > cantidadusada
                  AND almacen = almacen
                  AND fecha <= fecha
                ORDER BY fecha DESC
            LOOP
                xcant := cantidadSalida;
                WHILE xcant <> 0 LOOP
                    IF tipo IN ('SA', 'AS', 'DC') THEN
                        disponible := rec.cantidad - rec.cantidadusada;
                        IF xcant <= disponible THEN
                            cantidadSalida := xcant;
                            xcant := 0;
                        ELSE
                            xcant := xcant - disponible;
                            cantidadSalida := disponible;
                        END IF;
                        UPDATE productosmovimientos
                        SET cantidadusada = cantidadusada + cantidadSalida
                        WHERE registro = rec.registro;
                    ELSE
                        xcant := 0;
                        cantidadSalida := ABS(cantidadSalida);
                    END IF;
                    costo := rec.costototal / rec.cantidad;
                    INSERT INTO productosmovimientos (
                        codigoproducto, fecha, tipo, numero, unidadmedida, cantidad, origen,
                        proveedorcliente, almacen, costototal
                    ) VALUES (
                        codigoProducto, fecha, tipo, numero, unidadMedida, cantidadSalida, origen,
                        proveedorCliente, almacen, costo * cantidadSalida
                    );
                END LOOP;
            END LOOP;
        ELSIF tipoCosteo = 'F' THEN
            FOR rec IN
                SELECT cantidad, cantidadusada, costototal, registro
                FROM productosmovimientos
                WHERE codigoproducto = codigoProducto
                  AND (LEFT(tipo,1) = 'E' OR tipo = 'AE' OR tipo = 'DV')
                  AND cantidad > cantidadusada
                  AND almacen = almacen
                  AND fecha <= fecha
                ORDER BY fecha
            LOOP
                xcant := cantidadSalida;
                WHILE xcant <> 0 LOOP
                    IF tipo IN ('SA', 'AS', 'DC') THEN
                        disponible := rec.cantidad - rec.cantidadusada;
                        IF xcant <= disponible THEN
                            cantidadSalida := xcant;
                            xcant := 0;
                        ELSE
                            xcant := xcant - disponible;
                            cantidadSalida := disponible;
                        END IF;
                        UPDATE productosmovimientos
                        SET cantidadusada = cantidadusada + cantidadSalida
                        WHERE registro = rec.registro;
                    ELSE
                        xcant := 0;
                        cantidadSalida := ABS(cantidadSalida);
                    END IF;
                    costo := rec.costototal / rec.cantidad;
                    INSERT INTO productosmovimientos (
                        codigoproducto, fecha, tipo, numero, unidadmedida, cantidad, origen,
                        proveedorcliente, almacen, costototal
                    ) VALUES (
                        codigoProducto, fecha, tipo, numero, unidadMedida, cantidadSalida, origen,
                        proveedorCliente, almacen, costo * cantidadSalida
                    );
                END LOOP;
            END LOOP;
        ELSE
            SELECT costo INTO costo FROM productos WHERE codigoproducto = codigoProducto;
            INSERT INTO productosmovimientos (
                codigoproducto, fecha, tipo, numero, unidadmedida, cantidad, origen,
                proveedorcliente, almacen, costototal
            ) VALUES (
                codigoProducto, fecha, tipo, numero, unidadMedida, ABS(cantidadSalida), origen,
                proveedorCliente, almacen, ABS(costo * cantidadSalida)
            );
        END IF;
    END IF;

    UPDATE productos SET costo = costo WHERE codigoproducto = codigoProducto;
END;
$$ LANGUAGE plpgsql;


-- SalidaNotaEntrega
CREATE OR REPLACE FUNCTION salidaNotaEntrega(numero CHAR(8))
RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT fr.codigoproducto, f.fechaemision, fr.unidadmedida, fr.bultos * fr.cantidad AS cantidadSalida,
               f.codigocliente, fr.almacen, p.tipocosteo
        FROM notasentregarenglones fr
        INNER JOIN notasentrega f ON fr.numero = f.numero
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = numero
    LOOP
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fechaemision, numero, rec.unidadmedida,
            rec.cantidadSalida, rec.codigocliente, rec.almacen, 'SA', 'NOE'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SalidaNotaVenta
CREATE OR REPLACE FUNCTION salidaNotaVenta(numero CHAR(8))
RETURNS void AS $$
DECLARE
    rec RECORD;
    tipo CHAR(2);
BEGIN
    FOR rec IN
        SELECT fr.codigoproducto, f.fecha, fr.unidad, fr.cantidad AS cantidadSalida,
               f.cliente, fr.almacen, p.tipocosteo
        FROM notaventacuerpo fr
        INNER JOIN notaventa f ON fr.numero = f.numero
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = numero
    LOOP
        IF rec.cantidadSalida >= 0 THEN
            tipo := 'SA';
        ELSE
            tipo := 'DV';
        END IF;
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fecha, numero, rec.unidad,
            rec.cantidadSalida, rec.cliente, rec.almacen, tipo, 'NOV'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;




-- SalidaProduccion
CREATE OR REPLACE FUNCTION salidaProduccion(numero CHAR(8))
RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT opr.codigoproducto, op.fechainicio, p.unidadmedida, opr.cantidad * op.cantidad AS cantidadSalida,
               opr.almacen, p.tipocosteo
        FROM ordenesproduccionrenglones opr
        INNER JOIN ordenesproduccion op ON opr.numero = op.numero
        INNER JOIN productos p ON opr.codigoproducto = p.codigoproducto
        WHERE opr.numero = numero
    LOOP
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fechainicio, numero, rec.unidadmedida,
            rec.cantidadSalida, NULL, rec.almacen, 'SA', 'ODP'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SalidaProduccion2
CREATE OR REPLACE FUNCTION salidaProduccion2(numero CHAR(8), cantidad NUMERIC)
RETURNS void AS $$
DECLARE
    codigoproducto CHAR(50);
    producir NUMERIC;
    rec RECORD;
    cantidadSalida NUMERIC;
BEGIN
    SELECT codigoproducto INTO codigoproducto FROM ordenesproduccion WHERE numero = numero;
    SELECT producir INTO producir FROM productos WHERE codigoproducto = codigoproducto;
    IF producir IS NULL OR producir <= 0 THEN
        producir := 1;
    END IF;

    FOR rec IN
        SELECT pc.codigocomponente, op.fechainicio, p.unidadmedida, pc.cantidad * op.cantidad AS cantidads,
               op.almacensalida, p.tipocosteo
        FROM productoscomposicion pc
        INNER JOIN ordenesproduccion op ON pc.codigoproducto = op.codigoproducto
        INNER JOIN productos p ON pc.codigocomponente = p.codigoproducto
        WHERE op.numero = numero
    LOOP
        cantidadSalida := rec.cantidads * cantidad / producir;
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigocomponente, rec.fechainicio, numero, rec.unidadmedida,
            cantidadSalida, NULL, rec.almacensalida, 'SA', 'ODP'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SalidaTransferencia
CREATE OR REPLACE FUNCTION salidaTransferencia(numero CHAR(8))
RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT tr.codigoproducto, t.fechaemision, p.unidadmedida, tr.bultos * tr.cantidad AS cantidadSalida,
               tr.almacenorigen, p.tipocosteo
        FROM transferenciasrenglones tr
        INNER JOIN transferencias t ON tr.numero = t.numero
        INNER JOIN productos p ON tr.codigoproducto = p.codigoproducto
        WHERE tr.numero = numero
    LOOP
        PERFORM salidaInventario(
            rec.tipocosteo, rec.codigoproducto, rec.fechaemision, numero, rec.unidadmedida,
            rec.cantidadSalida, NULL, rec.almacenorigen, 'SA', 'TRF'
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;



-- Series
CREATE OR REPLACE FUNCTION series()
RETURNS void AS $$
DECLARE
    rec RECORD;
    aux NUMERIC;
    cant NUMERIC;
BEGIN
    -- Elimina la tabla temporal si existe
    DROP TABLE IF EXISTS seriestmp;

    -- Crea la tabla temporal
    CREATE TEMP TABLE seriestmp (
        numero NUMERIC,
        fechaemision TIMESTAMP,
        codigocliente CHAR(20),
        nombre CHAR(50),
        rif CHAR(22),
        nit CHAR(22),
        direccion TEXT,
        telofonos TEXT,
        fax TEXT,
        totalbruto NUMERIC,
        descuento NUMERIC,
        impuesto NUMERIC,
        cargo CHAR(22),
        totalnotaentrega NUMERIC,
        porcentajedescuento CHAR(80),
        vendedor CHAR(5),
        nombre1 TEXT,
        direccionenvio TEXT,
        comentarios TEXT,
        estatus TEXT,
        codigoproducto CHAR(50),
        descripcion CHAR(50),
        unidadmedida CHAR(12),
        porcentajeiva CHAR(200),
        bultos REAL,
        cantidad NUMERIC,
        precio NUMERIC,
        rendesc NUMERIC,
        totalrenglon NUMERIC,
        empnom TEXT,
        empdir TEXT,
        telefono TEXT,
        emprif TEXT,
        empnit TEXT,
        nota CHAR(300)
    );

    FOR rec IN
        SELECT 
            sc.nomEnt AS numero,
            sc.fecha AS fechaemision,
            f.referencia AS codigocliente,
            c.nombre,
            c.rif,
            c.nit,
            c.direccion,
            c.telefonos,
            sc.serie AS fax,
            0 AS totalbruto,
            0 AS descuento,
            0 AS impuesto,
            'Nada' AS cargo,
            0 AS totalnotaentrega,
            '' AS porcentajedescuento,
            'Vend' AS vendedor,
            c.personacontacto AS nombre1,
            'NN' AS direccionenvio,
            'Nin' AS comentarios,
            'E' AS estatus,
            p.codigoproducto,
            p.nombre AS descripcion,
            '' AS unidadmedida,
            'Garantia: ' || COALESCE(p.garantia::TEXT, '') || ' Meses' AS porcentajeiva,
            0 AS bultos,
            1 AS cantidad,
            0 AS precio,
            0 AS rendesc,
            0 AS totalrenglon,
            e.nombre AS empnom,
            e.direccion AS empdir,
            e.telefono,
            e.rif AS emprif,
            sc.nomdoc AS empnit,
            sc.nota
        FROM facturas f
        INNER JOIN clientes c ON f.codigocliente = c.codigocliente
        INNER JOIN seriecuerpo sc ON f.numero = sc.nomdoc
        INNER JOIN productos p ON sc.codigoproducto = p.codigoproducto
        CROSS JOIN empresa e
    LOOP
        SELECT COUNT(*) INTO cant FROM seriecuerpo WHERE noment = rec.numero AND codigoproducto = rec.codigoproducto;
        SELECT COUNT(*) INTO aux FROM seriestmp WHERE numero = rec.numero AND codigoproducto = rec.codigoproducto;

        IF rec.nota IS NOT NULL THEN
            rec.nota := 'OBSERVACION: ' || rec.nota;
        END IF;

        IF aux > 0 THEN
            rec.descripcion := NULL;
            cant := NULL;
            rec.codigoproducto := NULL;
            rec.porcentajeiva := NULL;
        END IF;

        INSERT INTO seriestmp (
            numero, fechaemision, codigocliente, nombre, rif, nit, direccion, telofonos, fax,
            totalbruto, descuento, impuesto, cargo, totalnotaentrega, porcentajedescuento,
            vendedor, nombre1, direccionenvio, comentarios, estatus, codigoproducto, descripcion,
            unidadmedida, porcentajeiva, bultos, cantidad, precio, rendesc, totalrenglon,
            empnom, empdir, telefono, emprif, empnit, nota
        ) VALUES (
            rec.numero, rec.fechaemision, rec.codigocliente, rec.nombre, rec.rif, rec.nit, rec.direccion, rec.telofonos, rec.fax,
            rec.totalbruto, rec.descuento, rec.impuesto, rec.cargo, rec.totalnotaentrega, rec.porcentajedescuento,
            rec.vendedor, rec.nombre1, rec.direccionenvio, rec.comentarios, rec.estatus, rec.codigoproducto, rec.descripcion,
            rec.unidadmedida, rec.porcentajeiva, rec.bultos, cant, rec.precio, rec.rendesc, rec.totalrenglon,
            rec.empnom, rec.empdir, rec.telefono, rec.emprif, rec.empnit, rec.nota
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- spAmexco
CREATE OR REPLACE FUNCTION spAmexco(fecDesde VARCHAR, fecHasta VARCHAR)
RETURNS void AS $$
BEGIN
    DROP TABLE IF EXISTS tmpconsulta;

    CREATE TEMP TABLE tmpconsulta (
        codigoproducto CHAR(50) NOT NULL,
        nombre CHAR(50),
        fecha TIMESTAMP,
        numero CHAR(8),
        cantidad NUMERIC,
        origen CHAR(8),
        tipo CHAR(8),
        unidadmedida CHAR(12),
        costototal NUMERIC,
        existencia NUMERIC
    );

    INSERT INTO tmpconsulta
    SELECT
        pm.codigoproducto,
        p.nombre AS nombre,
        pm.fecha,
        pm.numero,
        pm.cantidad,
        pm.origen,
        pm.tipo,
        pm.unidadmedida,
        p.ultimocosto,
        p.existencia
    FROM productos p
    FULL OUTER JOIN productosmovimientos pm ON p.codigoproducto = pm.codigoproducto
    WHERE pm.tipo <> 'en'
      AND pm.origen <> 'TRF'
      AND pm.origen <> 'NOE'
      AND pm.fecha BETWEEN fecDesde::timestamp AND fecHasta::timestamp;
END;
$$ LANGUAGE plpgsql;

-- 1. Actualizar estado de cotización
CREATE OR REPLACE PROCEDURE actualizarEstadoCotizacion(
    IN pNumero VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(
        SELECT estatus FROM cotizacionesrenglones 
        WHERE estatus = 'PE' AND numero = pNumero 
        AND codigoproducto <> '*D' AND TRIM(codigoproducto) <> ''
    ) THEN
        UPDATE cotizaciones SET estatus = 'PE' WHERE numero = pNumero;
    ELSE
        UPDATE cotizaciones SET estatus = 'OK' WHERE numero = pNumero;
    END IF;
END;
$$;

-- 2. Actualizar estado de nota de entrega
CREATE OR REPLACE PROCEDURE actualizarEstadoNotaEntrega(
    IN pNumero VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(
        SELECT estatus FROM notasentregarenglones 
        WHERE estatus = 'PE' AND numero = pNumero 
        AND codigoproducto <> '*D' AND TRIM(codigoproducto) <> ''
    ) THEN
        UPDATE notasentrega SET estatus = 'PE' WHERE numero = pNumero;
    ELSE
        UPDATE notasentrega SET estatus = 'OK' WHERE numero = pNumero;
    END IF;
END;
$$;

-- 3. Actualizar estado de orden de compra
CREATE OR REPLACE PROCEDURE actualizarEstadoOrdenCompra(
    IN pNumero VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(
        SELECT estatus FROM ordenescomprarenglones 
        WHERE estatus = 'PE' AND numero = pNumero 
        AND codigoproducto <> '*D' AND TRIM(codigoproducto) <> ''
    ) THEN
        UPDATE ordenescompra SET estatus = 'PE' WHERE numero = pNumero;
    ELSE
        UPDATE ordenescompra SET estatus = 'OK' WHERE numero = pNumero;
    END IF;
END;
$$;

-- 4. Actualizar estado de pedido
CREATE OR REPLACE PROCEDURE actualizarEstadoPedido(
    IN pNumero VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(
        SELECT estatus FROM pedidosrenglones 
        WHERE estatus = 'PE' AND numero = pNumero 
        AND codigoproducto <> '*D' AND TRIM(codigoproducto) <> ''
    ) THEN
        UPDATE pedidos SET estatus = 'PE' WHERE numero = pNumero;
    ELSE
        UPDATE pedidos SET estatus = 'OK' WHERE numero = pNumero;
    END IF;
END;
$$;

-- 5. Actualizar estado de recepción
CREATE OR REPLACE PROCEDURE actualizarEstadoRecepcion(
    IN pNumero VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(
        SELECT estatus FROM recepcionesrenglones 
        WHERE estatus = 'PE' AND numero = pNumero 
        AND codigoproducto <> '*D' AND TRIM(codigoproducto) <> ''
    ) THEN
        UPDATE recepciones SET estatus = 'PE' WHERE numero = pNumero;
    ELSE
        UPDATE recepciones SET estatus = 'OK' WHERE numero = pNumero;
    END IF;
END;
$$;

-- 6. Actualizar estado de requisición
CREATE OR REPLACE PROCEDURE actualizarEstadoRequisicion(
    IN pNumero VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS(
        SELECT estatus FROM requisicionesrenglones 
        WHERE estatus = 'PE' AND numero = pNumero 
        AND TRIM(codigoproducto) <> ''
    ) THEN
        UPDATE requisiciones SET estatus = 'PE' WHERE numero = pNumero;
    ELSE
        UPDATE requisiciones SET estatus = 'OK' WHERE numero = pNumero;
    END IF;
END;
$$;

-- 7. Aumentar existencia de productos
CREATE OR REPLACE PROCEDURE aumentarExistenciaProducto(
    IN pNumeroFactura VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    vCodigoProducto VARCHAR(50);
    vCantidad NUMERIC(19,4);
    vAlmacen VARCHAR(5);
BEGIN
    FOR vCodigoProducto, vCantidad, vAlmacen IN 
        SELECT fr.codigoproducto, fr.cantidad, fr.almacen
        FROM facturasrenglones fr
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto
        WHERE fr.numero = pNumeroFactura AND fr.pedido IS NULL
    LOOP
        UPDATE productos 
        SET existencia = existencia + vCantidad 
        WHERE codigoproducto = vCodigoProducto;
        
        UPDATE productosexistencias 
        SET existencia = existencia + vCantidad 
        WHERE codigoproducto = vCodigoProducto AND almacen = vAlmacen;
    END LOOP;
END;
$$;

-- 8. Calcular costo de producto
CREATE OR REPLACE PROCEDURE calcularCostoProducto(
    IN pCodigoProducto VARCHAR(50),
    OUT pCosto NUMERIC(19,4),
    OUT pExistencia NUMERIC(19,4)
)
LANGUAGE plpgsql
AS $$
BEGIN
    CALL calcularCostoPromedio(pCodigoProducto, CURRENT_DATE, pCosto, pExistencia);
END;
$$;

-- 9. Cambiar estatus de orden de compra
CREATE OR REPLACE PROCEDURE cambiarEstatusOrdenCompra(
    IN pNumeroDocumento VARCHAR(8)
)
LANGUAGE plpgsql
AS $$
DECLARE
    vCodigoProducto VARCHAR(50);
    vSinDespachar NUMERIC(19,4);
BEGIN
    UPDATE ordenescomprarenglones 
    SET sindespachar = cantidad * bultos - despacho, 
        estatus = 'OK' 
    WHERE numero = pNumeroDocumento;
    
    UPDATE ordenescomprarenglones 
    SET fechaentrega = CURRENT_DATE
    WHERE numero = pNumeroDocumento AND sindespachar > 0;
    
    UPDATE ordenescompra 
    SET estatus = 'OK' 
    WHERE numero = pNumeroDocumento;
    
    FOR vCodigoProducto, vSinDespachar IN 
        SELECT fr.codigoproducto, fr.sindespachar 
        FROM ordenescomprarenglones fr
        INNER JOIN productos p ON fr.codigoproducto = p.codigoproducto 
        WHERE fr.numero = pNumeroDocumento
    LOOP
        UPDATE productos 
        SET pedidocompra = pedidocompra - vSinDespachar
        WHERE codigoproducto = vCodigoProducto;
    END LOOP;
END;
$$;

-- 10. Decodificar códigos de peso
CREATE OR REPLACE PROCEDURE decodificarCodigoPeso(
    IN pCodigo VARCHAR(15),
    OUT pSubCodigo VARCHAR(15),
    OUT pPeso NUMERIC(10,3)
)
LANGUAGE plpgsql
AS $$
BEGIN
    pSubCodigo := SUBSTRING(pCodigo FROM 4 FOR 5);
    
    IF SUBSTRING(pCodigo FROM 1 FOR 3) = '020' THEN
        pPeso := CAST(SUBSTRING(pCodigo FROM 9 FOR 2) AS INTEGER) + 
                (CAST(SUBSTRING(pCodigo FROM 11 FOR 3) AS NUMERIC) / 1000);
    ELSE
        pSubCodigo := '';
        pPeso := 0;
    END IF;
END;
$$;

-- 11. Calcular costo promedio (simplificado)
CREATE OR REPLACE PROCEDURE calcularCostoPromedio(
    IN pCodigoProducto VARCHAR(50),
    IN pFecha DATE,
    OUT pCosto NUMERIC(19,4),
    OUT pExistencia NUMERIC(19,4)
)
LANGUAGE plpgsql
AS $$
DECLARE
    vEntrada NUMERIC(19,4);
    vAcumuladoEntrada NUMERIC(38,4);
    vSalida NUMERIC(19,4);
    vAcumuladoSalida NUMERIC(38,4);
BEGIN
    SELECT ac_cantidadentrada, ac_costoentrada, ac_cantidadsalida, ac_costosalida
    INTO vEntrada, vAcumuladoEntrada, vSalida, vAcumuladoSalida
    FROM productos 
    WHERE codigoproducto = pCodigoProducto;
    
    pExistencia := vEntrada - vSalida;
    pCosto := CASE WHEN pExistencia > 0 THEN (vAcumuladoEntrada - vAcumuladoSalida) / pExistencia ELSE 0 END;
END;
$$;

-- 12. Calcular costo promedio (detallado)
CREATE OR REPLACE PROCEDURE calcularCostoPromedioDetallado(
    IN pCodigoProducto VARCHAR(50),
    IN pFecha DATE,
    OUT pCosto NUMERIC(19,4),
    OUT pExistencia NUMERIC(19,4)
)
LANGUAGE plpgsql
AS $$
DECLARE
    vTipo VARCHAR(2);
    vCostoTotal NUMERIC(19,4);
    vCantidad NUMERIC(19,4);
    vEntrada NUMERIC(19,4) := 0;
    vAcumuladoEntrada NUMERIC(19,4) := 0;
    vSalida NUMERIC(19,4) := 0;
    vAcumuladoSalida NUMERIC(19,4) := 0;
BEGIN
    FOR vTipo, vCantidad, vCostoTotal IN 
        SELECT tipo, cantidad, costototal 
        FROM productosmovimientos
        WHERE codigoproducto = pCodigoProducto AND fecha <= pFecha
    LOOP
        IF LEFT(vTipo, 1) = 'E' OR vTipo = 'AE' OR vTipo = 'DV' THEN
            vEntrada := vEntrada + vCantidad;
            vAcumuladoEntrada := vAcumuladoEntrada + vCostoTotal;
        ELSE
            vSalida := vSalida + vCantidad;
            vAcumuladoSalida := vAcumuladoSalida + vCostoTotal;
        END IF;
    END LOOP;
    
    pExistencia := vEntrada - vSalida;
    pCosto := CASE WHEN pExistencia > 0 THEN (vAcumuladoEntrada - vAcumuladoSalida) / pExistencia ELSE 0 END;
END;
$$;

-- 13. Procesar devolución de compra
CREATE OR REPLACE PROCEDURE procesarDevolucionCompra(
    IN pNumeroDocumento VARCHAR(8),
    IN pCodigoProveedor VARCHAR(20))
LANGUAGE plpgsql
AS $$
DECLARE
    vCodigoProducto VARCHAR(50);
    vFecha DATE;
    vUnidadMedida VARCHAR(12);
    vCantidadSalida NUMERIC(19,4);
    vAlmacen VARCHAR(5);
    vTipoCosteo VARCHAR(1);
BEGIN
    FOR vCodigoProducto, vFecha, vUnidadMedida, vCantidadSalida, vAlmacen, vTipoCosteo IN 
        SELECT tr.codigoproducto, t.fechaemision, p.unidadmedida, 
               ABS(tr.bultos * tr.cantidad), tr.almacen, p.tipocosteo
        FROM comprasrenglones tr 
        INNER JOIN compras t ON tr.numero = t.numero
        INNER JOIN productos p ON tr.codigoproducto = p.codigoproducto
        WHERE tr.numero = pNumeroDocumento
    LOOP
        CALL registrarSalidaInventario(
            vTipoCosteo, vCodigoProducto, vFecha, pNumeroDocumento, 
            vUnidadMedida, vCantidadSalida, pCodigoProveedor, 
            vAlmacen, 'DC', 'CPA'
        );
    END LOOP;
END;
$$;

-- 14. Recostear todos los productos
CREATE OR REPLACE PROCEDURE recostearTodosProductos()
LANGUAGE plpgsql
AS $$
DECLARE
    vCodigoProducto VARCHAR(50);
BEGIN
    FOR vCodigoProducto IN SELECT codigoproducto FROM productos
    LOOP
        CALL recostearProducto(vCodigoProducto);
    END LOOP;
END;
$$;

-- 15. Obtener existencia en fecha específica
CREATE OR REPLACE PROCEDURE obtenerExistenciaEnFecha(
    IN pCodigoProducto VARCHAR(50),
    IN pAlmacen VARCHAR(5),
    IN pFecha DATE,
    OUT pExistencia NUMERIC(19,4))
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(CASE WHEN tipo IN ('EN','AE','DV') THEN cantidad ELSE -cantidad END)
    INTO pExistencia
    FROM productosmovimientos
    WHERE codigoproducto = pCodigoProducto 
      AND almacen = pAlmacen 
      AND fecha <= pFecha;
END;
$$;

-- 16. Obtener existencia por almacén
CREATE OR REPLACE PROCEDURE obtenerExistenciaPorAlmacen(
    IN pCodigoProducto VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT pa.nombre AS "Almacen", 
           SUM(CASE WHEN pm.tipo IN ('EN','AE','DV') THEN pm.cantidad ELSE -pm.cantidad END) AS "Existencia"
    FROM productosmovimientos pm
    JOIN productosalmacenes pa ON pm.almacen = pa.almacen
    WHERE pm.codigoproducto = pCodigoProducto
    GROUP BY pa.nombre;
END;
$$;

-- 17. Procedimiento para generar giros de cliente
CREATE OR REPLACE PROCEDURE generarGirosCliente(
    IN pCodigoCliente VARCHAR(20),
    IN pEmision TIMESTAMP,
    IN pNumeroDocumento VARCHAR(8),
    IN pSerie VARCHAR(3),
    IN pConcepto VARCHAR(50),
    IN pVendedor VARCHAR(5),
    IN pCapital NUMERIC(19,4),
    IN pInteres REAL,
    IN pAnos NUMERIC(19,4),
    IN pCuotas INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    vGiros INTEGER;
    vImporte NUMERIC(19,4);
    vPeriodo INTEGER;
    vContador INTEGER := 1;
    vVencimiento TIMESTAMP;
    vNumero VARCHAR(8);
    vPostfijo VARCHAR(4);
    vAcarreo INTEGER;
    vAcarreo1 INTEGER;
    vDia INTEGER;
    vMes INTEGER;
    vAno INTEGER;
BEGIN
    vGiros := pAnos * pCuotas;
    vPeriodo := ROUND(pAnos * 360 / vGiros);
    vImporte := ROUND(pCapital * ((pInteres/100)/pCuotas) / 
                     (1 - POWER((1 + (pInteres/100)/pCuotas), (-pCuotas*pAnos))), 2);
    
    vVencimiento := pEmision;
    vPostfijo := '/' || LPAD(vGiros::TEXT, 2, '0');
    
    WHILE vContador <= vGiros LOOP
        vNumero := pSerie || LPAD(vContador::TEXT, 2, '0') || vPostfijo;
        
        vMes := EXTRACT(MONTH FROM vVencimiento);
        vDia := EXTRACT(DAY FROM vVencimiento);
        vAno := EXTRACT(YEAR FROM vVencimiento);
        
        IF vMes = 2 AND vDia >= 28 THEN 
            vDia := 30;
        END IF;
        
        vAcarreo := (vDia + vPeriodo - 1) / 30;
        vDia := (vDia + vPeriodo - 1) - 30 * vAcarreo + 1;
        vAcarreo1 := ((vMes + vAcarreo - 1) / 12);
        vMes := (vMes + vAcarreo - 1) - 12 * vAcarreo1 + 1;
        vAno := (vAno + vAcarreo1) - 100 * ((vAno + vAcarreo1)/10000);
        
        IF vMes = 2 AND vDia > 28 THEN 
            vDia := 28;
        END IF;
        
        vVencimiento := MAKE_DATE(vAno, vMes, vDia);
        
        INSERT INTO clientesmovimientos (
            codigocliente, tipo, ntipo, numero, emision, vencimiento, 
            referencia, concepto, importe, numeroorigen, origen, vendedor
        ) VALUES (
            pCodigoCliente, 'GR', '0', vNumero, pEmision, vVencimiento,
            pNumeroDocumento, pConcepto, vImporte, pNumeroDocumento, 'FAC', pVendedor
        );
        
        vContador := vContador + 1;
    END LOOP;
END;
$$;

-- 18. Procedimiento para generar ITF bancario
CREATE OR REPLACE PROCEDURE generarItfBancario(
    IN pCodigoBanco VARCHAR(5),
    IN pMes INTEGER,
    IN pAno INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    vTipo VARCHAR(2);
    vImporte NUMERIC(19,4);
    vFecha TIMESTAMP;
    vConcepto VARCHAR(50);
    vNumero VARCHAR(12);
    vOrigen VARCHAR(3);
    vCursor REFCURSOR;
BEGIN
    DELETE FROM bancosmovimientos 
    WHERE codigobanco = pCodigoBanco 
      AND EXTRACT(MONTH FROM fecha) = pMes 
      AND EXTRACT(YEAR FROM fecha) = pAno 
      AND (tipo = 'IT' OR tipo = 'DB');
    
    OPEN vCursor FOR
        SELECT tipo, fecha, numero, importe, origen 
        FROM bancosmovimientos 
        WHERE codigobanco = pCodigoBanco 
          AND EXTRACT(MONTH FROM fecha) = pMes 
          AND EXTRACT(YEAR FROM fecha) = pAno 
          AND (tipo = 'CH' OR tipo = 'ND');
    
    LOOP
        FETCH vCursor INTO vTipo, vFecha, vNumero, vImporte, vOrigen;
        EXIT WHEN NOT FOUND;
        
        vImporte := vImporte * 0.50 / 100;
        
        INSERT INTO bancosmovimientos (
            codigobanco, fecha, tipo, numero, concepto, importe, origen
        ) VALUES (
            pCodigoBanco, vFecha, 'DB', vNumero, 
            'Impuesto débito bancario ' || vTipo, vImporte, vOrigen
        );
    END LOOP;
    
    CLOSE vCursor;
END;
$$;

-- 19. Procedimiento para generar giros de proveedor
CREATE OR REPLACE PROCEDURE generarGirosProveedor(
    IN pCodigoProveedor VARCHAR(20),
    IN pEmision TIMESTAMP,
    IN pNumeroDocumento VARCHAR(8),
    IN pSerie VARCHAR(3),
    IN pConcepto VARCHAR(50),
    IN pCapital NUMERIC(19,4),
    IN pInteres REAL,
    IN pAnos NUMERIC(19,4),
    IN pCuotas INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    vGiros INTEGER;
    vImporte NUMERIC(19,4);
    vPeriodo INTEGER;
    vContador INTEGER := 1;
    vVencimiento TIMESTAMP;
    vNumero VARCHAR(8);
    vPostfijo VARCHAR(4);
    vAcarreo INTEGER;
    vAcarreo1 INTEGER;
    vDia INTEGER;
    vMes INTEGER;
    vAno INTEGER;
BEGIN
    vGiros := pAnos * pCuotas;
    vPeriodo := ROUND(pAnos * 360 / vGiros);
    vImporte := ROUND(pCapital * ((pInteres/100)/pCuotas) / 
                (1 - POWER((1 + (pInteres/100)/pCuotas), (-pCuotas*pAnos))), 2);
    
    vVencimiento := pEmision;
    vPostfijo := '/' || LPAD(vGiros::TEXT, 2, '0');
    
    WHILE vContador <= vGiros LOOP
        vNumero := pSerie || LPAD(vContador::TEXT, 2, '0') || vPostfijo;
        
        vMes := EXTRACT(MONTH FROM vVencimiento);
        vDia := EXTRACT(DAY FROM vVencimiento);
        vAno := EXTRACT(YEAR FROM vVencimiento);
        
        IF vMes = 2 AND vDia = 28 THEN 
            vDia := 30;
        END IF;
        
        vAcarreo := (vDia + vPeriodo - 1) / 30;
        vDia := (vDia + vPeriodo - 1) - 30 * vAcarreo + 1;
        vAcarreo1 := ((vMes + vAcarreo - 1) / 12);
        vMes := (vMes + vAcarreo - 1) - 12 * vAcarreo1 + 1;
        vAno := (vAno + vAcarreo1) - 100 * ((vAno + vAcarreo1)/10000);
        
        IF vMes = 2 AND vDia > 28 THEN 
            vDia := 28;
        END IF;
        
        vVencimiento := MAKE_DATE(vAno, vMes, vDia);
        
        INSERT INTO proveedoresmovimientos (
            codigoproveedor, tipo, ntipo, numero, emision, vencimiento, 
            referencia, concepto, importe, numeroorigen, origen
        ) VALUES (
            pCodigoProveedor, 'GR', '0', vNumero, pEmision, vVencimiento,
            pNumeroDocumento, pConcepto, vImporte, pNumeroDocumento, 'CPA'
        );
        
        vContador := vContador + 1;
    END LOOP;
END;
$$;