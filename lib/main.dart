import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaushik/ViewPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: ViewPage(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("image/img.png",height: 20,width: 20,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


String numf(String n) {
  var numArr = n.split('');
  String revStr = "";
  int thousands = 0;
  for (var i = numArr.length - 1; i >= 0; i--) {
    if (numArr[i].toString() == ".") {
      thousands = 0;
    } else {
      thousands++;
    }
    revStr = revStr + numArr[i].toString();
    if (thousands == 3 && i > 0) {
      thousands = 0;
      revStr = revStr + ',';
    }
  }
  return revStr.split('').reversed.join('');
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      // Split the string into its integer and decimal parts
      List<String> parts = newValueText.split('.');

      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;// + (parts.length > 1 ? parts[1].length : 0);
      final chars = parts[0].split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString() + (parts.length > 1 ? '.' + parts[1] : ''),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex + (parts.length > 1 ? parts[1].length + 1 : 0),
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}