import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'package:simple_gradient_text/simple_gradient_text.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  final TextEditingController name1Controller = TextEditingController();
  final TextEditingController name2Controller = TextEditingController();
  String result = "";
  String resultImage = "";

  void calculate() {
    String name1 = name1Controller.text.toLowerCase().replaceAll(' ', '');
    String name2 = name2Controller.text.toLowerCase().replaceAll(' ', '');
    int count = 0;

    if (name1.isEmpty || name2.isEmpty) {
      result = "Please enter your names";
      resultImage = "";
      setState(() {});
      return;
    }

    // Cancelling out common letters
    for (int i = 0; i < name1.length; i++) {
      for (int j = 0; j < name2.length; j++) {
        if (name1[i] == name2[j]) {
          name1 = name1.replaceFirst(name1[i], "");
          name2 = name2.replaceFirst(name2[j], "");
          i--;
          break;
        }
      }
    }

    // Counting remaining letters
    count = name1.length + name2.length;

    // Cancelling letters in FLAMES based on count
    String flames = "FLAMES";
    while (flames.length > 1) {
      int index = count % flames.length;
      if (index > 0) {
        flames = flames.substring(index) + flames.substring(0, index - 1);
      } else {
        flames = flames.substring(0, flames.length - 1);
      }
    }

    // Determining result based on remaining letters in FLAMES
    switch (flames) {
      case "F":
        result = "Friends";
        resultImage = 'assests/images/a40412c591c279df8e1d8ab180f7a442.jpg';
        break;
      case "L":
        result = "Lovers";
        resultImage = 'assests/images/d497798fb6ce193e0b065bf4a349ce55--art-girl-sweet-girls.jpg';
        break;
      case "A":
        result = "Affectionate";
        resultImage = 'assests/images/images (1).jpeg';
        break;
      case "M":
        result = "Marriage";
        resultImage = 'assests/images/images.png';
        break;
      case "E":
        result = "Enemies";
        resultImage = 'assests/images/business-woman-being-kicked-businessman-eps-120791536.jpg';
        break;
      case "S":
        result = "Siblings";
        resultImage = 'assests/images/istockphoto-500612462-612x612.jpg';
        break;
      default:
        result = "Invalid input";
        break;
    }

    setState(() {});
  }

  void clearTextFields() {
    name1Controller.clear();
    name2Controller.clear();
    result = "";
    resultImage = "";
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.black,Colors.brown,],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       ),
      //     ),
      //   ),
      //   //backgroundColor: Colors.black38,
      //   title: Center(child: Text("Flames bro!",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),)),
      // ),
      backgroundColor: Colors.brown,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2.value + .100),
                  left: size.width * .15,
                  child:  Column(
                    children: [
                      GradientText(
                        "Flames bro!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize:50.0, shadows: [ Shadow( blurRadius: 10.0, color: Colors. brown, offset: Offset(5.0, 5.0), ), ],
                        ),
                        colors: [
                          Colors.brown,
                          Colors.white,
                          Colors.white,
                        ],
                      ),
                    ],
                  ), ),
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(100),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .7,
                  left: size.width * (animation2.value + .6),
                  child: CustomPaint(
                    painter: MyPainter(35),
                  ),
                ),
                Positioned(
                  top: size.height * animation3.value,
                  left: size.width * (animation1.value + .3),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black12,Colors.grey,],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 57,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.brown.withOpacity(0.9),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(9, 9), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Image.asset('assests/images/Attitude_boy_dp_-2635.jpg'),
                            ),
                            Container(
                              width: 300,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.brown.withOpacity(0.9),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(9, 9),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold// Set the desired text color here
                                  ),
                                  cursorColor: Colors.white,
                                  controller: name1Controller,
                                  decoration: InputDecoration(
                                    hintText: "King's Name",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    filled: true,
                                    fillColor: Colors.black45,
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 57,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.brown.withOpacity(0.9),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(9, 9), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Image.asset('assests/images/Attitude_girl_dp_-3017.jpg',)),
                            Container(
                              width: 300,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.brown.withOpacity(0.9),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(9, 9),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold// Set the desired text color here
                                  ),
                                  cursorColor: Colors.white,
                                  controller: name2Controller,
                                  decoration: InputDecoration(
                                    hintText: "Queen's Name",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    filled: true,
                                    fillColor: Colors.black45,

                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 150,
                              child:ElevatedButton(
                                child: Text("Clear"),
                                onPressed: clearTextFields,
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Colors.brown),
                                  shadowColor: MaterialStateProperty.all(Colors.white.withOpacity(1)), // make the shadow color darker
                                  elevation: MaterialStateProperty.all(8), // increase the elevation to make the shadow more visible
                                  overlayColor: MaterialStateProperty.all(Colors.black45),
                                ),
                              ),

                            ),
                            Container(
                              width: 150,
                              child: ElevatedButton(
                                child: Text("Calculate"),
                                onPressed: calculate,
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),side: MaterialStateProperty.all(
                                  const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                  backgroundColor: MaterialStateProperty.all(Colors.brown),
                                  shadowColor: MaterialStateProperty.all(Colors.white.withOpacity(1)), // make the shadow color darker
                                  elevation: MaterialStateProperty.all(8), // increase the elevation to make the shadow more visible
                                  overlayColor: MaterialStateProperty.all(Colors.black45),),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),
                        resultImage.isNotEmpty
                            ? Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Image.asset(
                            resultImage,
                            fit: BoxFit.cover,
                          ),
                        )

                            : Container(),
                        SizedBox(height: 20.0),
                        GradientText(
                          result,
                          style: TextStyle(
                            fontSize: 20.0, shadows: [ Shadow( blurRadius: 10.0, color: Colors. black, offset: Offset(5.0, 5.0), ), ],
                          ),
                          colors: [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("ft.manmadhan\nVersion:Corrected machi",style: TextStyle(color: Colors.brown),),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
            isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
              TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
          colors: [Colors.black12,Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}