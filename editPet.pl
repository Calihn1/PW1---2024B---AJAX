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

my @fields;

# Construir pares campo=valor directamente
for my $key (qw(nombre dueño especies sexo nacimiento muerte)) {
    if ($params->{$key}) {
        my $value = $params->{$key};
        $value =~ s/(['"])/\\$1/g;  # Escapar comillas simples y dobles
        push @fields, "$key = '$value'";
    }
}

# Verificar si se enviaron campos para actualizar
if (@fields) {
    eval {
        # Construir la consulta SQL directamente
        my $sql = "UPDATE pets SET " . join(", ", @fields) . " WHERE nombre = '$params->{nombre}'";
        
        # Ejecutar la consulta
        my $sth = $dbh->prepare($sql);
        $sth->execute();

        # Respuesta de éxito
        print to_json({ success => 1, message => "Mascota modificada con éxito." });
    };
    if ($@) {
        # Manejo de errores
        print to_json({ success => 0, message => "Error al modificar mascota: $@" });
    }
} else {
    # Si no hay campos para actualizar
    print to_json({ success => 0, message => "No se enviaron datos para modificar." });
}

