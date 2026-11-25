import 'package:flutter/material.dart';

import 'circulo.page.dart';
import 'triangulo.page.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key, required this.title});

  final String title;

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  // Página actual del BottomNavigationBar (0 = Triángulo, 1 = Círculo)
  int pagina = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      // SafeArea evita que la UI quede debajo del notch o la barra del sistema.
      // IndexedStack mantiene lo escrito en cada pantalla al cambiar de pestaña.
      body: SafeArea(
        child: IndexedStack(
          index: pagina,
          children: const [
            TrianguloPage(),
            CirculoPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pagina,
        onTap: (index) {
          setState(() {
            pagina = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.change_history),
            label: 'Triángulo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            label: 'Círculo',
          ),
        ],
      ),
    );
  }
}
