import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'form_screen.dart';
import 'calculator_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> _routes = ['/', '/calculator', '/game'];

  @override
  void initState() {
    super.initState();
    // Mostrar alerta de bienvenida al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeAlert(context);
    });
  }

  void _showWelcomeAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¡Bienvenido!'),
        content: const Text('Explora las funciones usando el menú lateral o inferior.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  void _navigateWithTransition(BuildContext context, String routeName) {
    Widget page;
    switch (routeName) {
      case '/calculator':
        page = const CalculatorScreen();
        break;
      case '/game':
        page = const GameScreen();
        break;
      case '/form':
        page = const FormScreen();
        break;
      default:
        page = const HomeScreen();
    }
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Moderna IUJO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _getBody(_currentIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.85),
        indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        onDestinationSelected: (index) {
          if (index == 0) {
            setState(() => _currentIndex = 0);
          } else {
            _navigateWithTransition(context, _routes[index]);
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.calculate_outlined), label: 'Calculadora'),
          NavigationDestination(icon: Icon(Icons.gamepad_outlined), label: 'Juego'),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu, size: 40, color: Colors.white),
                  const SizedBox(width: 16),
                  Text(
                    'Menú Principal',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text('Formulario', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _navigateWithTransition(context, '/form');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white),
              title: const Text('Salir', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Regresaste al inicio')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    return const WelcomeScreen();
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Image.network(
              'https://www.meme-arsenal.com/memes/94652cf1fba97b9b40444e6892112849.jpg',
              width: isWide ? 250 : 180,
              height: isWide ? 250 : 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Bienvenido a la App Moderna IUJO',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Explora el menú lateral o inferior para navegar.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
