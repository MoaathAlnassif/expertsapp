import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/models/Expert.dart';
import 'package:untitled4/modules/Expert/Home/HomePage.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/Services/AuthServices.dart';
import 'dart:io';

import 'package:untitled4/shared/network/remote/api_response.dart';

import '../../../fields_screen.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var numberController = TextEditingController();
  var addressController = TextEditingController();
  var priceController = TextEditingController();
  var DaysspaceController = TextEditingController();
  var categoryController = TextEditingController();
  var skillsController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File image;
  bool loading = false;
  final imagepicker = ImagePicker();
  TimeOfDay starttime;
  TimeOfDay endtime;
  selectstartTime() async {
    TimeOfDay d =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      starttime = d;
    });
  }

  selectendTime() async {
    TimeOfDay d =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      endtime = d;
    });
  }

  uploadImage() async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    } else {}
  }

  _createExpert() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiResponse response = ApiResponse();
    response = await createExpert(
        name: firstnameController.text + " " + lastnameController.text,
        address: addressController.text,
        phone: numberController.text,
        price: priceController.text,
        start_time: '${starttime.hour}:${starttime.minute}',
        end_time: '${endtime.hour}:${endtime.minute}',
        Daysspace: DaysspaceController.text,
        category: categoryController.text,
        photo: getStringImage(image),
        skills: skillsController.text);

    if (response.error == null) {
      Expert exp = response.data ;

      preferences.setString('name', exp.name);
      preferences.setString('photo', exp.photo);
      setState(() {
        loading = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(expert: exp,),
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
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: image == null
                            ? AssetImage(
                                'assets/images/FB_IMG_1611009566533.jpg')
                            : FileImage(image),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                            icon: Icon(
                              Icons.camera_alt_outlined,
                            ),
                            onPressed: () {
                              uploadImage();
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: firstnameController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'First Name',
                    prefix: Icons.text_fields,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: lastnameController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Last Name',
                    prefix: Icons.text_fields,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: numberController,
                    type: TextInputType.number,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'number must not be empty';
                      }
                      return null;
                    },
                    label: 'Number',
                    prefix: Icons.confirmation_number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: addressController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'address must not be empty';
                      }
                      return null;
                    },
                    label: ' Address',
                    prefix: Icons.home,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: priceController,
                    type: TextInputType.number,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'price must not be empty';
                      }
                      return null;
                    },
                    label: 'price',
                    prefix: Icons.attach_money_sharp,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: categoryController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'category again must not be empty';
                      }
                      return null;
                    },
                    label: 'category',
                    prefix: Icons.category,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: skillsController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'skills must not be empty';
                      }
                      return null;
                    },
                    label: 'skills ',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                    controller: DaysspaceController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return ' Daysspace must not be empty';
                      }
                      return null;
                    },
                    label: ' Daysspace ',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            selectstartTime();
                          },
                          child: Text(starttime == null
                              ? 'Select start Time'
                              : '${starttime.hour}:${starttime.minute} ${starttime.period.index == 0 ? 'AM' : 'PM'}')),
                      ElevatedButton(
                          onPressed: () {
                            selectendTime();
                          },
                          child: Text(endtime == null
                              ? 'Select end Time'
                              : '${endtime.hour}:${endtime.minute} ${starttime.period.index == 0 ? 'AM' : 'PM'}')),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultBotton(
                    text: 'Register',
                    function: ()async {
                      String token=await getToken();
                      if (formKey.currentState.validate()) {
                       _createExpert();
                        setState(() {
                          loading=true;
                         
                        });
                        print(firstnameController.text);
                        print(lastnameController.text);
                        print(numberController.text);
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
