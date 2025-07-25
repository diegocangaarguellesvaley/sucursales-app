// backend/controllers/sucursalController.js
const Sucursal = require('../models/sucursal');

// Obtener todas las sucursales
exports.getAllSucursales = async (req, res) => {
  try {
    const sucursales = await Sucursal.findAll();
    res.status(200).json(sucursales);
  } catch (error) {
    console.error('Error al obtener sucursales:', error);
    res.status(500).json({ message: 'Error interno del servidor al obtener sucursales.' });
  }
};

// Obtener una sucursal por ID
exports.getSucursalById = async (req, res) => {
  try {
    const { id } = req.params;
    const sucursal = await Sucursal.findByPk(id);
    if (!sucursal) {
      return res.status(404).json({ message: 'Sucursal no encontrada.' });
    }
    res.status(200).json(sucursal);
  } catch (error) {
    console.error('Error al obtener sucursal por ID:', error);
    res.status(500).json({ message: 'Error interno del servidor al obtener sucursal.' });
  }
};

// Crear una nueva sucursal
exports.createSucursal = async (req, res) => {
  try {
    const { ubicacion, telefono } = req.body;
    if (!ubicacion || !telefono) {
      return res.status(400).json({ message: 'Ubicación y teléfono son campos requeridos.' });
    }
    const newSucursal = await Sucursal.create({ ubicacion, telefono });
    res.status(201).json(newSucursal);
  } catch (error) {
    console.error('Error al crear sucursal:', error);
    res.status(500).json({ message: 'Error interno del servidor al crear sucursal.' });
  }
};

// Actualizar una sucursal existente
exports.updateSucursal = async (req, res) => {
  try {
    const { id } = req.params;
    const { ubicacion, telefono } = req.body;
    const sucursal = await Sucursal.findByPk(id);
    if (!sucursal) {
      return res.status(404).json({ message: 'Sucursal no encontrada.' });
    }
    sucursal.ubicacion = ubicacion || sucursal.ubicacion;
    sucursal.telefono = telefono || sucursal.telefono;
    await sucursal.save();
    res.status(200).json(sucursal);
  } catch (error) {
    console.error('Error al actualizar sucursal:', error);
    res.status(500).json({ message: 'Error interno del servidor al actualizar sucursal.' });
  }
};

// Eliminar una sucursal
exports.deleteSucursal = async (req, res) => {
  try {
    const { id } = req.params;
    const sucursal = await Sucursal.findByPk(id);
    if (!sucursal) {
      return res.status(404).json({ message: 'Sucursal no encontrada.' });
    }
    await sucursal.destroy();
    res.status(204).send(); // No Content
  } catch (error) {
    console.error('Error al eliminar sucursal:', error);
    res.status(500).json({ message: 'Error interno del servidor al eliminar sucursal.' });
  }
};