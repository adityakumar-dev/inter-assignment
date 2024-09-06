import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_assignment/Screens/Image_Post/image_post_screen.dart';
import 'package:intern_assignment/Screens/Text_Post/text_post_screen.dart';
import 'package:intern_assignment/Screens/Video_Post/video_post_screen.dart';
import 'package:intern_assignment/services/Auth/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetWidget();
  }
}

class GetWidget extends StatefulWidget {
  const GetWidget({super.key});

  @override
  State<GetWidget> createState() => _GetWidgetState();
}

class _GetWidgetState extends State<GetWidget> {
  String appBarText = "Text Posts";
  int currentIndex = 0;

  // Update appBarText and return the appropriate screen based on currentIndex
  Widget getPostScreen() {
    switch (currentIndex) {
      case 0:
        return const TextPostScreen();
      case 1:
        return const VideoPostScreen();
      case 2:
        return const ImagePostScreen();
      default:
        return const Center(child: Text("Widget Not found"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.push('/text');
            },
            icon: Icon(Icons.post_add)),
        title: Text(
          appBarText,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Authservice().logoutUser(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: getPostScreen(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
            // Update appBarText based on selected index
            switch (value) {
              case 0:
                appBarText = "Text Posts";
                break;
              case 1:
                appBarText = "Video Posts";
                break;
              case 2:
                appBarText = "Image Posts";
                break;
              default:
                appBarText = "Error!";
            }
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Text"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_chat_outlined), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: "Image"),
        ],
      ),
    );
  }
}
