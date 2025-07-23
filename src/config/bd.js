/**
 * Gestor de Conexiones a la Base de Datos
 * 
 * Este módulo se encarga de centralizar la creación de pools de conexiones a PostgreSQL.
 * Utiliza las variables de entorno para la configuración base.
 */
const { Pool } = require('pg');
require('dotenv').config();

// Lee la configuración base desde el archivo .env.
// Este objeto contendrá el usuario, host, password y puerto del servidor de BD.
const baseConfig = {
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
};

/**
 * Pool de Conexión a la Base de Datos General (GIS)
 * 
 * Este pool se conecta a la base de datos "maestra" que contiene las tablas `empresas` y `usuarios`.
 * Se usa siempre para operaciones de autenticación y para obtener la información de una empresa.
 */
const generalPool = new Pool({
    ...baseConfig,
    database: process.env.DB_NAME_GENERAL,
});

/**
 * Función para obtener un Pool de Conexión para una Empresa (Tenant)
 * 
 * Esta función es clave para la arquitectura multi-tenant. Una vez que se sabe a que empresa
 * pertenece un usuario, se llama a esta función pasándole el nombre de la base de datos
 * de su empresa para obtener un pool de conexión específico para esa BD.
 * 
 * @param {string} tenantDbName - El nombre de la base de datos de la empresa (ej. 'empresa_004_db').
 * @returns {Pool} Un nuevo pool de conexión para la base de datos de la empresa especificada.
 */
const getTenantPool = (tenantDbName) => {
    if (!tenantDbName) {
        throw new Error("Se requiere el nombre de la base de datos del tenant para crear una conexión.");
    }
    return new Pool({
        ...baseConfig,
        database: tenantDbName,
    });
};

module.exports = {
    generalPool,
    getTenantPool,
    // Se exporta 'query' como un atajo para hacer consultas directas al pool general.
    // Esto ahorra tener que escribir 'generalPool.query' cada vez.
    query: (text, params) => generalPool.query(text, params),
};