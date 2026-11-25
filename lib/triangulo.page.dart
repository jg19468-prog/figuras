import 'package:flutter/material.dart';

import 'figuras.widgets.dart';

class TrianguloPage extends StatefulWidget {
  const TrianguloPage({super.key});

  @override
  State<TrianguloPage> createState() => _TrianguloPageState();
}

class _TrianguloPageState extends State<TrianguloPage> {
  // Controladores para recuperar los valores de los TextField
  final TextEditingController base = TextEditingController();
  final TextEditingController altura = TextEditingController();
  final TextEditingController lado1 = TextEditingController();
  final TextEditingController lado2 = TextEditingController();
  final TextEditingController lado3 = TextEditingController();

  String area = '';
  String perimetro = '';

  @override
  void dispose() {
    base.dispose();
    altura.dispose();
    lado1.dispose();
    lado2.dispose();
    lado3.dispose();
    super.dispose();
  }

  void avisar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  void calcularArea() {
    final b = leerNumero(base);
    final h = leerNumero(altura);

    if (b == null || h == null || b <= 0 || h <= 0) {
      setState(() {
        area = '';
      });
      avisar('Ingresa la base y la altura (números mayores que 0)');
      return;
    }

    setState(() {
      area = '${formato(b * h / 2)} u²';
    });
  }

  void calcularPerimetro() {
    final l1 = leerNumero(lado1);
    final l2 = leerNumero(lado2);
    final l3 = leerNumero(lado3);

    if (l1 == null || l2 == null || l3 == null || l1 <= 0 || l2 <= 0 || l3 <= 0) {
      setState(() {
        perimetro = '';
      });
      avisar('Ingresa los 3 lados (números mayores que 0)');
      return;
    }

    setState(() {
      perimetro = '${formato(l1 + l2 + l3)} u';
    });
  }

  void limpiar() {
    base.clear();
    altura.clear();
    lado1.clear();
    lado2.clear();
    lado3.clear();
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
              icono: Icons.change_history,
              titulo: 'Triángulo',
              subtitulo: 'Calcula su área y su perímetro',
            ),
            const SizedBox(height: 15),
            TarjetaSeccion(
              titulo: 'Área',
              icono: Icons.square_foot,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CampoNumero(controller: base, etiqueta: 'Base (b)'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CampoNumero(
                        controller: altura,
                        etiqueta: 'Altura (h)',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: calcularArea,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular área'),
                ),
                const SizedBox(height: 15),
                CajaResultado(etiqueta: 'Área del triángulo', valor: area),
              ],
            ),
            const SizedBox(height: 15),
            TarjetaSeccion(
              titulo: 'Perímetro',
              icono: Icons.straighten,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CampoNumero(controller: lado1, etiqueta: 'Lado 1'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CampoNumero(controller: lado2, etiqueta: 'Lado 2'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CampoNumero(controller: lado3, etiqueta: 'Lado 3'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: calcularPerimetro,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular perímetro'),
                ),
                const SizedBox(height: 15),
                CajaResultado(
                  etiqueta: 'Perímetro del triángulo',
                  valor: perimetro,
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
