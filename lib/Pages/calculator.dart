import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<List<String>> operators = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', 'x'],
    ['1', '2', '3', '-'],
    ['.', '0', '00', '+'],
    ['clear', '='],
  ];
  String current = '0';
  String stored = '';
  String oper = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerRight,
              child: Text(current),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: operators
                  .map(
                    (e) => Expanded(
                      child: Row(
                        children: e
                            .map(
                              (e) => Expanded(
                                child: InkWell(
                                  onTap: () => setState(() {
                                    if (['+', '-', 'x', '/'].contains(e)) {
                                      stored = current;
                                      current = '';
                                      oper = e;
                                    } else {
                                      if (e != 'clear' && e != '=') {
                                        current += e;
                                      }
                                      current = e == 'clear' ? '' : current;
                                      oper = e == 'clear' ? '' : oper;
                                    }
                                    if (e == '=' &&stored != '' && current != '') {
                                      double a = double.parse(stored);
                                      double b = double.parse(current);
                                      Map<String, dynamic> results = {
                                        '+': a + b,
                                        '-': a - b,
                                        '/': a / b,
                                        'x': a * b
                                      };
                                      current = results[oper].toString();
                                      oper = '';
                                      stored = '';
                                    }
                                  }),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: oper == e ? Colors.orange : null,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(500))),
                                    child: Text(e),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
