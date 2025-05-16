import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _operand = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _operand = "";
        _num1 = 0;
        _num2 = 0;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _output = "0";
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "x":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error";
            break;
        }
        _operand = "";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.primary.withOpacity(0.8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(22),
          ),
          child: Text(text, style: const TextStyle(fontSize: 22)),
          onPressed: () => _buttonPressed(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isWide ? 400 : double.infinity),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: Text(_output, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildButton("7"),
                        _buildButton("8"),
                        _buildButton("9"),
                        _buildButton("/", color: Colors.orange),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("4"),
                        _buildButton("5"),
                        _buildButton("6"),
                        _buildButton("x", color: Colors.orange),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("1"),
                        _buildButton("2"),
                        _buildButton("3"),
                        _buildButton("-", color: Colors.orange),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton("C", color: Colors.red),
                        _buildButton("0"),
                        _buildButton("=", color: Colors.green),
                        _buildButton("+", color: Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
