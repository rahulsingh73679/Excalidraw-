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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0), // Set your desired height
        child: AppBar(
          title: Text(""),
          backgroundColor: Colors.transparent,
          elevation: 0, // Removes the shadow
        ),
      ),
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

  // Rest of the code remains unchanged
}




class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInternetConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.data == false) {
          // No internet connection
          return Container(
            color: Colors.white,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/no.png', // Replace with the path to your image asset
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Trigger the website reload when the button is pressed
                      _tryReloadWebsite(context);
                    },
                    child: Text("Try Again"),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Internet connection is available or connection state is not yet complete
          return SizedBox.shrink();
        }
      },
    );
  }

  Future<bool> checkInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }

  void _tryReloadWebsite(BuildContext context) {
    // You can add logic here to reload the website
    // For example, you might want to use a key to access the WebView and trigger a reload
    // webViewKey.currentState.reload();
    // or use Navigator.pushReplacement to reload the entire page
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}

