import 'package:flutter/material.dart';

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  State<KalkulatorScreen> createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  String _display = '0';
  String _history = '';
  double? _firstOperand;
  String? _operator;
  bool _shouldResetDisplay = false;

  // === Utility ===
  String _formatNumber(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toStringAsFixed(6).replaceFirst(RegExp(r'\.?0+$'), '');
  }

  // === Input & Operations ===
  void _inputDigit(String digit) {
    setState(() {
      if (_shouldResetDisplay || _display == '0') {
        _display = (digit == '.') ? '0.' : digit;
        _shouldResetDisplay = false;
      } else {
        if (digit == '.' && _display.contains('.')) return;
        _display += digit;
      }
    });
  }

  void _toggleSign() {
    setState(() {
      if (_display.startsWith('-')) {
        _display = _display.substring(1);
      } else if (_display != '0') {
        _display = '-$_display';
      }
    });
  }

  void _percentage() {
    final current = double.tryParse(_display) ?? 0.0;
    setState(() {
      _display = _formatNumber(current / 100);
      _shouldResetDisplay = true;
    });
  }

  void _setOperator(String op) {
    setState(() {
      final current = double.tryParse(_display) ?? 0.0;
      if (_firstOperand == null) {
        _firstOperand = current;
      } else if (_operator != null && !_shouldResetDisplay) {
        final res = _evaluate(_firstOperand!, _operator!, current);
        _firstOperand = res;
        _display = _formatNumber(res);
      }
      _operator = op;
      _history = '${_formatNumber(_firstOperand!)} ${_opSymbol(op)}';
      _shouldResetDisplay = true;
    });
  }

  String _opSymbol(String op) {
    switch (op) {
      case 'add':
        return '+';
      case 'sub':
        return '−';
      case 'mul':
        return '×';
      case 'div':
        return '÷';
      default:
        return '';
    }
  }

  double _evaluate(double a, String op, double b) {
    switch (op) {
      case 'add':
        return a + b;
      case 'sub':
        return a - b;
      case 'mul':
        return a * b;
      case 'div':
        if (b == 0) return double.nan;
        return a / b;
      default:
        return b;
    }
  }

  void _calculateResult() {
    final current = double.tryParse(_display) ?? 0.0;
    if (_firstOperand == null || _operator == null) return;

    final res = _evaluate(_firstOperand!, _operator!, current);
    final expr =
        '${_formatNumber(_firstOperand!)} ${_opSymbol(_operator!)} ${_formatNumber(current)} = ${_formatNumber(res)}';

    setState(() {
      _display = _formatNumber(res);
      _history = expr;
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = true;
    });
  }

  void _clearAll() {
    setState(() {
      _display = '0';
      _history = '';
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = false;
    });
  }

  // === UI ===
  Widget _buildButton(
    String label, {
    Color? color,
    Color? textColor,
    VoidCallback? onTap,
    double? fontSize,
    double buttonSize = 64,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        height: buttonSize,
        child: Material(
          color: color ?? const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.white.withValues(alpha: 0.1),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize ?? 24,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWideButton(
    String label, {
    Color? color,
    Color? textColor,
    VoidCallback? onTap,
    double buttonSize = 64,
  }) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.all(6),
        height: buttonSize,
        child: Material(
          color: color ?? const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.white.withValues(alpha: 0.1),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // === Build UI ===
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Hitung ukuran button berdasarkan tinggi layar
            final buttonSize = (constraints.maxHeight - 200) / 6;
            final clampedButtonSize = buttonSize.clamp(50.0, 72.0);

            return Column(
              children: [
                // Display Area
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // History
                        if (_history.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              child: Text(
                                _history,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        // Main Display
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Text(
                            _display,
                            style: const TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Row 1: C, +/-, %, ÷
                        Expanded(
                          child: Row(
                            children: [
                              _buildButton(
                                'C',
                                color: const Color(0xFFA5A5A5),
                                textColor: Colors.black,
                                onTap: _clearAll,
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '+/−',
                                color: const Color(0xFFA5A5A5),
                                textColor: Colors.black,
                                onTap: _toggleSign,
                                fontSize: 20,
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '%',
                                color: const Color(0xFFA5A5A5),
                                textColor: Colors.black,
                                onTap: _percentage,
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '÷',
                                color: const Color(0xFFFF9F0A),
                                onTap: () => _setOperator('div'),
                                buttonSize: clampedButtonSize,
                              ),
                            ],
                          ),
                        ),

                        // Row 2: 7, 8, 9, ×
                        Expanded(
                          child: Row(
                            children: [
                              _buildButton(
                                '7',
                                onTap: () => _inputDigit('7'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '8',
                                onTap: () => _inputDigit('8'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '9',
                                onTap: () => _inputDigit('9'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '×',
                                color: const Color(0xFFFF9F0A),
                                onTap: () => _setOperator('mul'),
                                buttonSize: clampedButtonSize,
                              ),
                            ],
                          ),
                        ),

                        // Row 3: 4, 5, 6, −
                        Expanded(
                          child: Row(
                            children: [
                              _buildButton(
                                '4',
                                onTap: () => _inputDigit('4'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '5',
                                onTap: () => _inputDigit('5'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '6',
                                onTap: () => _inputDigit('6'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '−',
                                color: const Color(0xFFFF9F0A),
                                onTap: () => _setOperator('sub'),
                                buttonSize: clampedButtonSize,
                              ),
                            ],
                          ),
                        ),

                        // Row 4: 1, 2, 3, +
                        Expanded(
                          child: Row(
                            children: [
                              _buildButton(
                                '1',
                                onTap: () => _inputDigit('1'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '2',
                                onTap: () => _inputDigit('2'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '3',
                                onTap: () => _inputDigit('3'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '+',
                                color: const Color(0xFFFF9F0A),
                                onTap: () => _setOperator('add'),
                                buttonSize: clampedButtonSize,
                              ),
                            ],
                          ),
                        ),

                        // Row 5: 0 (wide), ., =
                        Expanded(
                          child: Row(
                            children: [
                              _buildWideButton(
                                '0',
                                onTap: () => _inputDigit('0'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '.',
                                onTap: () => _inputDigit('.'),
                                buttonSize: clampedButtonSize,
                              ),
                              _buildButton(
                                '=',
                                color: const Color(0xFFFF9F0A),
                                onTap: _calculateResult,
                                buttonSize: clampedButtonSize,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
