#!C:/Strawberry/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use DBI;
use JSON;
use utf8;
binmode(STDOUT, ':utf8');

# Configuración CGI y cabeceras
my $cgi = CGI->new;
print $cgi->header('application/json');

# Leer datos del formulario enviados por AJAX
my $params = $cgi->Vars;

# Configurar conexión a la base de datos
my $dsn = "DBI:mysql:database=pets;host=localhost;port=3306";
my $usuario = "perl_user";  # Cambiar según configuración
my $contrasena = "perl_user";

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $usuario, $contrasena, { RaiseError => 1, AutoCommit => 1 })
    or die to_json({ success => 0, message => "Error al conectar a la base de datos: $DBI::errstr" });

# Eliminar la mascota
eval {
    my $sql = "DELETE FROM pets WHERE nombre = ?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($params->{nombre});
    print to_json({ success => 1, message => "Mascota eliminada con éxito." });
};
if ($@) {
    print to_json({ success => 0, message => "Error al eliminar mascota: $@" });
}

# Cerrar conexión
$dbh->disconnect;
