import 'package:chopspick/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  String? email;
  String? password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void formSubmit() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      debugPrint('Email:$email  şifre: $password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login to your Account',
          style: TextStyles.titleWhiteTextStyle1(color: Colors.red),
        ),
        Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(40.0.sp),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSaved: (String? val) {
                      email = val;
                    },
                  ),
                  TextFormField(
                    onSaved: (String? val) {
                      password = val;
                    },
                    validator: (String? value) {
                      if (value!.length < 6) {
                        return 'Şifre en az 6 karakter olmalı!';
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                  )
                ],
              ),
            )),
        ElevatedButton(
            onPressed: () {
              formSubmit();
            },
            child: Text('dokun')),
      ],
    ));
  }
}
