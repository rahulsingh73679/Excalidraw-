import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Excalidraw")),
      body: Stack(
        children: [
          WebView(
            initialUrl: "https://indianscholar.in/",
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          NoInternetWidget(),
        ],
      ),
    );
  }
}



class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInternetConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == false) {
            // No internet connection
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "No Internet Connection",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          } else {
            // Internet connection is available
            return SizedBox.shrink();
          }
        } else {
          // Connection state is not yet complete
          return SizedBox.shrink();
        }
      },
    );
  }

  Future<bool> checkInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }
}





// Gaya College of Engineering   https://www.gcegaya.ac.in
// flutter build apk --build-name=1.0.1 --build-number=1

//  flutter pub get
 // flutter pub run flutter_launcher_icons:main


// for less size
// flutter build apk --target-platform=android-arm64        

// Gaya College of Engineering   https://www.gcegaya.ac.in
// flutter build apk --build-name=1.0.1 --build-number=1

//  flutter pub get
 // flutter pub run flutter_launcher_icons:main
