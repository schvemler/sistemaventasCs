use sisnegocios;
/*inicio*/
drop procedure if exists	`ProductSearchName`;
drop procedure if exists 	`ProductSearchCod`;
drop procedure if exists 	`ProductIndex`;
drop procedure if exists 	`ProductPaginate`;
drop procedure if exists	`ProductPaginateStock`;
drop procedure if exists	`ProductPaginateSinStock`;
drop procedure if exists	`ProductPaginateNullFecha`;
drop procedure if exists	`ProductPaginateOldFecha`;
drop procedure if exists	`ProductPaginateNewFecha`;
drop procedure if exists	`ProductIndexStock`;
drop procedure if exists	`ProductIndexSinStock`;
drop procedure if exists	`ProductIndexOldFecha`;
drop procedure if exists	`ProductIndexNewFecha`;
drop procedure if exists	`ProductIndexNullFecha`;
drop procedure if exists	`ProductIndexUltimos`;
drop procedure if exists	`ProductConteo`;
drop procedure if exists	`ProductConteoStock`;
drop procedure if exists	`ProductConteoSinStock`;
drop procedure if exists	`ProductConteoNullFecha`;
drop procedure if exists	`ProductConteoOldFecha`;
drop procedure if exists	`ProductConteoNewFecha`;
drop procedure if exists	`ProductSearchNameVenta`;
drop procedure if exists	`ProductSearchMarcaVenta`;
drop procedure if exists 	`ProductSearchCodVenta`;
drop procedure if exists	`ProductosCreate`;
drop procedure if exists	`ProductosUpdate`;
drop procedure if exists	`ProductosDelete`;
drop procedure if exists	`ProductosSearchIfExist`;
drop procedure if exists	`ProductosUpdatePrecio`;
drop procedure if exists	`ProductosUpdateFecha`;
drop procedure if exists	`ProductosUpdateCantidad`;
drop procedure if exists	`ProductosUpdateCantidadSimple`;
/*final*/



drop procedure if exists	`PedidosPaginateFull`;
drop procedure if exists 	`PedidosPaginateFacturado`;
drop procedure if exists	`PedidosPaginateSinFacturar`;
drop procedure if exists	`PedidosPaginatePorRealizar`;
drop procedure if exists	`PedidosPaginateRealizado`;

drop procedure if exists	`PedidosIndexFull`;
drop procedure if exists	`PedidosIndexPorFacturar`;
drop procedure if exists	`PedidosIndexFacturados`;
drop procedure if exists	`PedidosIndexPorRealizar`;
drop procedure if exists	`PedidosIndexRealizados`;



drop procedure if exists	`PedidosSearchAbastecimientoCodPro`;
drop procedure if exists	`PedidosSearchAbastecimientoNomProd`;
drop procedure if exists 	`PedidosSearchAbastecimientoNomProv`;
drop procedure if exists	`PedidosSearchAbastecimientoCuitProv`;
drop procedure if exists	`PedidosFacturar`;
drop procedure if exists	`PedidosMarcar`;
drop procedure if exists	`PedidosDelete`;
drop procedure if exists	`PedidosValormax`;
drop procedure if exists	`PedidosCreate`;

drop procedure if exists	`ProveedoresCreate`;
drop procedure if exists	`ProveedoresPaginate`;
drop procedure if exists	`ProveedorIndex`;
drop procedure if exists	`ProveedorIndexUltimos`;
drop procedure if exists	`ProveedorDelete`;
drop procedure if exists	`ProveedoresUpdate`;
drop procedure if exists	`ProveedoresSearchName`;
drop procedure if exists	`ProveedoresSearchCuit`;
drop procedure if exists	`ProveedoresSearchDireccion`;
drop procedure if exists	`ProveedoresSearchEmail`;
drop procedure if exists	`ProveedoresSearchTel`;

drop procedure if exists	`VentasCreate`;
drop procedure if exists	`VentasPaginateTodas`;
drop procedure if exists	`VentasPaginateVentas`;
drop procedure if exists	`VentasIndex`;
drop procedure if exists	`VentasConteoTotal`;
drop procedure if exists	`VentasIndexFacturacion`;

drop procedure if exists	`EstadisticasDiariasVentas`;
drop procedure if exists	`EstadisticasMensualesVentas`;
drop procedure if exists	`EstadisticasAnualesVentas`;

