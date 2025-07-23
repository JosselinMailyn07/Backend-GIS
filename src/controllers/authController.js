const { generalPool } = require('../config/bd');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

/**
 * Controlador para el proceso de login.
 * 
 * @param {object} req - Objeto de la petición (request).
 * @param {object} res - Objeto de la respuesta (response).
 */
const login = async (req, res) => {
    // Extraigo el email y la contraseña del cuerpo de la petición.
    const { email, password } = req.body;

    // Verificación básica de que los datos llegaron.
    if (!email || !password) {
        return res.status(400).json({ message: 'El email y la contraseña son obligatorios.' });
    }

    try {
        // 1. Busco al usuario en la tabla `usuarios` de la BD General.
        // Uso una consulta parametrizada ($1) para evitar inyección SQL.
        const userQuery = await generalPool.query('SELECT * FROM usuarios WHERE email = $1', [email]);
        
        // Si no encuentro ningún usuario con ese email, devuelvo un error genérico.
        if (userQuery.rows.length === 0) {
            return res.status(401).json({ message: 'Credenciales inválidas.' });
        }
        const usuario = userQuery.rows[0];

        // 2. Comparo la contraseña que me enviaron con el hash que tengo en la BD.
        const isMatch = await bcrypt.compare(password, usuario.password_hash);
        if (!isMatch) {
            // Si no coinciden, devuelvo el mismo error genérico para no dar pistas a atacantes.
            return res.status(401).json({ message: 'Credenciales inválidas.' });
        }

        // 3. Si el usuario es válido, busco los datos de la empresa a la que pertenece.
        const empresaQuery = await generalPool.query('SELECT * FROM empresas WHERE codigoEmpresa = $1', [usuario.empresa_codigo]);
        if (empresaQuery.rows.length === 0) {
            // Esto sería un error de integridad de datos, no debería pasar si todo está bien configurado.
            return res.status(500).json({ message: 'Error interno: La empresa asociada al usuario no fue encontrada.' });
        }
        const empresa = empresaQuery.rows[0];

        // 4. Preparo el "payload", que es la información que guardaré dentro del token.
        // Esto me permitirá saber quién es el usuario y a qué empresa pertenece en las futuras peticiones.
        const payload = {
            usuario: {
                id: usuario.id,
                email: usuario.email,
                rol: usuario.rol,
            },
            empresa: {
                codigo: empresa.codigoempresa,
                nombre: empresa.nombre,
                db: empresa.basededatos, // ¡Guardo el nombre de la BD de la empresa para conexiones futuras!
            }
        };

        // 5. Firmo y genero el JWT.
        // El token se firma con la clave secreta del .env para asegurar su integridad.
        jwt.sign(
            payload,
            process.env.JWT_SECRET,
            { expiresIn: '8h' }, // El token expirará en 8 horas.
            (error, token) => {
                if (error) throw error;
                // Si todo sale bien, envío el token al cliente.
                res.json({ token });
            }
        );

    } catch (error) {
        console.error("Error en el proceso de login:", error);
        res.status(500).send('Error en el servidor');
    }
};

const register = async (req, res) => {
    // Extraigo los datos del cuerpo de la petición.
    const { nombre, email, password, rol, codigoEmpresa } = req.body;

    // Verificación básica de que todos los datos necesarios están presentes.
    if (!email || !password || !nombre || !rol || !codigoEmpresa) {
        return res.status(400).json({ message: 'Todos los campos son obligatorios.' });
    }

    try {
        // 1. Primero, verifico si ya existe un usuario con ese correo electrónico.
        // No quiero tener usuarios duplicados.
        const userExists = await generalPool.query('SELECT * FROM usuarios WHERE email = $1', [email]);
        if (userExists.rows.length > 0) {
            return res.status(400).json({ message: 'El correo electrónico ya está registrado.' });
        }

        // 2. Luego, me aseguro de que la empresa a la que se va a asociar el usuario realmente exista.
        const empresaExists = await generalPool.query('SELECT * FROM empresas WHERE codigoEmpresa = $1', [codigoEmpresa]);
        if (empresaExists.rows.length === 0) {
            return res.status(400).json({ message: 'La empresa especificada no existe.' });
        }

        // 3. Ahora, hasheo la contraseña para no guardarla en texto plano.
        // Por seguridad, nunca se deben guardar las contraseñas directamente.
        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(password, salt);

        // 4. Finalmente, inserto el nuevo usuario en la base de datos.
        // Uso una consulta parametrizada para evitar inyección SQL.
        const newUserQuery = `
            INSERT INTO usuarios (nombre, email, password_hash, rol, empresa_codigo)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING id, email, rol;
        `;
        const newUser = await generalPool.query(newUserQuery, [nombre, email, password_hash, rol, codigoEmpresa]);

        // 5. Devuelvo una respuesta de éxito con los datos del usuario creado.
        // No devuelvo el hash de la contraseña, por supuesto.
        res.status(201).json({
            message: 'Usuario registrado exitosamente.',
            usuario: newUser.rows[0]
        });

    } catch (error) {
        console.error("Error en el proceso de registro:", error);
        res.status(500).send('Error en el servidor');
    }
};


// Exporto las funciones para que puedan ser usadas por los enrutadores.
module.exports = {
    login,
    register,
};
