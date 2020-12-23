import 'package:oalarm/service/fetchdataUser.dart';
import 'package:oalarm/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'admin/homepage_admin.dart';

class LogIn extends StatefulWidget {
  final bool isAdmin;
  LogIn({this.isAdmin});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController username = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  bool isLoading = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    username.dispose();
    passwordController.dispose();
    super.dispose();
  }
  userLogin () {
    setState(() {
      isLoading = true;
    });
    FetchDataUser fetchData = FetchDataUser();
    fetchData.userLogin(
        username.text, passwordController.text)
        .then((value) {
      if (value) {
       if(widget.isAdmin){
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => HomePage()));
       }
       else {
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => HomePage()));
       }

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey.withOpacity(0.0),
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 30, color: Colors.transparent),
                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('LOGIN',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xff8b2f08),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            'Welcome Back!',
                            style: TextStyle(color: Color(0xff8b2f08), fontSize: 30),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            child: new Flexible(
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                controller: username,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                validator: (value){
                                  if (value.isEmpty) {
                                    return 'Username tidak boleh kosong';
                                  }
                                  else if(value.length<7){
                                    return 'Username tidak valid';
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 7),
                                    contentPadding: EdgeInsets.all(5),
                                    labelText: 'Username',
                                    labelStyle: TextStyle(fontSize: 13),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xff8b2f08)))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            child: new Flexible(
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black),
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !_passwordVisible,
                                cursorColor: Colors.black,
                                validator: (val) => val.length < 6 ? 'Password terlalu pendek.' :  val.isEmpty? 'Password tidak boleh kosong' : null,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 7),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: 13),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xff8b2f08))),

                                ),

                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            child: RaisedButton(
                              elevation: 7,
                              color: Color(0xff8b2f08),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side:
                                  BorderSide(color: Color(0xffACADA9), width: 0.1)),
                              onPressed: isLoading
                                  ? () {}
                                  : () {
                                // if(_formKey.currentState.validate()){
                                  FocusScope.of(context).unfocus();
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => HomePageAdmin()));
                                // }
                              },
                              child: isLoading
                                  ? SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30.0,
                              )
                                  : Text('Masuk',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  )),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
