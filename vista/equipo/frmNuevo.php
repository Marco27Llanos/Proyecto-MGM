    <section class="content">
    <div class="container-fluid">
    <form action="?ctrl=CtrlEquipo&accion=guardarNuevo" method="post">
        <div class="row mb-3">
        <div class="col-md-6">
            <label for="inputID" class="form-label">Id:</label>
            <input type="text" class="form-control"
                name="id" value="" id="inputID">
        </div>
        <div class="col-md-6">
            <label for="inputEquipo" class="form-label">Nombre:</label>
            <input type="text" class="form-control"
                name="nombre" value="" id="inputNombre">
        </div>
        <div class="col-md-6">
            <label for="inputEquipo" class="form-label">Pu:</label>
            <input type="text" class="form-control"
                name="pu" value="" id="inputPu">
        </div>
        <div class="col-md-6">
            <label for="inputEquipo" class="form-label">Stock:</label>
            <input type="text" class="form-control"
                name="stock" value="" id="inputStock">
        </div>
        </div>
        <div class="col-md-3">
        <button type="submit" class="form-control btn btn-primary">
            <i class="bi bi-save2"></i> Guardar</button>
        </div>
    </form>
    <br><a href="?ctrl=CtrlAlmacenamiento" class="btn btn-primary">
        <i class="bi bi-arrow-90deg-left"></i>
        Retornar</a>
</div>
</section>