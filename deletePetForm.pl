#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
binmode STDOUT, ':utf8';

print "Content-type: text/html\n\n";

print <<'EOF';
<form id="deletePetForm">
  <div class="form-group">
    <label for="name">Nombre de la Mascota a Eliminar:</label>
    <input type="text" class="form-control" id="name" name="name" required>
  </div>
  <button type="submit" class="btn btn-danger">Eliminar</button>
</form>
EOF

print encode_json({ success => 1, message => "Operación realizada con éxito" });