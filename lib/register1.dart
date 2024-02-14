import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Account',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreateAccountPage(),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateAccountForm(),
      ),
    );
  }
}

class CreateAccountForm extends StatefulWidget {
  @override
  CreateAccountFormState createState() => CreateAccountFormState();
}

class CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  Widget _buildTextField({required String labelText, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Espaciado entre campos de texto
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0), // Borde redondeado con radio de 5
          ),
          filled: true,
          fillColor: Colors.grey[200], // Color de fondo del campo de texto
        ),
        obscureText: isPassword, // Si es un campo de contraseña, oculta el texto
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // El logo debe ser de un tamaño específico y con un padding definido.
    // Basado en el diseño proporcionado, parece que el logo debería estar centrado con un tamaño específico.
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 37), // Espacio superior del logo
            Image.asset(
              'assets/images/logo.png',
              width: 365, // Ancho basado en el diseño
              height: 90, // Altura basada en el diseño
              fit: BoxFit.contain,
            ),
            SizedBox(height: 37), // Espacio inferior del logo
            // Definimos el resto de los campos de texto
            _buildTextField(labelText: 'Name'),
            _buildTextField(labelText: 'Surname'),
            _buildTextField(labelText: 'Date of Birth'),
            _buildTextField(labelText: 'Email Address'),
            _buildTextField(labelText: 'Country of Origin'),
            _buildTextField(labelText: 'Password', isPassword: true),
            _buildTextField(labelText: 'Confirm Password', isPassword: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(365, 60), // Tamaño del botón basado en tu diseño
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Botón con bordes redondeados
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
