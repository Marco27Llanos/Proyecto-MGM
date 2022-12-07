<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Modelo.php';
require_once PER . DIRECTORY_SEPARATOR . "BaseDeDatos.php";

class Marca extends Modelo {
    private $_id;
    private $_marca;
    private $_tabla="marcas";
    private $_bd;

    public function __construct($id=null, $marca=null){
        $this->_bd = new BaseDeDatos(new MySQL());
        $this->_id = $id;
        $this->_marca = $marca;
    }
    public function leer(){
        $sql ="SELECT * FROM ". $this->_tabla .";";
        return $this->_bd->ejecutar($sql);
    }
     public function leerUno(){
        $sql= "SELECT * FROM ". $this->_tabla
            . " WHERE idmarca=".$this->_id;
        
        $datos= $this->_bd->ejecutar($sql);  
        // var_dump($datos);exit();
        if (is_array($datos['data'])){
            $this->_id = $datos['data'][0]["idmarca"];
            $this->_marca = $datos['data'][0]["marca"];
        }
    
        return $datos; 
    }
    public function eliminar(){
        $sql= "Delete FROM ". $this->_tabla 
            . " WHERE idmarca=".$this->_id;
        return $this->_bd->ejecutar($sql);    
    }
    public function editar(){
        $sql ="UPDATE ". $this->_tabla 
            . " SET marca='".$this->_marca."',"
            ." WHERE idmarca=".$this->_id;
        // var_dump($sql); exit();
        return $this->_bd->ejecutar($sql);
    }

    public function nuevo(){
        $sql = "INSERT INTO ". $this->_tabla 
            ." (idmarca, marca) VALUES (".
                $this->_id .",'"
                . $this->_marca ."','"
            .");";
        // var_dump($sql); exit();
        return $this->_bd->ejecutar($sql);
    }
    public function getId(){
        return $this->_id;
    }
    public function getMarca(){
        return $this->_marca;
    }
}
