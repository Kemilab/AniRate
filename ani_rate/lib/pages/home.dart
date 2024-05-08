import 'package:ani_rate/models/category_model.dart';
import 'package:ani_rate/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final TextEditingController searchController = TextEditingController();

  List<CategoryModel> categories = [];

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  @override
  void initState() {
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Top ratings',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 119, 29),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: 250,
                  child: ListView.separated(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                          width: 166,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect( // Wrap the image with ClipRRect
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  categories[index].coverPath,
                                  width: 200, // Adjust width if needed
                                  height: 250, // Adjust height if needed
                                  fit: BoxFit.cover,
                                ),
                                 
                              ),
                            ],
                          ));
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search anime...',
          hintStyle: TextStyle(color: Color.fromARGB(255, 255, 119, 29)),
          prefixIcon: Icon(Icons.search),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            borderSide: BorderSide(
              color: Color.fromARGB(
                  255, 255, 119, 29), // Adjust border color as desired
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            borderSide: BorderSide(
              color: Colors.blue, // Adjust border color for focus state
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      leading: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          child: Image.asset(
            'assets/logo.png',
            height: 50,
            width: 50,
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromRGBO(35, 35, 35, 1),
            borderRadius: BorderRadius.circular(10)),
      ),
      actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
      ],
    );
  }
}
