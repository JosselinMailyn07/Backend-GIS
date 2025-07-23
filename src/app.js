require('dotenv').config(); // Cargo las variables de entorno del archivo .env
const express = require('express');
const cors = require('cors');
const routes = require('./routes'); // Importa el enrutador principal

const app = express();

app.use(cors());
app.use(express.json());

// Usa el enrutador principal para todas las rutas bajo /api
app.use('/api', routes);

module.exports = app;
