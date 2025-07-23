const express = require('express');
const router = express.Router();

// Importo los diferentes enrutadores de la aplicación.
const authRoutes = require('./authRoutes');
const ejemploRoutes = require('./ejemplo');

// Asocio cada enrutador a su ruta base.
// Todo lo que esté en authRoutes estará bajo /api/auth
router.use('/auth', authRoutes);

// Estas son las rutas de ejemplo que ya existían.
// router.use('/example', ejemploRoutes);


module.exports = router;