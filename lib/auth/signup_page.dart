import 'package:users_indriver_app/global.dart';
import 'package:users_indriver_app/methodes/associate_methods.dart';
import 'package:users_indriver_app/pages.dart/home_page.dart';
import 'package:users_indriver_app/widgets/loding_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_indriver_app/auth/signin_page.dart';
//import 'package:users_indriver_app/auth/signup_page.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController userNametextEditingController = TextEditingController();
  TextEditingController userPhonetextEditingController =
      TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

  void validateSignUpForm() {
    if (userNametextEditingController.text.trim().length < 3) {
      AssociateMethods.showSnackBarMsg(
          'Le nom dois faire plus de 3 caracteres', context);

    } else if (userPhonetextEditingController.text.trim().length < 8) {
      AssociateMethods.showSnackBarMsg('ex:70 00 00 00', context);

    } else if (passwordtextEditingController.text.trim().length < 6) {
      AssociateMethods.showSnackBarMsg(
          'Plus de 6 caractere, toi meme tu sais nombre, minuscule, majuscule charactere spe',
          context);

    } else if (!emailtextEditingController.text.contains('@')) {
      AssociateMethods.showSnackBarMsg('mail valid stp', context);

    } else {
      signUserNow();
    }
  }

  signUserNow() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => const LoadingDialog(
        messageTxt: "Patience...",
      ),
    );
    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailtextEditingController.text.trim(),
                  password: passwordtextEditingController.text.trim())
              .catchError((onError) {
        Navigator.pop(context);
        AssociateMethods.showSnackBarMsg(onError.toString(), context);
      }))
          .user;

      Map userDataMap = {
        "name": userNametextEditingController,
        "email": emailtextEditingController,
        "phone": userPhonetextEditingController,
        "id": firebaseUser!.uid,
        "blockStatus": "no",
      };
      FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(firebaseUser.uid)
          .set(userDataMap);
      Navigator.pop(context);
      AssociateMethods.showSnackBarMsg("compte creer avec succes", context);
    } on FirebaseAuthException catch (e) {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      AssociateMethods.showSnackBarMsg(e.toString(), context);
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const HomePage()));
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
                "assets/signup.webp",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Register New Account',
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
                      controller: userNametextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "user name",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
