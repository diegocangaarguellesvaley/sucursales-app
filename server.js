// backend/server.js
const express = require('express');
const cors = require('cors');
const sequelize = require('./config/database');
const sucursalRoutes = require('./routes/sucursalRoutes');
require('dotenv').config(); // Cargar variables de entorno

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors()); // Habilita CORS para permitir peticiones desde el frontend
app.use(express.json()); // Para parsear el body de las peticiones en formato JSON

// Rutas de la API
app.use('/api/sucursales', sucursalRoutes);

// Sincronizar la base de datos y arra// backend/server.js
const express = require('express');
const cors = require('cors');
const sequelize = require('./config/database');
const sucursalRoutes = require('./routes/sucursalRoutes');
require('dotenv').config(); // Cargar variables de entorno

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors()); // Habilita CORS para permitir peticiones desde el frontend
app.use(express.json()); // Para parsear el body de las peticiones en formato JSON

// Rutas de la API
app.use('/api/sucursales', sucursalRoutes);

// Sincronizar la base de datos y arrancar el servidor
sequelize.sync() // Esto creará las tablas si no existen (solo en desarrollo)
  .then(() => {
    app.listen(PORT, () => {
      console.log(`Servidor backend corriendo en http://localhost:${PORT}`);
    });
  })
  .catch(err => {
    console.error('No se pudo conectar a la base de datos:', err);
  });ncar el servidor
sequelize.sync() // Esto creará las tablas si no existen (solo en desarrollo)
  .then(() => {
    app.listen(PORT, () => {
      console.log(`Servidor backend corriendo en http://localhost:${PORT}`);
    });
  })
  .catch(err => {
    console.error('No se pudo conectar a la base de datos:', err);
  });