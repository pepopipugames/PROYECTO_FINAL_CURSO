<?php
require_once("BBDD_CTRLR.php");

if (isset($_REQUEST['peticion'])) {
    switch ($_REQUEST['peticion']) {
        case "EjecutarSelect":
            $sql = $_REQUEST['sql'];
            $datos['datos'] = BBDD_CTRLR::Consultas($sql);
            echo json_encode($datos);
            break;
        case "EjecutarInsert":
            $sql = $_REQUEST['sql'];
            $datos['datos'] = BBDD_CTRLR::CRUD($sql, 'i');
            echo json_encode($datos);
            break;
        // case "EjemploEvitarInyecciones":
        //     $SQLpreparado = $db->prepare('INSERT INTO table (column) VALUES (:column)');
        //     $preparedStatement->execute([ 'column' => $unsafeValue ]);
        case "EjecutarUpdateDelete":
            $sql = $_REQUEST['sql'];
            $datos['datos'] = BBDD_CTRLR::CRUD($sql, '');
            echo json_encode($datos);
            break;
        case "Login":
            $alias = $_REQUEST['alias'];
            $password = $_REQUEST['password'];
            $sql = 
                "SELECT * 
                FROM usuarios 
                WHERE usu_alias = '$alias' 
                AND usu_pass = md5('$password')";
                $datos['sql'] = $sql;
                $datos['datos'] = BBDD_CTRLR::Consultas($sql);
                echo json_encode($datos);      
                break;
        case "Cargar_Ciudades":
             $sql = "SELECT * FROM ciudades ORDER BY ciu_nombre ASC";
             $datos = BBDD_CTRLR::Consultas($sql);
             echo json_encode($datos);      
             break;
        case "Cargar_Hoteles":
            $sql = "SELECT * FROM hoteles ORDER BY hot_nombre ASC";
            $datos = BBDD_CTRLR::Consultas($sql);
            echo json_encode($datos);      
            break;
        case "Cargar_Hoteles_ID":
            $ciu_id=$_REQUEST['ciu_id'];
            $sql = 
            "SELECT *
             FROM  hoteles
             WHERE hot_ciu_id = '$ciu_id'
             ORDER BY hot_nombre ASC";
             $datos['sql'] = $sql;
             $datos['datos'] = BBDD_CTRLR::Consultas($sql);
             echo json_encode($datos);      
            break; 
        case "Cargar_Actividades":
            $sql = 
            "SELECT * 
            FROM actividades 
            ORDER BY act_nombre ASC";
            $datos = BBDD_CTRLR::Consultas($sql);
            echo json_encode($datos);      
            break;
        case "Cargar_Datos_Usuario_Por_Id":
            $usu_id=$_REQUEST['usu_id'];
            $sql = 
            "SELECT * FROM usuarios WHERE usu_id = '$user_id'";
            $datos = BBDD_CTRLR::Consultas($sql);
            echo json_encode($datos);      
            break;       
        case "Cargar_Reservas_Por_Usuario":
            $usu_id=$_REQUEST['usu_id'];
            $sql = 
            "SELECT * FROM reserva_act, reservas_hotel_viajes, usuarios WHERE usu_id = ra_usu_id AND usu_id = rhv_usu_id order by rhv_fecha, ra_fecha;";
            $datos = BBDD_CTRLR::Consultas($sql);
            echo json_encode($datos);      
            break;
    }
}