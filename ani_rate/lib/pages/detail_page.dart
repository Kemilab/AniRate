import 'package:ani_rate/models/detail_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<DetailModel> details = [];

  void _getDetails() {
    details = DetailModel.getDetails();
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        details[index].imagepath,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.0), // Add spacing between image and title
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0), // Add left padding to the title
                        child: Text(
                          details[index].title,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 119, 29),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
