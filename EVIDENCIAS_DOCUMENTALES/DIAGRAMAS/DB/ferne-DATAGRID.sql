create sequence PERSONA_PERSONA_ID_SEQ
    order
    nocache
/

create sequence SIGUIENTE
/

create sequence S_PROVEEDORES
/

create table BOLETA
(
    CANTIDAT  NUMBER not null,
    ID_BOLETA NUMBER not null,
    constraint BOLETA_PK
        primary key (ID_BOLETA)
)
/

create or replace trigger GENERATE_VENTA_BOLETA
    after insert
    on BOLETA
declare
    v_boletaID boleta.id_boleta%type;
    v_ventaID  venta.id%type;
begin

    select max(b.ID_BOLETA) into v_boletaID from boleta b;
    select max(ven.ID) into v_ventaID from VENTA ven;

    insert into VENTA_BOLETA(VENTA_ID, BOLETA_ID_BOLETA)
    values (v_ventaID, v_boletaID);
end;
/

create table FACTURA
(
    ID_FACTURA NUMBER not null,
    CANTIDAD   NUMBER,
    constraint FACTURA_PK
        primary key (ID_FACTURA)
)
/

create or replace trigger GENERATE_VENTA_FACTURA
    after insert
    on FACTURA
declare
    v_facturaID factura.id_factura%type;
    v_ventaID   venta.id%type;
begin

    select max(fa.ID_FACTURA) into v_facturaID from FACTURA fa;
    select max(ven.ID) into v_ventaID from venta ven;

    insert into VENTA_FACTURA(FACTURA_ID_FACTURA, VENTA_ID)
    values (v_facturaID, v_ventaID);

end;
/

create table FACTURA_CLIENTE
(
    CLIENTE_ID         NUMBER not null,
    FACTURA_ID_FACTURA NUMBER not null,
    constraint FACTURA_CLIENTE_PK
        primary key (CLIENTE_ID, FACTURA_ID_FACTURA),
    constraint FACTURA_CLIENTE_FACTURA_FK
        foreign key (FACTURA_ID_FACTURA) references FACTURA
)
/

create table PERFILAMIENTO
(
    TIPO VARCHAR2(20) not null,
    ID   NUMBER       not null,
    constraint PERFILAMIENTO_PK
        primary key (ID)
)
/

create table PERSONA
(
    NOMBRE     VARCHAR2(100) not null,
    APELLIDO   VARCHAR2(100) not null,
    DIRECCION  VARCHAR2(100) not null,
    CORREO     VARCHAR2(100) not null,
    RUT        VARCHAR2(20)  not null,
    TELEFONO   NUMBER        not null,
    PERSONA_ID NUMBER        not null,
    EMPRESA    NUMBER,
    constraint PERSONA_PK
        primary key (PERSONA_ID)
)
/

create table EMPLEADO
(
    ID                 NUMBER            not null,
    CARGO              VARCHAR2(20 char) not null,
    PERSONA_PERSONA_ID NUMBER            not null,
    constraint EMPLEADO_PK
        primary key (ID),
    constraint EMPLEADO_PERSONA_FK
        foreign key (PERSONA_PERSONA_ID) references PERSONA
)
/

create or replace trigger GENERATE_USER_EMP
    after insert
    on EMPLEADO
declare

    vcargo   empleado.cargo%type;
    vuname   usuarios.uname%type;
    vpass    usuarios.pass%type ;
    vperid   usuarios.perfilamiento_id%type;
    vpersona usuarios.persona_persona_id%type;

