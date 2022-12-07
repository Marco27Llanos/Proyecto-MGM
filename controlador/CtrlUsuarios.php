<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Controlador.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Usuario.php';
require_once REC . DIRECTORY_SEPARATOR . 'Libreria.php';
/*
* Clase CtrlUsuarios
*/
class CtrlUsuarios extends Controlador {
    
    public function index($msg=null){
        $menu= Libreria::getMenu();
        
        $obj = new Usuarios();
        $resultado = $obj->leer();
        $msg = $msg==null?$this->_getMsg():$msg;
        $datos = array(
            'titulo'=>"Usuarios",
            'contenido'=>Vista::mostrar('clientes/mostrar.php',$resultado,true),
            'menu'=>$menu,
            'migas'=>$this->_getMigas(),
            'msg'=>$msg
        );
        
        $this->mostrarVista('template.php',$datos);
    }
    public function validar(){
        if (isset($_POST['usuarios']) && isset($_POST['clave'])) {
            $obj = new Usuarios();
            $obj->setLogin($_POST['usuarios']);
            $obj->setClave($_POST['clave']);
            $datos=$obj->validarUsuarios();
            // var_dump($datos);exit();
            if (isset($datos['data']))
                if($datos['data']!=null){
                    $_SESSION['nombre']=$datos['data'][0]['nombre'];
                    $_SESSION['email']=$datos['data'][0]['email'];
                    // echo $_SESSION['nombre'];
                }
            
        }
        header("Location: ?");
        exit();
    }
    public function cerrarSesion()
    {
        session_destroy();
        header("Location: ?");
        exit();
    }
}