import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/modules/Expert/Auth/login_screen.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/Services/AuthServices.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';



class Drawerr extends StatefulWidget {

  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  String name;

  String email;

  String photo;

  getInfo()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      email=preferences.getString('email');
      name=preferences.getString('name');
      photo=preferences.getString('photo');
    });

  }
  @override
  void initState() {
    getInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name,),
            accountEmail: Text(email),
            currentAccountPicture:photo!=null? CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  ImageURL+photo,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ):Container(),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage('assets/images/download (4).jpg'),
                  fit: BoxFit.cover
              ),
            ),
          ),

          ListTile(
            leading:Icon(Icons.logout),
            title: TextButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: ()async{
                SharedPreferences preferences=await SharedPreferences.getInstance();
                ApiResponse res =await logOut();
                if(res.error ==null){
                  preferences.remove('token');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>LoginScreen()),(ctx)=>false);
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}
