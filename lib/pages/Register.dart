import 'package:flutter/material.dart';
import 'package:foodmonkey/helpers/TrianglePainter.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _phoneInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomPaint(painter: TrianglePainter(msize: msize)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(child: Image.asset("assets/images/fm.png")),
                    SizedBox(height: 10),
                    Text("Register", style: Constants.getTitleTextStyle(45)),
                    SizedBox(height: 10),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: _nameInputController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                                color: Constants.normal, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _emailInputController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Constants.normal, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _phoneInputController,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            labelStyle: TextStyle(
                                color: Constants.normal, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordInputController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "password",
                            labelStyle: TextStyle(
                                color: Constants.normal, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constants.normal)),
                          ),
                        )
                      ],
                    )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text("Already Member! Login Here")),
                            SizedBox(height: 5),
                            Container(
                              width: 50,
                              height: 5,
                              decoration:
                                  BoxDecoration(color: Constants.accent),
                            )
                          ],
                        ),
                        FlatButton(
                            onPressed: () async {
                              var name = _nameInputController.text;
                              var email = _emailInputController.text;
                              var phone = _phoneInputController.text;
                              var password = _passwordInputController.text;

                              bool bol = await Api.register(
                                  name: name,
                                  email: email,
                                  phone: phone,
                                  password: password);

                              if (bol)
                                Navigator.pop(context);
                              else
                                print("Register Fail!");
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: Constants.accent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: Constants.primary),
                                SizedBox(width: 5),
                                Text("Regoster",
                                    style: TextStyle(
                                        color: Constants.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
