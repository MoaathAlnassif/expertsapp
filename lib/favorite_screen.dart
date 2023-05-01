import 'package:flutter/material.dart';
import 'package:untitled4/expertInfo.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/Services/user_services.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';

import 'models/Expert.dart';

class FavoriteScreen extends StatefulWidget {


  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<dynamic> _experts = [];
  bool loading = true;

  _showexpertFavorite() async {
    ApiResponse response = ApiResponse();
    response = await showExpertFavorite();
    if(response.error == null) {
      setState(() {
        _experts = response.data as List;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
      ));
    }
  }
@override
  void initState() {
    _showexpertFavorite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Expanded(
            child: loading
                ? Center(
              child: CircularProgressIndicator(),
            ):_experts.isEmpty?Center(child: Text('No favorite '),)
                : ListView.builder(
              itemBuilder: (_, i) {
                Expert exp = _experts[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ExpertInfo(expert:exp)));
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                          NetworkImage(ImageURL + exp.photo)),
                      title: Text(exp.name),
                      subtitle: Text(exp.skills),
                    ),
                  ),
                );
              },
              itemCount: _experts.length,
            ),
          )
        ],
      ),
    );
  }
}
