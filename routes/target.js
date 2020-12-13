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

//obtiene todos los numeros de tarjeta de un usuario
router.get('/:userId', (req, res) => {
    console.log('-------')
    let userId = req.params.userId;

    database.table('tarjeta').filter({usuario_id: userId})
        .withFields([ 'numero','tipo_tarjeta'])
        .getAll().then(user => {
        if (user) {
            res.json({user});
        } else {
            res.json({message: `NO USER FOUND WITH ID : ${userId}`});
        }
    }).catch(err => res.json(err) );
});

//delete
router.post('/deleteT', function (req, res)  {

    let {numero} = req.body;
    console.log(numero)

    database.table('tarjeta').filter({ numero: numero }).remove().then(result => {
        res.json({ message: 'Producto deleted successfully'});
    }).catch(err => {
        res.json(err);
    });
});

module.exports = router;


