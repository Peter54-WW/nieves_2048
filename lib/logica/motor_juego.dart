import 'dart:math';

import 'direccion.dart';
import 'estado_juego.dart';
import 'grid.dart';

/// Orquesta la partida: puntaje, fichas nuevas, victoria y derrota.
class MotorJuego {
  static const int objetivoVictoria = 2048;

  final Random _aleatorio;
  Grid grid = Grid.vacio();
  int puntaje = 0;
  EstadoJuego estado = EstadoJuego.jugando;

  MotorJuego({Random? aleatorio}) : _aleatorio = aleatorio ?? Random() {
    grid.agregarFichaAleatoria(aleatorio: _aleatorio);
    grid.agregarFichaAleatoria(aleatorio: _aleatorio);
  }

  /// Devuelve true si alguna ficha se desplazó.
  bool mover(Direccion direccion) {
    if (estado != EstadoJuego.jugando) return false;
    final antes = grid.copia().celdas;

    final puntosGanados = switch (direccion) {
      Direccion.izquierda => grid.moverIzquierda(),
      Direccion.derecha => grid.moverDerecha(),
      Direccion.arriba => grid.moverArriba(),
      Direccion.abajo => grid.moverAbajo(),
    };
    puntaje += puntosGanados;

    if (grid.haGanado(objetivoVictoria)) {
      estado = EstadoJuego.ganado;
      return true;
    }

    final huboMovimiento = !_gridsIguales(antes, grid.celdas);
    if (huboMovimiento) grid.agregarFichaAleatoria(aleatorio: _aleatorio);
    if (!grid.hayMovimientosPosibles()) estado = EstadoJuego.perdido;
    return huboMovimiento;
  }

  bool _gridsIguales(List<List<int?>> a, List<List<int?>> b) {
    for (var f = 0; f < a.length; f++) {
      for (var c = 0; c < a[f].length; c++) {
        if (a[f][c] != b[f][c]) return false;
      }
    }
    return true;
  }
}
