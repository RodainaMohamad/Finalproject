import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/wavyAppBar.dart';

class CreateAccountScreen extends StatefulWidget {

  static const String routeName = 'CreateAccountScreen';

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  int currentIndex = 0;
  bool showThankYou = false;

  void switchContent() {
    setState(() {
      currentIndex = 1;
    });
  }

  void showThankYouScreen() {
    setState(() {
      showThankYou = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primary,
      body: Column(
        children: [
          Wavyappbar(),
          Expanded(
            child: showThankYou
                ? buildThankYouScreen()
                : IndexedStack(
                    index: currentIndex,
                    children: [
                      buildFirstScreen(),
                      buildSecondScreen(),
                    ],
                  ),
          ),
          if (!showThankYou)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    height: 8.0,
                    width: currentIndex == index ? 16.0 : 8.0,
                    decoration: BoxDecoration(
                      color: currentIndex == index ? secondary : Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  );
                }),
              ),
            ),
          ClipPath(
            clipper: WaveClipperTwo(reverse: true),
            child: Container(
              height: 100,
              color: secondary,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (currentIndex > 0 && !showThankYou) {
                        setState(() {
                          currentIndex = 0;
                        });
                      }
                    },
                    backgroundColor: primary,
                    foregroundColor: secondary,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/backArrow.png",
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {Navigator.pop(context);},
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFirstScreen() {
    return Container(
      color: primary,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: secondary,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'G-mail , Phone number',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'User name',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Re-type Password',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: switchContent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSecondScreen() {
    return Container(
      color: primary,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: secondary,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Gender',
                      style: TextStyle(color:secondary, fontSize: 16),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondary,
                            foregroundColor: Colors.teal,
                            shape: const CircleBorder(),
                          ),
                          child: const Text('M'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondary,
                            foregroundColor: Colors.teal,
                            shape: const CircleBorder(),
                          ),
                          child: const Text('F'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'National ID',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Guardian Number',
                    labelStyle: const TextStyle(color: Colors.teal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: secondary,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showThankYouScreen();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildThankYouScreen() {
    return Container(
      color: primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: secondary,
              size: 100,
            ),
            const SizedBox(height: 20),
             Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ),
            const SizedBox(height: 10),
             Text(
              'Your account has been successfully created.',
              style: TextStyle(
                fontSize: 18,
                color: secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}