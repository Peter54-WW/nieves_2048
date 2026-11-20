import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2048/logica/motor_2048.dart';

void main() {
  group('Ronda 1: compactar', () {
    test('compactarFila quita los huecos y mantiene el orden', () {
      expect(Motor2048.compactarFila([2, null, 4, null]), [2, 4, null, null]);
    });

    test('compactarFila sin huecos no cambia nada', () {
      expect(Motor2048.compactarFila([2, 4, 8, 16]), [2, 4, 8, 16]);
    });
  });

  group('Ronda 2: fusionar', () {
    test('fusionarFila combina un par adyacente igual', () {
      final resultado = Motor2048.fusionarFila([2, 2, 4, null]);
      expect(resultado.fila, [4, null, 4, null]);
      expect(resultado.puntosGanados, 4);
    });

    test('fusionarFila no fusiona tres iguales seguidos mas de una vez', () {
      final resultado = Motor2048.fusionarFila([2, 2, 2, null]);
      expect(resultado.fila, [4, null, 2, null]);
      expect(resultado.puntosGanados, 4);
    });

    test('fusionarFila con dos pares hace dos fusiones', () {
      final resultado = Motor2048.fusionarFila([2, 2, 4, 4]);
      expect(resultado.fila, [4, null, 8, null]);
      expect(resultado.puntosGanados, 12);
    });

    test('fusionarFila con huecos al final no intenta fusionar los huecos', () {
      final resultado = Motor2048.fusionarFila([2, 4, null, null]);
      expect(resultado.fila, [2, 4, null, null]);
      expect(resultado.puntosGanados, 0);
    });
  });

  group('Ronda 3: mover una fila', () {
    test('mover una fila hacia la izquierda compacta y fusiona correctamente', () {
      final resultado = Motor2048.moverFilaIzquierda([null, 2, 2, 4]);
      expect(resultado.fila, [4, 4, null, null]);
      expect(resultado.puntosGanados, 4);
      expect(resultado.seMovio, true);
    });

    test('una fila ya en su posicion final reporta seMovio en falso', () {
      expect(Motor2048.moverFilaIzquierda([2, 4, null, null]).seMovio, false);
    });

    test('cuatro iguales se vuelven dos fichas dobles', () {
      expect(Motor2048.moverFilaIzquierda([2, 2, 2, 2]).fila, [4, 4, null, null]);
    });
  });
}
