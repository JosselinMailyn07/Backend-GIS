#  Backend-GIS - Documentación del Proyecto

Este documento detalla la estructura, configuración y funcionamiento del backend para el Sistema GIS. Está construido con **Node.js** y **Express**.

---

## 📁 Estructura del Proyecto

El backend sigue una arquitectura modular orientada a servicios para facilitar su mantenimiento y escalabilidad.

```txt
src/
│
├── config/         → Configuración de la base de datos (conexiones).
│   └── bd.js
│
├── controllers/    → Lógica de negocio (qué hacer con cada petición).
│   ├── authController.js
│   └── ...
│
├── db/             → Scripts SQL para la creación y poblado de la base de datos.
│   ├── GIS.sql
│   └── empresa004.sql
│
├── routes/         → Definición de las rutas de la API (endpoints).
│   ├── authRoutes.js
│   └── index.js
│
├── swagger/        → Configuración para la documentación de la API con Swagger.
│   └── swagger.js
│
├── app.js          → Archivo principal de la aplicación Express.
└── serve.js        → Archivo que inicia el servidor.

```

---

## 🚀 Comandos Disponibles

Para ejecutar el proyecto, utiliza los siguientes comandos en la terminal, dentro de la carpeta `Backend-GIS`:

```bash
# Instala todas las dependencias necesarias del proyecto.
npm install

# Inicia el servidor.
npm start
```

---

## ⚙️ Configuración del Entorno

Para que el backend funcione correctamente, es necesario crear un archivo `.env` en la raíz de la carpeta `Backend-GIS/`. Este archivo debe contener las siguientes variables de entorno para la conexión a la base de datos PostgreSQL:

```env
# Usuario de la base de datos
DB_USER=postgres

# Contraseña del usuario de la base de datos
DB_PASSWORD=tu_contraseña_de_postgres

# Host donde se encuentra la base de datos
DB_HOST=localhost

# Puerto de la base de datos
DB_PORT=5432

# Nombre de la base de datos "General" que contiene las tablas de usuarios y empresas
DB_NAME_GENERAL=GIS

# Clave secreta para firmar los JSON Web Tokens (JWT)
# Puede ser cualquier cadena de texto larga y segura.
JWT_SECRET=tu_clave_secreta_para_jwt
```

---

## 🔑 API Endpoints

La API está versionada bajo el prefijo `/api`.

### Autenticación (`/api/auth`)

*   **`POST /api/auth/login`**: Autentica a un usuario y devuelve un JWT.
    *   **Body**:
        ```json
        {
          "email": "correo@ejemplo.com",
          "password": "clave123"
        }
        ```

*   **`POST /api/auth/register`**: Registra un nuevo usuario en el sistema.
    *   **Body**:
        ```json
        {
          "nombre": "Nombre Apellido",
          "email": "nuevo.usuario@ejemplo.com",
          "password": "unaClaveSegura123",
          "rol": "administrador",
          "codigoEmpresa": "EMP001"
        }
        ```

---

## 🗃️ Base de Datos

El sistema utiliza una arquitectura de base de datos **multi-tenant**, donde hay una base de datos general (`GIS`) para la autenticación y la gestión de empresas, y luego cada empresa tiene su propia base de datos aislada para sus datos operativos.

*   **`GIS.sql`**: Contiene el script para crear la base de datos general y las tablas `usuarios` y `empresas`.
*   **`empresa004.sql`**: Contiene un ejemplo de la estructura de la base de datos para una empresa específica.

El módulo `src/config/bd.js` gestiona dinámicamente las conexiones a la base de datos correspondiente según el usuario que haya iniciado sesión.
