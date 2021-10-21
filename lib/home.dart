import 'package:flutter/material.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showAlert(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.red,
              child: Center(
                child: Text(
                  "ALERTA",
                  key: Key('TextAlert'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
      body: Container(
          child: Column(
        children: [
          Text(
            'Hello World',
            key: Key('textHello'),
          ),
          ElevatedButton(
            key: Key('ButtonHome'),
            onPressed: () => showAlert(context),
            child: Text("Button Home"),
          )
        ],
      )),
    );
  }
}
