const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');

/* GET users listing. */
router.get('/', function (req, res) {
    database.table('Usuario')
        .withFields([ 'nombre' , 'email', 'apellido', 'celular', 'foto', 'tipo_usuario', 'id' ])
        .getAll().then((list) => {
        if (list.length > 0) {
            res.json({users: list});
        } else {
            res.json({message: 'NO USER FOUND'});
        }
    }).catch(err => res.json(err));
});

/**
 * ROLE 777 = ADMIN
 * ROLE 555 = CUSTOMER
 */


/* GET ONE USER MATCHING ID */
router.get('/:userId', (req, res) => {
    console.log('<><>>><<>>>>>>>>')
    let userId = req.params.userId;
    database.table('usuario').filter({id: userId})
        .withFields([ 'nombre' , 'apellido', 'email', 'celular', 'foto', 'tipo_usuario', 'id' ])
        .get().then(user => {
        if (user) {
            res.json({user});
        } else {
            res.json({message: `NO USER FOUND WITH ID : ${userId}`});
        }
    }).catch(err => res.json(err) );
});

/* UPDATE USER DATA */
router.patch('/:userId', async (req, res) => {
    let userId = req.params.userId;     // Get the User ID from the parameter

  // Search User in Database if any
    let user = await database.table('Usuario').filter({id: userId}).get();
    if (user) {

        let userEmail = req.body.email;
        let userPassword = req.body.contrasena;
        let userFirstName = req.body.nombre;
        let userLastName = req.body.apellido;
        let userUsername = req.body.foto;
        let age = req.body.tipo_usuario;

        // Replace the user's information with the form data ( keep the data as is if no info is modified )
        database.table('Usuario').filter({id: userId}).update({
            email: userEmail !== undefined ? userEmail : user.email,
            password: userPassword !== undefined ? userPassword : user.contrasena,
            username: userUsername !== undefined ? userUsername : user.foto,
            fname: userFirstName !== undefined ? userFirstName : user.nombre,
            lname: userLastName !== undefined ? userLastName : user.apellido,
            age: age !== undefined ? age : user.tipo_usuario
        }).then(result => res.json('User updated successfully')).catch(err => res.json(err));
    }
});

module.exports = router;
