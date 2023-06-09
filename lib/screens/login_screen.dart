import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jr_clock/services/services.dart';
import 'package:jr_clock/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: _boxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login card
                  CustomCard(
                    child: Column(
                      children: const [
                        // Title
                        Text('Iniciar sesión', style: TextStyle(color: Colors.black87, fontSize: 34) ),
                        SizedBox(height: 30),

                        // Form
                        _LoginForm(),
                      ],
                    ),
                  ),

                  // Forgotten password button
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed('register'),
                    style: ButtonStyle(shape:MaterialStateProperty.all(const StadiumBorder())), // rounder borders
                    child: Text('¿No tienes cuenta?', style: TextStyle(color: Theme.of(context).primaryColor)),
                  ),

                ]
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.black87,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.5]
        )
    );
  }
}

// Login form -> email and password
class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: const [
          // Email
          _TextFormEmail(),

          // Password
          SizedBox(height: 25,),
          _TextFormPassword(),

          // Button
          SizedBox(height: 25,),
          _ElevatedButton(),

        ],
      ),

    );
  }
}


// Email
class _TextFormEmail extends StatelessWidget {
  const _TextFormEmail({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    authProvider.email = Preferences.email; // To remember email user

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: Preferences.email,
      autocorrect: false,
      decoration: _buildInputDecoration(context),
      onChanged: (value) => authProvider.email = value,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp  = RegExp(pattern);
        return regExp.hasMatch(value ?? '')
            ? null
            : 'Introduce un correo válido';
      },

    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)
      ),

      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1
          )
      ),

      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
              color: Colors.red,
              width: 1
          )
      ),

      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
              color: Colors.red,
              width: 1
          )
      ),

      prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).primaryColor,),
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      labelText: 'Correo electrónico',
      hintText: 'ejemplo@gmail.com',
    );
  }
}


// Password
class _TextFormPassword extends StatelessWidget {
  const _TextFormPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      autocorrect: false,
      obscureText: authProvider.isObscured,
      onChanged: (value) => authProvider.password = value,
      decoration: _buildInputDecoration(context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'Introduce una contraseña de al menos 6 caracteres';
      },
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)
      ),

      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1
          )
      ),

        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
                color: Colors.red,
                width: 1
            )
        ),

        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
                color: Colors.red,
                width: 1
            )
        ),

      prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).primaryColor,),
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      labelText: 'Contraseña',
      hintText: '******',
      suffixIcon: IconButton(
        icon: Icon(authProvider.isObscured ? Icons.visibility : Icons.visibility_off, color: Colors.black87,),
        onPressed: () => authProvider.isObscured = !authProvider.isObscured,
      )
    );
  }
}


//Button
class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return SizedBox(
      height: 55,
      width: 270,
      child: ElevatedButton(
        onPressed:
            authProvider.isLoading
            ? null // Disable button while wait for data from firebase
            : ()  async {
              FocusScope.of(context).unfocus();
              final String? errorMessage = await authService.login(authProvider.email, authProvider.password);
              if(errorMessage == null){
                Preferences.email = authProvider.email;
                authProvider.isLoading = true;
                Position location = await _getCurrentLocation();
                authProvider.loginLat = location.latitude;
                authProvider.loginLong = location.longitude;
                authProvider.loginLocation = await _getCurrentAddress(authProvider.loginLat, authProvider.loginLong);
                authProvider.isLoading = false;
                Navigator.pushReplacementNamed(context, 'home');
              } else{
                authProvider.isLoading = false;
                NotificationsService.showSnackbar('Email o contraseña no válidos');
              }
            },

        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        child: authProvider.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator.adaptive(strokeWidth: 3, valueColor:AlwaysStoppedAnimation<Color>(Colors.white)),
              )
            : const Text('Iniciar sesión', style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }



  Future<Position> _getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('La geolocalización está desactivada');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Los permisios de geolocalización estan desactivados');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Los permisos estan denegados por siiempre');
    }

    return await Geolocator.getCurrentPosition();

  }

  Future<String> _getCurrentAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String street = place.street.toString();
    return street;
  }
}

