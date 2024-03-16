import 'package:flutter/material.dart';
import 'package:homeworkbeer5/beer.dart';
import 'package:homeworkbeer5/countrytable.dart';
import 'package:homeworkbeer5/wines.dart';

var kBottomBarBackgroundColor = Color.fromARGB(255, 8, 119, 238);
var kBottomBarForegroundActiveColor = Color.fromARGB(255, 4, 132, 237);
var kBottomBarForegroundInactiveColor = Colors.white60;
var kSplashColor = Color.fromARGB(255, 9, 126, 251);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  void _handleClickButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget _buildPageBody() {
      switch (_selectedIndex) {
        case 0:
          return const Countrytable();
        case 1:
          return const Wines();
        case 2:
          return const Beers();
        default:
          return const Countrytable();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phunsup'),
      ),
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
          backgroundColor: kBottomBarBackgroundColor,
          // splashColor: kSplashColor,
          shape: CircleBorder(),
          onPressed: () {},
          child: AppBottomMenuItem(
            iconData: Icons.games_outlined,
            text: 'MMO',
            isSelected: _selectedIndex == 1,
            onClick: () => _handleClickButton(1),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        height: 64.0,
        padding: EdgeInsets.zero,
        color: kBottomBarBackgroundColor,
        // notchMargin: 4.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.location_city_outlined,
                text: 'Country',
                isSelected: _selectedIndex == 0,
                onClick: () => _handleClickButton(0),
              ),
            ),
            SizedBox(width: 100.0),
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.local_drink,
                text: 'Beers',
                isSelected: _selectedIndex == 2,
                onClick: () => _handleClickButton(2),
              ),
            ),
          ],
        ),
      ),
      body: Container(child: Center(child: _buildPageBody())),
    );
  }
}

class AppBottomMenuItem extends StatelessWidget {
  const AppBottomMenuItem({
    super.key,
    required this.iconData,  // declare iconData as required
    required this.text,     
    required this.isSelected,
    required this.onClick,  
  });

  final IconData iconData;
  final String text;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected
        ? kBottomBarForegroundActiveColor
        : kBottomBarForegroundInactiveColor;

    return ClipOval(
      child: Material(
        color: Colors.transparent, // button color
        child: InkWell(
          // splashColor: kSplashColor,
          onTap: onClick, // button pressed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(iconData, color: color),
              SizedBox(height: 4.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: color,
                  // fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
