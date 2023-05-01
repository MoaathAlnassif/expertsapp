import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/models/Expert.dart';
import 'package:untitled4/models/user.dart';
import 'package:untitled4/modules/Expert/Home/HomePage.dart';

import 'package:untitled4/modules/users/users_register.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/Services/AuthServices.dart';
import 'package:untitled4/shared/network/remote/Services/user_services.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';
import 'package:http/http.dart' as http;
import '../../../fields_screen.dart';
import 'expert_register.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey= GlobalKey<FormState>();
  Function suffixPressed;
  bool isPassword = true;
  List<String> itemList =['Expert','User'];
  String selectedItem= 'User';
  bool loading = false;
  _userLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiResponse response = ApiResponse();
    response = await login( emailController.text, passwordController.text);

    if (response.error==null) {

      User user = response.data as User;
if(user.role=='manger'){
  print('manger');
  preferences.setString('token', user.token);
  preferences.setString('email', user.email);
  setState(() {
    loading=false;
  });

  String token = await getToken();
  try {
    await http.get(
      Uri.parse(ProfileexpertURL+user.id.toString()),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    ).then((value) {
      print(jsonDecode(value.body));
     Expert exp= Expert.fromJson(jsonDecode(value.body)['data']);

     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder: (context) => HomePage(expert: exp,),
         ),
             (ctx) => false);

    });



 }catch(e){print('errrrrrrrror');}



}
else{
  preferences.setString('token', user.token);
  preferences.setString('email', user.email);
  preferences.setString('name', user.name);
  setState(() {
    loading=false;
  });
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => FieldsScreen(),
      ),
          (ctx) => false);
}


    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultformfield(
                    controller: emailController,
                    label: 'Email',
                    prefix:Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (String value){
                      if(value.isEmpty){
                        return'email address must not be empty';
                      }
                      return null;
                    }

                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                      controller: passwordController,
                      label: 'Password',
                      prefix:Icons.lock,
                      suffix: isPassword? Icons.visibility:Icons.visibility_off,
                      suffixPressed: (){
                        setState(() {
                          isPassword= !isPassword;

                        });
                      },
                      isPassword: isPassword,
                      type: TextInputType.visiblePassword,
                      validate: (String value){
                        if(value.isEmpty){
                          return'password is too short';
                        }
                        return null;
                      }

                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultBotton(
                    background: loading?Colors.green:Colors.blue,
                    text: 'login',
                    function: (){
                      if(formKey.currentState.validate()){
                        print(emailController.text);
                        print(passwordController.text);
                        setState(() {
                          loading=true;
                          _userLogin();
                        });
                      }

                    },
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text(
                      'Don\'t have an accont?'
                  ),
                      TextButton(
                          onPressed: ()
                          {
                            if(selectedItem=='Expert'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:(context) =>RegisterExpert(),
                                ),
                              );
                            }
                            else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:(context) =>UsersScreen(),
                                ),
                              );
                            }

                          },
                          child:
                          Text(
                            'Register now'
                          )
                      ),
                      DropdownButton(
                        value:selectedItem ,
                        items: itemList.map((item) => DropdownMenuItem(
                            child: Text(item,),
                          value: item,
                        ),

                        )
                          .toList(),
                        onChanged: (item)=>setState(()=>selectedItem=item),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}