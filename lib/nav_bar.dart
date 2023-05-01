import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/favorite_screen.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/Services/AuthServices.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';

import 'modules/Expert/Auth/login_screen.dart';

class NavBar extends StatefulWidget {

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
String name;

String email;


getInfo()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  setState(() {
    email=preferences.getString('email');
    name=preferences.getString('name');

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

            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/download (4).jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
          ListTile(
            leading:Icon(Icons.favorite),
            title: TextButton(
              child: Text(
                      'Favorites',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>FavoriteScreen()));

              },
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
