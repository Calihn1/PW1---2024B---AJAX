#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
binmode STDOUT, ':utf8';

print "Content-type: text/html\n\n";

print <<'EOF';
<form id="editPetForm">
  <div class="form-group">
    <label for="nombre">Nombre (Para identificar):</label>
    <input type="text" class="form-control" id="nombre" name="nombre" required>
  </div>
  <div class="form-group">
    <label for="dueño">Dueño (opcional):</label>
    <input type="text" class="form-control" id="dueño" name="dueño">
  </div>
  <div class="form-group">
    <label for="species">Especie (opcional):</label>
    <input type="text" class="form-control" id="especies" name="especies">
  </div>
  <div class="form-group">
    <label for="sexo">Sexo (opcional):</label>
    <select class="form-control" id="sexo" name="sexo">
      <option value="">Selecciona</option>
      <option value="Macho">Macho</option>
      <option value="Hembra">Hembra</option>
    </select>
  </div>
  <div class="form-group">
    <label for="nacimiento">Nacimiento (opcional):</label>
    <input type="date" class="form-control" id="nacimiento" name="nacimiento">
  </div>
  <div class="form-group">
    <label for="muerte">Muerte (opcional):</label>
    <input type="date" class="form-control" id="muerte" name="muerte">
  </div>
  <button type="submit" class="btn btn-warning">Modificar</button>
</form>
EOF

print encode_json({ success => 1, message => "Operación realizada con éxito" });