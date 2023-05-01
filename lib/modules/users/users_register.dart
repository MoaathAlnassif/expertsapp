

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/models/user.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/remote/Services/AuthServices.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fields_screen.dart';

class UsersScreen extends StatefulWidget {
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordAgainController = TextEditingController();
  bool loading = false;
  _userRgister() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiResponse response = ApiResponse();
    response = await registerUser(nameController.text, emailController.text, passwordController.text);

    if (response.error==null) {

      User user = response.data as User;

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultformfield(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.text_fields,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      } else if (!value.contains('@')) {
                        return 'invalid email';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'password must not be empty';
                      }
                      return null;
                    },
                    label: 'Password',
                    prefix: Icons.lock,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: passwordAgainController,
                    type: TextInputType.visiblePassword,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'password again must not be empty';
                      } else if (value != passwordController.text) {
                        return 'password is not identical ';
                      }
                      return null;
                    },
                    label: 'Password Again',
                    prefix: Icons.lock,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultBotton(
                    background: loading?Colors.green:Colors.blue,
                    text: 'Register',
                    function: () async {
                      if (formKey.currentState.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                        print(passwordAgainController.text);
                        setState(() {
                          loading=true;
                        });
                        _userRgister();

                      }
                    },
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
