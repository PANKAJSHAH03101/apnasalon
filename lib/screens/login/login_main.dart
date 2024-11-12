import 'package:apnasaloon/assets/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {

  bool emailAutoValidate = false;
  final emailController = TextEditingController();
  bool passwordVisible = true;
  final passwordController = TextEditingController();
  bool _isChecked = false;

  saveStringPref(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  saveBoolPref(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  rememberMeAction(bool? value) {
    _isChecked = value!;
    saveBoolPref(REMEMBER_ME, value);
    saveStringPref(SAVE_EMAIL_CREDENTIALS, emailController.text);
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double widgetHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                children: [
                  Padding(
                  padding: const EdgeInsets.only(right:270.0,top:70),
                  child: Container(
                    child: const Text(
                        LOGIN,
                        style:TextStyle(
                            color: Colors.black,
                            fontSize:37,
                            fontWeight: FontWeight.w700
                        )),
                  )),
                  Padding(
                      padding: const EdgeInsets.only(left:19.0,top:37.0,right: 19.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          key: Key('userId'),
                          autovalidateMode: emailAutoValidate == false ? AutovalidateMode.onUserInteraction :AutovalidateMode.disabled ,
                          controller: emailController,
                          // validator: validateEmail,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 1,
                                vertical: 16.0),
                            isDense: true,
                            prefixIcon: Icon(Icons.email,weight: 0.1),
                            hintText: EMAIL_PROMPT,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                            errorStyle: TextStyle(color: Colors.red),
                            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left:19.0,top:37.0,right:19.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius:BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: TextFormField(
                        onTap: (){
                          setState(() {
                            // passAutoValidate = false;
                          });
                        },
                        cursorColor: Colors.black,
                        key: Key('userId'),
                        autovalidateMode: emailAutoValidate == false ? AutovalidateMode.onUserInteraction :AutovalidateMode.disabled ,
                        controller: passwordController,
                        // validator: validateEmail,
                        obscureText: passwordVisible,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 16
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Icon(
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: 16.0),
                          isDense: true,
                          prefixIcon: Icon(Icons.lock,weight: 0.1),
                          hintText: PASSWORD_PROMPT,
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.black,
                            ),
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.orange,
                              value: _isChecked,
                              onChanged: rememberMeAction,
                              side: BorderSide(color: Colors.orange,width: 1.9),
                            ),
                          ),
                        ),
                        const Text(
                          REMEMBER_ME_TEXT,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: widgetWidth * 0.8,
                      height: widgetHeight * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.orange
                      ),
                      child: TextButton(
                        key: Key('login_button'),
                        child: Text(LOGIN,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          HapticFeedback.lightImpact();
                          // var isValid = formKey.currentState!.validate();
                          // if (isValid) {
                          //   if(UrlConstants.isQASetup){
                          //     String xapiUrl = await getStringPref(XAPI_URL);
                          //     if(xapiUrl.isEmpty ) {
                          //       saveStringPref(XAPI_URL, UrlConstants.baseXapiURL);
                          //     }
                          //     if(emailController.text.trim() == "Qa@extremetest.com" && passwordController.text.trim() == "Qa@123" ){
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => QaScreen(callBackBaseURL:  callBackBaseURL) ));
                          //       emailController.clear();
                          //       passwordController.clear();
                          //       setState(() {
                          //         emailAutoValidate= true;
                          //         passAutoValidate = true;
                          //       });
                          //     } else {
                          //       username = emailController.text.trim();
                          //       password = passwordController.text;
                          //       showLoader(context) ;
                          //       await _loginUser();
                          //     }
                          //   } else {
                          //     await saveStringPref(XAPI_URL, UrlConstants.baseXapiURL);
                          //     username = emailController.text.trim();
                          //     password = passwordController.text;
                          //     showLoader(context) ;
                          //     await _loginUser();
                          //   }
                          // }
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 37.0,right: 37.0,top: 31.0,bottom: 13.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:7.0,right:7.0),
                            child: Text(
                            OR,
                            style: TextStyle(
                                color: Colors.black,),
                        ),
                          ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        )
                       ],
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 90.0,right: 90.0,top: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 61,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 61,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:31.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DONT_HAVE_AN_ACCOUNT,
                          style: TextStyle(
                              color: Colors.black,),
                        ),
                        TextButton(
                          onPressed:(){},
                          child: Text(
                            SIGN_UP,
                            style: TextStyle(
                                color: Colors.orange,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
      )
    );
  }
}
