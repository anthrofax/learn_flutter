import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:favorite_places/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _emailController = '';
  String _passwordController = '';
  File? _profileImage;

  bool _isLogin = true;

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _onSubmitForm() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    if (!_isLogin && _profileImage != null) return;

    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        // Login Logic
        final userCredential = await _firebase.signInWithEmailAndPassword(
          email: _emailController,
          password: _passwordController,
        );

        print(userCredential);
      } else {
        //  Signup Logic
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _emailController,
          password: _passwordController,
        );

        print(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {}

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Terjadi kesalahan saat membuat akun"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/chat.png', width: 200, height: 200),
            Form(
              key: _formKey,
              child: Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (!_isLogin)
                        UserImagePicker(onPickImage: (pickedImage) {
                          _profileImage = pickedImage;
                        }),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Alamat Email',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email tidak boleh kosong";
                          }

                          if (!value.contains('@')) {
                            return "Email tidak valid";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _emailController = value!;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Password tidak boleh kosong";
                          }

                          if (value.length < 6) {
                            return "Password harus memiliki minimal 6 karakter";
                          }

                          return null;
                        },
                        obscureText: true,
                        onSaved: (value) {
                          _passwordController = value!;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: _onSubmitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          _isLogin ? 'Login' : 'Sign Up',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: _toggleAuthMode,
                        child: Text(_isLogin
                            ? "Buat akun disini"
                            : 'Sudah punya akun? login disini'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
