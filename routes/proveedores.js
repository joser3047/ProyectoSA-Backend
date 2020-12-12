const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');

/* GET productos por ID proveedor */
router.get('/:provId', function (req, res) {
    let provId = req.params.provId;

    database.table('producto').filter({ proveedor: provId })
        .getAll().then(prods => {
        if (prods.length > 0) {
            res.json( prods );
        } else {
            res.json({ message: `NO PRODUCTS FOUND WITH PROVEEDOR ID : ${provId}` });
        }
    }).catch(err => res.json(err) );
});

/* UPDATE PRODUCTO */
router.patch('/:prodId', async (req, res) => {
    let prodId = req.params.prodId;     // Get the User ID from the parameter

  // Search User in Database if any
    let product = await database.table('producto').filter({codigo: prodId}).get();
    if (product) {

        let nombre = req.body.nombre;
        let imagen = req.body.imagen;
        let valor_unitario = req.body.valor_unitario;
        let stock = req.body.stock;
        let precio_cliente = req.body.precio_cliente;

        // Replace the user's information with the form data ( keep the data as is if no info is modified )
        database.table('producto').filter({ codigo: prodId }).update({
            nombre: nombre !== undefined ? nombre : product.nombre,
            imagen: imagen !== undefined ? imagen : product.imagen,
            valor_unitario: valor_unitario !== undefined ? valor_unitario : product.valor_unitario,
            stock: stock !== undefined ? stock : product.stock,
            precio_cliente: precio_cliente !== undefined ? precio_cliente : product.precio_cliente

        }).then(result => res.json({ message: 'Producto updated successfully'})).catch(err => res.json(err));
    }
});

/* AGREGAR PRODUCTOS */
router.post('/agregar', async (req, res) => {
    
    let nombre = req.body.nombre;
    let imagen = req.body.imagen;
    let valor_unitario = req.body.valor_unitario;
    let stock = req.body.stock;
    let precio_cliente = req.body.precio_cliente;
    let proveedor = req.body.proveedor;

    database.table('producto').insert({
        nombre: nombre,
        imagen: imagen,
        valor_unitario: valor_unitario,
        stock: stock,
        precio_cliente: precio_cliente,
        proveedor: proveedor
    }).then(result => {
        res.json({ message: 'Product added successfully'});
    }).catch(err => {
        res.json(err);
    });
});

/* DELETE PRODUCTO */
router.delete('/:prodId', async (req, res) => {
    let prodId = req.params.prodId;     // Get the User ID from the parameter

    database.table('producto').filter({ codigo: prodId }).remove().then(result => {
        res.json({ message: 'Producto deleted successfully'});
    }).catch(err => {
        res.json(err);
    });
});

module.exports = router;