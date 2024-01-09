import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  String? emailError;
  String? passwordError;
  bool showPassword = false;

  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: myColor,
          image: DecorationImage(
            image: const AssetImage("assets/images/pg.jpg"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 30, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.restaurant_menu_sharp,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Bienvenido",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "hola",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Ingrese sus datos"),
        const SizedBox(
          height: 40,
        ),
        _buildGreyText("Correo Electronico"),
        _buildInputField(emailController),
        if (emailError != null) // Mostrar mensaje de error si existe
          _buildErrorMessage(emailError!),
        const SizedBox(
          height: 30,
        ),
        _buildGreyText("Contraseña"),
        _buildInputField(passwordController, isPassword: true),
        if (passwordError != null) // Mostrar mensaje de error si existe
          _buildErrorMessage(passwordError!),
        const SizedBox(
          height: 10,
        ),
        _buildRememberForgot(),
        const SizedBox(
          height: 10,
        ),
        _buildLoginButton(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        errorText,
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.blueGrey, fontSize: 15),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : const Icon(Icons.done),
      ),
      obscureText: isPassword ? !showPassword : false,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Recordar contraseña")
          ],
        ),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 40),
            ),
            child: _buildGreyText("Olvide la contraseña")),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        // Simular el proceso de inicio de sesión
        String exampleEmail = "example@example.com";
        String examplePassword = "12345";

        emailError = _isValidEmail(emailController.text)
            ? null
            : 'Correo electrónico inválido';
        passwordError =
            passwordController.text.isEmpty ? 'Contraseña requerida' : null;

        if (emailError != null || passwordError != null) {
          // Mostrar mensajes de error en los campos correspondientes.
          return;
        }
        if (emailController.text == exampleEmail &&
            passwordController.text == examplePassword) {
          // Navegar a la página Home
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // Mostrar mensaje de error en caso de credenciales incorrectas
          setState(() {
            emailError = 'Credenciales incorrectas';
            passwordError = 'Credenciales incorrectas';
          });
        }
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Login"),
    );
  }
}
