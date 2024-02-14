import 'package:flutter/material.dart';
class RegisterPage3 extends StatefulWidget {
  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  String? selectedLanguage;
  List<String> languages = [
    "English", "Spanish", "Mandarin", "French", "German",
    "Japanese", "Russian", "Italian", "Portuguese", "Arabic", "Korean",
  ];

  late Map<String, bool> interest1;
  late Map<String, bool> interest2;
  late Map<String, bool> interest3;

  @override
  void initState() {
    super.initState();
    interest1 = {
      "option 1": false,
      "option 2": false,
      "option 3": false,
      "option 4": false,
      "option 5": false,
      "option 6": false,
      "option 7": false,
      "option 8": false,
      "option 9": false,
    };

    interest2 = Map.from(interest1);
    interest3 = {
      "option 1": false,
      "option 2": false,
      "option 3": false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/images/logo.png', height: 120, width: 120),
            const SizedBox(height: 20),
            const Text(
              'Almost there, just a few more steps',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select the languages you speak'),
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            _buildCheckboxListTileSection('Select interest 1', interest1),
            _buildCheckboxListTileSection('Select interest 2', interest2),
            _buildCheckboxListTileSection('Select interest 3', interest3),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Finish'),
              onPressed: () {
                // Action when you press 'Finish'
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxListTileSection(String title, Map<String, bool> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...options.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: options[key],
            onChanged: (bool? value) {
              setState(() {
                options[key] = value!;
              });
            },
          );
        }).toList(),
      ],
    );
  }
}
