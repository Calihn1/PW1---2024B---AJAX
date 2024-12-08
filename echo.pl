#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
binmode STDOUT, ':utf8';

print <<'EOF';
Content-type: text/html

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Registro de Mascotas</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
  <h1 class="text-center">Bienvenido al registro de Mascotas</h1>
  <hr>
  <div class="text-center">
    <!-- Botones para cargar formularios dinámicamente -->
    <button id="addPetBtn" class="btn btn-primary">Agregar Mascota</button>
    <button id="updatePetBtn" class="btn btn-warning">Modificar Mascota</button>
    <button id="deletePetBtn" class="btn btn-danger">Eliminar Mascota</button>
  </div>
  <hr>
  
  <!-- Sección dinámica donde se mostrarán los formularios cargados -->
  <div id="dynamicSection"></div>
  
  <!-- Sección para mostrar las mascotas -->
  <h3 class="text-center">Lista de Mascotas</h3>
  <div id="petsList" class="row"></div>
</div>

<script>
$(document).ready(function() {
    /**
     * Función que carga el formulario dinámicamente en el div con id "dynamicSection".
     * @param {string} script - Ruta al script CGI que genera el formulario.
     * @param {string} titulo - Título que se mostrará encima del formulario.
     */
    function cargarFormulario(script, titulo) {
        var request = $.ajax({
            url: script,
            type: "GET",
            dataType: "html"
        });

        request.done(function(response) {
            $('#dynamicSection').html(
                `<h3 class="text-center">` + titulo + `</h3>` + response
            );
        });

        request.fail(function(jqXHR, textStatus) {
            $('#dynamicSection').html(
                `<div class="alert alert-danger">Error al cargar el formulario: ` + textStatus + `</div>`
            );
        });
    }

    /**
     * Función que carga y muestra la lista de mascotas.
     */
    function cargarMascotas() {
        var request = $.ajax({
            url: "loadPets.pl",
            type: "GET",
            dataType: "json"
        });

        request.done(function(data) {
            let html = '';
            data.forEach((pet) => {
                html += `
                    <div class="col-md-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">${pet.nombre}</h4>
                            </div>
                            <div class="panel-body">
                                <p><strong>Dueño:</strong> ${pet.dueño}</p>
                                <p><strong>Especie:</strong> ${pet.especies}</p>
                                <p><strong>Sexo:</strong> ${pet.sexo}</p>
                                <p><strong>Nacimiento:</strong> ${pet.nacimiento}</p>
                                <p><strong>Muerte:</strong> ${pet.muerte || 'N/A'}</p>
                            </div>
                        </div>
                    </div>`;
            });
            $('#petsList').html(html);
        });

        request.fail(function(jqXHR, textStatus) {
            $('#petsList').html(
                `<div class="alert alert-danger">Error al cargar los datos: ` + textStatus + `</div>`
            );
        });
    }

    // Cargar la lista de mascotas al inicio
    cargarMascotas();

    // Recargar la lista de mascotas después de una operación
    $(document).on('formSuccess', function() {
        cargarMascotas();
    });

    // Manejar eventos de los botones para cargar el formulario correspondiente
    $('#addPetBtn').on('click', function() {
        cargarFormulario("addPetForm.pl", "Formulario para Agregar Mascota");
    });

    $('#updatePetBtn').on('click', function() {
        cargarFormulario("editPetForm.pl", "Formulario para Modificar Mascota");
    });

    $('#deletePetBtn').on('click', function() {
        cargarFormulario("deletePetForm.pl", "Formulario para Eliminar Mascota");
    });
});
</script>
</body>
</html>
EOF
