/// Cada valor de ficha es un sabor de nieve de Dolores Hidalgo.
class Sabores {
  static const Map<int, String> nombres = {
    2: 'Vainilla',
    4: 'Fresa',
    8: 'Chocolate',
    16: 'Mango',
    32: 'Limon',
    64: 'Uva',
    128: 'Mole',
    256: 'Tequila',
    512: 'Cafe',
    1024: 'Rompope',
    2048: 'Independencia',
  };

  static String nombre(int valor) => nombres[valor] ?? '';
}