begin
    select em.CARGO
    into vcargo
    from EMPLEADO em
    where em.ID = (select max(id) from EMPLEADO);

    select max(per.ID) into vperid from PERFILAMIENTO per;

    vperid := vperid + 1;

    if vcargo = 'administrador' then
        insert into PERFILAMIENTO(PERFILAMIENTO.TIPO, PERFILAMIENTO.ID)
        values ('admin', vperid);
    else
        insert into PERFILAMIENTO(PERFILAMIENTO.TIPO, PERFILAMIENTO.ID)
        values ('emp', vperid);
    end if;

    select substr(p.NOMBRE, 1, 3)
    into vuname
    from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select substr(p.APELLIDO, 1, 3) || substr(p.RUT, 1, 3)
    into vpass
    from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select max(per.ID) into vperid from PERFILAMIENTO per;

    select max(p.PERSONA_ID) into vpersona from PERSONA p;

    insert into USUARIOS(USUARIOS.ID, usuarios.uname, USUARIOS.PASS, USUARIOS.PERFILAMIENTO_ID,
                         USUARIOS.PERSONA_PERSONA_ID)
    values (siguiente.nextval, vuname, vpass, vperid, vpersona);
end generate_user_emp;
/

create or replace trigger PERSONA_PERSONA_ID_TRG
    before insert
    on PERSONA
    for each row
    when (new.persona_id IS NULL)
BEGIN
    :new.persona_id := persona_persona_id_seq.nextval;
END;
/

create table PRODUCTO
(
    ID_PRODUCTO       NUMBER not null,
    FECHA_VENCIMIENTO DATE   not null,
    ID_TIPO           NUMBER not null,
    PRECIO            NUMBER not null,
    STOCK             NUMBER not null,
    STOCK_CRITICO     NUMBER not null,
    DESCRIPCION       VARCHAR2(200 char),
    constraint PRODUCTO_PK
        primary key (ID_PRODUCTO, STOCK)
)
/

create table PROVEEDOR
(
    ID      NUMBER            not null,
    NOMBRE  VARCHAR2(20 char) not null,
    CELULAR VARCHAR2(10 char) not null,
    RUBRO   VARCHAR2(20 char) not null,
    constraint PROVEEDOR_PK
        primary key (ID)
)
/

create table OC
(
    CANTIDAD     NUMBER not null,
    ID_OC        NUMBER not null,
    PROVEEDOR_ID NUMBER not null,
    constraint OC_PK
        primary key (ID_OC, PROVEEDOR_ID),
    constraint OC_PROVEEDOR_FK
        foreign key (PROVEEDOR_ID) references PROVEEDOR
)
/

create table EMPLEADO_OC
(
    EMPLEADO_ID     NUMBER not null,
    OC_ID_OC        NUMBER not null,
    OC_PROVEEDOR_ID NUMBER not null,
    constraint EMPLEADO_OC_PK
        primary key (EMPLEADO_ID, OC_ID_OC, OC_PROVEEDOR_ID),
    constraint EMPLEADO_OC_EMPLEADO_FK
        foreign key (EMPLEADO_ID) references EMPLEADO,
    constraint EMPLEADO_OC_OC_FK
        foreign key (OC_ID_OC, OC_PROVEEDOR_ID) references OC
)
/

create or replace trigger GENEEMPOC
    after insert
    on OC
declare
    vemp_id  empleado_oc.empleado_id%type;
    voc_id   empleado_oc.oc_id_oc%type;
    vproo_id empleado_oc.oc_proveedor_id%type;
begin
    select max(em.id) into vemp_id from empleado em where em.cargo = 'recepcion';
    select max(o.id_oc) into voc_id from oc o;
    select max(o.proveedor_id) into vproo_id from oc o;

    insert into empleado_oc(empleado_id, oc_id_oc, oc_proveedor_id)
    values (vemp_id, voc_id, vproo_id);
end geneEmpOC;
/

create table PRODUCTO_OC
(
    PRODUCTO_ID_PRODUCTO NUMBER not null,
    PRODUCTO_STOCK       NUMBER not null,
    OC_ID_OC             NUMBER not null,
    OC_PROVEEDOR_ID      NUMBER not null,
    constraint PRODUCTO_OC_PK
        primary key (PRODUCTO_ID_PRODUCTO, PRODUCTO_STOCK, OC_ID_OC, OC_PROVEEDOR_ID),
    constraint PRODUCTO_OC_OC_FK
        foreign key (OC_ID_OC, OC_PROVEEDOR_ID) references OC,
    constraint PRODUCTO_OC_PRODUCTO_FK
        foreign key (PRODUCTO_ID_PRODUCTO, PRODUCTO_STOCK) references PRODUCTO
)
/

