import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2048/logica/grid.dart';
import 'package:nieves_2048/logica/motor_juego.dart';
import 'package:nieves_2048/presentation/juego_screen.dart';

void main() {
  testWidgets('deslizar a la izquierda fusiona y suma puntaje', (tester) async {
    MotorJuego crear() {
      final m = MotorJuego(aleatorio: Random(1));
      m.grid = Grid([
        [2, 2, null, null],
        [null, null, null, null],
        [null, null, null, null],
        [null, null, null, null],
      ]);
      return m;
    }

    await tester.pumpWidget(MaterialApp(home: JuegoScreen(crearMotor: crear)));
    expect(find.text('Vainilla'), findsNWidgets(2));
    await tester.fling(find.byType(GridView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Fresa'), findsWidgets);
    expect(find.text('Puntaje: 4'), findsOneWidget);
  });

  testWidgets('al ganar aparece el dialogo de Independencia', (tester) async {
    MotorJuego crear() {
      final m = MotorJuego(aleatorio: Random(1));
      m.grid = Grid([
        [1024, 1024, null, null],
        [null, null, null, null],
        [null, null, null, null],
        [null, null, null, null],
      ]);
      return m;
    }

    await tester.pumpWidget(MaterialApp(home: JuegoScreen(crearMotor: crear)));
    await tester.fling(find.byType(GridView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Independencia lograda!'), findsOneWidget);
  });
}