drop procedure if exists  `RubrosCreate`;
drop procedure if exists  `RubrosIndex`;
drop procedure if exists  `RubrosIndexDesc`;
drop procedure if exists  `RubrosUpdate`;
drop procedure if exists  `RubrosDelete`;

/*inicio*/
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductSearchName`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.nombre LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY ID DESC LIMIT 25 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductSearchCod`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.codigo LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY ID DESC LIMIT 25 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginate`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateStock`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos WHERE cantidadvendida>0);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateSinStock`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos WHERE cantidadvendida<=0.00);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateNullFecha`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos WHERE fecha IS NULL);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateOldFecha`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos  WHERE fecha < curdate() );
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateNewFecha`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos  WHERE fecha >= curdate());
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductIndex`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductIndexStock`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
     WHERE productos.cantidadvendida>0
    ORDER BY   productos.cantidadvendida  DESC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductIndexSinStock`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
     WHERE productos.cantidadvendida<=0.00
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductIndexOldFecha`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
     WHERE productos.fecha < curdate()
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductIndexNewFecha`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.fecha>=	curdate()
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductIndexNullFecha`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.fecha IS NULL
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductIndexUltimos`( )
BEGIN
    SELECT productos.id AS 'ID',
	productos.codigo as 'CODIGO big beibi',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
    ORDER BY  productos.id DESC LIMIT  20 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteo`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoStock`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where cantidadvendida>0.00);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoSinStock`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where cantidadvendida<=0.00);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoNullFecha`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where fecha is null);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoOldFecha`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where fecha <curdate());
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoNewFecha`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where fecha >=curdate());
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductSearchNameVenta`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.rubro as IDR,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'PRODUCTO', 
    rubros.nombre as 'RUBRO',
    productos.precioventa as 'PRECIO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.nombre LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY productos.cantidadvendida DESC LIMIT 10 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductSearchCodVenta`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.rubro as IDR,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'PRODUCTO', 
    rubros.nombre as 'RUBRO',
    productos.precioventa as 'PRECIO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.codigo LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY productos.cantidadvendida DESC LIMIT 10 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosCreate`(
in ProductName varchar(155),
in ProductCodigo varchar(60),
in ProductCantidad varchar(60),
in ProductPrecioCompra varchar(60),
in ProductPrecioVenta varchar(60),
in ProcedureIdrubro int
 )
BEGIN
	declare control int;
    set	control=(SELECT MAX(id) FROM controlador);
	INSERT INTO productos
    (
    nombre,
    codigo,
    cantidadvendida,
    idcontrol,
    preciocompra,
    precioventa,
    rubro
    )
    VALUES 
    ( 
    NULLIF((RTRIM(LTRIM(ProductName))),''),
	NULLIF((RTRIM(LTRIM(ProductCodigo))),''),
    CAST(ProductCantidad AS DECIMAL(18,2)),
    control,
    CAST(ProductPrecioCompra AS DECIMAL(18,2)),
    CAST(ProductPrecioVenta AS DECIMAL(18,2)),
    ProcedureIdrubro);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdate`(
in ProductName varchar(155),
in ProductCodigo varchar(60),
in idProduct INT)
BEGIN
	UPDATE productos
    SET
    nombre=ProductName ,
    codigo=ProductCodigo
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosDelete`(
in idProduct INT
 )
BEGIN
	DELETE FROM productos
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosSearchIfExist`(
in ProductCodigo varchar(55),
out existencia INT
 )
BEGIN
    DECLARE registros decimal(18,2);
    SET registros=(SELECT COUNT(*) FROM productos WHERE codigo=ProductCodigo);
	IF (registros > 0) THEN
    SET existencia = 1;
    ELSE 
    SET existencia = 0;
    END IF;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdateCantidad`(
in idProduct INT,
in stock varchar(55)
 )
