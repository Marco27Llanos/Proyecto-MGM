<section class="content">

      <!-- Default box -->
      <div class="card card-solid">
        <div class="card-body">
          <div class="row">
            <div class="col-12 col-sm-6">
              <h3 class="d-inline-block d-sm-none">LOWA Men’s Renegade GTX Mid Hiking Boots Review</h3>
              <div class="col-12">
                <?php 
                    $imagen= (is_array($imagenes['data']))?$imagenes['data'][0]['url']:'SIN_IMAGEN.jpg' ;
                ?>
                <img src="recursos/images/catalogo/<?=$imagen?>" class="product-image" alt="Product Image">
              </div>
              <div class="col-12 product-image-thumbs">
                <?php 
                    if(is_array($imagenes['data']))
                    foreach ($imagenes['data'] as $img) { ?>
                <div class="product-image-thumb active"><img src="recursos/images/catalogo/<?=$img['url']?>" alt="Product Image"></div>           
                <?php 
                    }
                ?>    
             </div>
            </div>
            <div class="col-12 col-sm-6">
              <h3 class="my-3"><?=$data[0]['nombre']?></h3>
                <p><?=$data[0]['descripcion']?>
                </p>
                
              <hr>
              <!--<h4>Marca: <?=$data[0]['marca']?></h4>
              <h4>Modelo: <?=$data[0]['modelo']?></h4>-->
              <hr>
              <h4>Colores disponibles</h4>
              <div class="btn-group btn-group-toggle" data-toggle="buttons">
                <label class="btn btn-default text-center">
                  <input type="radio" name="color_option" id="color_option_a1" autocomplete="off">
                  Azul
                  <br>
                  <i class="fas fa-circle fa-2x text-blue"></i>
                </label>
                <label class="btn btn-default text-center">
                  <input type="radio" name="color_option" id="color_option_a2" autocomplete="off">
                  Blanco
                  <br>
                  <i class="fas fa-circle fa-2x text-white"></i>
                </label>
                <label class="btn btn-default text-center">
                  <input type="radio" name="color_option" id="color_option_a3" autocomplete="off">
                  Negro
                  <br>
                  <i class="fas fa-circle fa-2x text-black"></i>
                </label>
              </div>

              <div class="row">
                <div class="col-md-6">
                    <div class="bg-gray py-2 px-3 mt-4">
                        <h2 class="mb-0">
                        S/ <?=number_format($data[0]['pu'], 2, ',', ' ')?>
                        </h2>
                        <h4 class="mt-0">
                        <small>Transporte: S/ 10.00 </small>
                        </h4>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="bg-gray py-2 px-3 mt-4">
                        <h2 class="mb-0">
                          <?= $data[0]['stock']?> Unidades disponibles
                        </h2>
                        
                    </div>
                </div>
              </div>

              <div class="mt-4">
                <a href="?ctrl=CtrlCarrito&accion=agregar&id=<?=$data[0]['idequipo']?>&url=detalles" class="btn btn-primary btn-lg btn-flat">
                  <i class="fas fa-cart-plus fa-lg mr-2"></i>
                  Agregar al carrito
                </a>
                <div class="btn btn-default btn-lg btn-flat">
                  <i class="fas fa-heart fa-lg mr-2"></i>
                  Añadir a favoritos
                </div>
              </div>

              <div class="mt-4 product-share">
                <a href="#" class="text-gray">
                  <i class="fab fa-facebook-square fa-2x"></i>
                </a>
                <a href="#" class="text-gray">
                  <i class="fab fa-twitter-square fa-2x"></i>
                </a>
                <a href="#" class="text-gray">
                  <i class="fas fa-envelope-square fa-2x"></i>
                </a>
                <a href="#" class="text-gray">
                  <i class="fas fa-rss-square fa-2x"></i>
                </a>
              </div>

            </div>
          </div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->