import 'package:fitsight_app/widgets/components/shared/app_bar_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:fitsight_app/widgets/components/auth/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: AppBarGradient(),
        title: Text(
          FlutterI18n.translate(
            context,
            "sign_up.app_bar.title",
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