BEGIN
    DECLARE suma DECIMAL(18,2);
    DECLARE CantidadOld DECIMAL(18,2);
    SET CantidadOld=( SELECT cantidadvendida FROM productos WHERE id=idProduct);
    SET suma = CantidadOld + CAST(stock AS DECIMAL(18,2));
    UPDATE productos 
    SET  cantidadvendida=suma
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdateCantidadSimple`(
in idProduct INT,
in stock varchar(55)
 )
BEGIN
    UPDATE productos 
    SET  cantidadvendida=CAST(stock AS DECIMAL(18,2))
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdatePrecio`(
in ProductPrecioCompra varchar(55),
in ProductPrecioVenta varchar(55),
in idProduct INT
 )
BEGIN
	UPDATE productos
    SET
    preciocompra=ProductPrecioCompra ,
    precioventa=ProductPrecioVenta,
    fecha=curdate()
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdateFecha`( )
BEGIN
	UPDATE productos
    SET
    fecha=curdate();
END ;;
/*final*/





DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `PedidosPaginateFull`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM pedidosabastecimiento);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `PedidosPaginateFacturado`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(*) FROM pedidosabastecimiento WHERE facturado=true);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `PedidosPaginateSinFacturar`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(*) FROM pedidosabastecimiento WHERE facturado=false );
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `PedidosPaginatePorRealizar`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(*) FROM pedidosabastecimiento WHERE realizado=false);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;

CREATE PROCEDURE `PedidosPaginateRealizado`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(*) FROM pedidosabastecimiento WHERE realizado=true);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;


CREATE  PROCEDURE `PedidosIndexFull`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
	ORDER BY  'PRECIO'  ASC LIMIT  LongPage OFFSET inicial;
    
    
    
END ;;
DELIMITER ;
DELIMITER ;;


CREATE  PROCEDURE `PedidosIndexPorFacturar`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
    WHERE pedidosabastecimiento.facturado=false
	ORDER BY  'PRECIO'  ASC LIMIT  LongPage OFFSET inicial;
    
    
    
END ;;
DELIMITER ;
DELIMITER ;;

CREATE  PROCEDURE `PedidosIndexFacturados`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
    WHERE pedidosabastecimiento.facturado=true
	ORDER BY  'PRECIO'  ASC LIMIT  LongPage OFFSET inicial;
    
    
    
END ;;
DELIMITER ;
DELIMITER ;;


CREATE  PROCEDURE `PedidosIndexPorRealizar`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
    WHERE pedidosabastecimiento.realizado=false
	ORDER BY  'PRECIO'  ASC LIMIT  LongPage OFFSET inicial;
    
    
    
END ;;
DELIMITER ;
DELIMITER ;;


CREATE  PROCEDURE `PedidosIndexRealizados`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
    WHERE pedidosabastecimiento.realizado=true
	ORDER BY  'PRECIO'  ASC LIMIT  LongPage OFFSET inicial;
    
    
    
END ;;
DELIMITER ;
DELIMITER ;;

CREATE  PROCEDURE `PedidosSearchAbastecimientoCodPro`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
	WHERE productos.codigo LIKE  CONCAT('%',Procedurename, '%')
    ORDER BY  'PRECIO'  ASC LIMIT  25 OFFSET 0;
END ;;




DELIMITER ;
DELIMITER ;;

CREATE  PROCEDURE `PedidosSearchAbastecimientoNomProd`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
	WHERE productos.nombre LIKE  CONCAT('%',Procedurename, '%')
    ORDER BY  'PRECIO'  ASC LIMIT  25 OFFSET 0;
END ;;




DELIMITER ;
DELIMITER ;;

CREATE  PROCEDURE `PedidosSearchAbastecimientoNomProv`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT pedidosabastecimiento.id AS ID,
	productos.codigo as 'COD',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO',
    pedidosabastecimiento.cantidadvendida as 'CANT', 
	pedidosabastecimiento.precio as 'PRECIO.UNID', 
	pedidosabastecimiento.total as 'TOTAL', 
	proveedores.nombre as 'PROV', 
	pedidosabastecimiento.fecha as 'FECHA', 
	productos.id as 'ID2', 
	pedidosabastecimiento.realizado as 'REALIZADO', 
	pedidosabastecimiento.facturado as 'FACTURADO' 
	FROM pedidosabastecimiento
    INNER JOIN rubros ON rubros.id = pedidosabastecimiento.idrubro 
	INNER JOIN  proveedores ON proveedores.id = pedidosabastecimiento.idproveedor 
	INNER JOIN productos ON productos.id = pedidosabastecimiento.idproducto 
	WHERE proveedores.nombre LIKE  CONCAT('%',Procedurename, '%')
    ORDER BY  'PRECIO'  ASC LIMIT  25 OFFSET 0;
END ;;



DELIMITER ;
DELIMITER ;;

CREATE  PROCEDURE `PedidosFacturar`( 
in idPedido INT)
BEGIN
	UPDATE pedidosabastecimiento
    SET facturado=true
    WHERE id= idPedido;
END ;;

DELIMITER ;
DELIMITER ;;

CREATE  PROCEDURE `PedidosMarcar`( 
in idPedido INT)
BEGIN
	UPDATE pedidosabastecimiento
    SET realizado=true
    WHERE id= idPedido;
END ;;

DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `PedidosDelete`( 
in idPedido INT)
BEGIN
	DELETE FROM pedidosabastecimiento
    WHERE id= idPedido;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `PedidosValormax`( 
out MaxidPedido INT)
BEGIN
	SET MaxidPedido =(SELECT MAX(id) FROM pedidosabastecimiento);
END ;;


DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `PedidosCreate`( 
in ProcedureidProduct INT,
in ProcedureidProveedor INT,
in ProcedureIdrubro INT,
in ProcedureCantidad VARCHAR(55),
in ProcedurePrecioProveedor VARCHAR(55))
BEGIN
	declare control int;
    set	control=(SELECT MAX(id) FROM controlador);
	INSERT INTO pedidosabastecimiento 
    (
    idproducto,
    idproveedor,
    cantidadvendida,
    precio,
    idrubro,
    idcontrol
    )
    VALUES
    (
    ProcedureidProduct,
    ProcedureidProveedor,
    ProcedureCantidad ,
    ProcedurePrecioProveedor,
    ProcedureIdrubro,
    control);
END ;;












DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresCreate`( 
in ProveedorName varchar(150),
in ProveedorCuit varchar(150),
in ProveedorDireccion varchar(150),
in ProveedorTelefono varchar(150),
in ProveedorEmail varchar(150))
BEGIN
	declare control int;
    set	control=(SELECT MAX(id) FROM controlador);
	INSERT INTO proveedores
    (
    nombre,
    cuit,
    direccion,
    telefono,
    email,
    idcontrol
    )
    VALUES
    (
    NULLIF((RTRIM(LTRIM(ProveedorName))),''),
    NULLIF((RTRIM(LTRIM(ProveedorCuit))),''),
    NULLIF((RTRIM(LTRIM(ProveedorDireccion))),''),
    NULLIF((RTRIM(LTRIM(ProveedorTelefono))),''),
    NULLIF((RTRIM(LTRIM(ProveedorEmail))),''),
    control
    );
