const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');
const crypto = require('crypto');

// GET ALL ORDERS
router.get('/', (req, res) => {
    database.table('DetalleCarrito as dc')
        .join([
            {
                table: 'Carrito as c',
                on: 'c.id = dc.idCarrito'
            },
            {
                table: 'Producto as p',
                on: 'p.codigo = dc.codigoProducto'
            },
            {
                table: 'Usuario as u',
                on: 'u.id = c.Usuario_id'
            }
        ])
        .withFields(['c.id', 'p.nombre', 'p.stock', 'p.precio_cliente', 'u.nombre'])
        .getAll()
        .then(orders => {
            if (orders.length > 0) {
                res.json(orders);
            } else {
                res.json({message: "No orders found"});
            }

        }).catch(err => res.json(err));
});

// Get Single Order
router.get('/:id', async (req, res) => {
    let orderId = req.params.id;
    console.log(orderId);

    database.table('DetalleCarrito as dc')
        .join([
            {
                table: 'Carrito as c',
                on: 'c.id = dc.idCarrito'
            },
            {
                table: 'Producto as p',
                on: 'p.codigo = dc.codigoProducto'
            },
            {
                table: 'Usuario as u',
                on: 'u.id = c.Usuario_id'
            }
        ])
        .withFields(['c.id', 'p.nombre', 'p.stock', 'p.precio_cliente', 'p.imagen', 'dc.cantidad'])
        .filter({'c.id': orderId})
        .getAll()
        .then(orders => {
            console.log(orders);
            if (orders.length > 0) {
                res.json(orders);
            } else {
                res.json({message: "No orders found"});
            }

        }).catch(err => res.json(err));
});

// Place New Order
router.post('/new', async (req, res) => {
    // let userId = req.body.userId;
    // let data = JSON.parse(req.body);
    let {userId, products} = req.body;
    console.log(userId);
    console.log(products);

     if (userId !== null && userId > 0) {
        database.table('Carrito')
            .insert({
                user_id: userId
            }).then((newOrderId) => {

            if (newOrderId > 0) {
                products.forEach(async (p) => {

                        let data = await database.table('producto').filter({id: p.codigo}).withFields(['stock']).get();



                    let inCart = parseInt(p.incart);

                    // Deduct the number of pieces ordered from the quantity in database

                    if (data.stock > 0) {
                        data.stock = data.stock - inCart;

                        if (data.stock < 0) {
                            data.stock = 0;
                        }

                    } else {
                        data.stock = 0;
                    }

                    // Insert order details w.r.t the newly created order Id
                    database.table('detallecarrito')
                        .insert({
                            idCarrito: newOrderId,
                            codigoProducto: p.id,
                            cantidad: inCart
                        }).then(newId => {
                        database.table('producto')
                            .filter({codigo: p.id})
                            .update({
                                stock: data.stock
                            }).then(successNum => {
                        }).catch(err => console.log(err));
                    }).catch(err => console.log(err));
                });

            } else {
                res.json({message: 'New order failed while adding order details', success: false});
            }
            res.json({
                message: `Order successfully placed with order id ${newOrderId}`,
                success: true,
                order_id: newOrderId,
                products: products
            })
        }).catch(err => res.json(err));
    }

    else {
        res.json({message: 'New order failed', success: false});
    }

});

// Payment Gateway
router.post('/payment', (req, res) => {
    setTimeout(() => {
        res.status(200).json({success: true});
    }, 3000)
});






module.exports = router;
