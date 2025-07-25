// backend/models/sucursal.js
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Sucursal = sequelize.define('Sucursal', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  ubicacion: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  telefono: {
    type: DataTypes.STRING,
    allowNull: false,
  },
}, {
  // Opciones del modelo
  tableName: 'sucursales', // Asegúrate de que coincida con el nombre de tu tabla en la DB
  timestamps: true, // Sequelize maneja createdAt y updatedAt automáticamente
});

module.exports = Sucursal;
