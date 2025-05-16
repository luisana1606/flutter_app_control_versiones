import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _numero1Controller = TextEditingController();
  final TextEditingController _numero2Controller = TextEditingController();
  String _operacion = '+';
  double _resultado = 0;
  bool _mostrarResultado = false;

  void _calcular() {
    double num1 = double.tryParse(_numero1Controller.text) ?? 0;
    double num2 = double.tryParse(_numero2Controller.text) ?? 0;

    setState(() {
      if (_operacion == '÷' && num2 == 0) {
        _resultado = double.nan;
      } else {
        switch (_operacion) {
          case '+':
            _resultado = num1 + num2;
            break;
          case '-':
            _resultado = num1 - num2;
            break;
          case 'x':
            _resultado = num1 * num2;
            break;
          case '÷':
            _resultado = num1 / num2;
            break;
        }
      }
    });
  }

  void _mostrarCalculo() {
    _calcular();
    setState(() {
      _mostrarResultado = true;
    });
  }

  void _limpiar() {
    setState(() {
      _numero1Controller.text = '';
      _numero2Controller.text = '';
      _operacion = '+';
      _resultado = 0;
      _mostrarResultado = false;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora CASIO'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Image.asset(
                            'assets/casio_logo.png',
                            height: 50,
                            fit: BoxFit.contain,
                            color: colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInputField('Inserte el primer número', _numero1Controller, theme),
                        const SizedBox(height: 10),
                        _buildInputField('Inserte el segundo número', _numero2Controller, theme),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: _mostrarCalculo,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.secondaryContainer,
                              foregroundColor: colorScheme.onSecondaryContainer,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              textStyle: const TextStyle(fontSize: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text('Ver Resultado'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_mostrarResultado)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                '${_resultado.isNaN ? 'Error' : _resultado.toStringAsFixed(_resultado.truncateToDouble() == _resultado ? 0 : 2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildOperationButton('+', theme),
                            _buildOperationButton('-', theme),
                            _buildOperationButton('x', theme),
                            _buildOperationButton('÷', theme),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: _limpiar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.secondaryContainer,
                              foregroundColor: colorScheme.onSecondaryContainer,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              textStyle: const TextStyle(fontSize: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text('Limpiar'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Copyright, © Luisana Soto 2025\nTodos los derechos Reservados.',
                            style: TextStyle(fontSize: 9, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: colorScheme.surface.withOpacity(0.65),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.8,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  label == 'Inserte el primer número'
                      ? Icons.looks_one_rounded
                      : Icons.looks_two_rounded,
                  color: colorScheme.secondary,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  height: 32,
                  child: TextField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(fontSize: 12, color: colorScheme.onSurface.withOpacity(0.3)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                      filled: true,
                      fillColor: colorScheme.surface.withOpacity(0.75),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colorScheme.outline.withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: colorScheme.secondary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationButton(String operation, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _operacion = operation;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _operacion == operation
            ? colorScheme.secondary
            : colorScheme.surface,
        foregroundColor: _operacion == operation
            ? colorScheme.onSecondary
            : colorScheme.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(14),
      ),
      child: Text(
        operation,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }
}