END ;;



DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProveedoresPaginate`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(*) FROM proveedores);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;


DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProveedorIndex`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    ORDER BY ID DESC LIMIT LongPage  OFFSET  inicial;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProveedorIndexUltimos`( 
)
BEGIN
    SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    ORDER BY ID DESC LIMIT 25  OFFSET  0;
END ;;



DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProveedorDelete`(
in idProveedor INT
)
BEGIN
	DELETE FROM proveedores
    WHERE id=idProveedor;
END ;;



DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresUpdate`
( 
in ProveedorName varchar(150),
in ProveedorCuit varchar(150),
in ProveedorDireccion varchar(150),
in ProveedorTelefono varchar(150),
in ProveedorEmail varchar(150),
in idProveedor INT
)
BEGIN
	UPDATE proveedores 
    SET
    nombre= NULLIF((RTRIM(LTRIM(ProveedorName))),''),
    cuit=NULLIF((RTRIM(LTRIM(ProveedorCuit))),''),
    direccion=NULLIF((RTRIM(LTRIM(ProveedorDireccion))),''),
    telefono=    NULLIF((RTRIM(LTRIM(ProveedorTelefono))),''),
    email=NULLIF((RTRIM(LTRIM(ProveedorEmail))),'')
    WHERE id=idProveedor;
END ;;






DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresSearchName`
( 
in Procedurename varchar(150)
)
BEGIN
	SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    WHERE nombre LIKE  CONCAT('%',Procedurename,'%') ORDER BY ID;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresSearchCuit`
( 
in Procedurename varchar(150)
)
BEGIN
	SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    WHERE cuit LIKE  CONCAT('%',Procedurename,'%') ORDER BY ID;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresSearchDireccion`
