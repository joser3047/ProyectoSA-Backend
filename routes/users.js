const express = require('express');
const router = express.Router();
const {database} = require('../config/helpers');

/* GET users listing. */
router.get('/', function (req, res) {
    database.table('usuario')
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
    let userId = req.params.userId;
    console.log(userId);
    database.table('usuario').filter({id: userId})
        .withFields([ 'id', 'nombre' , 'apellido', 'email', 'celular', 'foto', 'tipo_usuario' ])
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
    let user = await database.table('usuario').filter({id: userId}).get();
    if (user) {

        let userEmail = req.body.email;
        let userPassword = req.body.password;
        let userFirstName = req.body.nombre;
        let userLastName = req.body.apellido;
        let foto = req.body.foto;
        let tipo = req.body.tipo_usuario;
        let cel = req.body.celular;

        // Replace the user's information with the form data ( keep the data as is if no info is modified )
        database.table('usuario').filter({id: userId}).update({
            email: userEmail !== undefined ? userEmail : user.email,
            contrasena: userPassword !== undefined ? userPassword : user.contrasena,
            foto: foto !== undefined ? foto : user.foto,
            nombre: userFirstName !== undefined ? userFirstName : user.nombre,
            apellido: userLastName !== undefined ? userLastName : user.apellido,
            celular: cel !== undefined ? cel : user.celular,
            tipo_usuario: tipo !== undefined ? tipo : user.tipo_usuario
        }).then(result => res.json({ message: 'User updated successfully'})).catch(err => res.json(err));
    }
});

/* LOGIN USERS */
router.post('/login', (req, res) => {
    let userEmail = req.body.email;
    let userPassword = req.body.password;
    database.table('usuario').filter({email: userEmail, contrasena: userPassword})
        .get().then(user => {
            if (user) {
                res.json(user);
            } else {
                res.status(404).json({message: `NO USER FOUND`});
            }
    }).catch(err => res.json(err) );
});


module.exports = router;
