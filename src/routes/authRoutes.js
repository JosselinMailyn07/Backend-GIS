const express = require('express');
const router = express.Router();
const { login, register } = require('../controllers/authController');

// Defino la ruta para el login.
// Cuando llegue una petición POST a /api/auth/login, se ejecutará la función 'login' del controlador.
router.post('/login', login);

// Defino la ruta para el registro de nuevos usuarios.
// Cuando llegue una petición POST a /api/auth/register, se ejecutará la función 'register'.
router.post('/register', register);

module.exports = router;