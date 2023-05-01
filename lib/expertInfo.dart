import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled4/DemoApp.dart';
import 'package:untitled4/appointment.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/Services/AuthServices.dart';
import 'package:untitled4/shared/network/remote/Services/user_services.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';
import 'package:like_button/like_button.dart';
import 'models/Expert.dart';

class ExpertInfo extends StatefulWidget {
  final Expert expert;

  ExpertInfo({this.expert});

  @override
  State<ExpertInfo> createState() => _ExpertInfoState();
}

class _ExpertInfoState extends State<ExpertInfo> {
  bool isLike = false;
  _createRating() async {
    ApiResponse response = ApiResponse();

    response = await createRating(widget.expert.id, star.toInt());

    if (response.error == null) {
      print('reting success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  _showRating() async {
    ApiResponse response = ApiResponse();
    response = await showRating(widget.expert.id);

    if (response.error == null) {
      setState(() {
        starAvg = double.parse(response.data.toString());
      });
    } else {
      if (response.error == 0) {
        starAvg = 0.0;
      }
    }
  }
  _isfavourite() async {
    ApiResponse response = ApiResponse();
    response = await isFavourite(widget.expert.id);
    if (response.error == null) {
    setState(() {
      if(response.data==1){
        isLike=true;
      }
      else{
        isLike=false;
      }
    });
    } else {

    }
  }
  _addfavourite() async {
    ApiResponse response = ApiResponse();
    response = await addFavourite(widget.expert.id);
    if (response.error == null) {
   print('create favorite');
    } else {
      print('error favorite');
    }
  }
  _clearfavorite() async {
    ApiResponse response = ApiResponse();
    response = await clearFavourite(widget.expert.id);
    if (response.error == null) {
      print('clear favoirt');
    } else {
      print('error favoirt');
    }
  }
  double star;
  double starAvg;

  @override
  void initState() {
    _isfavourite();
    _showRating();
    super.initState();
  }



  Future<bool> onFavorit(bool k) async {
  if(k){
    _clearfavorite();
  }
  else{
    _addfavourite();
  }
    return !k;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: LikeButton(
              onTap: onFavorit,
              isLiked: isLike,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage(ImageURL + widget.expert.photo),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  widget.expert.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20,
                rating: starAvg == null ? 0.0 : starAvg,
              ),
              Divider(),
              ListTile(
                title: Text('Skills'),
                subtitle: Text(widget.expert.skills),
              ),
              ListTile(
                title: Text('Category'),
                subtitle: Text(widget.expert.category),
              ),
              ListTile(
                title: Text('Start Time'),
                subtitle: Text(widget.expert.startTime),
              ),
              ListTile(
                title: Text('End Time'),
                subtitle: Text(widget.expert.endTime),
              ),
              ListTile(
                title: Text('Discussion Price'),
                subtitle: Text(widget.expert.price.toString() + ' S.P'),
              ),
              ListTile(
                title: Text('Phone Number'),
                subtitle: Text(widget.expert.phone),
              ),
              ListTile(
                title: Text('Address'),
                subtitle: Text(widget.expert.address),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                  minRating: 1,
                  allowHalfRating: false,
                  itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  onRatingUpdate: (value) {
                    setState(() {
                      star = value;
                    });
                  }),
              FloatingActionButton(
                onPressed: () async {
                  String token = await getToken();
                  await post(Uri.parse(CreateratingURL), headers: {
                    'Accept': 'application/json',
                    'Authorization': 'Bearer $token',
                  }, body: {
                    'star': star.toString(),
                    'expert_id': widget.expert.id.toString()
                  }).then((value) => print(value.body.toString()));
                  _showRating();
                },
                child: Text('Rating'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.date_range),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DemoApp(expert: widget.expert)));
        },
      ),
    );
  }
}
