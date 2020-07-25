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