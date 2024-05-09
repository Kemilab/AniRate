import 'package:ani_rate/components/my_button.dart';
import 'package:ani_rate/components/my_textfield.dart';
import 'package:ani_rate/components/square_tile.dart';
import 'package:ani_rate/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //sign in the user up
  void signUserUp() async {
    showDialog(
        //login circle
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //try creating the user
    try {
      // chech if the password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        //show error message, password don't match
        showErrorMessage("Passwords don't match!");
      }
      print("User logged in");
      if (mounted) {
        Navigator.pop(context); // pop the navigation circle
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      if (mounted) {
        Navigator.pop(context); // pop the navigation circle
      }
      switch (e.code) {
        case "invalid-email":
          showErrorMessage("Your email address appears to be malformed");
          break;
        case "invalid-credential":
          showErrorMessage("Your email or password is wrong");
          break;
        case "weak-password":
          showErrorMessage("Your password should be at least 6 characters");
          break;
        case "email-already-in-use":
          showErrorMessage(
              "The email address is already in use by another account");
          break;
        default:
          showErrorMessage("Provide your credentials");
          if (mounted) {
            Navigator.pop(context); // pop the navigation circle
          }
      }
    }
  }

  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 161, 22, 22),
          title: Center(
            child: Text(
              textAlign: TextAlign.center,
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(104, 0, 0, 0), BlendMode.overlay))),
          child: SizedBox(
            height: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    //logo
                    /* SvgPicture.asset(
                        "assets/logo.svg",
                        width: 100,
                        height: 100,
                      ),*/
                    const SizedBox(height: 0),
                    //Title

                    /* const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 140.0),
                      child: Image(image: AssetImage("assets/logo.png")),
                    ),*/

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Image(image: AssetImage("assets/title.png")),
                    ),

                    const SizedBox(height: 1),

                    //email
                    MyTextFiled(
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),

                    const SizedBox(height: 10),

                    //password
                    MyTextFiled(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    //confirm password
                    MyTextFiled(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 25),

                    //signUp
                    MyButton(
                      text: "Sign Up",
                      onTap: signUserUp,
                    ),

                    const SizedBox(height: 25),

                    // or continu with
                    /* Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 5.5,
                                color: Colors.grey[500],
                              ),
                            ),
                           const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Continue with",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 115, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 5.5,
                                color: Color.fromARGB(255, 138, 138, 138),
                              ),
                            ),
                          ],
                        ),
                      ),*/

                    const SizedBox(height: 20),

                    //google + apple
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //google
                        SquareTile(
                          imagePath: "assets/google.png",
                          onTap: () => AuthServices().signInWithGoogle(),
                        ),

                        const SizedBox(width: 10),

                        //apple
                        SquareTile(
                          imagePath: "assets/apple.png",
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //not a member
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a member?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 118, 14),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Login now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



//bugs
 //add border inside continue width
// change the text insidt the rext filed to someting else
// if no password is eterd app crashes
// random black screen when loging in or on a wrom cred.