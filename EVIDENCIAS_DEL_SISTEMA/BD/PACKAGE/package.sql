create or replace package PK_ferne as
    -- todo: implement
        --procedures
        --metodo get
    procedure getClientes (CURSOR_RES OUT SYS_REFCURSOR);
        --
    procedure getEmpleado(cursor_res out SYS_REFCURSOR);
        --
    procedure getOC(cursor_res out sys_refcursor);
        --
    procedure getProductos(CURSOR_RES OUT SYS_REFCURSOR);
        --
    procedure getProovedor(CURSOR_RES OUT SYS_REFCURSOR);
        --
    procedure getUsuario(CURSOR_RES OUT SYS_REFCURSOR);
        --
    procedure getVenta(CURSOR_RES OUT SYS_REFCURSOR);
        --metodo set
    PROCEDURE setCliente(
                         nombre IN varchar2,
                         apellido IN varchar2,
                         direccion IN varchar2,
                         correo IN varchar2,
                         rut IN varchar2,
                         telefono IN NUMBER,
                         empresa IN NUMBER
                        );
        --
    PROCEDURE setEmpleado(
                            V_nombre IN varchar2,
                            V_apellido IN varchar2,
                            V_direccion IN varchar2,
                            V_correo IN varchar2,
                            V_rut IN varchar2,
                            V_telefono IN NUMBER,
                            V_cargo IN varchar2
                         );
        --
    procedure setOC(
                    vnombre IN  varchar2,
                    vcelular IN number,
                    vrubro in varchar2,
                    vcantidad in number
                    );
        --
    procedure setProductos(
                            fecha IN date,
                            idTipo IN number,
                            vprecio IN number,
                            stockCritico IN number,
                            descrip IN varchar2
                            );
        --
    procedure setProveedor(
                            V_NombreProveedor IN varchar2,
                            V_Rubro IN varchar2,
                            V_Telefono IN varchar2
                            );
        --
    procedure setUsuarios(
                            Vuser IN varchar2,
                            Vpass IN varchar2,
                            Vtipo IN varchar2
                         );
        --
    procedure setVenta(
                         vcantidad IN number
                      );
        --metodo update
    procedure udpProductos(
                            V_id in number,
                            v_fecha in date,
                            v_tipo in number,
                            v_precio in number,
                            v_stock in number,
                            v_stcritico in number,
                            v_descip in varchar2
                          );
        --
    procedure udpProveedor(
                            V_IDProveedor IN number,
                            V_NombreProveedor IN varchar2,
                            V_Rubro IN varchar2,
                            V_Telefono IN Number
                            );
        --
    procedure udpUsuarios(
                            v_id IN number,
                            v_user IN varchar2,
                            v_pass IN varchar2
                            );
        --
    procedure udpVenta(
                        v_id in number,
                        v_cantidad in number,
                        v_emid in number
                      );
        --
    PROCEDURE UpdcEmpleados(
                            v_personaID IN NUMBER,
                            v_nombre IN varchar2,
                            v_apellido IN varchar2,
                            v_direccion IN varchar2,
                            v_correo IN varchar2,
                            v_rut IN varchar2,
                            v_telefono IN NUMBER
                            );
        --
    PROCEDURE UpdClientes(
                             v_personaID IN NUMBER,
                             v_nombre IN varchar2,
                             v_apellido IN varchar2,
                             v_direccion IN varchar2,
                             v_correo IN varchar2,
                             v_rut IN varchar2,
                             v_telefono IN NUMBER,
                             v_empresa IN NUMBER
                            );

end PK_ferne;


