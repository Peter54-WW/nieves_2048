import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2048/logica/direccion.dart';
import 'package:nieves_2048/logica/estado_juego.dart';
import 'package:nieves_2048/logica/grid.dart';
import 'package:nieves_2048/logica/motor_juego.dart';
import 'package:nieves_2048/logica/sabores.dart';

int _vacias(MotorJuego m) => m.grid.celdas.expand((f) => f).where((v) => v == null).length;

void main() {
  test('una partida nueva empieza con dos fichas y puntaje 0', () {
    final motor = MotorJuego(aleatorio: Random(3));
    expect(16 - _vacias(motor), 2);
    expect(motor.puntaje, 0);
    expect(motor.estado, EstadoJuego.jugando);
  });

  test('mover sin ningun desplazamiento no agrega una ficha nueva', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [2, 4, 8, 16],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    final vaciasAntes = _vacias(motor);
    final seMovio = motor.mover(Direccion.izquierda);
    expect(seMovio, false);
    expect(_vacias(motor), vaciasAntes);
  });

  test('alcanzar el valor objetivo cambia el estado a ganado', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [1024, 1024, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    motor.mover(Direccion.izquierda);
    expect(motor.estado, EstadoJuego.ganado);
    expect(motor.puntaje, 2048);
  });

  test('si despues de mover ya no hay movimientos, el estado es perdido', () {
    final motor = MotorJuego(aleatorio: Random(1));
    motor.grid = Grid([
      [2, 4, 2, 4],
      [4, 2, 4, 2],
      [2, 4, 2, 4],
      [4, 2, 4, 2],
    ]);
    motor.mover(Direccion.izquierda);
    expect(motor.estado, EstadoJuego.perdido);
  });

  test('con el juego terminado, mover ya no hace nada', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [1024, 1024, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    motor.mover(Direccion.izquierda);
    final puntaje = motor.puntaje;
    motor.grid.celdas[1][0] = 2;
    motor.grid.celdas[1][1] = 2;
    motor.mover(Direccion.izquierda);
    expect(motor.puntaje, puntaje);
  });

  test('una serie de movimientos combina fichas y acumula puntaje', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [2, 2, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    motor.mover(Direccion.izquierda);
    expect(motor.grid.celdas[0][0], 4);
    expect(motor.puntaje, 4);
    expect(motor.estado, EstadoJuego.jugando);
    expect(16 - _vacias(motor), 2); // la fusionada + la nueva
  });

  test('cada valor tiene su sabor y 2048 es Independencia', () {
    expect(Sabores.nombre(2), 'Vainilla');
    expect(Sabores.nombre(128), 'Mole');
    expect(Sabores.nombre(2048), 'Independencia');
    expect(Sabores.nombre(4096), '');
  });
}
