import 'package:flutter/material.dart';

class BottomNavigationBarTeste extends StatefulWidget {
  const BottomNavigationBarTeste({super.key});

  @override
  State<BottomNavigationBarTeste> createState() =>
      _BottomNavigationBarTesteState();
}

class _BottomNavigationBarTesteState extends State<BottomNavigationBarTeste> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Não Gostei',
      style: optionStyle,
    ),
    Text(
      'Index 1: Não avaliados',
      style: optionStyle,
    ),
    Text(
      'Index 2: Gostei',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_down),
          label: 'Não gostei',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: 'Não avaliados',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up),
          label: 'Gostei',
          backgroundColor: Colors.green,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: cores.onPrimary,
      unselectedItemColor: cores.onSecondaryContainer,
      onTap: _onItemTapped,
      backgroundColor: cores.onBackground,
    );
  }
}
