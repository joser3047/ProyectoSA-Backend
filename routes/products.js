const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');

/* GET ALL PRODUCTS */
router.get('/', function (req, res) {       // Sending Page Query Parameter is mandatory http://localhost:3636/api/products?page=1
    let page = (req.query.page !== undefined && req.query.page !== 0) ? req.query.page : 1;
    const limit = (req.query.limit !== undefined && req.query.limit !== 0) ? req.query.limit : 10;   // set limit of items per page
    let startValue;
    let endValue;
    if (page > 0) {
        startValue = (page * limit) - limit;     // 0, 10, 20, 30
        endValue = page * limit;                  // 10, 20, 30, 40
    } else {
        startValue = 0;
        endValue = 10;
    }
    database.table('categoria_producto as cp')
        .join([
            {
                table: "producto as p",
                on: `p.codigo = cp.producto_codigo`
            },
            {
                table: "categoria as c",
                on: `c.id = cp.categoria_id`
            }
        ])
        .withFields(['c.nombre as category',
            'p.nombre as nombre',
            'p.valor_unitario',
            'p.stock',
            'p.precio_cliente',
            'p.imagen',
            'p.proveedor',
            'p.codigo as id'
        ])
        .slice(startValue, endValue)
        .getAll()
        .then(prods => {
            if (prods.length > 0) {
                res.status(200).json({
                    count: prods.length,
                    products: prods
                });
            } else {
                res.json({message: "No products found"});
            }
        })
        .catch(err => console.log(err));
});


/* GET CATEGORIAS*/
router.get('/categorias', (req, res) => {

    database.table('categoria')
        .getAll().then((list) => {
            if (list.length > 0) {
                res.json(list);
            } else {
                res.json({ message: 'SIN CATEGORIAS' });
            }
        }).catch(err => res.json(err));
});

/* GET ONE PRODUCT*/
router.get('/:prodId', (req, res) => {
    let productId = req.params.prodId;
    database.table('categoria_producto as cp')
        .leftJoin([
            {
                table: "producto as p",
                on: `p.codigo = cp.producto_codigo`
            },
            {
                table: "categoria as c",
                on: `c.id = cp.categoria_id`
            }
        ])
        .filter({'p.codigo': productId})
        .withFields(['c.nombre as category',
            'p.nombre as nombre',
            'p.valor_unitario',
            'p.stock',
            'p.precio_cliente',
            'p.imagen',
            'p.proveedor',
            'p.codigo as id'
        ])
        .get()
        .then(prod => {
            console.log(prod);
            if (prod) {
                res.status(200).json(prod);
            } else {
                res.json({message: `No product found with id ${productId}`});
            }
        }).catch(err => res.json(err));
});

/* GET ALL PRODUCTS FROM ONE CATEGORY */
router.get('/category/:catName', (req, res) => { // Sending Page Query Parameter is mandatory http://localhost:3636/api/products/category/categoryName?page=1
    let page = (req.query.page !== undefined && req.query.page !== 0) ? req.query.page : 1;   // check if page query param is defined or not
    const limit = (req.query.limit !== undefined && req.query.limit !== 0) ? req.query.limit : 10;   // set limit of items per page
    let startValue;
    let endValue;
    if (page > 0) {
        startValue = (page * limit) - limit;      // 0, 10, 20, 30
        endValue = page * limit;                  // 10, 20, 30, 40
    } else {
        startValue = 0;
        endValue = 10;
    }

    // Get category title value from param
    const cat_title = req.params.catName;

    database.table('categoria_producto as cp')
        .join([
            {
                table: "producto as p",
                on: `p.codigo = cp.producto_codigo`
            },
            {
                table: "categoria as c",
                on: `c.id = cp.categoria_id WHERE c.nombre LIKE '%${cat_title}%'`
            }
        ])
        .withFields(['c.nombre as category',
            'p.nombre as nombre',
            'p.valor_unitario',
            'p.stock',
            'p.precio_cliente',
            'p.imagen',
            'p.proveedor'
        ])
        .slice(startValue, endValue)
        .sort({id: 1})
        .getAll()
        .then(prods => {
            if (prods.length > 0) {
                res.status(200).json({
                    count: prods.length,
                    products: prods
                });
            } else {
                res.json({message: `No products found matching the category ${cat_title}`});
            }
        }).catch(err => res.json(err));

});


module.exports = router;
