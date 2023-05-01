import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/expertInfo.dart';
import 'package:untitled4/models/Expert.dart';
import 'package:untitled4/models/SearchResult.dart';
import 'package:untitled4/models/consulting.dart';
import 'package:untitled4/nav_bar.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/remote/Services/user_services.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';
import 'modules/management_consulting/management_consulting.dart';

class FieldsScreen extends StatefulWidget {
  @override
  _FieldsScreenState createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  var searchController = TextEditingController();
  List<dynamic> resultsearch;

  List<dynamic> _consulting = [];
  bool loading = true;

  _showConsulting() async {
    ApiResponse response = ApiResponse();
    response = await showAllConsulting();

    if (response.error == null) {
      setState(() {
        _consulting = response.data as List;
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
    _showConsulting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _showConsulting();
        },
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  children: [
                    defaultformfield(
                      onChange: (value) async {
                        if (value.length > 0) {
                          ApiResponse response = ApiResponse();
                          response = await search(value);
                          if (response.error == null) {
                            if (response.data == 0) {
                              setState(() {
                                resultsearch = [];
                              });
                            } else {
                              setState(() {
                                resultsearch = response.data as List;
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${response.error}"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        } else {
                          setState(() {
                            resultsearch = null;
                          });
                        }
                      },
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: size.height * 0.8,
                            width: double.infinity,
                            child: Container(
                              child: resultsearch == null
                                  ? ListView.builder(
                                      itemBuilder: (ctx, i) {
                                        Consulting cons = _consulting[i];
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ManagementConsulting(
                                                                consulting:
                                                                    cons)));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Text(
                                                  cons.name.toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _consulting.length,
                                    )
                                  : resultsearch.isEmpty
                                      ? Center(
                                          child: Text(
                                            'no result',
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemBuilder: (ctx, i) {
                                            SearchResult res = resultsearch[i];
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: ListTile(
                                                    onTap: () async {
                                                      if (res.type ==
                                                          'Expert') {}
                                                    },
                                                    title: Text(
                                                        res.name.toString(),
                                                        style: TextStyle(
                                                            fontSize: 25)),
                                                    subtitle: Text(
                                                        res.type.toString(),
                                                        style: TextStyle(
                                                            fontSize: 19)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: resultsearch.length,
                                        ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
