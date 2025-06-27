import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_practice/signin_signup_provider.dart';

class Submit extends StatelessWidget {
  const Submit({super.key});

  @override
  Widget build(BuildContext context) {
    SigninProvider provider= context.watch<SigninProvider>();
    return Positioned(
        top: provider.isSignUp? 430:400,
        right: 0,
        left: 0,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: GestureDetector(
              onTap: (){
                provider.tryValidation();
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.orange, Colors.red],//그라데이션, 여러 색 가능
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 5,
                          offset: Offset(0,5)
                      )
                    ]
                ),
                child: Icon(Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }
}
