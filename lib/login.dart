import 'package:oalarm/service/fetchdataUser.dart';
import 'package:oalarm/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oalarm/components/arrow_button.dart';
import 'package:oalarm/components/toggle_button.dart';
import 'package:oalarm/utils/viewport_size.dart';

import 'admin/tab_admin/list_pasien.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String greeting;

  bool isLoading = false;
  bool isLoginPasien = true;
  //
  // AnimationController _animationController;
  // LoginTheme day;
  // LoginTheme night;
  // Mode _activeMode = Mode.night;

  @override
  void initState() {
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(
    //     milliseconds: 1000,
    //   ),
    // );
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _animationController.forward(from: 0.0);
    // }); // wait for all the widget to render
    // initializeTheme(); //initializing theme for day and night

    initGreeting();
    super.initState();
  }



  adminLogin () {
    setState(() {
      isLoading = true;
    });
    FetchDataUser fetchData = FetchDataUser();
    fetchData.adminLogin(
        usernameController.text, passwordController.text)
        .then((value) {
      if (value) {
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => ListPasien()));
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  userLogin () {
    setState(() {
      isLoading = true;
    });
    FetchDataUser fetchData = FetchDataUser();
    fetchData.userLogin(
        usernameController.text, passwordController.text)
        .then((value) {
      if (value) {
        Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  initGreeting(){
    var hour = DateTime.now().hour;
      if (hour < 12) {
        setState(() {
          greeting = 'Selamat Pagi';
        });
      }
      if (hour >= 12 && hour < 18) {
        setState(() {
          greeting = 'Selamat Sore';
        });
      }
      else if(hour>=18){
        setState(() {
          greeting = 'Selamat Malam';
        });
      }
  }

  //
  //
  // @override
  // void didChangeDependencies() {
  //   cacheImages();
  //   super.didChangeDependencies();
  // }
  //
  // cacheImages() {
  //   CachedImages.imageAssets.forEach((asset) {
  //     precacheImage(asset, context);
  //   });
  // }
  //
  // initializeTheme() {
  //   var hour = DateTime.now().hour;
  //   String greeting;
  //   if (hour < 12) {
  //     setState(() {
  //       greeting = 'Selamat Pagi';
  //     });
  //   }
  //   if (hour >= 12 && hour < 18) {
  //     setState(() {
  //       greeting = 'Selamat Sore';
  //     });
  //   }
  //   else if(hour>=18){
  //     setState(() {
  //       greeting = 'Selamat Malam';
  //     });
  //   }
  //   day = LoginTheme(
  //     title: greeting,
  //     backgroundGradient: [
  //       const Color(0xFF8C2480),
  //       const Color(0xFFCE587D),
  //       const Color(0xFFFF9485),
  //       const Color(0xFFFF9D80),
  //       // const Color(0xFFFFBD73),
  //     ],
  //     landscape: CachedImages.imageAssets[0],
  //     circle: Sun(
  //       controller: _animationController,
  //     ),
  //     rays: SunRays(
  //       controller: _animationController,
  //     ),
  //   );
  //
  //   night = LoginTheme(
  //
  //     title: greeting,
  //     backgroundGradient: [
  //       const Color(0xFF0D1441),
  //       const Color(0xFF283584),
  //       const Color(0xFF6384B2),
  //       const Color(0xFF6486B7),
  //     ],
  //     landscape: CachedImages.imageAssets[1],
  //     circle: Moon(
  //       controller: _animationController,
  //     ),
  //     rays: MoonRays(
  //       controller: _animationController,
  //     ),
  //   );
  // }
  //

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ViewportSize.getSize(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff3e3a63),
      key: _scaffoldKey,
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: _activeMode == Mode.day
        //         ? day.backgroundGradient
        //         : night.backgroundGradient,
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
            clipper: CustomShapeClass(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  ToggleButton(
                    startText: 'Pasien Login',
                    endText: 'Admin Login',
                    tapCallback: (index) {
                      setState(() {
                        index == 0 ? isLoginPasien = true :isLoginPasien = false;
                      });
                    },
                  ),
                  buildText(
                    text: greeting,
                    padding: EdgeInsets.only(top: height * 0.04),
                    fontSize: width * 0.09,
                    fontFamily: 'YesevaOne',
                  ),
                  buildText(
                    fontSize: width * 0.04,
                    padding: EdgeInsets.only(
                      top: height * 0.02,
                    ),
                    text: 'Masukkan informasi kamu dibawah',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
            // Positioned(
            //   width: height * 0.8,
            //   height: height * 0.8,
            //   bottom: _activeMode == Mode.day ? -300 : -50,
            //   child: _activeMode == Mode.day ? day.rays : night.rays,
            // ),
            // Positioned(
            //   bottom: _activeMode == Mode.day ? -160 : -80,
            //   child: _activeMode == Mode.day ? day.circle : night.circle,
            // ),
            // Positioned.fill(
            //   child: Image(
            //     image:
            //     _activeMode == Mode.day ? day.landscape : night.landscape,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 300),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      text: 'Username',
                      padding: EdgeInsets.only(
                          top: height * 0.04, bottom: height * 0.015),
                      fontSize: width * 0.04,
                    ),
                    inputField(
                      hintText: 'Masukkan username',
                      controller: usernameController,
                      isPassword: false,
                    ),
                    buildText(
                      text: 'Password',
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                        bottom: height * 0.015,
                      ),
                      fontSize: width * 0.04,
                    ),
                    inputField(
                      hintText: 'Password kamu',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    isLoading?
                    Container(
                      width: ViewportSize.width - ViewportSize.width * 0.15,
                      margin: EdgeInsets.only(
                        top: ViewportSize.height * 0.02,
                      ),
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: ViewportSize.width * 0.155,
                        height: ViewportSize.width * 0.155,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: const Color(0xFFFFFFFF),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x55000000),
                              blurRadius: ViewportSize.width * 0.02,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        child: SpinKitThreeBounce(
                          size: 20,
                          color: Color(0xff3e3a63),
                        ),
                      ),
                    )
                        :

                    InkWell(
                        onTap: (){
                         if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                          isLoginPasien? userLogin() : adminLogin();
                         }
                         else {
                           _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Harap Lengkapi Data')));
                         }
                        },
                        child: const ArrowButton()),
                    SizedBox(height:250,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildText(
      {double fontSize, EdgeInsets padding, String text, String fontFamily}) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: fontSize,
          fontFamily: fontFamily ?? '',
        ),
      ),
    );
  }

  Widget inputField({String hintText, TextEditingController controller, bool isPassword}){
    return Container(
      width: ViewportSize.width * 0.85,
      alignment: Alignment.center,
      child: Theme(
        data: ThemeData(
          primaryColor: const Color(0x55000000),
        ),
        child: TextField(
          controller: controller,
          obscureText:  isPassword? true  : false ,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ViewportSize.width * 0.025),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xffaeabd6),
            ),
            fillColor: const Color(0xff434372),
            filled: true,
          ),
        ),
      ),
    );
  }

  // static Widget buildShape(){
  //   return
  // }

}



class CustomShapeClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height/2.5);
    var firstControlPoint = new Offset(size.width / 4, size.height / 3);
    var firstEndPoint = new Offset(size.width / 2, size.height / 2 - 100);
    var secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height / 2 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 4 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)
  {
    return true;
  }
}

