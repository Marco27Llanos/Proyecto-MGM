<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Controlador.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Marca.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Carrito.php';
require_once REC . DIRECTORY_SEPARATOR . 'Libreria.php';
/*
* Clase CtrlMarca
*/
class CtrlMarca extends Controlador {
    
    public function index($msg=array('titulo'=>'','cuerpo'=>'')){
        if(!isset($_SESSION['nombre'])){
            header("Location: ?");
            exit();
        }
        $menu= Libreria::getMenu();
        $migas = array(
            '?'=>'Inicio',
            '#'=>'Listado'
        );

        $obj = new Marca();
        $resultado = $obj->leer();

        $datos = array(
            'titulo'=>"Marcas",
            'contenido'=>Vista::mostrar('marca/mostrar.php',$resultado,true),
            'menu'=>$menu,
            'migas'=>$migas,
            'msg'=>$msg
        );
        
        $this->mostrarVista('template.php',$datos);
    }
    public function nuevo(){
        $menu = Libreria::getMenu();
        
        $obj = new Marca();
        $datos1=array(
            'encabezado'=>'Nueva Marca',
            'marca'=>$obj
            );
        $jsVista = array(
                array(
                'url'=>'recursos/js/jsPais.js'
                )
            );

        $datos = array(
                'titulo'=>'Nueva Marca',
                'contenido'=>Vista::mostrar('marca/frmNuevo.php',$datos1,true),
                'menu'=>$menu,
                'migas'=>$this->_getMigas('nuevo'),
                'msg'=>$this->_getMsg('Nuevo...','Ingrese información para nueva Marca'),
                'js'=>$jsVista
            );
        $this->mostrarVista('template.php',$datos);
    }

    public function guardarNuevo(){
        $obj = new Marca (
                $_POST["id"],
                $_POST["marca"],
                );
        $respuesta=$obj->nuevo();
        // var_dump($respuesta);exit();
        $this->index($respuesta['msg']);
    }
    public function eliminar(){
        if (isset($_REQUEST['id'])) {
            $obj = new Marca($_REQUEST['id']);
            $resultado=$obj->eliminar();
            $this->index($resultado['msg']);
        } else {
            echo "...El Id a ELIMINAR es requerido";
        }
    }
    public function editar(){
        #Mostramos el Formulario de Editar
        $menu = Libreria::getMenu();
        $jsVista = array(
                array(
                'url'=>'recursos/js/jsPais.js'
                )
            );
        if (isset($_REQUEST['id'])) {
            $obj = new Marca($_REQUEST['id']);
            $miObj = $obj->leerUno();
            if (is_null($miObj['data'])) {
                $this->index($this->_getMsg('Error',
                        'ID Requerido: '.$_REQUEST['id']. ' No Existe')
                    );
            }else{
                $datos1 = array(
                        'Marca'=>$obj
                    );

                $datos = array(
                    'titulo'=>'Editando Marca: '. $_REQUEST['id'],
                    'contenido'=>Vista::mostrar('Marca/frmEditar.php',$datos1,true),
                    'menu'=>$menu,
                    'migas'=>$this->_getMigas('editar'),
                    'msg'=>$this->_getMsg('Editando...','Iniciando edición para: '.$_REQUEST['id']),
                    'js'=>$jsVista
                );
            }
        }else {
            $datos = array(
                'titulo'=>'Editando Marca... DESCONOCIDO',
                'contenido'=>'...El Id a Editar es requerido',
                'menu'=>$menu,
                'migas'=>$this->_getMigas('editar'),
                'msg'=>$this->_getMsg('Error','No se encontró al ID requerido')
            );
        }
        
        $this->mostrarVista('template.php',$datos);
    }
    public function guardarEditar(){
        $obj = new Marca (
                $_POST["id"],
                $_POST["marca"],
                );
        $respuesta=$obj->editar();
        
        $this->index($respuesta['msg']);
    }
    private function _getMigas($operacion=null)     {
        $retorno=null;
        switch ($operacion) {
            case 'nuevo':
                $retorno = array(
                    '?'=>'Inicio',
                    '?ctrl=CtrlMarca'=>'Listado',
                    '#'=>'Nuevo',
                );
                break;
            case 'editar':
                $retorno = array(
                    '?'=>'Inicio',
                    '?ctrl=CtrlMarca'=>'Listado',
                    '#'=>'Editar',
                );
                break;
            
            default:
                $retorno = array(
                    '?'=>'Inicio',
                );
                break;
        }
        return $retorno;
    }
    private function _getMsg($titulo=null,$msg=null){
        return array(
            'titulo'=>$titulo,
            'cuerpo'=>$msg
        );
    }
}