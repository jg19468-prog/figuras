import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'figuras.widgets.dart';

class CirculoPage extends StatefulWidget {
  const CirculoPage({super.key});

  @override
  State<CirculoPage> createState() => _CirculoPageState();
}

class _CirculoPageState extends State<CirculoPage> {
  final TextEditingController radio = TextEditingController();

  String area = '';
  String perimetro = '';

  @override
  void dispose() {
    radio.dispose();
    super.dispose();
  }

  void calcular() {
    final r = leerNumero(radio);

    if (r == null || r <= 0) {
      setState(() {
        area = '';
        perimetro = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa el radio (número mayor que 0)')),
      );
      return;
    }

    setState(() {
      area = '${formato(math.pi * r * r)} u²';
      perimetro = '${formato(2 * math.pi * r)} u';
    });
  }

  void limpiar() {
    radio.clear();
    setState(() {
      area = '';
      perimetro = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const EncabezadoFigura(
              icono: Icons.circle_outlined,
              titulo: 'Círculo',
              subtitulo: 'Calcula su área y su perímetro',
            ),
            const SizedBox(height: 15),
            TarjetaSeccion(
              titulo: 'Datos del círculo',
              icono: Icons.straighten,
              children: [
                CampoNumero(controller: radio, etiqueta: 'Radio (r)'),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: calcular,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular área y perímetro'),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CajaResultado(
                        etiqueta: 'Área del círculo',
                        valor: area,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CajaResultado(
                        etiqueta: 'Perímetro (circunferencia)',
                        valor: perimetro,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: limpiar,
              icon: const Icon(Icons.refresh),
              label: const Text('Limpiar campos'),
            ),
          ],
        ),
      ),
    );
  }
}
