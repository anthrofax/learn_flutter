import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:favorite_places/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredUsername = '';
  String _enteredPassword = '';

  File? _profileImage;
  bool _isAuthenticating = false;

  bool _isLogin = true;

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _onSubmitForm() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    if (!_isLogin && _profileImage == null) {
      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Data belum lengkap'),
                content: const Text(
                    'Anda belum menentukan gambar profil untuk akun anda!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLogin) {
        // Login Logic
        final userCredential = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        print(userCredential);
      } else {
        //  Signup Logic
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        // Upload gambar ke Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');

        await storageRef.putFile(_profileImage!);
        // Ambil URL gambar yang sudah terunggah
        final imageUrl = await storageRef.getDownloadURL();

        // Simpan data pengguna ke Firestore
        await FirebaseFirestore.instance
            .collection('users') // Koleksi "users"
            .doc(userCredential.user!.uid) // Dokumen dengan UID sebagai nama
            .set({
          'username': _enteredUsername, // Nama pengguna (akan ditambahkan nanti)
          'email': _enteredEmail, // Email pengguna
          'image_url': imageUrl, // URL gambar yang diunggah
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {}

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Terjadi kesalahan saat membuat akun"),
        ),
      );
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
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
                        enableSuggestions: true,
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
                          _enteredEmail = value!;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty || value.trim().length < 4) {
                              return "Harap masukkan username yang valid (Minimal 4 karakter)";
                            }

                            return null;
                          },
                          enableSuggestions: false,
                          onSaved: (value) {
                            _enteredUsername = value!;
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
                          _enteredPassword = value!;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (_isAuthenticating) const CircularProgressIndicator(),
                      if (!_isAuthenticating)
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
                      if (!_isAuthenticating)
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
