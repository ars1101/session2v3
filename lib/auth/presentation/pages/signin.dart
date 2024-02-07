import 'package:flutter/material.dart';
import 'package:session2v3/auth/presentation/widgets/customtextinput.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart';
import 'package:session2v3/run.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailctr = TextEditingController();
  TextEditingController passctr = TextEditingController();
  bool check = false;
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    bool isValid() {
      if (
      (passctr.text.length >= 6) &
      (emailctr.text.length != 0) &
      (check == true)) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
        body: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 76,
                    ),
                    Text(
                      'Welcome back',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Fill in your email and password to continue',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        height: 77,
                        child: CustomTextField(
                          onChange: (str){ setState(() {

                          });},
                            label: "Email Adress",
                            hint: "***********@mail.com",
                            controller: emailctr)),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        height: 77,
                        child: CustomTextField(
                          onChange: (str){ setState(() {

                          });},
                          label: "Password",
                          hint: "*********",
                          controller: passctr,
                          isObscure: obs,
                          onTapSuffix: () {
                            print(obs);
                            setState(() {
                              if (obs == true) {
                                obs = false;
                              } else {
                                obs = true;
                              }
                            });
                          },
                        )),

                    SizedBox(
                      height: 37,
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width-48, height: 30,child:
                    Row(children: [

                      Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check = value!;
                            });
                          }),
                      Text("Remember password", style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 167, 167, 167)),),
                      SizedBox(width: 48,),
                      Text("Forgot password", style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 5, 96, 250)))],),),
                    SizedBox(
                      height: 64,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        height: 46,
                        child: FilledButton(
                            onPressed: isValid() ? () async {var  res = await supabase.auth.signUp(email: emailctr.text, password: passctr.text  );
                            final Session? session = res.session;
                            final User user = res.user!;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => home(title: '')))
                            } : null,
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color.fromARGB(255, 167, 167, 167)),
                          ),
                          GestureDetector(
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 5, 96, 250)),
                            ),
                            onTap: () {},
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 48,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Or sign in with',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 167, 167, 167)),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Image.asset('assets/google.png')
                              ],
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
                SizedBox(
                  width: 24,
                )
              ],
            )
          ],
        ));
  }
}
