import 'package:flutter/material.dart';

class UserImageAndBackroundProfile extends StatefulWidget {
  const UserImageAndBackroundProfile({
    super.key,
  });

  @override
  State<UserImageAndBackroundProfile> createState() =>
      _UserImageAndBackroundProfileState();
}

class _UserImageAndBackroundProfileState
    extends State<UserImageAndBackroundProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomLeft,
      children: [
        // ? Background Image
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/cafe.jpg"))),
        ),

        // ? Back and Settings
        Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () => print("Arrow Back and Back"),
                child: Container(
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              InkWell(
                onTap: () => print("Settings"),
                child: Image.asset(
                  "assets/images/settings.png",
                  width: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // ? Profile Image and Camera
        const Stack(alignment: Alignment.bottomRight, children: [
          Padding(
            padding: EdgeInsets.only(top: 128, left: 120),
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage("assets/images/christ.jpg"),
              ),
            ),
          ),
          CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ))),
        ]),

        // ? Camera
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 120),
          child: Container(
            height: 60,
            width: 40,
            // color: Colors.red,
            child: const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ))),
          ),
        ),
      ],
    );
  }
}
