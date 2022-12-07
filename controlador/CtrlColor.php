<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Controlador.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Color.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Carrito.php';
require_once REC . DIRECTORY_SEPARATOR . 'Libreria.php';
/*
* Clase CtrlColor
*/
class CtrlColor extends Controlador {
    
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

        $obj = new Color();
        $resultado = $obj->leer();

        $datos = array(
            'titulo'=>"Color",
            'contenido'=>Vista::mostrar('color/mostrar.php',$resultado,true),
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
            'cuerpo'=>'Ingrese información para nuevo Color');
        $migas = array(
            '?'=>'Inicio',
            '?ctrl=CtrlColor'=>'Listado',
            '#'=>'Nuevo'
        );
        $datos1=array(
            'encabezado'=>'Nuevo Color'
            );

        $datos = array(
                'titulo'=>'Nuevo Color',
                'contenido'=>Vista::mostrar('color/frmNuevo.php',$datos1,true),
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
        $obj = new Color (
                $_POST["id"],
                $_POST["color"],
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
            $obj = new Color($_REQUEST['id']);
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
            '?ctrl=CtrlColor'=>'Listado',
            '#'=>'Editar',
        );
        if (isset($_REQUEST['id'])) {
            $obj = new Color($_REQUEST['id']);
            $miObj = $obj->leerUno();
            // var_dump($obj->leerUno());exit();
            if (is_null($miObj['data'])) {
                $this->index(array(
                    'titulo'=>'Error',
                    'cuerpo'=>'ID Requerido: '.$_REQUEST['id']. ' No Existe')
                );
            }else{
                $datos1 = array(
                    'color'=>$obj
                );
            $datos = array(
                'titulo'=>'Editando Color: '. $_REQUEST['id'],
                'contenido'=>Vista::mostrar('color/frmEditar.php',$datos1,true),
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
        $obj = new Color (
                $_POST["id"],    #El id que enviamos
                $_POST["color"]
                );
        $respuesta=$obj->editar();
        
        $this->index($respuesta['msg']);
    }
    public function getColoresSelect(){
        $obj = new Color();
        $datos = $obj->leer()['data'];
        $html = '<option value="0">Seleccionar...</option>';
        foreach ($datos as $d) {
            $html .= '<option value="'.$d['idcolor'].'">'.$d['color'].'</option>';
        }
        echo $html;
    }
}