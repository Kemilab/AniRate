import 'package:ani_rate/components/my_button.dart';
import 'package:ani_rate/components/my_textfield.dart';
import 'package:ani_rate/components/square_tile.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in the user

  void signUserIn() {}

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
                  colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.overlay))),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    //logo
                    /* SvgPicture.asset(
                      "assets/logo.svg",
                      width: 100,
                      height: 100,
                    ),*/
                    const SizedBox(height: 0),
                    //welcome back
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.0),
                      child: Image(image: AssetImage("assets/title.png")),
                    ),
                    const SizedBox(height: 20),

                    //username
                    MyTextFiled(
                      controller: usernameController,
                      hintText: "Username",
                      obscureText: false,
                    ),

                    const SizedBox(height: 20),

                    //password
                    MyTextFiled(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    //forgot
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    //signin
                    MyButton(
                      onTap: signUserIn,
                    ),

                    const SizedBox(height: 50),

                    // or continu with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[500],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Continue with",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Color.fromARGB(255, 126, 32, 32),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    //google + apple
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //google
                        SquareTile(imagePath: "assets/google.png"),

                        SizedBox(width: 10),

                        //apple
                        SquareTile(imagePath: "assets/apple.png"),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //not a member
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Register now",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
