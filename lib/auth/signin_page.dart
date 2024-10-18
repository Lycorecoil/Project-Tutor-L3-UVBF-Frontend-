/*import 'package:driver/methodes/associate_methods.dart';
import 'package:flutter/material.dart';
import 'package:driver/auth/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
@override
  State<StatefulWidget> createState() {
   
    return _SignInPageState();
  }
  }


class _SignInPageState extends State<SignInPage> {
  // controleur champ
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  
  validateSignInForm(){if(!emailtextEditingController.text.contains("@")){
      AssociateMethods.showSnackBarMsg("email non valid", context);
  }else if(!passwordtextEditingController.text.trim().length<5){
    AssociateMethods.showSnackBarMsg("password trop court", context);}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 122),
              Image.asset(
                "assets/signin.webp",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Login as User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(children: [
//Email textfield
                    TextField(
                      controller: emailtextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "user email",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
//Space
                    const SizedBox(height: 22),
//Password textfield
                    TextField(
                      controller: passwordtextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "user password",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

//Space
                    const SizedBox(height: 22),
//Button login

                    ElevatedButton(
                      onPressed: () {
                        validateSignInForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ])),
              const SizedBox(height: 12),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const SignUpPage()));
                  },
                  child: const Text(
                    "Don't have an acoount? SignUp here",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}}*/
/*import 'package:driver/global.dart';
import 'package:driver/widgets/loding_dialog.dart';
import 'package:driver/pages.dart/home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:driver/methodes/associate_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver/auth/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  // Contrôleurs de champ
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

  // Validation du formulaire de connexion
  void validateSignInForm() {
    if (!emailtextEditingController.text.contains("@")) {
      AssociateMethods.showSnackBarMsg("Email non valide", context);
    } else if (passwordtextEditingController.text.trim().length < 5) {
      // Correction de la condition ici
      AssociateMethods.showSnackBarMsg(
          "Le mot de passe est trop court", context);
    } else {
      signInUserNow(); // Appel à la méthode pour se connecter si la validation passe
    }
  }

  void signInUserNow() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => const LoadingDialog(
        messageTxt: "Patience...",
      ),
    );
    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailtextEditingController.text.trim(),
                  password: passwordtextEditingController.text.trim())
              .catchError((onError) {
        Navigator.pop(context);
        associateMethods.showSnackBarMsg(onError.toString(), context);
      }))
          .user;

      if (firebaseUser != null) {
        DatabaseReference ref = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(firebaseUser.uid);
        await ref.once().then((dataSnapshot) {
          if (dataSnapshot.snapshot.value != null) {
            if ((dataSnapshot.snapshot.value as Map)["blockStatus"] == 'no') {
              userName = (dataSnapshot.snapshot.value as Map)["name"];
              userPhone = (dataSnapshot.snapshot.value as Map)["phone"];

              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const HomePage()));
            } else {
              FirebaseAuth.instance.signOut();
              associateMethods.showSnackBarMsg("Contact l'admin JB", context);
            }
          }
          else{
            FirebaseAuth.instance.signOut();
            associateMethods.showSnackBarMsg("Vous n'etes pas  enregistrer Creer un compte", context);
          }
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 122),
              Image.asset(
                "assets/signin.webp",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Login as User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(children: [
                  // Email textfield
                  TextField(
                    controller: emailtextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "User Email",
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  // Space
                  const SizedBox(height: 22),
                  // Password textfield
                  TextField(
                    controller: passwordtextEditingController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: "User Password",
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  // Space
                  const SizedBox(height: 22),
                  // Button login
                  ElevatedButton(
                    onPressed: () {
                      validateSignInForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const SignUpPage()),
                  );
                },
                child: const Text(
                  "Don't have an account? SignUp here",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
}*/

import 'package:users_indriver_app/global.dart';
import 'package:users_indriver_app/widgets/loding_dialog.dart';
import 'package:users_indriver/pages.dart/home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:users_indriver_app/methodes/associate_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_indriver_app/auth/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}




class _SignInPageState extends State<SignInPage> {
  // Contrôleurs de champ
  final TextEditingController emailtextEditingController =
      TextEditingController();
  final TextEditingController passwordtextEditingController =
      TextEditingController();

  // Validation du formulaire de connexion
  void validateSignInForm() {
    if (!emailtextEditingController.text.contains("@")) {
      AssociateMethods.showSnackBarMsg("Email non valide", context);
    } else if (passwordtextEditingController.text.trim().length < 5) {
      AssociateMethods.showSnackBarMsg(
          "Le mot de passe est trop court", context);
    } else {
      signInUserNow(); // Appel à la méthode pour se connecter si la validation passe
    }
  }

  void signInUserNow() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => const LoadingDialog(
        messageTxt: "Patience...",
      ),
    );

    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
        email: emailtextEditingController.text.trim(),
        password: passwordtextEditingController.text.trim(),
      )
              .catchError((onError) {
        Navigator.pop(context);
        AssociateMethods.showSnackBarMsg(onError.toString(), context);
      }))
          .user;

      if (firebaseUser != null) {
        DatabaseReference ref = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(firebaseUser.uid);
        await ref.once().then((dataSnapshot) {
          if (dataSnapshot.snapshot.value != null) {
            if ((dataSnapshot.snapshot.value as Map)["blockStatus"] == 'no') {
              userName = (dataSnapshot.snapshot.value as Map)["name"];
              userPhone = (dataSnapshot.snapshot.value as Map)["phone"];

              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const HomePage()));
              AssociateMethods.showSnackBarMsg('logging succefully', context);
            } else {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
              AssociateMethods.showSnackBarMsg("Contactez l'admin JB", context);
            }
          } else {
            FirebaseAuth.instance.signOut();
            AssociateMethods.showSnackBarMsg(
                "Vous n'êtes pas enregistré. Créez un compte.", context);
          }
        });
      }
    } catch (e) {
      Navigator.pop(context);
      AssociateMethods.showSnackBarMsg("Erreur : $e", context);
    }
    Navigator.pop(context);
    AssociateMethods.showSnackBarMsg("Logger avec succes", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 122),
              Image.asset(
                "assets/signin.webp",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Login as User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(children: [
                  // Email textfield
                  TextField(
                    controller: emailtextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "User Email",
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  // Space
                  const SizedBox(height: 22),
                  // Password textfield
                  TextField(
                    controller: passwordtextEditingController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: "User Password",
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  // Space
                  const SizedBox(height: 22),
                  // Button login
                  ElevatedButton(
                    onPressed: () {
                      validateSignInForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const SignUpPage()),
                  );
                },
                child: const Text(
                  "Don't have an account? SignUp here",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
