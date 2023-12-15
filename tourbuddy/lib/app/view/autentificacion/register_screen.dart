import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourbuddy/app/view/home/home_page.dart';
import 'package:tourbuddy/app/view/autentificacion/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Center(
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: Text(
                  'TourBuddy',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Por favor cree su cuenta'),
              const SizedBox(height: 36),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {
                  createAccount();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  '¿Ya tienes una cuenta? Inicia sesión aquí',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Guardar el nombre de usuario en Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(_nameController.text);
      }

      showMessage(message: 'Cuenta creada con éxito');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(message: e.message ?? 'Error al crear la cuenta');
    } catch (e) {
      showMessage(message: e.toString());
    }
  }

  void showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
