const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');


router.post('/', function (req, res) {

    //console.log(req.body);
    let {no, caducidad, codigo,tipo,user}= req.body

    console.log(req.body);

    database.table('tarjeta').insert({
        numero: no,
        caducidad: caducidad,
        codigo: codigo,
        tipo_tarjeta: tipo,
        usuario_id: user
    }).then(lastId => {
        if (lastId > 0) {
            res.status(201).json({message: 'Registration successful.'});
        } else {
            res.status(501).json({message: 'Registration failed.'});
        }
    }).catch(err => res.status(433).json({error: err}));
});

module.exports = router;