create or replace trigger PERSONA_PROVEEDOR_ID_TRG
    before insert
    on PROVEEDOR
    for each row
    when (new.ID IS NULL)
BEGIN
    :new.ID := S_PROVEEDORES.nextval;
END;
/

create table USUARIOS
(
    ID                 NUMBER            not null,
    UNAME              VARCHAR2(20 char) not null,
    PASS               VARCHAR2(20 char) not null,
    PERFILAMIENTO_ID   NUMBER            not null,
    PERSONA_PERSONA_ID NUMBER            not null,
    constraint USUARIOS_PK
        primary key (ID),
    constraint USUARIOS_PERFILAMIENTO_FK
        foreign key (PERFILAMIENTO_ID) references PERFILAMIENTO,
    constraint USUARIOS_PERSONA_FK
        foreign key (PERSONA_PERSONA_ID) references PERSONA
)
/

create table VENTA
(
    ID          NUMBER not null,
    CANTIDAD    NUMBER not null,
    EMPLEADO_ID NUMBER not null,
    constraint VENTA_PK
        primary key (ID),
    constraint VENTA_EMPLEADO_FK
        foreign key (EMPLEADO_ID) references EMPLEADO
)
/

create table RELATION_16
(
    VENTA_ID             NUMBER not null,
    PRODUCTO_ID_PRODUCTO NUMBER not null,
    PRODUCTO_STOCK       NUMBER not null,
    constraint RELATION_16_PK
        primary key (VENTA_ID, PRODUCTO_ID_PRODUCTO, PRODUCTO_STOCK),
    constraint RELATION_16_PRODUCTO_FK
        foreign key (PRODUCTO_ID_PRODUCTO, PRODUCTO_STOCK) references PRODUCTO,
    constraint RELATION_16_VENTA_FK
        foreign key (VENTA_ID) references VENTA
)
/

create unique index VENTA__IDX
    on VENTA (EMPLEADO_ID)
/

create or replace trigger GENERATE_PRODUCTO_VENTA
    before insert
    on VENTA
declare
    v_ventaID       venta.id%type;
    v_productoID    producto.id_producto%type;
    v_productoStock producto.stock%type;
    v_cantidadVenta venta.cantidad%type;
begin

    select max(ven.ID) into v_ventaID from venta ven;
    select max(pr.ID_PRODUCTO) into v_productoID from PRODUCTO pr;
    select pr.STOCK_CRITICO
    into v_productoStock
    from PRODUCTO pr
    where pr.ID_PRODUCTO = v_productoID;
    select ven.CANTIDAD
    into v_cantidadVenta
    from VENTA ven
    where ven.ID = v_ventaID;

    if v_productoStock = 0 then
        delete from RELATION_16 where PRODUCTO_ID_PRODUCTO = v_productoID;
    end if;

    v_productoStock := v_productoStock - v_cantidadVenta;

    insert into RELATION_16(VENTA_ID, PRODUCTO_ID_PRODUCTO, PRODUCTO_STOCK)
    values (v_ventaID, v_productoID, v_productoStock);

end;
/

create table VENTA_BOLETA
(
    VENTA_ID         NUMBER not null,
    BOLETA_ID_BOLETA NUMBER not null,
    constraint VENTA_BOLETA_PK
        primary key (VENTA_ID, BOLETA_ID_BOLETA),
    constraint VENTA_BOLETA_BOLETA_FK
        foreign key (BOLETA_ID_BOLETA) references BOLETA,
    constraint VENTA_BOLETA_VENTA_FK
        foreign key (VENTA_ID) references VENTA
)
/

create table VENTA_FACTURA
(
    FACTURA_ID_FACTURA NUMBER not null,
    VENTA_ID           NUMBER not null,
    constraint VENTA_FACTURA_PK
        primary key (FACTURA_ID_FACTURA, VENTA_ID),
    constraint VENTA_FACTURA_FACTURA_FK
        foreign key (FACTURA_ID_FACTURA) references FACTURA,
    constraint VENTA_FACTURA_VENTA_FK
        foreign key (VENTA_ID) references VENTA
)
/

