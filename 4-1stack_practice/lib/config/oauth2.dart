import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_practice/signin_signup_provider.dart';

import 'palette.dart';

class Oauth2 extends StatelessWidget {
  const Oauth2({super.key});

  @override
  Widget build(BuildContext context) {
    SigninProvider provider= context.read<SigninProvider>();
    return Positioned(top: MediaQuery.of(context).size.height-250,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Text(provider.isSignUp? "or SignUP with": "or SignIn with"
          ),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: (){},
            label: Text("Google"),
            icon: Icon(Icons.add),
            style: TextButton.styleFrom(
                backgroundColor: Palette.googleColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          )
        ],
      ),
    );
  }
}
