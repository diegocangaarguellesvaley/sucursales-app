// Estructura de la prueba:
// sucursales-app/
// ├── backend/
// │   ├── server.js
// │   └── src/
// │       ├── database.js
// │       ├── models/
// │       │   └── Sucursal.js
// │       ├── controllers/
// │       │   └── sucursalController.js
// │       └── routes/
// │           └── sucursalRoutes.js
// └── frontend/
//     └── src/
//         └── App.js

// ===========================
// BACKEND (Node.js + Sequelize)
// ===========================

// backend/server.js
const express = require('express');
const cors = require('cors');
const app = express();
const port = 3001;
const db = require('./src/database');
const sucursalRoutes = require('./src/routes/sucursalRoutes');

app.use(cors());
app.use(express.json());
app.use('/sucursales', sucursalRoutes);

db.sync().then(() => {
  app.listen(port, () => {
    console.log(`Servidor corriendo en http://localhost:${port}`);
  });
});

// backend/src/database.js
const { Sequelize } = require('sequelize');
const sequelize = new Sequelize('sucursalesdb', 'root', 'tu_contraseña', {
  host: 'localhost',
  dialect: 'mysql',
});
module.exports = sequelize;

// backend/src/models/Sucursal.js
const { DataTypes } = require('sequelize');
const sequelize = require('../database');

const Sucursal = sequelize.define('Sucursal', {
  nombre: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  direccion: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  telefono: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  estado: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
  },
});

module.exports = Sucursal;

// backend/src/controllers/sucursalController.js
const Sucursal = require('../models/Sucursal');

exports.getAll = async (req, res) => {
  try {
    const data = await Sucursal.findAll();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.create = async (req, res) => {
  try {
    const sucursal = await Sucursal.create(req.body);
    res.json(sucursal);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.update = async (req, res) => {
  try {
    await Sucursal.update(req.body, { where: { id: req.params.id } });
    res.json({ message: 'Sucursal actualizada' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.delete = async (req, res) => {
  try {
    await Sucursal.destroy({ where: { id: req.params.id } });
    res.json({ message: 'Sucursal eliminada' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// backend/src/routes/sucursalRoutes.js
const express = require('express');
const router = express.Router();
const controller = require('../controllers/sucursalController');

router.get('/', controller.getAll);
router.post('/', controller.create);
router.put('/:id', controller.update);
router.delete('/:id', controller.delete);

module.exports = router;


// ===========================
// FRONTEND (React con Hooks)
// ===========================

// frontend/src/App.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [sucursales, setSucursales] = useState([]);
  const [form, setForm] = useState({ nombre: '', direccion: '', telefono: '' });
  const [editingId, setEditingId] = useState(null);

  const getSucursales = async () => {
    const res = await axios.get('http://localhost:3001/sucursales');
    setSucursales(res.data);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (editingId !== null) {
      await axios.put(`http://localhost:3001/sucursales/${editingId}`, form);
    } else {
      await axios.post('http://localhost:3001/sucursales', form);
    }
    setForm({ nombre: '', direccion: '', telefono: '' });
    setEditingId(null);
    getSucursales();
  };

  const handleEdit = (sucursal) => {
    setForm({ nombre: sucursal.nombre, direccion: sucursal.direccion, telefono: sucursal.telefono });
    setEditingId(sucursal.id);
  };

  const handleDelete = async (id) => {
    await axios.delete(`http://localhost:3001/sucursales/${id}`);
    getSucursales();
  };

  useEffect(() => {
    getSucursales();
  }, []);

  return (
    <div className="App">
      <h1>Sucursales de Somos Crédito</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Nombre"
          value={form.nombre}
          onChange={(e) => setForm({ ...form, nombre: e.target.value })}
          required
        />
        <input
          type="text"
          placeholder="Dirección"
          value={form.direccion}
          onChange={(e) => setForm({ ...form, direccion: e.target.value })}
          required
        />
        <input
          type="text"
          placeholder="Teléfono"
          value={form.telefono}
          onChange={(e) => setForm({ ...form, telefono: e.target.value })}
          required
        />
        <button type="submit">{editingId !== null ? 'Actualizar' : 'Crear'}</button>
      </form>

      <ul>
        {sucursales.map((s) => (
          <li key={s.id}>
            {s.nombre} - {s.direccion} - {s.telefono}
            <button onClick={() => handleEdit(s)}>Editar</button>
            <button onClick={() => handleDelete(s.id)}>Eliminar</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
