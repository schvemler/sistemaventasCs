drop database sisnegocios;
create database sisnegocios;
use sisnegocios;
create table controlador(
	id int(11) auto_increment primary key,
    cont boolean,
    fecha timestamp
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table rubros(
    id int(11) AUTO_INCREMENT PRIMARY key ,
    nombre varchar(100) unique NULL,
    idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table productos(
    id int(11) AUTO_INCREMENT PRIMARY key ,
    nombre varchar(150) NOT NULL,
    cantidadvendida decimal(18,2)DEFAULT 0.00,
    codigo varchar(55) NOT NULL UNIQUE,
    enventa boolean default false,
    rubro int(11) default 1,
	idcontrol int(11) default 1,
    preciocompra decimal(18,2) DEFAULT 0.00,
    precioventa decimal(18,2) DEFAULT 0.00,
    diferencia decimal(18,2) as  (precioventa-preciocompra),
    porcentaje decimal(18,2) as  (diferencia*100/preciocompra),
    fecha date default null,
    FOREIGN KEY (`rubro`) REFERENCES `rubros` (`id`),
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table proveedores(
    id int(11) AUTO_INCREMENT PRIMARY key ,
    nombre varchar(100) NOT NULL,
    cuit varchar(12) NOT NULL UNIQUE,
    direccion varchar(100) NOT NULL,
    telefono varchar(50) DEFAULT NULL,
    email varchar(100) DEFAULT NULL,
    idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table facturas(
    id int(11) AUTO_INCREMENT PRIMARY key ,
    numeracion varchar(100) DEFAULT NULL,
    fecha  timestamp,
    compra boolean default false,
    detalle varchar(150) DEFAULT NULL,
    idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table listaproveedores(
    idproducto int(11) NOT NULL,
    idproveedor int(11)NOT NULL,
    precio decimal(18,2) DEFAULT 0.00,
    idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`),
    FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`),
    FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`id`) ON DELETE CASCADE,
    PRIMARY KEY (`idproducto`,`idproveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table pedidosabastecimiento(
    id int(11) auto_increment primary key,
    idproducto int(11) NOT NULL,
    idproveedor int(11)NOT NULL,
    idrubro int(11)NOT NULL,
    cantidadvendida decimal(18,2)NOT NULL,
    precio decimal(18,2)NOT NULL,
    total decimal(18,2) as (precio*cantidadvendida),
    fecha timestamp,
    facturado boolean default false,
    realizado boolean default false,
    idcontrol int(11) default 1,
    FOREIGN KEY (`idrubro`) REFERENCES `rubros` (`id`),
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`),
    FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`),
    FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table compraventa(
	id int(11) auto_increment primary key,
    idproducto int(11) NOT NULL,
    idfactura int(11)NOT NULL,
    idrubro int(11)DEFAULT 1,
    fecha timestamp,
    cantidadvendida decimal(18,2),
    precio decimal(18,2),
    total decimal(18,2) as (precio*cantidadvendida),
    compra boolean default false,
	idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`),
    FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`),
    FOREIGN KEY (`idrubro`) REFERENCES `rubros` (`id`),
    FOREIGN KEY (`idfactura`) REFERENCES `facturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table ticketventa(
    idfactura int(11)NOT NULL,
    fecha timestamp,
    costo decimal(18,2),
    pagado decimal(18,2),
    vuelto decimal(18,2) as (pagado-costo),
	idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`),
    FOREIGN KEY (`idfactura`) REFERENCES `facturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
create table reportes(
	id int(11) auto_increment primary key,
    detalles varchar(50),
    fecha timestamp,
	idcontrol int(11) default 1,
    FOREIGN KEY (`idcontrol`) REFERENCES `controlador` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;










insert into `controlador`(`cont`)values(true);



INSERT INTO `rubros`(`nombre`)VALUES('SIN CLASIFICAR');
INSERT INTO `rubros`(`nombre`)VALUES('GALLETITAS Y GOLOSINAS');
INSERT INTO `rubros`(`nombre`)VALUES('PASTAS Y PIZZAS');
INSERT INTO `rubros`(`nombre`)VALUES('ALMACEN');
INSERT INTO `rubros`(`nombre`)VALUES('BEBIDAS CON ALCOHOL');
/*5*/
INSERT INTO `rubros`(`nombre`)VALUES('PERFUMERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('ROPA');
INSERT INTO `rubros`(`nombre`)VALUES('KIOSCO');
INSERT INTO `rubros`(`nombre`)VALUES('MASCOTAS');
INSERT INTO `rubros`(`nombre`)VALUES('BEBIDAS SIN ALCOHOL');
/*10*/
INSERT INTO `rubros`(`nombre`)VALUES('LIMPIEZA');
INSERT INTO `rubros`(`nombre`)VALUES('OTROS RUBROS');
INSERT INTO `rubros`(`nombre`)VALUES('BAZAR');
INSERT INTO `rubros`(`nombre`)VALUES('FIAMBRERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('MAMÁS Y BEBÉS');
/*15*/
INSERT INTO `rubros`(`nombre`)VALUES('ALIMENTOS CONGELADOS');
INSERT INTO `rubros`(`nombre`)VALUES('FERRETERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('LACTEOS');
INSERT INTO `rubros`(`nombre`)VALUES('MEDICAMENTOS');
INSERT INTO `rubros`(`nombre`)VALUES('BEBIDAS');
/*20*/
INSERT INTO `rubros`(`nombre`)VALUES('PASTAS FRESCAS');
INSERT INTO `rubros`(`nombre`)VALUES('PANADERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('FARMACIA');
INSERT INTO `rubros`(`nombre`)VALUES('VARIOS');
INSERT INTO `rubros`(`nombre`)VALUES('BLANCO Y MANTELERÍA');
/*25*/
INSERT INTO `rubros`(`nombre`)VALUES('BALANCEADOS');
INSERT INTO `rubros`(`nombre`)VALUES('CARNICERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('JUGUETERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('AUTOMOTOR');
INSERT INTO `rubros`(`nombre`)VALUES('PANIFICACION');
/*30*/
INSERT INTO `rubros`(`nombre`)VALUES('CAMPING');
INSERT INTO `rubros`(`nombre`)VALUES('HELADOS');
INSERT INTO `rubros`(`nombre`)VALUES('LIBRERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('ELECTRODOMÉSTICOS');
INSERT INTO `rubros`(`nombre`)VALUES('PESCADERÍA');
/*35*/
INSERT INTO `rubros`(`nombre`)VALUES('JARDINERÍA');
INSERT INTO `rubros`(`nombre`)VALUES('PESCADOS Y MARISCOS');

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7794529041424','*BREVISS TOSTADA DULCE 220 GR.',2);

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7794529041219','*BREVISS TOSTADAS LACTEAD 220 GR.',2);

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7794529041240','*BREVISS TOSTADAS LIGHT 220 GR.',2);

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7794529041233','*BREVISS TOSTADAS MULT CE 220 GR.',2);

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7794529041226','*BREVISS TOSTADAS S/SAL 220 GR.',2);

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7795735000090','*EL MUELLE PAN DULCE C/FR 400 GR.',1);

INSERT INTO `productos`(`codigo`,`nombre`,`rubro`)VALUES('7791672001558','*FANTOCHE PAN DULCE MARM 400 GR.',1);
