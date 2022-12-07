    <section class="content">
    <div class="container-fluid">
    <form action="?ctrl=CtrlMarca&accion=guardarEditar" method="post">
        <div class="row mb-3">
        <div class="col-md-6">
            <label for="inputID" class="form-label">Id:</label>
            <input type="text" class="form-control"
                name="id" value="<?=$cliente->getId()?>" id="inputID">
        </div>
        <div class="col-md-6">
            <label for="inputID" class="form-label">Marca:</label>
            <input type="text" class="form-control"
                name="marca" value="<?=$cliente->getMarca()?>" id="inputID">
        </div>
        </div>
        <div class="col-md-3">
        <button type="submit" class="form-control btn btn-primary">
            <i class="bi bi-save2"></i> Guardar</button>
        </div>
    </form>
    <br><a href="?ctrl=CtrlCliente" class="btn btn-primary">
        <i class="bi bi-arrow-90deg-left"></i>
        Retornar</a>
</div>
</section>