( 
in Procedurename varchar(150)
)
BEGIN
	SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    WHERE direccion LIKE  CONCAT('%',Procedurename,'%') ORDER BY ID;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresSearchEmail`
( 
in Procedurename varchar(150)
)
BEGIN
	SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    WHERE email LIKE  CONCAT('%',Procedurename,'%') ORDER BY ID;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProveedoresSearchTel`
( 
in Procedurename varchar(150)
)
BEGIN
	SELECT
    id as 'ID', 
    nombre as 'NOMBRE',
    cuit as 'CUIT',
    direccion as 'DIRECCION',
    telefono as 'TELEFONO',
    email as 'EMAIL'
    FROM proveedores
    WHERE telefono LIKE  CONCAT('%',Procedurename,'%') ORDER BY ID;
END ;;




                    



/*inicio*/



DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `VentasCreate`
( 
in ProcedureProductid INT,
in ProcedureIdrubro INT,
in ProcedureCantidad varchar(55),
in ProcedurePrecio varchar(55)
)
BEGIN
DECLARE suma DECIMAL(18,2);
 DECLARE CantidadOld DECIMAL(18,2);
	declare control, factura int;
    set	control=(SELECT MAX(id) FROM controlador);

   
    set	factura=(SELECT MAX(id) FROM facturas);

	INSERT INTO compraventa(
		idproducto,
		idfactura,
		cantidadvendida,
		precio,
		idrubro,
		idcontrol
		)
	VALUES(ProcedureProductid,
		factura,
		CAST(ProcedureCantidad  AS DECIMAL(18,2)),
		CAST(ProcedurePrecio  AS DECIMAL(18,2)),
		ProcedureIdrubro,
		control
		);
  
   
    SET CantidadOld=( SELECT cantidadvendida FROM productos WHERE id=ProcedureProductid);
    SET suma = CantidadOld + CAST(ProcedureCantidad AS DECIMAL(18,2));
    UPDATE productos 
    SET  cantidadvendida=suma
    WHERE id=ProcedureProductid;
      
        
       

END ;;







/*

DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductSearchName`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.nombre LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY ID DESC LIMIT 25 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductSearchCod`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.codigo LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY ID DESC LIMIT 25 OFFSET 0;
END ;;*/

DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `VentasPaginateTodas`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM compraventa);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;


DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `VentasPaginateVentas`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM compraventa  WHERE compra=false);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;



DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `VentasConteoTotal`( 
out ProcedureConteoTotal INT(11))
BEGIN
	SET ProcedureConteoTotal = (SELECT  COUNT(*) FROM compraventa where compra=false);
END ;;
/*
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateStock`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos WHERE cantidadvendida>0);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateSinStock`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos WHERE cantidadvendida<=0.00);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateNullFecha`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos WHERE fecha IS NULL);
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateOldFecha`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos  WHERE fecha < curdate() );
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductPaginateNewFecha`( 
in ProcedureLongPage INT,
out ProcedureTotalPage INT(11))
BEGIN
  DECLARE CountRows INT;
   SET CountRows = (SELECT COUNT(id) FROM productos  WHERE fecha >= curdate());
   SET ProcedureTotalPage = CountRows / ProcedureLongPage;
   IF (CountRows / ProcedureLongPage) > ProcedureTotalPage
   then	
   SET ProcedureTotalPage = ProcedureTotalPage + 1;
   ELSE set ProcedureTotalPage = ProcedureTotalPage;
   End if;
   IF (ProcedureTotalPage = 0)   then
   SET ProcedureTotalPage = 1;
   end if;
   
END ;;

*/
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `VentasIndex`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT compraventa.id  AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    compraventa.fecha as 'FECHA',
    compraventa.precio as 'PRECIO',
    compraventa.cantidadvendida as 'CANT',
    compraventa.total as 'TOTAL'
    FROM compraventa
    INNER JOIN rubros ON rubros.id = compraventa.idrubro
    INNER JOIN productos ON productos.id = compraventa.idproducto  WHERE compraventa.compra=false
    ORDER BY ID DESC LIMIT  LongPage OFFSET  inicial;