//Space
                    const SizedBox(height: 22),

                    TextField(
                      controller: userPhonetextEditingController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "user phone",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

//Space
                    const SizedBox(height: 22),

                    TextField(
                      controller: emailtextEditingController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "user mail",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

//Space
                    const SizedBox(height: 22),
//Password textfield
                    TextField(
                      controller: passwordtextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
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
                        validateSignUpForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                      ),
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ])),
              const SizedBox(height: 12),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const SignInPage()));
                  },
                  child: const Text(
                    "Already have an acoount? login here",
                    style: TextStyle(color: Colors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


/*import 'package:driver/global.dart';
import 'package:driver/methodes/associate_methods.dart';
import 'package:driver/widgets/loding_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver/auth/signin_page.dart';
import 'package:driver/auth/signup_page.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController userNametextEditingController = TextEditingController();
  TextEditingController userPhonetextEditingController =
      TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

  void validateSignUpForm() {
    if (userNametextEditingController.text.trim().length < 3) {
      associateMethods.showSnackBarMsg(
          'Le nom doit faire plus de 3 caractères', context);
    } else if (userPhonetextEditingController.text.trim().length < 8) {
      associateMethods.showSnackBarMsg('ex:70 00 00 00', context);
    } else if (passwordtextEditingController.text.trim().length < 6) {
      associateMethods.showSnackBarMsg(
          'Plus de 6 caractères, utilise majuscule, minuscule, nombre, et caractère spécial',
          context);
    } else if (!emailtextEditingController.text.contains('@')) {
      associateMethods.showSnackBarMsg('Entrez un mail valide', context);
    } else {
      signUserNow();
    }
  }

  signUserNow() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => const LoadingDialog(
        messageTxt: "Patience...",
      ),
    );
    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailtextEditingController.text.trim(),
                  password: passwordtextEditingController.text.trim())
              .catchError((onError) {
        Navigator.pop(context);
        associateMethods.showSnackBarMsg(onError.toString(), context);
      }))
          .user;

      if (firebaseUser != null) {
        Map<String, String> userDataMap = {
          "name": userNametextEditingController.text.trim(),
          "email": emailtextEditingController.text.trim(),
          "phone": userPhonetextEditingController.text.trim(),
          "id": firebaseUser.uid,
          "blockStatus": "no",
        };

        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("users");
        userRef.child(firebaseUser.uid).set(userDataMap);

        Navigator.pop(context); // Fermer le dialogue de chargement après succès
        associateMethods.showSnackBarMsg("Compte créé avec succès", context);

        // Rediriger l'utilisateur vers la page de connexion
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const SignInPage()));
      }
    } on FirebaseAuthException catch (e) {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      associateMethods.showSnackBarMsg(e.toString(), context);
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
                "assets/signup.webp",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Register New Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    // Nom d'utilisateur
                    TextField(
                      controller: userNametextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "Nom d'utilisateur",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Téléphone
                    TextField(
                      controller: userPhonetextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Numéro de téléphone",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Email
                    TextField(
                      controller: emailtextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Mot de passe
                    TextField(
                      controller: passwordtextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Bouton d'inscription
                    ElevatedButton(
                      onPressed: () {
                        validateSignUpForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                      ),
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Lien vers la page de connexion
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const SignInPage()));
                },
                child: const Text(
                  "Already have an account? Login here",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

/*import 'package:driver/global.dart';
import 'package:driver/methodes/associate_methods.dart';
import 'package:driver/widgets/loding_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver/auth/signin_page.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController userNametextEditingController = TextEditingController();
  TextEditingController userPhonetextEditingController =
      TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

  void validateSignUpForm() {
    if (userNametextEditingController.text.trim().length < 3) {
      associateMethods.showSnackBarMsg(
          'Le nom doit faire plus de 3 caractères', context);
    } else if (userPhonetextEditingController.text.trim().length < 8) {
      associateMethods.showSnackBarMsg('ex:70 00 00 00', context);
    } else if (passwordtextEditingController.text.trim().length < 6) {
      associateMethods.showSnackBarMsg(
          'Plus de 6 caractères, utilise majuscule, minuscule, nombre, et caractère spécial',
          context);
    } else if (!emailtextEditingController.text.contains('@')) {
      associateMethods.showSnackBarMsg('Entrez un mail valide', context);
    } else {
      signUserNow();
    }
  }

  signUserNow() async {
    // Affichage du dialogue de chargement
    showDialog(
      context: context,
      builder: (BuildContext context) => LoadingDialog(
        messageTxt: "Patience...",
      ),
    );

    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailtextEditingController.text.trim(),
                  password: passwordtextEditingController.text.trim())
              .catchError((onError) {
        if (mounted) {
          Navigator.pop(context); // Fermer le dialogue en cas d'erreur
          associateMethods.showSnackBarMsg(onError.toString(), context);
        }
      }))
          .user;

      if (firebaseUser != null) {
        Map<String, String> userDataMap = {
          "name": userNametextEditingController.text.trim(),
          "email": emailtextEditingController.text.trim(),
          "phone": userPhonetextEditingController.text.trim(),
          "id": firebaseUser.uid,
          "blockStatus": "no",
        };

        // Enregistrement dans la base de données Firebase
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child("users");
        await userRef.child(firebaseUser.uid).set(userDataMap);

        if (mounted) {
          Navigator.pop(context); // Fermer le dialogue après succès
          associateMethods.showSnackBarMsg("Compte créé avec succès", context);

          // Redirection vers la page de connexion après succès
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const SignInPage()));
        }
      }
    } on FirebaseAuthException catch (e) {
      FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pop(context); // Fermer le dialogue en cas d'erreur
        associateMethods.showSnackBarMsg(e.toString(), context);
      }
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
                "assets/signup.webp",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const SizedBox(height: 12),
              const Text(
                'Register New Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    // Nom d'utilisateur
                    TextField(
                      controller: userNametextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "Nom d'utilisateur",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Téléphone
                    TextField(
                      controller: userPhonetextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Numéro de téléphone",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Email
                    TextField(
                      controller: emailtextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Mot de passe
                    TextField(
                      controller: passwordtextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Bouton d'inscription
                    ElevatedButton(
                      onPressed: () {
                        validateSignUpForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                      ),
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Lien vers la page de connexion
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const SignInPage()));
                },
                child: const Text(
                  "Already have an account? Login here",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