create table CLIENTE
(
    ID                 NUMBER not null,
    PERSONA_PERSONA_ID NUMBER not null,
    constraint CLIENTE_PK
        primary key (ID)
)
/

create or replace trigger GENERATE_USER_CLI
    after insert
    on CLIENTE
declare

    v_id      cliente.id%type;
    v_persona cliente.persona_persona_id%type;
    v_uname   persona.nombre%type;
    v_pass    usuarios.pass%type;
    v_perid   perfilamiento.id%type;

begin

    select max(per.ID) into v_perid from PERFILAMIENTO per;

    v_perid := v_perid + 1;

    insert into PERFILAMIENTO(PERFILAMIENTO.TIPO, PERFILAMIENTO.ID)
    values ('client', v_perid);

    select substr(p.NOMBRE, 1, 3)
    into v_uname
    from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select substr(p.APELLIDO, 1, 3) || substr(p.RUT, 1, 3)
    into v_pass
    from PERSONA p
    where p.PERSONA_ID = (select max(PERSONA_ID) from persona);

    select max(per.ID) into v_perid from PERFILAMIENTO per;

    select max(p.PERSONA_ID) into v_persona from PERSONA p;

    insert into USUARIOS(USUARIOS.ID, usuarios.uname, USUARIOS.PASS, USUARIOS.PERFILAMIENTO_ID,
                         USUARIOS.PERSONA_PERSONA_ID)
    values (siguiente.nextval, v_uname, v_pass, v_perid, v_persona);
end generate_user_cli;
/

create or replace view VW_CLIENTES as
SELECT cliente.id,
       PERSONA_PERSONA_ID,
       NOMBRE,
       APELLIDO,
       Direccion,
       Correo,
       rut,
       telefono,
       empresa
from CLIENTE
         INNER JOIN PERSONA on persona.persona_id = cliente.persona_persona_id
/

create or replace view VW_EMPLEADOS as
select e.id,
       e.cargo,
       p.persona_id,
       p.NOMBRE,
       p.APELLIDO,
       p.Direccion,
       p.Correo,
       p.rut,
       p.telefono,
       u.uname,
       u.pass
from empleado e,
     persona p,
     usuarios u
where e.persona_persona_id = p.persona_id
  and e.persona_persona_id = u.persona_persona_id
/

create or replace view VW_PRODUCTOS as
SELECT "ID_PRODUCTO", "FECHA_VENCIMIENTO", "ID_TIPO", "PRECIO", "STOCK", "STOCK_CRITICO", "DESCRIPCION"
FROM PRODUCTO
/

create or replace view VW_USUARIOS as
(
select uname, pass
from usuarios)
/

create or replace view VW_PROVEEDOR as
(
select nombre, celular, rubro
from proveedor)
/

create or replace view VW_CLIENTES2 as
select c.id,
       p.nombre,
       p.APELLIDO,
       p.Direccion,
       p.Correo,
       p.rut,
       p.telefono,
       p.empresa,
       u.uname,
       u.pass
from cliente C,
     persona p,
     usuarios u
where c.persona_persona_id = p.persona_id
  and C.persona_persona_id = u.persona_persona_id
/

create or replace PROCEDURE setCliente(nombre IN varchar2,
                                       apellido IN varchar2,
                                       direccion IN varchar2,
                                       correo IN varchar2,
                                       rut IN varchar2,
                                       telefono IN NUMBER,
                                       empresa IN NUMBER)
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


        INSERT INTO PERSONA(NOMBRE, APELLIDO, DIRECCION, CORREO, RUT, TELEFONO, PERSONA_ID, EMPRESA)
        VALUES (nombre, apellido, direccion, correo, rut, telefono, i_PersonaID, empresa);

        IF i_ClienteID IS NULL THEN i_ClienteID := 1; END IF;
        i_ClienteID := i_ClienteID + 1;
        INSERT INTO CLIENTE(ID, PERSONA_PERSONA_ID) VALUES (i_ClienteID, i_PersonaID);


    END;