create or replace package body PK_FERNE as
    -- todo: implement

        PROCEDURE GETCLIENTES
        (
         CURSOR_RES OUT SYS_REFCURSOR
        )
        as
        BEGIN
            open CURSOR_RES for
            SELECT cliente.id, PERSONA_PERSONA_ID, NOMBRE , APELLIDO, Direccion, Correo, rut, telefono , empresa
            from CLIENTE INNER JOIN PERSONA on persona.persona_id = cliente.persona_persona_id;

        END getClientes;


        --------------------------------------------------------
        --  DDL for Procedure GETEMPLEADO
        --------------------------------------------------------


        PROCEDURE GETEMPLEADO (
            cursor_res out SYS_REFCURSOR
        )
        as
        BEGIN
            open cursor_res for
            select empleado.id, empleado.cargo, PERSONA_PERSONA_ID, NOMBRE , APELLIDO, Direccion, Correo, rut, telefono
            from empleado inner join persona on persona.persona_id = empleado.persona_persona_id;

        end getEmpleado;


        --------------------------------------------------------
        --  DDL for Procedure GETOC
        --------------------------------------------------------


        PROCEDURE GETOC
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


        --------------------------------------------------------
        --  DDL for Procedure GETPRODUCTOS
        --------------------------------------------------------


        PROCEDURE GETPRODUCTOS
        (
            CURSOR_RES OUT SYS_REFCURSOR
        )
        as
        begin

            open CURSOR_RES for
            select * from producto;
        end getProductos;


        --------------------------------------------------------
        --  DDL for Procedure GETPROOVEDOR
        --------------------------------------------------------


        PROCEDURE GETPROOVEDOR
        (
            CURSOR_RES OUT SYS_REFCURSOR
        )
        as
        begin
            open CURSOR_RES for
                select pr.ID, pr.NOMBRE, pr.CELULAR, pr.RUBRO
                from PROVEEDOR pr;

        end getProovedor;


        --------------------------------------------------------
        --  DDL for Procedure GETUSUARIO
        --------------------------------------------------------


        PROCEDURE GETUSUARIO
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


        --------------------------------------------------------
        --  DDL for Procedure GETVENTA
        --------------------------------------------------------


        PROCEDURE GETVENTA
        (
            CURSOR_RES OUT SYS_REFCURSOR
        )
        as
        Begin

            open CURSOR_RES for
            select E.id, ven.ID, cantidad, EMPLEADO_ID from venta ven
            inner join EMPLEADO E on VEN.EMPLEADO_ID = E.ID;

        end getVenta;


        --------------------------------------------------------
        --  DDL for Procedure SETCLIENTE
        --------------------------------------------------------


        PROCEDURE SETCLIENTE
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


        --------------------------------------------------------
        --  DDL for Procedure SETEMPLEADO
        --------------------------------------------------------


        PROCEDURE SETEMPLEADO
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


        --------------------------------------------------------
        --  DDL for Procedure SETOC
        --------------------------------------------------------


        PROCEDURE SETOC
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


        --------------------------------------------------------
        --  DDL for Procedure SETPRODUCTOS
        --------------------------------------------------------


        PROCEDURE SETPRODUCTOS
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


        --------------------------------------------------------
        --  DDL for Procedure SETPROVEEDOR
        --------------------------------------------------------


        PROCEDURE SETPROVEEDOR
        (
        V_NombreProveedor IN varchar2,
        V_Rubro IN varchar2,
        V_Telefono IN varchar2
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

        --------------------------------------------------------
        --  DDL for Procedure SETUSUARIOS
        --------------------------------------------------------


        PROCEDURE SETUSUARIOS
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

        --------------------------------------------------------
        --  DDL for Procedure SETVENTA
        --------------------------------------------------------


        PROCEDURE SETVENTA
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


        --------------------------------------------------------
        --  DDL for Procedure UDPPRODUCTOS
        --------------------------------------------------------


        PROCEDURE UDPPRODUCTOS
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

        --------------------------------------------------------
        --  DDL for Procedure UDPPROVEEDOR
        --------------------------------------------------------


        PROCEDURE UDPPROVEEDOR
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


        --------------------------------------------------------
        --  DDL for Procedure UDPUSUARIOS
        --------------------------------------------------------


        PROCEDURE UDPUSUARIOS
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


        --------------------------------------------------------
        --  DDL for Procedure UDPVENTA
        --------------------------------------------------------


        PROCEDURE UDPVENTA
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

        --------------------------------------------------------
        --  DDL for Procedure UPDCEMPLEADOS
        --------------------------------------------------------

        PROCEDURE UPDCEMPLEADOS
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


        --------------------------------------------------------
        --  DDL for Procedure UPDCLIENTES
        --------------------------------------------------------

        PROCEDURE UPDCLIENTES
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


end PK_FERNE;

