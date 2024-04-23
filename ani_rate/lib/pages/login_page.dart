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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 240, 0, 1)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    //signin
                    MyButton(
                      onTap: signUserIn,
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
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 118, 14),
                              fontWeight: FontWeight.bold),
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



//bugs
 //add border inside continue width
// change the text insidt the rext filed to someting else