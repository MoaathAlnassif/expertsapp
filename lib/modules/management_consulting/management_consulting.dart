import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/expertInfo.dart';
import 'package:untitled4/models/Expert.dart';
import 'package:untitled4/models/consulting.dart';

import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/remote/Constant/url_routes.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';
import 'package:untitled4/shared/network/remote/Services/user_services.dart';

class ManagementConsulting extends StatefulWidget {
  Consulting consulting;

  ManagementConsulting({@required this.consulting});

  @override
  _ManagementConsultingState createState() => _ManagementConsultingState();
}

class _ManagementConsultingState extends State<ManagementConsulting> {
  var searchController = TextEditingController();
  List<dynamic> _experts = [];
  bool loading = true;

  _showexpertInConsulting() async {
    ApiResponse response = ApiResponse();
    response = await expertInConsulting(widget.consulting.id);

    if (response.error == null) {
      setState(() {
        _experts = response.data as List;
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    _showexpertInConsulting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.consulting.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: defaultformfield(
              controller: searchController,
              type: TextInputType.text,
              label: 'Search',
              prefix: Icons.search,
            ),
          ),
          Expanded(
            child: loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
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
