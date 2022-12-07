$(function () {
    console.log('Cargando colores');
    $.ajax({
        method: "GET",
        url: "index.php?ctrl=CtrlColor&accion=getColoresSelect",
        data: {}
    }).done(function (data) {
            $("#color").html(data);
        });
    
    $("#nuevo").click(function (e) { 
        e.preventDefault();
        let url ='ctrl=CtrlCiudad$accion=nuevo';
        $("#modal-nuevo").load(url, function (response, status, xhr) {
            if (status == "error") {
                var msg = "Lo siento pero ocurrió un error: ";
                alert(msg + xhr.status + " " + xhr.statusText);
            }
        });
    });
});