END ;;


DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `VentasIndexFacturacion`( 
in  ProcedureIdFactura  INT
)
BEGIN
    SELECT compraventa.id  AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    compraventa.fecha as 'FECHA',
    compraventa.precio as 'PRECIO',
    compraventa.cantidadvendida as 'CANT',
    compraventa.total as 'TOTAL'
    FROM compraventa
    INNER JOIN rubros ON rubros.id = compraventa.idrubro
    INNER JOIN productos ON productos.id = compraventa.idproducto WHERE compraventa.idfactura=ProcedureIdFactura
    ORDER BY ID DESC;
END ;;


               







DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `EstadisticasDiariasVentas`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT
	DATE(fecha) as 'FECHA DE VENTAS',
    SUM(cantidadvendida) as 'CANTIDAD VENDIDA', 
    SUM(total) as 'TOTAL VENDIDO EN PESOS'
    FROM compraventa 
    WHERE compra=false 
    GROUP BY DATE( compraventa.fecha) 
    DESC LIMIT LongPage OFFSET inicial;
END ;;



DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `EstadisticasMensualesVentas`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT
	YEAR(fecha) as 'AÑO',
	MONTH(fecha) as 'MES DE VENTA',
	SUM(cantidadvendida) as 'CANTIDAD VENDIDA', 
    SUM(total) as 'TOTAL VENDIDO EN PESOS'
    FROM compraventa 
    WHERE compra=false 
    GROUP BY MONTH( compraventa.fecha) 
    DESC LIMIT LongPage OFFSET inicial;
END ;;



DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `EstadisticasAnualesVentas`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT
	YEAR(fecha) as 'AÑO',
	SUM(cantidadvendida) as 'CANTIDAD VENDIDA', 
    SUM(total) as 'TOTAL VENDIDO EN PESOS'
    FROM compraventa 
    WHERE compra=false 
    GROUP BY YEAR( compraventa.fecha)
    DESC LIMIT LongPage OFFSET inicial;
END ;;

