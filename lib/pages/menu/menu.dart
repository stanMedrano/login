import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background, // Usar el color de fondo del tema
      child: const Center(
        child: Text("Contenido de la página de Menú"),
      ),
    );
  }
}
