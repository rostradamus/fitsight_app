import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  )
);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Flutter layout demo'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Text(
                    "WOLOG",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    )
                  )
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[100]))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email address"
                            ),
                          )
                        )
                      ],
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