/*
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductIndexSinStock`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
     WHERE productos.cantidadvendida<=0.00
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductIndexOldFecha`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
     WHERE productos.fecha < curdate()
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductIndexNewFecha`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.fecha>=	curdate()
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductIndexNullFecha`( 
in  LongPage  INT,
in  PageNumber  INT
)
BEGIN
	declare inicial int;
    set	inicial=(PageNumber*LongPage)-LongPage;
    SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.fecha IS NULL
    ORDER BY  'NOMBRE'  ASC LIMIT  LongPage OFFSET inicial;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductIndexUltimos`( )
BEGIN
    SELECT productos.id AS 'ID',
	productos.codigo as 'CODIGO big beibi',
    productos.nombre AS 'NOMBRE', 
    rubros.nombre as 'RUBRO',
    productos.cantidadvendida as 'CANTIDAD VENDIDA',
    productos.fecha as 'ACTUALIZADO',
    productos.preciocompra as 'PRECIO DE COMPRA',
    productos.precioventa as 'PRECIO DE VENTA',
    productos.diferencia as 'DIFERENCIA OBTENIDA',
    productos.porcentaje as 'PORCENTAJE DE AUMENTO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
    ORDER BY  productos.id DESC LIMIT  25 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteo`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoStock`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where cantidadvendida>0.00);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoSinStock`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where cantidadvendida<=0.00);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoNullFecha`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where fecha is null);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoOldFecha`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where fecha <curdate());
END ;;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `ProductConteoNewFecha`( 
out ProcedureTotal INT(11))
BEGIN
   SET ProcedureTotal = (SELECT COUNT(id) FROM productos Where fecha >=curdate());
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductSearchNameVenta`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'PRODUCTO', 
    rubros.nombre as 'RUBRO',
    productos.precioventa as 'PRECIO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.nombre LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY ID DESC LIMIT 3 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductSearchCodVenta`( 
in Procedurename VARCHAR(55))
BEGIN
	SELECT productos.id AS ID,
	productos.codigo as 'CODIGO',
    productos.nombre AS 'PRODUCTO', 
    rubros.nombre as 'RUBRO',
    productos.precioventa as 'PRECIO'
    FROM productos
    INNER JOIN rubros ON rubros.id = productos.rubro 
	WHERE productos.codigo LIKE  CONCAT('%',Procedurename, '%')
	ORDER BY ID DESC LIMIT 3 OFFSET 0;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosCreate`(
in ProductName varchar(155),
in ProductCodigo varchar(60),
in ProductCantidad varchar(60),
in ProductPrecioCompra varchar(60),
in ProductPrecioVenta varchar(60),
in ProcedureIdrubro int
 )
BEGIN
	declare control int;
    set	control=(SELECT MAX(id) FROM controlador);
	INSERT INTO productos
    (
    nombre,
    codigo,
    cantidadvendida,
    idcontrol,
    preciocompra,
    precioventa,
    rubro
    )
    VALUES 
    ( 
    NULLIF((RTRIM(LTRIM(ProductName))),''),
	NULLIF((RTRIM(LTRIM(ProductCodigo))),''),
    CAST(ProductCantidad AS DECIMAL(18,2)),
    control,
    CAST(ProductPrecioCompra AS DECIMAL(18,2)),
    CAST(ProductPrecioVenta AS DECIMAL(18,2)),
    ProcedureIdrubro);
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdate`(
in ProductName varchar(155),
in ProductCodigo varchar(60),
in idProduct INT)
BEGIN
	UPDATE productos
    SET
    nombre=ProductName ,
    codigo=ProductCodigo
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosDelete`(
in idProduct INT
 )
BEGIN
	DELETE FROM productos
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosSearchIfExist`(
in ProductCodigo varchar(55),
out existencia INT
 )
BEGIN
    DECLARE registros decimal(18,2);
    SET registros=(SELECT COUNT(*) FROM productos WHERE codigo=ProductCodigo);
	IF (registros > 0) THEN
    SET existencia = 1;
    ELSE 
    SET existencia = 0;
    END IF;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdateCantidad`(
in idProduct INT,
in stock varchar(55)
 )
BEGIN
    DECLARE suma DECIMAL(18,2);
    DECLARE CantidadOld DECIMAL(18,2);
    SET CantidadOld=( SELECT cantidadvendida FROM productos WHERE id=idProduct);
    SET suma = CantidadOld + CAST(stock AS DECIMAL(18,2));
    UPDATE productos 
    SET  cantidadvendida=suma
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdateCantidadSimple`(
in idProduct INT,
in stock varchar(55)
 )
BEGIN
    UPDATE productos 
    SET  cantidadvendida=CAST(stock AS DECIMAL(18,2))
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdatePrecio`(
in ProductPrecioCompra varchar(55),
in ProductPrecioVenta varchar(55),
in idProduct INT
 )
BEGIN
	UPDATE productos
    SET
    preciocompra=ProductPrecioCompra ,
    precioventa=ProductPrecioVenta,
    fecha=curdate()
    WHERE id=idProduct;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `ProductosUpdateFecha`( )
BEGIN
	UPDATE productos
    SET
    fecha=curdate();
END ;;
/*final*/

DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `RubrosCreate`( 
in ProcedureNombre varchar(150))
BEGIN
  declare control int;
    set control=(SELECT MAX(id) FROM controlador);
  INSERT INTO rubros
    (
    nombre,
    idcontrol
    )
    VALUES
    (
    NULLIF((RTRIM(LTRIM(ProcedureNombre))),''),
    control
    );
END ;;


DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `RubrosIndex`()
BEGIN
    SELECT
    id as 'ID', 
    nombre as 'NOMBRE'
    FROM rubros
    ORDER BY ID ASC;
END ;;

DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `RubrosIndexDesc`()
BEGIN
    SELECT
    id as 'ID', 
    nombre as 'NOMBRE'
    FROM rubros
    ORDER BY ID DESC;
END ;;

DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `RubrosUpdate`(
in ProcedureNombre varchar(155),
in ProcedureId INT)
BEGIN
  UPDATE rubros
    SET
    nombre=ProcedureNombre
    WHERE id=ProcedureId;
END ;;



DELIMITER ;
DELIMITER ;;
CREATE  PROCEDURE `RubrosDelete`(
in ProvedureId INT
 )
BEGIN
  DELETE FROM rubros
    WHERE id=ProvedureId;
END ;;


