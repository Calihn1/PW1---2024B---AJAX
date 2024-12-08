#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
binmode STDOUT, ':utf8';

print "Content-type: text/html\n\n";

print <<'EOF';
<form id="addPetForm">
  <div class="form-group">
    <label for="name">Nombre:</label>
    <input type="text" class="form-control" id="name" name="name" required>
  </div>
  <div class="form-group">
    <label for="owner">Dueño:</label>
    <input type="text" class="form-control" id="owner" name="owner" required>
  </div>
  <div class="form-group">
    <label for="species">Especie:</label>
    <input type="text" class="form-control" id="species" name="species" required>
  </div>
  <div class="form-group">
    <label for="birth">Nacimiento:</label>
    <input type="date" class="form-control" id="birth" name="birth" required>
  </div>
  <div class="form-group">
    <label for="death">Muerte (opcional):</label>
    <input type="date" class="form-control" id="death" name="death">
  </div>
  <button type="submit" class="btn btn-primary">Guardar</button>
</form>
EOF

print encode_json({ success => 1, message => "Operación realizada con éxito" });
