<?php
require_once SYS . DIRECTORY_SEPARATOR . 'Controlador.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Equipo.php';
require_once MOD .DIRECTORY_SEPARATOR . 'Carrito.php';
require_once REC . DIRECTORY_SEPARATOR . 'Libreria.php';
/*
* Clase CtrlEquipo
*/
class CtrlEquipo extends Controlador {
    
    public function index($msg=array('titulo'=>'','cuerpo'=>'')){
        $menu= Libreria::getMenu();
        $migas = array(
            '?'=>'Inicio',
        );

        $obj = new Equipo();
        $resultado = $obj->leer();

        $datos = array(
            'titulo'=>"Equipos",
            'contenido'=>Vista::mostrar('equipo/mostrar.php',$resultado,true),
            'menu'=>$menu,
            'migas'=>$migas,
            'msg'=>$msg
        );
        
        $this->mostrarVista('template.php',$datos);
    }
    public function nuevo(){
        $menu = Libreria::getMenu();
        $msg= array(
            'titulo'=>'Nuevo...',
            'cuerpo'=>'Ingrese información para nuevo Equipo');
        $migas = array(
            '?'=>'Inicio',
            '?ctrl=CtrlEquipo'=>'Listado',
            '#'=>'Nuevo',
        );
        $obj = new Equipo();
        $datos1=array(
            'encabezado'=>'Nuevo Equipo',
            'equipo'=>$obj
            );

        $datos = array(
                'titulo'=>'Nueva Equipo',
                'contenido'=>Vista::mostrar('equipo/frmNuevo.php',$datos1,true),
                'menu'=>$menu,
                'migas'=>$migas,
                'msg'=>$msg
            );
        $this->mostrarVista('template.php',$datos);
    }

    public function guardarNuevo(){
        $obj = new Equipo (
                $_POST["id"],
                $_POST["equipo"],
                $_POST["pais"],
                );
        $respuesta=$obj->nuevo();

        $this->index($respuesta['msg']);
    }
    public function eliminar(){
        if (isset($_REQUEST['id'])) {
            $obj = new Equipo($_REQUEST['id']);
            $resultado=$obj->eliminar();
            $this->index($resultado['msg']);
        } else {
            echo "...El Id a ELIMINAR es requerido";
        }
    }
    public function editar(){
        #Mostramos el Formulario de Editar
        $menu = Libreria::getMenu();
        $msg= array(
            'titulo'=>'Editando...',
            'cuerpo'=>'Iniciando edición para: '.$_REQUEST['id']);
        $migas = array(
            '?'=>'Inicio',
            '?ctrl=CtrlEquipo'=>'Listado',
            '#'=>'Editar',
        );
        if (isset($_REQUEST['id'])) {
            $obj = new Equipo($_REQUEST['id']);
            $miObj = $obj->leerUno();
            if (is_null($miObj['data'])) {
                $this->index(array(
                    'titulo'=>'Error',
                    'cuerpo'=>'ID Requerido: '.$_REQUEST['id']. ' No Existe')
                );
            }else{

                $datos1 = array(
                        'equipo'=>$obj
                    );

                $datos = array(
                    'titulo'=>'Editando Equipo: '. $_REQUEST['id'],
                    'contenido'=>Vista::mostrar('equipo/frmEditar.php',$datos1,true),
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
                'titulo'=>'Editando Equipo... DESCONOCIDO',
                'contenido'=>'...El Id a Editar es requerido',
                'menu'=>$menu,
                'migas'=>$migas,
                'msg'=>$msg);
        }
        
        $this->mostrarVista('template.php',$datos);

        
    }
    public function guardarEditar(){
        $obj = new Equipo (
                $_POST["id"],    #El id que enviamos
                $_POST["equipo"],
                $_POST["pais"]
                );
        $respuesta=$obj->editar();
        
        $this->index($respuesta['msg']);
    }
    public function getEquipoesSelect(){
        $id = $_GET['id'];
        $obj = new Equipo();
        $datos = $obj->leerXPais($id)['data'];
        $html = '<option value="0">Seleccionar...</option>';
        foreach ($datos as $d) {
            $html .= '<option value="'.$d['idequipo'].'">'.$d['nombre'].'</option>';
        }
        echo $html;

    }
    public function getCatalogo(){
        $menu= Libreria::getMenu();
        $migas = array(
            '?'=>'Inicio',
            '#'=>'Catálogo',
        );

        $obj = new Equipo();
        $resultado = $obj->leer();
        
        $msg=(!isset($_GET['id']))?array('titulo'=>'','cuerpo'=>''):array('titulo'=>'Nuevo elemento','cuerpo'=>'Se agregó un elemento al Carrito');
        $datos = array(
            'titulo'=>"Catálogo",
            'contenido'=>Vista::mostrar('equipo/catalogo.php',$resultado,true),
            'menu'=>$menu,
            'migas'=>$migas,
            'msg'=>$msg
        );
        
        $this->mostrarVista('template.php',$datos);
    }
    public function verDetalles(){
        $menu= Libreria::getMenu();
        $migas = array(
            '?'=>'Inicio',
            '?ctrl=CtrlEquipo&accion=getCatalogo'=>'Catálogo',
            '#'=>'Detalles',
        );
        $id = $_GET['id'];
        $jsVista = array(
                array(
                'url'=>'recursos/js/jsImagenes.js'
                )
            );

        $obj = new Equipo($id);
        $resultado = $obj->getDetalles();

        $msg=array('titulo'=>'','cuerpo'=>'');
        $datos = array(
            'titulo'=>"Detalles",
            'contenido'=>Vista::mostrar('equipo/detalles.php',$resultado,true),
            'menu'=>$menu,
            'migas'=>$migas,
            'msg'=>$msg,
            'js'=>$jsVista
        );
        
        $this->mostrarVista('template.php',$datos);
    }
}