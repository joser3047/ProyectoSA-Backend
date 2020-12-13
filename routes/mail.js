var nodemailer = require('nodemailer');

// email sender function
exports.sendEmail = function(req, res) {

    let asunto = req.body.asunto;
    let mensaje = req.body.mensaje;
    let destino = req.body.destino;

    // Definimos el transporter
    var transporter = nodemailer.createTransport({
        service: 'Gmail',
        auth: {
            user: 'econoahorro.sa@gmail.com',
            pass: '8p5VHpj7G5U4'
        }
    });

    // Definimos el email
    var mailOptions = {
        from: 'econoahorro.sa@gmail.com',
        to: destino,                        // email al que se envia el mensaje
        subject: asunto,
        text: mensaje
    };

    // Enviamos el email
    transporter.sendMail(mailOptions, function(error, info){
        if (error){
            console.log(error);
            res.status(500).send(error);
        } else {
            console.log("Email sent");
            res.status(200).jsonp( { messaje: "Email sent", data: req.body });
        }
    });
};