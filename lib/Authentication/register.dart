import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasmadonationtiu/Firebase%20Functions/firebase-actions.dart';
import 'login.dart';
import 'package:cool_alert/cool_alert.dart';
import 'verification.dart';

//import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isHiddenRegPass = true;
  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();
  String uid;
  TextEditingController name=TextEditingController();

  TextEditingController phone=TextEditingController();

  TextEditingController city=TextEditingController();
  FirebaseActions auth = FirebaseActions();
  String blood;
  final List<String> bloodTypes = [
    'O+',
    'O-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'A+',
    'A-'
];
  void _toggleVisibilityregpass() {
    setState(() {
      _isHiddenRegPass = !_isHiddenRegPass;
    });
  }

  void validate() {
    if (formkey.currentState.validate()) {
      createUser();
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Your transaction was successful!",
      );


    } else {
      print("Not Validated");
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    child: Icon(
                      Icons.person,
                      size: 130,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100)),
                      color: Color(0xffdb0b46),
                    ),
                    height: 280,
                    width: double.maxFinite,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      controller: name,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Color(0xffdb0b46),
                          size: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Name',
                      ),
                      validator: (String name) {
                        if (name.isEmpty) {
                          return "Required";
                        } else if (name.length < 4) {
                          return "Name is not correct";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      controller: email,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xffdb0b46),
                          size: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Email',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Required";
                        } else
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Email is not correct";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      controller: city,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Color(0xffdb0b46),
                          size: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'City',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    width: 300,
                    height: 60,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                      prefixIcon: Icon(
                      Icons.wrong_location,
                      color: Color(0xffdb0b46),
                      size: 18,
                    ), hintText:("Select Blood type"),

                            //style: TextStyle(color: Colors.black45,fontSize: 20.0),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                     // style: TextStyle(color: Colors.white),
                     //dropdownColor: Colors.pink,
                     // hint: Text(
                       // "          Select Blood type",
                      //  style: TextStyle(color: Colors.black45,fontSize: 20.0),
                      ),
                      value: blood,
                      onChanged: (String cvalue) {
                        setState(() {
                          blood =  cvalue;
                        });
                      },
                      items: bloodTypes.map((cvalue) {
                        return DropdownMenuItem<String>(
                          value: cvalue,
                          child: Text(
                            cvalue,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox( height: 0.0,),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xffdb0b46),
                            size: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Phone Number',
                        ),
                        validator: (var phone) {
                          if (phone.length != 11) {
                            return "Phone number must be 11 digit";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),




                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: TextFormField(
                          controller: password,
                          obscureText: _isHiddenRegPass,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: Color(0xffdb0b46),
                                size: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: _isHiddenRegPass
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  _toggleVisibilityregpass();
                                },
                              )),
                          validator: (var value) {
                            if (value.length < 8) {
                              return "Password is too short";
                            } else if (value.length > 16) {
                              return "Password is too long";
                            } else if (value.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                     validate();
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffdb0b46),
                      ),
                      padding: EdgeInsets.all(14),
                      child: Text('SIGN UP',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),




                  ),

                  Padding(padding: EdgeInsets.only(top: 30)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'I am already a member',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffdb0b46),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void createUser() async {
    dynamic result = await auth.createNewUser(
        name.text, phone.text, uid,city.text,blood, email.text, password.text).then((_)
    {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VerifyScreen()));
    });
    if (result == null) {
      print('Email is not valid');
    } else {
      print(result.toString());
      name.clear();
      city.clear();
      phone.clear();
      password.clear();
      email.clear();
      Navigator.pop(context);
    }
  }

}

