// backend/routes/sucursalRoutes.js
const express = require('express');
const router = express.Router();
const sucursalController = require('../controllers/sucursalController');

// Rutas para las operaciones CRUD de sucursales
router.get('/', sucursalController.getAllSucursales);
router.get('/:id', sucursalController.getSucursalById);
router.post('/', sucursalController.createSucursal);
router.put('/:id', sucursalController.updateSucursal);
router.delete('/:id', sucursalController.deleteSucursal);

module.exports = router;