import 'package:flutter/material.dart';

class Exercise2 extends StatefulWidget {
  const Exercise2({super.key});

  @override
  State<Exercise2> createState() => _Exercise2State();
}

class _Exercise2State extends State<Exercise2> {
  double _rating = 50;
  bool _isActive = false;
  String? _genre;
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 - Input Controls Demo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating (Slider)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              onChanged: (value) => setState(() => _rating = value),
            ),
            Text('Current value: ${_rating.round()}'),
            const SizedBox(height: 16),
            const Text(
              'Active (Switch)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Is movie active?'),
                  Switch(
                    value: _isActive,
                    onChanged: (value) => setState(() => _isActive = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            RadioGroup<String>(
              groupValue: _genre,
              onChanged: (value) => setState(() => _genre = value),
              child: const Column(
                children: [
                  RadioListTile<String>(title: Text('Action'), value: 'Action'),
                  RadioListTile<String>(title: Text('Comedy'), value: 'Comedy'),
                ],
              ),
            ),
            Text('Selected genre: ${_genre ?? 'None'}'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _pickDate,
                child: const Text('Open Date Picker'),
              ),
            ),
            if (_selectedDate != null)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Selected date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
