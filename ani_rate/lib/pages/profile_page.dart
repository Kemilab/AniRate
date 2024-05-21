import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool resetPasswordSuccess = false;
  String profileImageUrl = "https://www.woolha.com/media/2020/03/eevee.png";

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      profileImageUrl = prefs.getString('profileImageUrl') ?? profileImageUrl;
    });
  }

  void resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: currentUser.email!);
    setState(() {
      resetPasswordSuccess = true;
    });
  }

  void deleteUser() async {
    await currentUser.delete();
    FirebaseAuth.instance.signOut();
  }

  void selectProfileImage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Profile Image'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300.0,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(imageUrls.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('profileImageUrl', imageUrls[index]);
                    setState(() {
                      profileImageUrl = imageUrls[index];
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.network(imageUrls[index]),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: Stack(
        children: [
          Positioned(
            top: 10.0,
            left: 0.0,
            right: 0.0,
            height: 18.0,
            child: Center(
              child: Text(
                "account".tr(),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: selectProfileImage,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(176, 63, 61, 61),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(profileImageUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            currentUser.email!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 211, 205, 205),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: resetPassword,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(176, 63, 61, 61),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "reset_password".tr(),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: resetPasswordSuccess
                                  ? const Color.fromARGB(255, 94, 255, 0)
                                  : const Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.setLocale(Locale('hr'));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(176, 63, 61, 61),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "change_language".tr(),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 8, 235, 178),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: deleteUser,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(176, 63, 61, 61),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "remove_account".tr(),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
const List<String> imageUrls = [
  "https://www.woolha.com/media/2020/03/eevee.png",
  "https://wrapime.com/wp-content/uploads/2024/04/one-piece-luffy-gear-five.png",
  "https://w7.pngwing.com/pngs/490/190/png-transparent-roronoa-zoro-goku-dragon-ball-z-itachi-uchiha-character-goku-television-face-manga-thumbnail.png",
  "https://image.pngaaa.com/917/2115917-middle.png",
  "https://i.pinimg.com/564x/93/49/87/93498730955ea119575b1af4cbe6827b.jpg",
  "https://w7.pngwing.com/pngs/560/93/png-transparent-a-o-t-wings-of-freedom-attack-on-titan-logo-eren-yeager-corps.png",
  "https://m.media-amazon.com/images/I/51s66WF9hjL.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2yCXpXJ66Mydkn32palBRezCPgYJ1NWuQxGW3k72dwA&s",
  "https://www.pngall.com/wp-content/uploads/13/Anime-Logo-PNG-Cutout.png",
  "https://m.media-amazon.com/images/I/71EafIm1NdL._AC_UF1000,1000_QL80_.jpg",
];
