<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Modelo.php';
require_once PER . DIRECTORY_SEPARATOR . "BaseDeDatos.php";

class Almacenamiento extends Modelo {
    private $_id;
    private $_almacenamiento;
    private $_tabla="almacenamiento";
    private $_bd;

    public function __construct($id=null, $almacenamiento=null){
        $this->_bd = new BaseDeDatos(new MySQL());
        $this->_id = $id;
        $this->_almacenamiento= $almacenamiento;
    }
    public function leer(){
        $sql ="SELECT * FROM ". $this->_tabla .";";
        return $this->_bd->ejecutar($sql);
    }
     public function leerUno(){
        $sql= "SELECT * FROM ". $this->_tabla 
            . " WHERE idalmacenamiento=".$this->_id;
        
        $datos= $this->_bd->ejecutar($sql);  
        //var_dump($datos);exit();
        if (is_array($datos['data'])){
            $this->_id = $datos['data'][0]["idalmacenamiento"];
            $this->_almacenamiento = $datos['data'][0]["almacenamiento"];  
        }
        
        return $datos; 
    }
    public function eliminar(){
        $sql= "Delete FROM ". $this->_tabla 
            . " WHERE idalmacenamiento=".$this->_id;
        return $this->_bd->ejecutar($sql);    
    }
    public function editar(){
        $sql ="UPDATE ". $this->_tabla 
            . " SET almacenamiento='".$this->_almacenamiento."'"
            ." WHERE idalmacenamiento=".$this->_id;
        return $this->_bd->ejecutar($sql);
    }

    public function nuevo(){
        $sql = "INSERT INTO ". $this->_tabla 
            ." (idalmacenamiento, almacenamiento) VALUES (".
                $this->_id .",'". $this->_almacenamiento ."'"
            .");";
        return $this->_bd->ejecutar($sql);
    }
    public function getId(){
        return $this->_id;
    }
    public function getAlmacenamiento(){
        return $this->_almacenamiento;
    }
}
