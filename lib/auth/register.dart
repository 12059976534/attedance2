import 'package:attendance2/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../page/homepage.dart';
import '../service/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final passwordcotroler = TextEditingController();
  final usernamecotroler = TextEditingController();
  var authservice = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        children: [
          Container(
            // color: Color.fromARGB(193, 101, 101, 101),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10),
            // padding: EdgeInsets.only(top:20),
            child: Column(
              children: [
                TextFormField(
                  controller: usernamecotroler,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey,
                    ),

                    // errorText: "Error",

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    fillColor: Colors.grey,

                    hintText: "Email/Mobile",

                    //make hint text
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),

                    //create lable
                    labelText: 'Email/Mobile',
                    //lable style
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordcotroler,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye_sharp),

                    // errorText: "Error",

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    fillColor: Colors.grey,

                    hintText: "Password",

                    //make hint text
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),

                    //create lable
                    labelText: 'Password',
                    //lable style
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return Homepage();
                    // }));
                    // var register =  authservice.Register(user, password)
                    if (passwordcotroler.text.isNotEmpty &&
                        usernamecotroler.text.isNotEmpty) {
                      var register = authservice.Register(
                          usernamecotroler.text, passwordcotroler.text);
                      register.then((value) async {
                        if (value.message == "registrasi succes") {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('login', true);
                          await prefs.setString(
                              'username', value.data.username);
                          await prefs.setInt('id', value.data.id);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Homepage();
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('gagal registrasi'),
                          ));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('user and password requered'),
                      ));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 13,
                    color: Colors.black,
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya accout"),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                        child: Container(
                          child: Text(
                            " Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
