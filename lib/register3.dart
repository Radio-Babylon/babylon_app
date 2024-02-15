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
            _buildCheckboxGridSection('Select interest 1', interest1),
            _buildCheckboxGridSection('Select interest 2', interest2),
            _buildCheckboxGridSection('Select interest 3', interest3),
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

  Widget _buildCheckboxGridSection(String title, Map<String, bool> options) {
    int crossAxisCount = 3; // Number of columns in the grid

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        // Wrap the GridView with a Container for the background
        Container(
          decoration: BoxDecoration(
            // Use a BoxDecoration to style the background
            color: Colors.grey[200], // This should be the color of your choice
            border: Border.all(
              color: Colors.black, // The color of the border
              width: 1, // The width of the border
            ),
            borderRadius: BorderRadius.circular(15), // The border radius
          ),
          padding: const EdgeInsets.all(8), // Padding for the Container
          // GridView for the checkbox grid
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 3 / 1, // Adjust as needed for your design
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              String key = options.keys.elementAt(index);
              return CheckboxListTile(
                title: Text(key),
                value: options[key],
                onChanged: (bool? value) {
                  setState(() {
                    options[key] = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing, // Position the checkbox after the text
                contentPadding: EdgeInsets.symmetric(horizontal: 0),// Position the checkbox on the left side
              );
            },
          ),
        ),
      ],
    );
  }

  }

