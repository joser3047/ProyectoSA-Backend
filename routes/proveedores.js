const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');

/* GET productos por ID proveedor */
router.get('/:provId', function (req, res) {
    let provId = req.params.provId;

    database.table('producto').filter({ proveedor: provId })
        .get().then(prods => {
        if (prods) {
            res.json({ prods });
        } else {
            res.json({ message: `NO PRODUCTS FOUND WITH ID : ${provId}` });
        }
    }).catch(err => res.json(err) );
});