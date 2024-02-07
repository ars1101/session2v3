import 'package:flutter/material.dart';
import 'package:session2v3/auth/presentation/widgets/customtextinput.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:session2v3/auth/presentation/pages/signin.dart';
import 'package:session2v3/run.dart';
import 'home.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController namectr = TextEditingController();
  TextEditingController emailctr = TextEditingController();
  TextEditingController phonectr = TextEditingController();
  TextEditingController passctr = TextEditingController();
  TextEditingController passcctr = TextEditingController();
  bool check = false;
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    bool isValid() {
      if ((passcctr.text == passctr.text) &
          (passctr.text.length >= 6) &
          (namectr.text.length != 0) &
          (phonectr.text.length != 0) &
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
                  'Create an account',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Complete the sign up process to get started',
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
                        label: "Full name",
                        hint: "Ivanov Ivan",
                        controller: namectr)),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    height: 77,
                    child: CustomTextField(
                      label: "phone number",
                      hint: "+9(999)999-99-99",
                      controller: phonectr,
                      formatter: MaskTextInputFormatter(
                          mask: '+#(###)###-##-##',
                          filter: ({'#': RegExp(r'[0-9]')})),
                    )),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    height: 77,
                    child: CustomTextField(
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
                  height: 24,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    height: 77,
                    child: CustomTextField(
                      label: "Confirm Password",
                      hint: "*********",
                      controller: passcctr,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  height: 30,
                  child: Row(
                    children: [
                      Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check = value!;
                            });
                          }),
                      SizedBox(
                        width: 271,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "By ticking this box, you agree to our ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 167, 167, 167)),
                                children: [
                                  TextSpan(
                                      text:
                                          'Terms and conditions and private policy',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 235, 188, 46)))
                                ])),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 64,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    height: 46,
                    child: FilledButton(
                        onPressed: isValid()
                            ? () async {
                                var res = await supabase.auth.signUp(
                                    email: emailctr.text,
                                    password: passctr.text);
                                final Session? session = res.session;
                                final User user = res.user!;
                                await supabase.from('profiles').insert({
                                  'id_user': user.id,
                                  'phone': user.phone,
                                  'fullname': namectr.text,
                                  'avatar': ''
                                }).then((value) => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  home(title: '')))
                                    });
                              }
                            : null,
                        child: Text(
                          'Sign up',
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
                          'Sign in',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromARGB(255, 5, 96, 250)),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignIn()));
                        },
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
                              'Or sign up with',
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
