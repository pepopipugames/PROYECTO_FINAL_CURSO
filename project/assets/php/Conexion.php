<?php
require_once("configuracionBBDD.php");
class Conexion {
    static function Conectar(){
        $cnx = mysqli_connect(SERVIDOR, USUARIO, PASSWORD, BBDD);
        // Mayor seguridad en la conexión usando la clase PDO de PHP
            // $cnx = new PDO('mysql:dbname=bd_viajes;host=127.0.0.1;charset=utf8mb4', 'user', 'password');
        // Desactivamos la emulación de declaraciones SQL preparadas
            // $cnx->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
            // $cnx->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $cnx;
    }
}   