--------------------------------------------------------
-- Archivo creado  - sábado-julio-18-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence PERSONA_PERSONA_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FERNE"."PERSONA_PERSONA_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SIGUIENTE
--------------------------------------------------------

   CREATE SEQUENCE  "FERNE"."SIGUIENTE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence S_PROVEEDORES
--------------------------------------------------------

   CREATE SEQUENCE  "FERNE"."S_PROVEEDORES"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 45 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BOLETA
--------------------------------------------------------

  CREATE TABLE "FERNE"."BOLETA" 
   (	"CANTIDAT" NUMBER(*,0), 
	"ID_BOLETA" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table CLIENTE
--------------------------------------------------------

  CREATE TABLE "FERNE"."CLIENTE" 
   (	"ID" NUMBER, 
	"PERSONA_PERSONA_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table EMPLEADO
--------------------------------------------------------

  CREATE TABLE "FERNE"."EMPLEADO" 
   (	"ID" NUMBER(*,0), 
	"CARGO" VARCHAR2(20 CHAR), 
	"PERSONA_PERSONA_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table EMPLEADO_OC
--------------------------------------------------------

  CREATE TABLE "FERNE"."EMPLEADO_OC" 
   (	"EMPLEADO_ID" NUMBER(*,0), 
	"OC_ID_OC" NUMBER(*,0), 
	"OC_PROVEEDOR_ID" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table FACTURA
--------------------------------------------------------

  CREATE TABLE "FERNE"."FACTURA" 
   (	"ID_FACTURA" NUMBER(*,0), 
	"CANTIDAD" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table FACTURA_CLIENTE
--------------------------------------------------------

  CREATE TABLE "FERNE"."FACTURA_CLIENTE" 
   (	"CLIENTE_ID" NUMBER(*,0), 
	"FACTURA_ID_FACTURA" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table OC
--------------------------------------------------------

  CREATE TABLE "FERNE"."OC" 
   (	"CANTIDAD" NUMBER(*,0), 
	"ID_OC" NUMBER(*,0), 
	"PROVEEDOR_ID" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PERFILAMIENTO
--------------------------------------------------------

  CREATE TABLE "FERNE"."PERFILAMIENTO" 
   (	"TIPO" VARCHAR2(20 BYTE), 
	"ID" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PERSONA
--------------------------------------------------------

  CREATE TABLE "FERNE"."PERSONA" 
   (	"NOMBRE" VARCHAR2(100 BYTE), 
	"APELLIDO" VARCHAR2(100 BYTE), 
	"DIRECCION" VARCHAR2(100 BYTE), 
	"CORREO" VARCHAR2(100 BYTE), 
	"RUT" VARCHAR2(20 BYTE), 
	"TELEFONO" NUMBER(*,0), 
	"PERSONA_ID" NUMBER, 
	"EMPRESA" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table PRODUCTO
--------------------------------------------------------

  CREATE TABLE "FERNE"."PRODUCTO" 
   (	"ID_PRODUCTO" NUMBER(*,0), 
	"FECHA_VENCIMIENTO" DATE, 
	"ID_TIPO" NUMBER(*,0), 
	"PRECIO" NUMBER(*,0), 
	"STOCK" NUMBER(*,0), 
	"STOCK_CRITICO" NUMBER(*,0), 
	"DESCRIPCION" VARCHAR2(200 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table PRODUCTO_OC
--------------------------------------------------------

  CREATE TABLE "FERNE"."PRODUCTO_OC" 
   (	"PRODUCTO_ID_PRODUCTO" NUMBER(*,0), 
	"PRODUCTO_STOCK" NUMBER(*,0), 
	"OC_ID_OC" NUMBER(*,0), 
	"OC_PROVEEDOR_ID" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PROVEEDOR
--------------------------------------------------------

  CREATE TABLE "FERNE"."PROVEEDOR" 
   (	"ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(20 CHAR), 
	"CELULAR" VARCHAR2(10 CHAR), 
	"RUBRO" VARCHAR2(20 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table RELATION_16
--------------------------------------------------------

  CREATE TABLE "FERNE"."RELATION_16" 
   (	"VENTA_ID" NUMBER(*,0), 
	"PRODUCTO_ID_PRODUCTO" NUMBER(*,0), 
	"PRODUCTO_STOCK" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table USUARIOS
--------------------------------------------------------

  CREATE TABLE "FERNE"."USUARIOS" 
   (	"ID" NUMBER(*,0), 
	"UNAME" VARCHAR2(20 CHAR), 
	"PASS" VARCHAR2(20 CHAR), 
	"PERFILAMIENTO_ID" NUMBER(*,0), 
	"PERSONA_PERSONA_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table VENTA
--------------------------------------------------------

  CREATE TABLE "FERNE"."VENTA" 
   (	"ID" NUMBER(*,0), 
	"CANTIDAD" NUMBER(*,0), 
	"EMPLEADO_ID" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table VENTA_BOLETA
--------------------------------------------------------

  CREATE TABLE "FERNE"."VENTA_BOLETA" 
   (	"VENTA_ID" NUMBER(*,0), 
	"BOLETA_ID_BOLETA" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table VENTA_FACTURA
--------------------------------------------------------

  CREATE TABLE "FERNE"."VENTA_FACTURA" 
   (	"FACTURA_ID_FACTURA" NUMBER(*,0), 
	"VENTA_ID" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for View VW_CLIENTES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FERNE"."VW_CLIENTES" ("ID", "PERSONA_PERSONA_ID", "NOMBRE", "APELLIDO", "DIRECCION", "CORREO", "RUT", "TELEFONO", "EMPRESA") AS 
  SELECT cliente.id, PERSONA_PERSONA_ID, NOMBRE , APELLIDO, Direccion, Correo, rut, telefono , empresa 
    from CLIENTE INNER JOIN PERSONA on persona.persona_id = cliente.persona_persona_id
;
--------------------------------------------------------
--  DDL for View VW_CLIENTES2
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FERNE"."VW_CLIENTES2" ("ID", "NOMBRE", "APELLIDO", "DIRECCION", "CORREO", "RUT", "TELEFONO", "EMPRESA", "UNAME", "PASS") AS 
  select c.id, p.nombre , p.APELLIDO, p.Direccion, p.Correo, p.rut, p.telefono, p.empresa, u.uname, u.pass
    from cliente C, persona p, usuarios u
    where c.persona_persona_id = p.persona_id 
    and C.persona_persona_id = u.persona_persona_id
;
--------------------------------------------------------
--  DDL for View VW_EMPLEADOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FERNE"."VW_EMPLEADOS" ("ID", "CARGO", "PERSONA_ID", "NOMBRE", "APELLIDO", "DIRECCION", "CORREO", "RUT", "TELEFONO", "UNAME", "PASS") AS 
  select e.id, e.cargo, p.persona_id, p.NOMBRE , p.APELLIDO, p.Direccion, p.Correo, p.rut, p.telefono,u.uname, u.pass
    from empleado e, persona p, usuarios u
    where e.persona_persona_id = p.persona_id 
    and e.persona_persona_id = u.persona_persona_id
;
--------------------------------------------------------
--  DDL for View VW_PRODUCTOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FERNE"."VW_PRODUCTOS" ("ID_PRODUCTO", "FECHA_VENCIMIENTO", "ID_TIPO", "PRECIO", "STOCK", "STOCK_CRITICO", "DESCRIPCION") AS 
  SELECT "ID_PRODUCTO","FECHA_VENCIMIENTO","ID_TIPO","PRECIO","STOCK","STOCK_CRITICO","DESCRIPCION" FROM PRODUCTO
;
--------------------------------------------------------
--  DDL for View VW_PROVEEDOR
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FERNE"."VW_PROVEEDOR" ("NOMBRE", "CELULAR", "RUBRO") AS 
  (select nombre, celular, rubro from proveedor)
;
--------------------------------------------------------
--  DDL for View VW_USUARIOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FERNE"."VW_USUARIOS" ("UNAME", "PASS") AS 
  (select uname, pass from usuarios)
;
REM INSERTING into FERNE.BOLETA
SET DEFINE OFF;
Insert into FERNE.BOLETA (CANTIDAT,ID_BOLETA) values ('54000','9');
REM INSERTING into FERNE.CLIENTE
SET DEFINE OFF;
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('2','2');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('3','3');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('4','4');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('5','5');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('6','6');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('7','25');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('8','26');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('9','27');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('10','28');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('11','29');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('12','30');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('13','31');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('14','32');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('15','33');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('16','34');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('17','35');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('18','36');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('19','37');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('20','38');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('21','39');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('22','40');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('23','41');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('24','42');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('25','43');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('26','44');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('27','45');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('28','46');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('29','47');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('30','48');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('31','49');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('32','50');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('33','51');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('34','52');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('35','53');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('36','54');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('37','55');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('38','56');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('39','57');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('40','58');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('41','59');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('42','60');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('43','61');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('44','62');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('45','63');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('46','66');
Insert into FERNE.CLIENTE (ID,PERSONA_PERSONA_ID) values ('47','67');
REM INSERTING into FERNE.EMPLEADO
SET DEFINE OFF;
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('100','gerente','1');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('103','recepcion','7');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('104','recepcion','8');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('105','recepcion','9');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('106','administrador','10');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('107','administrador','11');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('108','administrador','12');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('109','administrador','13');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('110','vendedor','14');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('111','prueba','15');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('112','prueba','16');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('113','prueba','17');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('114','prueba','18');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('115','prueba','19');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('116','prueba','20');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('117','prueba','21');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('118','prueba','22');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('119','prueba','23');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('120','prueba','24');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('121',' ','64');
Insert into FERNE.EMPLEADO (ID,CARGO,PERSONA_PERSONA_ID) values ('122',' empleado','65');
REM INSERTING into FERNE.EMPLEADO_OC
SET DEFINE OFF;
Insert into FERNE.EMPLEADO_OC (EMPLEADO_ID,OC_ID_OC,OC_PROVEEDOR_ID) values ('104','1','1');
REM INSERTING into FERNE.FACTURA
SET DEFINE OFF;
Insert into FERNE.FACTURA (ID_FACTURA,CANTIDAD) values ('100','50000');
REM INSERTING into FERNE.FACTURA_CLIENTE
SET DEFINE OFF;
REM INSERTING into FERNE.OC
SET DEFINE OFF;
Insert into FERNE.OC (CANTIDAD,ID_OC,PROVEEDOR_ID) values ('100','1','1');
Insert into FERNE.OC (CANTIDAD,ID_OC,PROVEEDOR_ID) values ('30','2','2');
REM INSERTING into FERNE.PERFILAMIENTO
SET DEFINE OFF;
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('admin','1');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('clie','2');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','6');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','3');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','4');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','5');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('admin','7');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','8');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('TEST 9','9');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','10');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','11');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','12');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','13');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','14');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','15');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','16');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','17');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','18');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','19');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','20');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','21');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','22');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','23');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','24');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','25');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','26');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','27');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','28');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','29');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','30');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','31');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','32');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','33');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','34');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','35');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','36');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','37');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','38');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','39');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','40');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','41');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','42');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','43');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','44');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('emp','45');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','46');
Insert into FERNE.PERFILAMIENTO (TIPO,ID) values ('client','47');
REM INSERTING into FERNE.PERSONA
SET DEFINE OFF;
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('sergio','manguera','lira 1237','sergio@mail.com','1333444-7','8515806','1',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('franco','urra','sol333','prueba3@gmail.com','1655756','0','2','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('JESUS','MOLINA','DA LO MISMO 12345','algo@gmail.com','1-9','123456789','3','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Andres','Espinoza','DA LO MISMO 12321','algo@email.com','1-9','123456782','4','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Andres','Espinoza','DA LO MISMO 12321','algo@email.com','1-9','123456782','5','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jona','Hernandez','csmahsaljs 1254','algoa@algo.cl','12345678-8','45545465','6','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('carlos','urrutia','lira 8976','usrruti@mail.com','1755663-8','876543','7',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('romina','urzua','madrid 3476','rurzua@mail.com','17567853-8','9845673','8',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('jose','maza','madrid 5678','jmaza@mail.com','13654789-0','98765432','9',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('margarita','mosqueta','portugal 5678','mar@mail.com','18462492-3','98765432','10',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('claudia','mortera','portugal 5678','mar@mail.com','17432678-0','98765432','11',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('claudia','mortera','portugal 5678','mar@mail.com','17432678-0','98765432','12',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('claudia','mortera','portugal 5678','mar@mail.com','17432678-0','98765432','13',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('claudia','mortera','portugal 5678','mar@mail.com','17432678-0','98765432','14',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('jesus','espinoza','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','15',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueba','prueba','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','16',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueba','prueba','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','17',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueba','prueba','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','18',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueba','prueba','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','19',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueba','prueba','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','20',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueba','prueba','cdsfsds 1254','alsdfds@algo.cl','12345444-8','45514145','21',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueb','pru2','cdds 1254','a@algo.cl','12344-8','45514145','22',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueb','pru2','cdds 1254','a@algo.cl','12344-8','45514145','23',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('pueb','pru2','cdds 1254','a@algo.cl','12344-8','45514145','24',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' j@jmail.com',' 16471559','996860937','25','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' j@jmail.com',' 16471559','996860937','26','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' j@jmail.com',' 16471559','996860937','27','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('prueba profe','molina','Navarrete 1280 Providencia',' j@jmail.com',' 16471559','995959595','28','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('prueba 1000','molina','Navarrete 1280 Providencia',' jw@jmail.com',' 456456456','996860937','29','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' braulio',' nelson','americo vespucio 1111',' jdgdfghdfg@jmail.com',' 85555555','996860937','30','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' dfgsghdfgh',' dfgdfgdfg','Navarrete 1280 Providencia',' fghu',' 123456789','453453','31','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' jdgdfghdfg@jmail.com',' 16471559','996860937','32','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' ',' ','996860937','33','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','34','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','35','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','36','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' ',' 777777777','996860937','37','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' franco',' Urra','Navarrete 1280 Providencia',' jdgdfghdfg@jmail.com',' 164715598','996860937','38','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('   braulio','nelson','Navarrete 1280 Providencia',' jw@jmail.com',' 16471559','0','39','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' pablo',' guerra','Navarrete 1280 Providencia',' jw@jmail.com',' 456465465','568949469','40','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' Elver',' galarga','Navarrete 1280 Providencia',' j@jmail.com',' 99966655441','0','41','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' condoritux','veliz','timeo 44444',' ',' 12222222-8','21333333','42','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('prueba3','pruebacli','csmahsaljs 1254','algoa@algo.cl','12345678-8','45545465','43','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' bbbbb',' jjjkkkk','Navarrete 1280 Providencia',' jdgdooofghdfg@jmail.com',' 78888888','752121111','44','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('norman','bate','lira 1237','algo@mail.com',' 184624923','8515806','45','2');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','46','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('norman','bate','lira 1237',' algo@mail.com',' 184624923','8515806','47','54');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('norman','bate','lira 1237',' algo@mail.com','184624923','8515806','48','45');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' Braulio','nelson',' lira 1237',' algo@mail.com',' 184624923','92109284','49','45');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' prueba',' prueba','Navarrete 1280 Providencia',' j@jmail.com',' 15555555','996860937','50','1');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' condoritux',' ii',' kkkk',' ',' 11111111-5','21333333','51','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','52','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','53','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('JEsususususu',' ',' ',' ',' ','0','54','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('JESUS0001',' ',' ',' ',' ','0','55','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('JESUS','MOLINA','DA LO MISMO 12345','algo@gmail.com','1-9','0','56','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' condoritux','maraco',' kkkk',' hhhh@jjj.cl',' 12222255-8','21333333','57','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('eff',' ',' ',' ',' 126097131','0','58','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','59','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' ',' ',' ',' ',' ','0','60','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' Braulio',' ',' ',' ',' ','0','61','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('prueba3','pruebacli','csmahsaljs 1254','algoa@algo.cl','12345678-8','45545465','62','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('prueba3','pruebacli','csmahsaljs 1254','algoa@algo.cl','12345678-8','45545465','63','0');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' prueba',' ',' ',' ',' 123456789-k','0','64',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('Jesús','molina','Navarrete 1280 Providencia',' ',' 123456789-0','996860937','65',null);
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values ('111','11','11','11','12','11','66','11');
Insert into FERNE.PERSONA (NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA) values (' jesus',' molina','Navarrete 1280 Providencia',' jesus@gmail.com',' 16471533-7','996860937','67','1');
REM INSERTING into FERNE.PRODUCTO
SET DEFINE OFF;
Insert into FERNE.PRODUCTO (ID_PRODUCTO,FECHA_VENCIMIENTO,ID_TIPO,PRECIO,STOCK,STOCK_CRITICO,DESCRIPCION) values ('1',to_date('25/06/20','DD/MM/RR'),'1','5000','12','12','martillo');
Insert into FERNE.PRODUCTO (ID_PRODUCTO,FECHA_VENCIMIENTO,ID_TIPO,PRECIO,STOCK,STOCK_CRITICO,DESCRIPCION) values ('2',to_date('25/06/20','DD/MM/RR'),'2','12000','200','60','clavos');
REM INSERTING into FERNE.PRODUCTO_OC
SET DEFINE OFF;
REM INSERTING into FERNE.PROVEEDOR
SET DEFINE OFF;
Insert into FERNE.PROVEEDOR (ID,NOMBRE,CELULAR,RUBRO) values ('1','juanmaestro','12345678','semento');
Insert into FERNE.PROVEEDOR (ID,NOMBRE,CELULAR,RUBRO) values ('2','polpaico','65784723','construccion');
Insert into FERNE.PROVEEDOR (ID,NOMBRE,CELULAR,RUBRO) values ('5','Bauker','12345678','herramientas');
Insert into FERNE.PROVEEDOR (ID,NOMBRE,CELULAR,RUBRO) values ('6','delco','12345678','tornillos');
REM INSERTING into FERNE.RELATION_16
SET DEFINE OFF;
REM INSERTING into FERNE.USUARIOS
SET DEFINE OFF;
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('10','smanguera','roma.2345','1','1');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('3','ser','urz184','4','10');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('5','cla','mor174','5','11');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('6','cla','mor174','6','12');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('7','cla','mor174','7','13');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('8','cla','mor174','8','14');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('21','jes','esp123','10','15');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('41','pue','pru123','11','16');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('42','pue','pru123','12','17');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('43','pue','pru123','13','18');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('44','pue','pru123','14','19');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('45','pue','pru123','15','20');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('46','pue','pru123','16','21');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('47','pue','pru123','17','22');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('48','pue','pru123','18','23');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('49','pue','pru123','19','24');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('61',' pa',' gu 45','20','40');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('62',' El',' ga 99','21','41');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('63',' co','vel 12','22','42');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('64','pru','pru123','23','43');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('65',' bb',' jj 78','24','44');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('66','nor','bat 18','25','45');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('67',' ','  ','26','46');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('68','nor','bat 18','27','47');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('69','nor','bat184','28','48');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('70',' Br','nel 18','29','49');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('71',' pr',' pr 15','30','50');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('72',' co',' ii 11','31','51');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('73',' ','  ','32','52');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('74',' ','  ','33','53');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('75','JEs','  ','34','54');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('76','JES','  ','35','55');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('77','JES','MOL1-9','36','56');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('81',' co','mar 12','37','57');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('82','eff','  12','38','58');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('83',' ','  ','39','59');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('84',' ','  ','40','60');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('85',' Br','  ','41','61');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('86','pru','pru123','42','62');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('87','pru','pru123','43','63');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('88',' pr','  12','44','64');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('89','Jes','mol 12','45','65');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('90','111','1112','46','66');
Insert into FERNE.USUARIOS (ID,UNAME,PASS,PERFILAMIENTO_ID,PERSONA_PERSONA_ID) values ('91',' je',' mo 16','47','67');
REM INSERTING into FERNE.VENTA
SET DEFINE OFF;
Insert into FERNE.VENTA (ID,CANTIDAD,EMPLEADO_ID) values ('1','50000','103');
Insert into FERNE.VENTA (ID,CANTIDAD,EMPLEADO_ID) values ('2','54000','105');
REM INSERTING into FERNE.VENTA_BOLETA
SET DEFINE OFF;
Insert into FERNE.VENTA_BOLETA (VENTA_ID,BOLETA_ID_BOLETA) values ('2','9');
REM INSERTING into FERNE.VENTA_FACTURA
SET DEFINE OFF;
Insert into FERNE.VENTA_FACTURA (FACTURA_ID_FACTURA,VENTA_ID) values ('100','1');
--------------------------------------------------------
--  DDL for Index USUARIOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."USUARIOS_PK" ON "FERNE"."USUARIOS" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index RELATION_16_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."RELATION_16_PK" ON "FERNE"."RELATION_16" ("VENTA_ID", "PRODUCTO_ID_PRODUCTO", "PRODUCTO_STOCK") 
  ;
--------------------------------------------------------
--  DDL for Index PERFILAMIENTO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."PERFILAMIENTO_PK" ON "FERNE"."PERFILAMIENTO" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index BOLETA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."BOLETA_PK" ON "FERNE"."BOLETA" ("ID_BOLETA") 
  ;
--------------------------------------------------------
--  DDL for Index VENTA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."VENTA_PK" ON "FERNE"."VENTA" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index PRODUCTO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."PRODUCTO_PK" ON "FERNE"."PRODUCTO" ("ID_PRODUCTO", "STOCK") 
  ;
--------------------------------------------------------
--  DDL for Index OC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."OC_PK" ON "FERNE"."OC" ("ID_OC", "PROVEEDOR_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FACTURA_CLIENTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."FACTURA_CLIENTE_PK" ON "FERNE"."FACTURA_CLIENTE" ("CLIENTE_ID", "FACTURA_ID_FACTURA") 
  ;
--------------------------------------------------------
--  DDL for Index PERSONA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."PERSONA_PK" ON "FERNE"."PERSONA" ("PERSONA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index VENTA__IDX
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."VENTA__IDX" ON "FERNE"."VENTA" ("EMPLEADO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMPLEADO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."EMPLEADO_PK" ON "FERNE"."EMPLEADO" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMPLEADO_OC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."EMPLEADO_OC_PK" ON "FERNE"."EMPLEADO_OC" ("EMPLEADO_ID", "OC_ID_OC", "OC_PROVEEDOR_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PRODUCTO_OC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."PRODUCTO_OC_PK" ON "FERNE"."PRODUCTO_OC" ("PRODUCTO_ID_PRODUCTO", "PRODUCTO_STOCK", "OC_ID_OC", "OC_PROVEEDOR_ID") 
  ;
--------------------------------------------------------
--  DDL for Index VENTA_BOLETA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."VENTA_BOLETA_PK" ON "FERNE"."VENTA_BOLETA" ("VENTA_ID", "BOLETA_ID_BOLETA") 
  ;
--------------------------------------------------------
--  DDL for Index CLIENTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."CLIENTE_PK" ON "FERNE"."CLIENTE" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index FACTURA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."FACTURA_PK" ON "FERNE"."FACTURA" ("ID_FACTURA") 
  ;
--------------------------------------------------------
--  DDL for Index VENTA_FACTURA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."VENTA_FACTURA_PK" ON "FERNE"."VENTA_FACTURA" ("FACTURA_ID_FACTURA", "VENTA_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PROVEEDOR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FERNE"."PROVEEDOR_PK" ON "FERNE"."PROVEEDOR" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Trigger GENEEMPOC
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."GENEEMPOC" 
after insert on oc
declare
    vemp_id empleado_oc.empleado_id%type;
    voc_id empleado_oc.oc_id_oc%type;
    vproo_id empleado_oc.oc_proveedor_id%type;
begin
    select max(em.id) into vemp_id from empleado em where em.cargo = 'recepcion';
    select max(o.id_oc) into voc_id from oc o;
    select max(o.proveedor_id) into vproo_id from oc o;

    insert into empleado_oc(empleado_id, oc_id_oc, oc_proveedor_id)
    values(vemp_id,voc_id,vproo_id);
end geneEmpOC;
/
ALTER TRIGGER "FERNE"."GENEEMPOC" ENABLE;
--------------------------------------------------------
--  DDL for Trigger GENERATE_PRODUCTO_VENTA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."GENERATE_PRODUCTO_VENTA" 
before insert on VENTA
declare
    v_ventaID venta.id%type;
    v_productoID producto.id_producto%type;
    v_productoStock producto.stock%type;
    v_cantidadVenta venta.cantidad%type;
begin

    select max(ven.ID) into v_ventaID from venta ven;
    select max(pr.ID_PRODUCTO) into v_productoID from PRODUCTO pr;
    select pr.STOCK_CRITICO into v_productoStock from PRODUCTO pr
    where pr.ID_PRODUCTO = v_productoID;
    select ven.CANTIDAD into v_cantidadVenta from VENTA ven
    where ven.ID = v_ventaID;

    if v_productoStock = 0 then
        delete from RELATION_16 where PRODUCTO_ID_PRODUCTO = v_productoID;
    end if;

    v_productoStock := v_productoStock - v_cantidadVenta;

    insert into RELATION_16(VENTA_ID, PRODUCTO_ID_PRODUCTO, PRODUCTO_STOCK)
    values(v_ventaID,v_productoID,v_productoStock);

end;
/
ALTER TRIGGER "FERNE"."GENERATE_PRODUCTO_VENTA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger GENERATE_USER_CLI
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."GENERATE_USER_CLI" 
after insert on cliente

declare
    
    v_id cliente.id%type;
    v_persona cliente.persona_persona_id%type;
    v_uname persona.nombre%type;
    v_pass  usuarios.pass%type;
    v_perid perfilamiento.id%type;

begin

    select max(per.ID) into v_perid from PERFILAMIENTO per;

    v_perid:= v_perid+1 ;

    insert into PERFILAMIENTO(PERFILAMIENTO.TIPO, PERFILAMIENTO.ID)
        values('client', v_perid);

    select substr(p.NOMBRE,1,3) into v_uname from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select substr(p.APELLIDO,1,3) || substr(p.RUT,1,3) into v_pass from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select max(per.ID) into v_perid from PERFILAMIENTO per;

    select max(p.PERSONA_ID) into v_persona from PERSONA p;

    insert into USUARIOS(USUARIOS.ID, usuarios.uname, USUARIOS.PASS, USUARIOS.PERFILAMIENTO_ID, USUARIOS.PERSONA_PERSONA_ID)
    values (siguiente.nextval,v_uname, v_pass, v_perid,v_persona);
end generate_user_cli;
/
ALTER TRIGGER "FERNE"."GENERATE_USER_CLI" ENABLE;
--------------------------------------------------------
--  DDL for Trigger GENERATE_USER_EMP
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."GENERATE_USER_EMP" 
after insert on empleado

declare

    vcargo empleado.cargo%type;
    vuname usuarios.uname%type;
    vpass usuarios.pass%type ;
    vperid usuarios.perfilamiento_id%type;
    vpersona usuarios.persona_persona_id%type;

begin
    select em.CARGO into vcargo from EMPLEADO em
    where em.ID = (select max(id) from EMPLEADO);

    select max(per.ID) into vperid from PERFILAMIENTO per;

    vperid:= vperid+1 ;

    if vcargo = 'administrador' then
        insert into PERFILAMIENTO(PERFILAMIENTO.TIPO, PERFILAMIENTO.ID)
        values('admin', vperid);
    else
        insert into PERFILAMIENTO(PERFILAMIENTO.TIPO, PERFILAMIENTO.ID)
        values('emp', vperid);
    end if;

    select substr(p.NOMBRE,1,3) into vuname from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select substr(p.APELLIDO,1,3) || substr(p.RUT,1,3) into vpass from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select max(per.ID) into vperid from PERFILAMIENTO per;

    select max(p.PERSONA_ID) into vpersona from PERSONA p;

    insert into USUARIOS(USUARIOS.ID, usuarios.uname, USUARIOS.PASS, USUARIOS.PERFILAMIENTO_ID, USUARIOS.PERSONA_PERSONA_ID)
    values (siguiente.nextval,vuname, vpass, vperid,vpersona);
end generate_user_emp;
/
ALTER TRIGGER "FERNE"."GENERATE_USER_EMP" ENABLE;
--------------------------------------------------------
--  DDL for Trigger GENERATE_VENTA_BOLETA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."GENERATE_VENTA_BOLETA" 
after insert on BOLETA
declare
v_boletaID boleta.id_boleta%type;
v_ventaID venta.id%type;
begin

    select max(b.ID_BOLETA) into v_boletaID from boleta b;
    select max(ven.ID) into v_ventaID from VENTA ven;

    insert into VENTA_BOLETA(VENTA_ID, BOLETA_ID_BOLETA)
    values(v_ventaID, v_boletaID);
end;
/
ALTER TRIGGER "FERNE"."GENERATE_VENTA_BOLETA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger GENERATE_VENTA_FACTURA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."GENERATE_VENTA_FACTURA" 
after insert on factura
declare
v_facturaID factura.id_factura%type;
v_ventaID venta.id%type;
begin

    select max(fa.ID_FACTURA) into v_facturaID from FACTURA fa;
    select max(ven.ID) into v_ventaID from venta ven;

    insert into VENTA_FACTURA(FACTURA_ID_FACTURA, VENTA_ID)
    values(v_facturaID,v_ventaID);

end;
/
ALTER TRIGGER "FERNE"."GENERATE_VENTA_FACTURA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PERSONA_PERSONA_ID_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."PERSONA_PERSONA_ID_TRG" BEFORE
    INSERT ON persona
    FOR EACH ROW
     WHEN ( new.persona_id IS NULL ) BEGIN
    :new.persona_id := persona_persona_id_seq.nextval;
END;
/
ALTER TRIGGER "FERNE"."PERSONA_PERSONA_ID_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PERSONA_PROVEEDOR_ID_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FERNE"."PERSONA_PROVEEDOR_ID_TRG" 
    before insert
    on PROVEEDOR
    for each row
     WHEN (new.ID IS NULL) BEGIN
    :new.ID := S_PROVEEDORES.nextval;
END;
/
ALTER TRIGGER "FERNE"."PERSONA_PROVEEDOR_ID_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Procedure GENEMPOC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GENEMPOC" 
is
i_productoID number;
i_productoSTOCK number;
i_ocID number;
i_proveedorID number;
begin

    begin
        select max(p.id_producto), max(p.stock) into i_productoID, i_productoSTOCK from producto p;
        EXCEPTION
            when no_data_found then i_productoID := null;
    end;

    begin
        select max(o.id_oc) into i_ocID from oc o;
        EXCEPTION
            when no_data_found then i_ocID:= null;
    end;

    begin
        select max(pr.id) into i_proveedorID from proveedor pr;
        EXCEPTION
            when no_data_found then i_proveedorID :=null;
    end;

    begin
        insert into producto_oc(producto_id_producto, producto_stock, oc_id_oc, oc_proveedor_id)
        values(i_productoID,i_productoSTOCK,i_ocID,i_proveedorID);
    end;
end;

/
--------------------------------------------------------
--  DDL for Procedure GENPROOC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GENPROOC" 

as
i_productoID number;
i_productoSTOCK number;
i_ocID number;
i_proveedorID number;
begin

    begin
        select max(p.id_producto), max(p.stock) into i_productoID, i_productoSTOCK from producto p;
        EXCEPTION
            when no_data_found then i_productoID := null;
    end;

    begin
        select max(o.id_oc) into i_ocID from oc o;
        EXCEPTION
            when no_data_found then i_ocID:= null;
    end;

    begin
        select max(pr.id) into i_proveedorID from proveedor pr;
        EXCEPTION
            when no_data_found then i_proveedorID :=null;
    end;

    begin
        insert into producto_oc(producto_id_producto, producto_stock, oc_id_oc, oc_proveedor_id)
        values(i_productoID,i_productoSTOCK,i_ocID,i_proveedorID);
    end;
end;

/
--------------------------------------------------------
--  DDL for Procedure GETCLIENTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETCLIENTES" 
(
 CURSOR_RES OUT SYS_REFCURSOR
)
as
BEGIN
    open CURSOR_RES for
    SELECT cliente.id, PERSONA_PERSONA_ID, NOMBRE , APELLIDO, Direccion, Correo, rut, telefono , empresa 
    from CLIENTE INNER JOIN PERSONA on persona.persona_id = cliente.persona_persona_id;

END getClientes;

/
--------------------------------------------------------
--  DDL for Procedure GETEMPLEADO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETEMPLEADO" (
    cursor_res out SYS_REFCURSOR
)
as
BEGIN
    open cursor_res for
    select empleado.id, empleado.cargo, PERSONA_PERSONA_ID, NOMBRE , APELLIDO, Direccion, Correo, rut, telefono
    from empleado inner join persona on persona.persona_id = empleado.persona_persona_id;

end getEmpleado;

/
--------------------------------------------------------
--  DDL for Procedure GETOC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETOC" 
(
    cursor_res out sys_refcursor
)
as
begin
    open cursor_res for
    SELECT
    pr.id, o.cantidad, o.id_oc, o.proveedor_id
    FROM OC o
    inner join proveedor pr on pr.id = o.proveedor_id;

end getOC;

/
--------------------------------------------------------
--  DDL for Procedure GETPRODUCTOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETPRODUCTOS" 
(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
begin

    open CURSOR_RES for
    select * from producto;
end getProductos;

/
--------------------------------------------------------
--  DDL for Procedure GETPROOVEDOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETPROOVEDOR" 
(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
begin
    open CURSOR_RES for
        select pr.ID, pr.NOMBRE, pr.CELULAR, pr.RUBRO
        from PROVEEDOR pr;

end getProovedor;

/
--------------------------------------------------------
--  DDL for Procedure GETUSUARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETUSUARIO" 
(
	CURSOR_RES OUT SYS_REFCURSOR
)
as
BEGIN
	open CURSOR_RES for
	select persona.persona_id as personaID, perfilamiento.id as perfilID, us.id, us.uname, us.pass, us.perfilamiento_id, us.persona_persona_id
	from usuarios us
	join persona on us.persona_persona_id = persona.persona_id
	join perfilamiento on us.perfilamiento_id = perfilamiento.id;

end getUsuario;

/
--------------------------------------------------------
--  DDL for Procedure GETVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."GETVENTA" 
(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
Begin

    open CURSOR_RES for
    select E.id, ven.ID, cantidad, EMPLEADO_ID from venta ven
    inner join EMPLEADO E on VEN.EMPLEADO_ID = E.ID;

end getVenta;

/
--------------------------------------------------------
--  DDL for Procedure SETCLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETCLIENTE" 
(
 nombre IN varchar2,
 apellido IN varchar2,
 direccion IN varchar2,
 correo IN varchar2,
 rut IN varchar2,
 telefono IN NUMBER,
 empresa IN NUMBER
)
IS
i_ClienteID NUMBER;
i_PersonaID NUMBER;

BEGIN

    BEGIN
        SELECT MAX(PERSONA_ID) INTO i_PersonaID FROM Persona;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN i_PersonaID := 1;
    END;

    BEGIN
        SELECT MAX(Cliente.ID) INTO i_ClienteID FROM Cliente;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN i_ClienteID := null;
    END;

    BEGIN


        i_PersonaID := i_PersonaID + 1;        

   
            INSERT INTO PERSONA(NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA)
            VALUES(nombre,apellido,direccion,correo,rut,telefono,i_PersonaID,empresa);
    
            IF i_ClienteID IS NULL THEN i_ClienteID := 1; END IF;
            i_ClienteID := i_ClienteID +1;
            INSERT INTO CLIENTE(ID,PERSONA_PERSONA_ID) VALUES(i_ClienteID,i_PersonaID);
   
            
    END;

END;

/
--------------------------------------------------------
--  DDL for Procedure SETEMPLEADO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETEMPLEADO" 
(
	V_nombre IN varchar2,
 	V_apellido IN varchar2,
 	V_direccion IN varchar2,
 	V_correo IN varchar2,
 	V_rut IN varchar2,
 	V_telefono IN NUMBER,
 	V_cargo IN varchar2
)
IS
i_EmpleadoID number;
i_PersonaID number;
BEGIN

	BEGIN
		select max(PERSONA_ID) into i_PersonaID from Persona;
		EXCEPTION
		when NO_DATA_FOUND THEN i_PersonaID := 1;
	END;

	BEGIN
		select max(id) into i_EmpleadoID from empleado;
		EXCEPTION
		when NO_DATA_FOUND THEN i_EmpleadoID := null;
	END;


    BEGIN

        i_PersonaID := i_PersonaID + 1;

        INSERT INTO PERSONA(NOMBRE,APELLIDO,DIRECCION,CORREO,RUT,TELEFONO,PERSONA_ID,EMPRESA)
        VALUES(V_nombre,V_apellido,V_direccion,V_correo,V_rut,V_telefono,i_PersonaID,null);

        IF i_EmpleadoID IS NULL THEN i_EmpleadoID := 1; END IF;
        i_EmpleadoID := i_EmpleadoID +1;
        INSERT INTO empleado(ID,cargo,PERSONA_PERSONA_ID) VALUES(i_EmpleadoID,V_cargo,i_PersonaID);
    END;

END;

/
--------------------------------------------------------
--  DDL for Procedure SETOC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETOC" 
(
--proveedor
vnombre IN  varchar2,
vcelular IN number,
vrubro in varchar2,
--oc
vcantidad in number
)
is
i_ocID number;
i_proveedorID number;
begin

    begin
        select max(pr.id) into i_proveedorID from proveedor pr;
        exception
            when no_data_found then i_proveedorID:=1;
    end;

    begin
        select (o.id_oc) into i_ocID from oc o;
        exception
            when no_data_found then i_ocID:= null;
    end;

    begin
        i_proveedorID := i_proveedorID +1;
        insert into proveedor(proveedor.id, proveedor.nombre, proveedor.celular, proveedor.rubro)
        values (i_proveedorID, vnombre, vcelular, vrubro);

        if i_ocID is null then i_ocID := 1; end if;
        i_ocID := i_ocID+1;
        insert into oc(cantidad, id_oc, proveedor_id)
        values(vcantidad, i_ocID, i_proveedorID);
    end;
end;

/
--------------------------------------------------------
--  DDL for Procedure SETPRODUCTOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETPRODUCTOS" 
(
fecha IN date,
idTipo IN number,
vprecio IN number,
stockCritico IN number,
descrip IN varchar2
)
IS
i_productoID number;
i_stockID number;
begin

    begin
        select max(id_producto) into i_productoID from producto;
        exception
            when no_data_found then i_productoID := 1;
    end;

    begin
        select max(stock) into i_stockID from producto;
        exception
            when no_data_found then i_stockID := null;
    end;

    begin
        i_productoID := i_productoID +1;
        insert into producto(id_producto, fecha_vencimiento, id_tipo, precio, stock, stock_critico, descripcion)
        values(i_productoID, fecha,idTipo,vprecio,i_stockID,stockCritico,descrip);
    end;
end;

/
--------------------------------------------------------
--  DDL for Procedure SETPROVEEDOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETPROVEEDOR" 
(
V_NombreProveedor IN varchar2,
V_Rubro IN varchar2,
V_Telefono IN number
)
IS
    i_proveedorID number;
begin
    begin
        select max(pr.ID) into i_proveedorID from PROVEEDOR pr;
        EXCEPTION
		when NO_DATA_FOUND THEN i_proveedorID := 1;
    end;

    begin
        i_proveedorID := i_proveedorID +1;
        insert into PROVEEDOR(ID, NOMBRE, CELULAR, RUBRO)
        values (S_PROVEEDORES.nextval,V_NombreProveedor,V_Rubro,V_Telefono);
    end;

end;

/
--------------------------------------------------------
--  DDL for Procedure SETUSUARIOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETUSUARIOS" 
(
Vuser IN varchar2,
Vpass IN varchar2,
Vtipo IN varchar2
)
IS
i_usuarioID number;
i_personaID number;
i_perfilamientoID number;
begin
    begin
        SELECT MAX(PERSONA_ID) INTO i_PersonaID FROM Persona;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN i_PersonaID := 1;
    end;

    begin
        SELECT MAX(perfilamiento.id) INTO i_perfilamientoID FROM perfilamiento;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN i_perfilamientoID := null;
    end;

    begin
        SELECT MAX(usuarios.id) INTO i_usuarioID FROM usuarios;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN i_usuarioID:= null;
    end;

    begin
        i_perfilamientoID := i_perfilamientoID +1;

        insert into perfilamiento(tipo, id)
        values (Vtipo, i_perfilamientoID);

        if i_usuarioID is null then i_usuarioID := 1; end if;
        i_usuarioID := i_usuarioID+1;
        i_personaID :=  i_personaID+1;
        insert into usuarios(id, uname, pass, perfilamiento_id, persona_persona_id)
        values(i_usuarioID, Vuser,Vpass,i_perfilamientoID,i_personaID);
    end;
end;

/
--------------------------------------------------------
--  DDL for Procedure SETVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."SETVENTA" 
(
 vcantidad IN number
)
is
i_empleadoID number;
i_ventaID number;
begin

    begin
        select max(em.ID) into i_empleadoID from empleado em;
        EXCEPTION
            when no_data_found then i_empleadoID :=1;
    end;

    begin
        select max(ven.ID) into i_ventaID from venta ven;
        EXCEPTION
            when no_data_found then i_ventaID := 1;
    end;

    begin
        i_empleadoID:= i_empleadoID +1;
        i_ventaID:= i_ventaID+1;
        insert into venta(ID, CANTIDAD, EMPLEADO_ID)
        values(i_ventaID,vcantidad,i_empleadoID);
    end;

end;

/
--------------------------------------------------------
--  DDL for Procedure UDPPRODUCTOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."UDPPRODUCTOS" 
(
V_id in number,
v_fecha in date,
v_tipo in number,
v_precio in number,
v_stock in number,
v_stcritico in number,
v_descip in varchar2
)
as
begin
    update producto pr
    set
        pr.fecha_vencimiento = v_fecha,
        pr.id_tipo = v_tipo,
        pr.precio = v_precio,
        pr.stock = v_stock,
        pr.stock_critico = v_stcritico,
        pr.descripcion = v_descip
    where
        pr.id_producto = v_id;
end udpProductos;

/
--------------------------------------------------------
--  DDL for Procedure UDPPROVEEDOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."UDPPROVEEDOR" 
(
V_IDProveedor IN number,
V_NombreProveedor IN varchar2,
V_Rubro IN varchar2,
V_Telefono IN Number
)
AS
begin
    update PROVEEDOR pr
    set
        pr.NOMBRE = V_NombreProveedor,
        pr.RUBRO = V_Rubro,
        pr.CELULAR = V_Telefono
    where
        pr.ID = V_IDProveedor;
end udpProveedor;

/
--------------------------------------------------------
--  DDL for Procedure UDPUSUARIOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."UDPUSUARIOS" 
(
v_id IN number,
v_user IN varchar2,
v_pass IN varchar2
)
as
begin
    update usuarios us
    set
        us.uname = v_user,
        us.pass = v_pass
    where
        us.id = v_id;
end udpUsuarios;

/
--------------------------------------------------------
--  DDL for Procedure UDPVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."UDPVENTA" 
(
    v_id in number,
    v_cantidad in number,
    v_emid in number
)
as
begin
    update VENTA
        set
            venta.CANTIDAD = v_cantidad,
            venta.EMPLEADO_ID = v_emid
        where venta.ID = v_id;

end udpVenta;

/
--------------------------------------------------------
--  DDL for Procedure UPDCEMPLEADOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."UPDCEMPLEADOS" 
(
v_personaID IN NUMBER,
v_nombre IN varchar2,
v_apellido IN varchar2,
v_direccion IN varchar2,
v_correo IN varchar2,
v_rut IN varchar2,
v_telefono IN NUMBER
)
as
BEGIN
    UPDATE Persona
    set NOMBRE = v_nombre,
    APELLIDO =v_apellido,
    direccion=v_direccion,
    correo=v_correo,
    rut=v_rut,
    telefono=v_telefono,
    empresa=null
    WHERE PERSONA_ID=v_personaID;
END UpdcEmpleados;

/
--------------------------------------------------------
--  DDL for Procedure UPDCLIENTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FERNE"."UPDCLIENTES" 
(
 v_personaID IN NUMBER,
 v_nombre IN varchar2,
 v_apellido IN varchar2,
 v_direccion IN varchar2,
 v_correo IN varchar2,
 v_rut IN varchar2,
 v_telefono IN NUMBER,
 v_empresa IN NUMBER
)
as
BEGIN
    UPDATE Persona
    set NOMBRE = v_nombre,
    APELLIDO =v_apellido,
    direccion=v_direccion,
    correo=v_correo,
    rut=v_rut,
    telefono=v_telefono,
    empresa=v_empresa
    WHERE PERSONA_ID=v_personaID;
END UpdClientes;

/
--------------------------------------------------------
--  Constraints for Table PROVEEDOR
--------------------------------------------------------

  ALTER TABLE "FERNE"."PROVEEDOR" ADD CONSTRAINT "PROVEEDOR_PK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FERNE"."PROVEEDOR" MODIFY ("RUBRO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PROVEEDOR" MODIFY ("CELULAR" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PROVEEDOR" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PROVEEDOR" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EMPLEADO_OC
--------------------------------------------------------

  ALTER TABLE "FERNE"."EMPLEADO_OC" ADD CONSTRAINT "EMPLEADO_OC_PK" PRIMARY KEY ("EMPLEADO_ID", "OC_ID_OC", "OC_PROVEEDOR_ID") ENABLE;
  ALTER TABLE "FERNE"."EMPLEADO_OC" MODIFY ("OC_PROVEEDOR_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."EMPLEADO_OC" MODIFY ("OC_ID_OC" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."EMPLEADO_OC" MODIFY ("EMPLEADO_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USUARIOS
--------------------------------------------------------

  ALTER TABLE "FERNE"."USUARIOS" ADD CONSTRAINT "USUARIOS_PK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FERNE"."USUARIOS" MODIFY ("PERSONA_PERSONA_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."USUARIOS" MODIFY ("PERFILAMIENTO_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."USUARIOS" MODIFY ("PASS" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."USUARIOS" MODIFY ("UNAME" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."USUARIOS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "FERNE"."EMPLEADO" ADD CONSTRAINT "EMPLEADO_PK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FERNE"."EMPLEADO" MODIFY ("PERSONA_PERSONA_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."EMPLEADO" MODIFY ("CARGO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."EMPLEADO" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VENTA_BOLETA
--------------------------------------------------------

  ALTER TABLE "FERNE"."VENTA_BOLETA" ADD CONSTRAINT "VENTA_BOLETA_PK" PRIMARY KEY ("VENTA_ID", "BOLETA_ID_BOLETA") ENABLE;
  ALTER TABLE "FERNE"."VENTA_BOLETA" MODIFY ("BOLETA_ID_BOLETA" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."VENTA_BOLETA" MODIFY ("VENTA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PERFILAMIENTO
--------------------------------------------------------

  ALTER TABLE "FERNE"."PERFILAMIENTO" ADD CONSTRAINT "PERFILAMIENTO_PK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FERNE"."PERFILAMIENTO" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERFILAMIENTO" MODIFY ("TIPO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BOLETA
--------------------------------------------------------

  ALTER TABLE "FERNE"."BOLETA" ADD CONSTRAINT "BOLETA_PK" PRIMARY KEY ("ID_BOLETA") ENABLE;
  ALTER TABLE "FERNE"."BOLETA" MODIFY ("ID_BOLETA" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."BOLETA" MODIFY ("CANTIDAT" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FACTURA_CLIENTE
--------------------------------------------------------

  ALTER TABLE "FERNE"."FACTURA_CLIENTE" ADD CONSTRAINT "FACTURA_CLIENTE_PK" PRIMARY KEY ("CLIENTE_ID", "FACTURA_ID_FACTURA") ENABLE;
  ALTER TABLE "FERNE"."FACTURA_CLIENTE" MODIFY ("FACTURA_ID_FACTURA" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."FACTURA_CLIENTE" MODIFY ("CLIENTE_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VENTA
--------------------------------------------------------

  ALTER TABLE "FERNE"."VENTA" ADD CONSTRAINT "VENTA_PK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FERNE"."VENTA" MODIFY ("EMPLEADO_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."VENTA" MODIFY ("CANTIDAD" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."VENTA" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PRODUCTO
--------------------------------------------------------

  ALTER TABLE "FERNE"."PRODUCTO" ADD CONSTRAINT "PRODUCTO_PK" PRIMARY KEY ("ID_PRODUCTO", "STOCK") ENABLE;
  ALTER TABLE "FERNE"."PRODUCTO" MODIFY ("STOCK_CRITICO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO" MODIFY ("STOCK" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO" MODIFY ("PRECIO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO" MODIFY ("ID_TIPO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO" MODIFY ("FECHA_VENCIMIENTO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO" MODIFY ("ID_PRODUCTO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CLIENTE
--------------------------------------------------------

  ALTER TABLE "FERNE"."CLIENTE" ADD CONSTRAINT "CLIENTE_PK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FERNE"."CLIENTE" MODIFY ("PERSONA_PERSONA_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."CLIENTE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OC
--------------------------------------------------------

  ALTER TABLE "FERNE"."OC" ADD CONSTRAINT "OC_PK" PRIMARY KEY ("ID_OC", "PROVEEDOR_ID") ENABLE;
  ALTER TABLE "FERNE"."OC" MODIFY ("PROVEEDOR_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."OC" MODIFY ("ID_OC" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."OC" MODIFY ("CANTIDAD" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PRODUCTO_OC
--------------------------------------------------------

  ALTER TABLE "FERNE"."PRODUCTO_OC" ADD CONSTRAINT "PRODUCTO_OC_PK" PRIMARY KEY ("PRODUCTO_ID_PRODUCTO", "PRODUCTO_STOCK", "OC_ID_OC", "OC_PROVEEDOR_ID") ENABLE;
  ALTER TABLE "FERNE"."PRODUCTO_OC" MODIFY ("OC_PROVEEDOR_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO_OC" MODIFY ("OC_ID_OC" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO_OC" MODIFY ("PRODUCTO_STOCK" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PRODUCTO_OC" MODIFY ("PRODUCTO_ID_PRODUCTO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VENTA_FACTURA
--------------------------------------------------------

  ALTER TABLE "FERNE"."VENTA_FACTURA" ADD CONSTRAINT "VENTA_FACTURA_PK" PRIMARY KEY ("FACTURA_ID_FACTURA", "VENTA_ID") ENABLE;
  ALTER TABLE "FERNE"."VENTA_FACTURA" MODIFY ("VENTA_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."VENTA_FACTURA" MODIFY ("FACTURA_ID_FACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FACTURA
--------------------------------------------------------

  ALTER TABLE "FERNE"."FACTURA" ADD CONSTRAINT "FACTURA_PK" PRIMARY KEY ("ID_FACTURA") ENABLE;
  ALTER TABLE "FERNE"."FACTURA" MODIFY ("ID_FACTURA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table RELATION_16
--------------------------------------------------------

  ALTER TABLE "FERNE"."RELATION_16" ADD CONSTRAINT "RELATION_16_PK" PRIMARY KEY ("VENTA_ID", "PRODUCTO_ID_PRODUCTO", "PRODUCTO_STOCK") ENABLE;
  ALTER TABLE "FERNE"."RELATION_16" MODIFY ("PRODUCTO_STOCK" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."RELATION_16" MODIFY ("PRODUCTO_ID_PRODUCTO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."RELATION_16" MODIFY ("VENTA_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PERSONA
--------------------------------------------------------

  ALTER TABLE "FERNE"."PERSONA" ADD CONSTRAINT "PERSONA_PK" PRIMARY KEY ("PERSONA_ID") ENABLE;
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("PERSONA_ID" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("TELEFONO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("RUT" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("CORREO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("DIRECCION" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("APELLIDO" NOT NULL ENABLE);
  ALTER TABLE "FERNE"."PERSONA" MODIFY ("NOMBRE" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "FERNE"."EMPLEADO" ADD CONSTRAINT "EMPLEADO_PERSONA_FK" FOREIGN KEY ("PERSONA_PERSONA_ID")
	  REFERENCES "FERNE"."PERSONA" ("PERSONA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMPLEADO_OC
--------------------------------------------------------

  ALTER TABLE "FERNE"."EMPLEADO_OC" ADD CONSTRAINT "EMPLEADO_OC_EMPLEADO_FK" FOREIGN KEY ("EMPLEADO_ID")
	  REFERENCES "FERNE"."EMPLEADO" ("ID") ENABLE;
  ALTER TABLE "FERNE"."EMPLEADO_OC" ADD CONSTRAINT "EMPLEADO_OC_OC_FK" FOREIGN KEY ("OC_ID_OC", "OC_PROVEEDOR_ID")
	  REFERENCES "FERNE"."OC" ("ID_OC", "PROVEEDOR_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table FACTURA_CLIENTE
--------------------------------------------------------

  ALTER TABLE "FERNE"."FACTURA_CLIENTE" ADD CONSTRAINT "FACTURA_CLIENTE_FACTURA_FK" FOREIGN KEY ("FACTURA_ID_FACTURA")
	  REFERENCES "FERNE"."FACTURA" ("ID_FACTURA") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OC
--------------------------------------------------------

  ALTER TABLE "FERNE"."OC" ADD CONSTRAINT "OC_PROVEEDOR_FK" FOREIGN KEY ("PROVEEDOR_ID")
	  REFERENCES "FERNE"."PROVEEDOR" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRODUCTO_OC
--------------------------------------------------------

  ALTER TABLE "FERNE"."PRODUCTO_OC" ADD CONSTRAINT "PRODUCTO_OC_OC_FK" FOREIGN KEY ("OC_ID_OC", "OC_PROVEEDOR_ID")
	  REFERENCES "FERNE"."OC" ("ID_OC", "PROVEEDOR_ID") ENABLE;
  ALTER TABLE "FERNE"."PRODUCTO_OC" ADD CONSTRAINT "PRODUCTO_OC_PRODUCTO_FK" FOREIGN KEY ("PRODUCTO_ID_PRODUCTO", "PRODUCTO_STOCK")
	  REFERENCES "FERNE"."PRODUCTO" ("ID_PRODUCTO", "STOCK") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RELATION_16
--------------------------------------------------------

  ALTER TABLE "FERNE"."RELATION_16" ADD CONSTRAINT "RELATION_16_PRODUCTO_FK" FOREIGN KEY ("PRODUCTO_ID_PRODUCTO", "PRODUCTO_STOCK")
	  REFERENCES "FERNE"."PRODUCTO" ("ID_PRODUCTO", "STOCK") ENABLE;
  ALTER TABLE "FERNE"."RELATION_16" ADD CONSTRAINT "RELATION_16_VENTA_FK" FOREIGN KEY ("VENTA_ID")
	  REFERENCES "FERNE"."VENTA" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table USUARIOS
--------------------------------------------------------

  ALTER TABLE "FERNE"."USUARIOS" ADD CONSTRAINT "USUARIOS_PERFILAMIENTO_FK" FOREIGN KEY ("PERFILAMIENTO_ID")
	  REFERENCES "FERNE"."PERFILAMIENTO" ("ID") ENABLE;
  ALTER TABLE "FERNE"."USUARIOS" ADD CONSTRAINT "USUARIOS_PERSONA_FK" FOREIGN KEY ("PERSONA_PERSONA_ID")
	  REFERENCES "FERNE"."PERSONA" ("PERSONA_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VENTA
--------------------------------------------------------

  ALTER TABLE "FERNE"."VENTA" ADD CONSTRAINT "VENTA_EMPLEADO_FK" FOREIGN KEY ("EMPLEADO_ID")
	  REFERENCES "FERNE"."EMPLEADO" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VENTA_BOLETA
--------------------------------------------------------

  ALTER TABLE "FERNE"."VENTA_BOLETA" ADD CONSTRAINT "VENTA_BOLETA_BOLETA_FK" FOREIGN KEY ("BOLETA_ID_BOLETA")
	  REFERENCES "FERNE"."BOLETA" ("ID_BOLETA") ENABLE;
  ALTER TABLE "FERNE"."VENTA_BOLETA" ADD CONSTRAINT "VENTA_BOLETA_VENTA_FK" FOREIGN KEY ("VENTA_ID")
	  REFERENCES "FERNE"."VENTA" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VENTA_FACTURA
--------------------------------------------------------

  ALTER TABLE "FERNE"."VENTA_FACTURA" ADD CONSTRAINT "VENTA_FACTURA_FACTURA_FK" FOREIGN KEY ("FACTURA_ID_FACTURA")
	  REFERENCES "FERNE"."FACTURA" ("ID_FACTURA") ENABLE;
  ALTER TABLE "FERNE"."VENTA_FACTURA" ADD CONSTRAINT "VENTA_FACTURA_VENTA_FK" FOREIGN KEY ("VENTA_ID")
	  REFERENCES "FERNE"."VENTA" ("ID") ENABLE;
