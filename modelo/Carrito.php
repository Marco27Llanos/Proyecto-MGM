<?php 
class Carrito {
    private $_equipos=null;

    public function agregar($id,$cant=1){
        if (!isset($this->_equipos[$id]))
            $this->_equipos[$id]['cant']=0;       #inicializamos por lo menos 'cant'
        $this->_equipos[$id]['cant'] += $cant;    #Agregamos la Cantidad
    }
    public function sacar($id,$cant=1){
        if ($cant<=$this->_equipos[$id]['cant'])
            $this->_equipos[$id]['cant']-= $cant;
        if ($this->_equipos[$id]['cant']==0)
            unset($this->_equipos[$id]);
    }
    public function getEquipos(){
        return $this->_equipos;
    }
    public function getCantidad($id){
        return isset($this->_equipos[$id]['cant'])?$this->_equipos[$id]['cant']:0;
    }
    public function calcularTotal(){
        $total = 0;
        foreach ($this->_equipos as $p) 
            $total += $p['precio'] * $p['cant'] ;
        $total = number_format($total,2,"."," ");
        return $total;
    }
    public function getNroEquipos(){
        $nro=0;
        if (is_array($this->_equipos))
        foreach ($this->_equipos as $p) {
            $nro += $p['cant'];
        }
        return $nro;
    }
}