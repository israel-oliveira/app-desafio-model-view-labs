// Classe para represnetar o void, para não retornar o void diretamente

final class Unit {
  @override
  String toString() {
    return 'Unit{}';
  }
}

Unit get unit => Unit();
