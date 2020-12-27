import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/service/fetchdataUser.dart';
import 'package:oalarm/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oalarm/components/arrow_button.dart';
import 'package:oalarm/components/day/sun.dart';
import 'package:oalarm/components/day/sun_rays.dart';
import 'package:oalarm/components/input_field.dart';
import 'package:oalarm/components/night/moon.dart';
import 'package:oalarm/components/night/moon_rays.dart';
import 'package:oalarm/components/toggle_button.dart';
import 'package:oalarm/enums/mode.dart';
import 'package:oalarm/models/login_theme.dart';
import 'package:oalarm/utils/cached_images.dart';
import 'package:oalarm/utils/viewport_size.dart';

import 'admin/tab_admin/list_pasien.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool isLoading = false;
  bool _passwordVisible = false;

  AnimationController _animationController;
  LoginTheme day;
  LoginTheme night;
  Mode _activeMode = Mode.day;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward(from: 0.0);
    }); // wait for all the widget to render
    initializeTheme(); //initializing theme for day and night
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



  @override
  void didChangeDependencies() {
    cacheImages();
    super.didChangeDependencies();
  }

  cacheImages() {
    CachedImages.imageAssets.forEach((asset) {
      precacheImage(asset, context);
    });
  }

  initializeTheme() {
    var hour = DateTime.now().hour;
    String greeting;
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
    day = LoginTheme(
      title: greeting,
      backgroundGradient: [
        const Color(0xFF8C2480),
        const Color(0xFFCE587D),
        const Color(0xFFFF9485),
        const Color(0xFFFF9D80),
        // const Color(0xFFFFBD73),
      ],
      landscape: CachedImages.imageAssets[0],
      circle: Sun(
        controller: _animationController,
      ),
      rays: SunRays(
        controller: _animationController,
      ),
    );

    night = LoginTheme(

      title: greeting,
      backgroundGradient: [
        const Color(0xFF0D1441),
        const Color(0xFF283584),
        const Color(0xFF6384B2),
        const Color(0xFF6486B7),
      ],
      landscape: CachedImages.imageAssets[1],
      circle: Moon(
        controller: _animationController,
      ),
      rays: MoonRays(
        controller: _animationController,
      ),
    );
  }


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
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _activeMode == Mode.day
                ? day.backgroundGradient
                : night.backgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: height * 0.8,
              height: height * 0.8,
              bottom: _activeMode == Mode.day ? -300 : -50,
              child: _activeMode == Mode.day ? day.rays : night.rays,
            ),
            Positioned(
              bottom: _activeMode == Mode.day ? -160 : -80,
              child: _activeMode == Mode.day ? day.circle : night.circle,
            ),
            Positioned.fill(
              child: Image(
                image:
                _activeMode == Mode.day ? day.landscape : night.landscape,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: height * 0.1,
              left: width * 0.07,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleButton(
                    startText: 'Pasien Login',
                    endText: 'Admin Login',
                    tapCallback: (index) {
                      setState(() {
                        _activeMode = index == 0 ? Mode.day : Mode.night;
                        _animationController.forward(from: 0.0);
                      });
                    },
                  ),
                  buildText(
                    text: _activeMode == Mode.day ? day.title : night.title,
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
                  buildText(
                    text: 'Username',
                    padding: EdgeInsets.only(
                        top: height * 0.04, bottom: height * 0.015),
                    fontSize: width * 0.04,
                  ),
                  inputField(
                    hintText: 'Masukkan username',
                    controller: usernameController
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
                    controller: passwordController
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
                        color: Colors.black,
                      ),
                    ),
                  )
                      :

                  InkWell(
                      onTap: (){
                       if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                         _activeMode == Mode.day? userLogin() : adminLogin();
                       }
                       else {
                         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Harap Lengkapi Data')));
                       }
                      },
                      child: const ArrowButton()),
                ],
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

  Widget inputField({String hintText, TextEditingController controller}){
    return Container(
      width: ViewportSize.width * 0.85,
      alignment: Alignment.center,
      child: Theme(
        data: ThemeData(
          primaryColor: const Color(0x55000000),
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ViewportSize.width * 0.025),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xFFFFFFFF),
            ),
            fillColor: const Color(0x33000000),
            filled: true,
          ),
        ),
      ),
    );
  }


}