END;
/

create or replace PROCEDURE getClientes(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
BEGIN
    open CURSOR_RES for
        SELECT cliente.id,
               PERSONA_PERSONA_ID,
               NOMBRE,
               APELLIDO,
               Direccion,
               Correo,
               rut,
               telefono,
               empresa
        from CLIENTE
                 INNER JOIN PERSONA on persona.persona_id = cliente.persona_persona_id;

END getClientes;
/

create or replace PROCEDURE UpdClientes(v_personaID IN NUMBER,
                                        v_nombre IN varchar2,
                                        v_apellido IN varchar2,
                                        v_direccion IN varchar2,
                                        v_correo IN varchar2,
                                        v_rut IN varchar2,
                                        v_telefono IN NUMBER,
                                        v_empresa IN NUMBER)
as
BEGIN
    UPDATE Persona
    set NOMBRE   = v_nombre,
        APELLIDO =v_apellido,
        direccion=v_direccion,
        correo=v_correo,
        rut=v_rut,
        telefono=v_telefono,
        empresa=v_empresa
    WHERE PERSONA_ID = v_personaID;
END UpdClientes;
/

create or replace procedure getEmpleado(
    cursor_res out SYS_REFCURSOR
)
as
BEGIN
    open cursor_res for
        select empleado.id,
               empleado.cargo,
               PERSONA_PERSONA_ID,
               NOMBRE,
               APELLIDO,
               Direccion,
               Correo,
               rut,
               telefono
        from empleado
                 inner join persona on persona.persona_id = empleado.persona_persona_id;

end getEmpleado;
/

create or replace PROCEDURE setEmpleado(V_nombre IN varchar2,
                                        V_apellido IN varchar2,
                                        V_direccion IN varchar2,
                                        V_correo IN varchar2,
                                        V_rut IN varchar2,
                                        V_telefono IN NUMBER,
                                        V_cargo IN varchar2)
    IS
    i_EmpleadoID number;
    i_PersonaID  number;
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

        INSERT INTO PERSONA(NOMBRE, APELLIDO, DIRECCION, CORREO, RUT, TELEFONO, PERSONA_ID, EMPRESA)
        VALUES (V_nombre, V_apellido, V_direccion, V_correo, V_rut, V_telefono, i_PersonaID, null);

        IF i_EmpleadoID IS NULL THEN i_EmpleadoID := 1; END IF;
        i_EmpleadoID := i_EmpleadoID + 1;
        INSERT INTO empleado(ID, cargo, PERSONA_PERSONA_ID) VALUES (i_EmpleadoID, V_cargo, i_PersonaID);
    END;

END;
/

create or replace PROCEDURE UpdcEmpleados(v_personaID IN NUMBER,
                                          v_nombre IN varchar2,
                                          v_apellido IN varchar2,
                                          v_direccion IN varchar2,
                                          v_correo IN varchar2,
                                          v_rut IN varchar2,
                                          v_telefono IN NUMBER)
as
BEGIN
    UPDATE Persona
    set NOMBRE   = v_nombre,
        APELLIDO =v_apellido,
        direccion=v_direccion,
        correo=v_correo,
        rut=v_rut,
        telefono=v_telefono,
        empresa=null
    WHERE PERSONA_ID = v_personaID;
END UpdcEmpleados;
/

create or replace PROCEDURE getUsuario(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
BEGIN
    open CURSOR_RES for
        select persona.persona_id as personaID,
               perfilamiento.id   as perfilID,
               us.id,
               us.uname,
               us.pass,
               us.perfilamiento_id,
               us.persona_persona_id
        from usuarios us
                 join persona on us.persona_persona_id = persona.persona_id
                 join perfilamiento on us.perfilamiento_id = perfilamiento.id;

end getUsuario;
/

create or replace procedure setUsuarios(Vuser IN varchar2,
                                        Vpass IN varchar2,
                                        Vtipo IN varchar2)
    IS
    i_usuarioID       number;
    i_personaID       number;
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
        WHEN NO_DATA_FOUND THEN i_usuarioID := null;
    end;

    begin
        i_perfilamientoID := i_perfilamientoID + 1;

        insert into perfilamiento(tipo, id)
        values (Vtipo, i_perfilamientoID);

        if i_usuarioID is null then i_usuarioID := 1; end if;
        i_usuarioID := i_usuarioID + 1;
        i_personaID := i_personaID + 1;
        insert into usuarios(id, uname, pass, perfilamiento_id, persona_persona_id)
        values (i_usuarioID, Vuser, Vpass, i_perfilamientoID, i_personaID);
    end;
end;
/

create or replace procedure udpUsuarios(v_id IN number,
                                        v_user IN varchar2,
                                        v_pass IN varchar2)
as
begin
    update usuarios us
    set us.uname = v_user,
        us.pass  = v_pass
    where us.id = v_id;
end udpUsuarios;
/

create or replace procedure getProductos(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
begin

    open CURSOR_RES for
        select * from producto;
end getProductos;
/

create or replace procedure setProductos(fecha IN date,
                                         idTipo IN number,
                                         vprecio IN number,
                                         stockCritico IN number,
                                         descrip IN varchar2)
    IS
    i_productoID number;
    i_stockID    number;
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
        i_productoID := i_productoID + 1;
        insert into producto(id_producto, fecha_vencimiento, id_tipo, precio, stock, stock_critico, descripcion)
        values (i_productoID, fecha, idTipo, vprecio, i_stockID, stockCritico, descrip);
    end;
end;
/

create or replace procedure udpProductos(V_id in number,
                                         v_fecha in date,
                                         v_tipo in number,
                                         v_precio in number,
                                         v_stock in number,
                                         v_stcritico in number,
                                         v_descip in varchar2)
as
begin
    update producto pr
    set pr.fecha_vencimiento = v_fecha,
        pr.id_tipo           = v_tipo,
        pr.precio            = v_precio,
        pr.stock             = v_stock,
        pr.stock_critico     = v_stcritico,
        pr.descripcion       = v_descip
    where pr.id_producto = v_id;
end udpProductos;
/

create or replace procedure getOC(
    cursor_res out sys_refcursor
)
as
begin
    open cursor_res for
        SELECT pr.id,
               o.cantidad,
               o.id_oc,
               o.proveedor_id
        FROM OC o
                 inner join proveedor pr on pr.id = o.proveedor_id;

end getOC;
/

create or replace procedure setOC(
--proveedor
    vnombre IN varchar2,
    vcelular IN number,
    vrubro in varchar2,
--oc
    vcantidad in number)
    is
    i_ocID        number;
    i_proveedorID number;
begin

    begin
        select max(pr.id) into i_proveedorID from proveedor pr;
    exception
        when no_data_found then i_proveedorID := 1;
    end;

    begin
        select (o.id_oc) into i_ocID from oc o;
    exception
        when no_data_found then i_ocID := null;
    end;

    begin
        i_proveedorID := i_proveedorID + 1;
        insert into proveedor(proveedor.id, proveedor.nombre, proveedor.celular, proveedor.rubro)
        values (i_proveedorID, vnombre, vcelular, vrubro);

        if i_ocID is null then i_ocID := 1; end if;
        i_ocID := i_ocID + 1;
        insert into oc(cantidad, id_oc, proveedor_id)
        values (vcantidad, i_ocID, i_proveedorID);
    end;
end;
/

create or replace procedure genEmpOC
    is
    i_productoID    number;
    i_productoSTOCK number;
    i_ocID          number;
    i_proveedorID   number;
begin

    begin
        select max(p.id_producto), max(p.stock) into i_productoID, i_productoSTOCK from producto p;
    EXCEPTION
        when no_data_found then i_productoID := null;
    end;

    begin
        select max(o.id_oc) into i_ocID from oc o;
    EXCEPTION
        when no_data_found then i_ocID := null;
    end;

    begin
        select max(pr.id) into i_proveedorID from proveedor pr;
    EXCEPTION
        when no_data_found then i_proveedorID := null;
    end;

    begin
        insert into producto_oc(producto_id_producto, producto_stock, oc_id_oc, oc_proveedor_id)
        values (i_productoID, i_productoSTOCK, i_ocID, i_proveedorID);
    end;
end;
/

create or replace procedure genProOC
as
    i_productoID    number;
    i_productoSTOCK number;
    i_ocID          number;
    i_proveedorID   number;
begin

    begin
        select max(p.id_producto), max(p.stock) into i_productoID, i_productoSTOCK from producto p;
    EXCEPTION
        when no_data_found then i_productoID := null;
    end;

    begin
        select max(o.id_oc) into i_ocID from oc o;
    EXCEPTION
        when no_data_found then i_ocID := null;
    end;

    begin
        select max(pr.id) into i_proveedorID from proveedor pr;
    EXCEPTION
        when no_data_found then i_proveedorID := null;
    end;

    begin
        insert into producto_oc(producto_id_producto, producto_stock, oc_id_oc, oc_proveedor_id)
        values (i_productoID, i_productoSTOCK, i_ocID, i_proveedorID);
    end;
end;
/

create or replace procedure getVenta(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
Begin

    open CURSOR_RES for
        select E.id, ven.ID, cantidad, EMPLEADO_ID
        from venta ven
                 inner join EMPLEADO E on VEN.EMPLEADO_ID = E.ID;

end getVenta;
/

create or replace procedure setVenta(
    vcantidad IN number
)
    is
    i_empleadoID number;
    i_ventaID    number;
begin

    begin
        select max(em.ID) into i_empleadoID from empleado em;
    EXCEPTION
        when no_data_found then i_empleadoID := 1;
    end;

    begin
        select max(ven.ID) into i_ventaID from venta ven;
    EXCEPTION
        when no_data_found then i_ventaID := 1;
    end;

    begin
        i_empleadoID := i_empleadoID + 1;
        i_ventaID := i_ventaID + 1;
        insert into venta(ID, CANTIDAD, EMPLEADO_ID)
        values (i_ventaID, vcantidad, i_empleadoID);
    end;

end;
/

create or replace procedure udpVenta(v_id in number,
                                     v_cantidad in number,
                                     v_emid in number)
as
begin
    update VENTA
    set venta.CANTIDAD    = v_cantidad,
        venta.EMPLEADO_ID = v_emid
    where venta.ID = v_id;

end udpVenta;
/

create or replace procedure getProovedor(
    CURSOR_RES OUT SYS_REFCURSOR
)
as
begin
    open CURSOR_RES for
        select pr.ID, pr.NOMBRE, pr.CELULAR, pr.RUBRO
        from PROVEEDOR pr;

end getProovedor;
/

create or replace procedure setProveedor(V_NombreProveedor IN varchar2,
                                         V_Rubro IN varchar2,
                                         V_Telefono IN number)
    IS
    i_proveedorID number;
begin
    begin
        select max(pr.ID) into i_proveedorID from PROVEEDOR pr;
    EXCEPTION
        when NO_DATA_FOUND THEN i_proveedorID := 1;
    end;

    begin
        i_proveedorID := i_proveedorID + 1;
        insert into PROVEEDOR(ID, NOMBRE, CELULAR, RUBRO)
        values (S_PROVEEDORES.nextval, V_NombreProveedor, V_Rubro, V_Telefono);
    end;

end;
/

create or replace procedure udpProveedor(V_IDProveedor IN number,
                                         V_NombreProveedor IN varchar2,
                                         V_Rubro IN varchar2,
                                         V_Telefono IN Number)
AS
begin
    update PROVEEDOR pr
    set pr.NOMBRE  = V_NombreProveedor,
        pr.RUBRO   = V_Rubro,
        pr.CELULAR = V_Telefono
    where pr.ID = V_IDProveedor;
end udpProveedor;
/


