#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;
use utf8;
use DBI;
use JSON::XS;
use open ':std', ':encoding(UTF-8)';

print "Content-type: application/json; charset=UTF-8\n\n";

# Conectar a la base de datos
my $dsn = "DBI:mysql:database=pets;host=localhost;port=3306";
my $usuario = "perl_user";
my $contrasena = "perl_user"; # Cambia según tu configuración

my $dbh = DBI->connect(
    $dsn, 
    $usuario, 
    $contrasena, 
    {
        RaiseError       => 1,
        AutoCommit       => 1,
        mysql_enable_utf8mb4 => 1,
    }
);

# Asegurar que la conexión esté en utf8mb4
$dbh->do("SET NAMES 'utf8mb4'");

# Consultar los datos
my $sth = $dbh->prepare("SELECT * FROM pets");
$sth->execute();

my @pets;
while (my $row = $sth->fetchrow_hashref) {
    $row->{dueño} = "dueño";  # Incluir explícitamente "dueño"
    push @pets, $row;
}

# Codificar JSON
my $json = JSON::XS->new->utf8(0)->encode(\@pets);  # No forzar UTF-8 aquí
print Encode::encode('UTF-8', $json);  # Imprimir correctamente en UTF-8

$sth->finish();
$dbh->disconnect();
