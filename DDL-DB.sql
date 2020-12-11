CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `contrasena` VARCHAR(45) NULL,
  `celular` VARCHAR(45) NULL,
  `foto` VARCHAR(500) NULL,
  `tipo_usuario` BOOLEAN NULL DEFAULT 0,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `producto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(500) NULL,
  `valor_unitario` DECIMAL NOT NULL,
  `stock` INT NULL DEFAULT 0,
  `precio_cliente` DECIMAL NULL,
  `proveedor` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Producto_Usuario_idx` (`proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Usuario`
    FOREIGN KEY (`proveedor`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


CREATE TABLE IF NOT EXISTS `categoria_producto` (
  `producto_codigo` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  `visible` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`producto_codigo`, `categoria_id`),
  INDEX `fk_Categoria_Producto_Categoria1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Categoria_Producto_Producto1`
    FOREIGN KEY (`producto_codigo`)
    REFERENCES `producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Categoria_Producto_Categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `tarjeta` (
  `numero` VARCHAR(45) NOT NULL,
  `caducidad` VARCHAR(45) NULL,
  `codigo` VARCHAR(45) NULL,
  `tipo_tarjeta` TINYINT NULL DEFAULT 0,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Tarjeta_Usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tarjeta_Usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `carrito` (
  `idcarrito` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `total` DECIMAL NULL,
  PRIMARY KEY (`idcarrito`),
  INDEX `fk_Carrito_Usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Carrito_Usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `compra` (
  `id` INT NOT NULL,
  `idcarrito` INT NOT NULL,
  `fecha_compra` DATE NULL,
  `idtarjeta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Compra_Carrito1_idx` (`idcarrito` ASC) VISIBLE,
  INDEX `fk_Compra_Tarjeta1_idx` (`idtarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Carrito1`
    FOREIGN KEY (`idcarrito`)
    REFERENCES `carrito` (`idcarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Tarjeta1`
    FOREIGN KEY (`idtarjeta`)
    REFERENCES `tarjeta` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `detallecarrito` (
  `codigoproducto` INT NOT NULL,
  `idcarrito` INT NOT NULL,
  `cantidad` INT NULL,
  `subtotal` DECIMAL NULL,
  PRIMARY KEY (`codigoproducto`, `idcarrito`),
  INDEX `fk_DetalleCarrito_Carrito1_idx` (`idcarrito` ASC) VISIBLE,
  CONSTRAINT `fk_DetalleCarrito_Producto1`
    FOREIGN KEY (`codigoproducto`)
    REFERENCES `producto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleCarrito_Carrito1`
    FOREIGN KEY (`idcarrito`)
    REFERENCES `carrito` (`idcarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


insert into usuario
values(1, 'proveedor1', 'apellido', 'email', '1234', '12123411', '', true);  

insert into usuario
values(2, 'proveedor2', 'apellido', 'email', '1234', '12123411', '', true);


INSERT INTO categoria (id, nombre, descripcion) VALUES
(1, 'zapatos', ''),
(2, 'Electronicos', '');


INSERT INTO categoria_producto (producto_codigo, categoria_id, visible) VALUES
(1, 1, true),
(2, 1, true),
(3, 1, true),
(4, 1, true),
(5, 1, true),
(6, 1, true),
(7, 1, true),
(8, 1, true),
(9, 1, true),
(10, 1, true),
(11, 1, true),
(12, 1, true),
(13, 2, true),
(14, 1, true),
(15, 1, true),
(16, 2, true),
(17, 2, true),
(18, 1, true),
(19, 1, true),
(20, 2, true),
(21, 2, true),
(22, 1, true),
(23, 1, true),
(24, 2, true),
(25, 2, true),
(26, 1, true),
(27, 1, true),
(28, 2, true),
(29, 2, true),
(30, 1, true),
(31, 1, true),
(32, 2, true),
(33, 1, true),
(34, 1, true),
(35, 2, true),
(36, 2, true),
(37, 1, true),
(38, 1, true),
(39, 2, true),
(40, 1, true),
(41, 1, true),
(42, 2, true),
(43, 2, true),
(44, 1, true),
(45, 1, true),
(46, 2, true),
(47, 1, true),
(48, 1, true),
(49, 2, true),
(50, 2, true),
(51, 1, true),
(52, 1, true),
(53, 2, true);


INSERT INTO producto (codigo, nombre, imagen, valor_unitario, stock, precio_cliente, proveedor) VALUES
(1, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 10, 240.99, 1),
(2, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 51, 59.99, 1),
(3, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 69, 39.99, 1),
(4, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 78, 250, 1),
(5, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 83, 240.99, 1),
(6, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 1, 59.99, 1),
(7, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 95, 39.99, 1),
(8, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 1),
(9, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 1),
(10, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(11, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(12, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 1),
(13, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 68, 240.99, 2),
(14, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(15, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(16, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(17, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(18, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 80, 59.99, 1),
(19, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(20, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(21, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(22, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(23, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(24, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(25, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(26, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(27, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(28, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(29, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(30, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(31, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(32, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 88, 250, 2),
(33, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(34, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(35, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(36, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(37, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(38, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(39, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(40, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(41, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(42, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(43, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(44, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(45, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(46, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(47, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(48, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(49, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2),
(50, 'PlayStation 4', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSr-iFW5W8n3_jxNKiclAP_k71Fi9PGcojsMUC-vb8zbwJthbBd', 240.99, 100, 240.99, 2),
(51, 'PEGASUS 33 Running Shoes For Men', 'https://i.pinimg.com/originals/43/40/8e/43408ee5a8d234752ecf80bbc3832e65.jpg', 59.99, 100, 59.99, 1),
(52, 'MEN\'S ADIDAS RUNNING KALUS SHOES', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSrEqFHfSbs6rUzcYnN_PcnS_D2JLXusKMVFk4Y8N_tn3hJgNIf', 39.99, 100, 39.99, 1),
(53, 'Xbox One X Star Wars Jedi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8ufSADR9EyusxEfgMLErqISEcKVzQyjoD81zWcdpBvuEGBnYP', 250, 100, 250, 2);
