import 'package:flutter/material.dart';

class Exercise5 extends StatefulWidget {
  const Exercise5({super.key});

  @override
  State<Exercise5> createState() => _Exercise5State();
}

class _Exercise5State extends State<Exercise5> {
  int _counter = 0;

  Future<void> _pickDateSafely() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Picked: ${picked.day}/${picked.month}/${picked.year}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 5 - Common UI Fixes'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                final label = String.fromCharCode(65 + index);
                return ListTile(
                  leading: const Icon(Icons.movie),
                  title: Text('Movie $label'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Fix Overflow'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(50, (i) => Text('Dòng số ${i + 1}')),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Fix 2: Overflow'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: Text('Fix 3: Counter $_counter'),
                ),
                OutlinedButton(
                  onPressed: _pickDateSafely,
                  child: const Text('Fix 4: DatePicker')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}