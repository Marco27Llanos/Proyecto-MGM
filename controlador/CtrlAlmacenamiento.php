<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Controlador.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Almacenamiento.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Carrito.php';
require_once REC . DIRECTORY_SEPARATOR . 'Libreria.php';
/*
* Clase CtrlAlmacenamiento
*/
class CtrlAlmacenamiento extends Controlador {
    
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

        $obj = new Almacenamiento();
        $resultado = $obj->leer();

        $datos = array(
            'titulo'=>"Almacenamiento",
            'contenido'=>Vista::mostrar('almacenamiento/mostrar.php',$resultado,true),
            'menu'=>$menu,
            'migas'=>$migas,
            'msg'=>$msg
        );
        
        $this->mostrarVista('template.php',$datos);
    }
    public function nuevo(){
        if(!isset($_SESSION['nombre'])){
            header("Location: ?");
            exit();
        }
        $menu = Libreria::getMenu();
        $msg= array(
            'titulo'=>'Nuevo...',
            'cuerpo'=>'Ingrese información para nuevo Almacenamiento');
        $migas = array(
            '?'=>'Inicio',
            '?ctrl=CtrlAlmacenamiento'=>'Listado',
            '#'=>'Nuevo'
        );
        $datos1=array(
            'encabezado'=>'Nuevo Almacenamiento'
            );

        $datos = array(
                'titulo'=>'Nuevo Almacenamiento',
                'contenido'=>Vista::mostrar('almacenamiento/frmNuevo.php',$datos1,true),
                'menu'=>$menu,
                'migas'=>$migas,
                'msg'=>$msg
            );
        $this->mostrarVista('template.php',$datos);
    }

    public function guardarNuevo(){
        if(!isset($_SESSION['nombre'])){
            header("Location: ?");
            exit();
        }
        $obj = new Almacenamiento (
                $_POST["id"],
                $_POST["almacenamiento"],
                );
        $respuesta=$obj->nuevo();

        $this->index($respuesta['msg']);
    }
    public function eliminar(){
        if(!isset($_SESSION['nombre'])){
            header("Location: ?");
            exit();
        }
        if (isset($_REQUEST['id'])) {
            $obj = new Almacenamiento($_REQUEST['id']);
            $resultado=$obj->eliminar();
            $this->index($resultado['msg']);
        } else {
            echo "...El Id a ELIMINAR es requerido";
        }
    }
    public function editar(){
        if(!isset($_SESSION['nombre'])){
            header("Location: ?");
            exit();
        }
        #Mostramos el Formulario de Editar
        $datos=null;
        $menu = Libreria::getMenu();
        $msg= array(
            'titulo'=>'Editando...',
            'cuerpo'=>'Iniciando edición de: '.$_REQUEST['id']);
        $migas = array(
            '?'=>'Inicio',
            '?ctrl=CtrlAlmacenamiento'=>'Listado',
            '#'=>'Editar',
        );
        if (isset($_REQUEST['id'])) {
            $obj = new Almacenamiento($_REQUEST['id']);
            $miObj = $obj->leerUno();
            // var_dump($obj->leerUno());exit();
            if (is_null($miObj['data'])) {
                $this->index(array(
                    'titulo'=>'Error',
                    'cuerpo'=>'ID Requerido: '.$_REQUEST['id']. ' No Existe')
                );
            }else{
                $datos1 = array(
                    'almacenamiento'=>$obj
                );
            $datos = array(
                'titulo'=>'Editando Almacenamiento: '. $_REQUEST['id'],
                'contenido'=>Vista::mostrar('almacenamiento/frmEditar.php',$datos1,true),
                'menu'=>$menu,
                'migas'=>$migas,
                'msg'=>$msg
            );
            }
            
        }else {
            $msg= array(
            'titulo'=>'Error',
            'cuerpo'=>'No se encontró al ID requerido');

            $datos = array(
                'titulo'=>'Editando Turno... DESCONOCIDO',
                'contenido'=>'...El Id a Editar es requerido',
                'menu'=>$menu,
                'migas'=>$migas,
                'msg'=>$msg);
        }
        
        $this->mostrarVista('template.php',$datos);

        
    }
    public function guardarEditar(){
        if(!isset($_SESSION['nombre'])){
            header("Location: ?");
            exit();
        }
        $obj = new Almacenamiento (
                $_POST["id"],    #El id que enviamos
                $_POST["almacenamiento"]
                );
        $respuesta=$obj->editar();
        
        $this->index($respuesta['msg']);
    }
    public function getAlmacenamientosSelect(){
        $obj = new Almacenamiento();
        $datos = $obj->leer()['data'];
        $html = '<option value="0">Seleccionar...</option>';
        foreach ($datos as $d) {
            $html .= '<option value="'.$d['idalmacenamiento'].'">'.$d['almacenamiento'].'</option>';
        }
        echo $html;
    }
}