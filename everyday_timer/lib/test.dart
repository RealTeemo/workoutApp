import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dropdown in Dialog'),
        ),
        body: const Center(
          child: MyDropdownButton(),
        ),
      ),
    );
  }
}

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showDropdownDialog(context);
      },
      child: selectedValue != null
          ? Text('Selected Value: $selectedValue')
          : const Text('Show Dropdown Dialog'),
    );
  }

  Future<void> _showDropdownDialog(BuildContext context) async {
    int? result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Option'),
          content: DropdownButton<int>(
            value: selectedValue,
            onChanged: (int? newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            items: List.generate(5, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text('Option $index'),
              );
            }),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedValue);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedValue = result;
      });
    }
  }
}
