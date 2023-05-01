import 'package:flutter/material.dart';
import 'package:untitled4/shared/network/remote/Services/user_services.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';
import 'DemoApp.dart';
import 'models/Appointment.dart';
import 'models/Expert.dart';

class AddAppoitment extends StatefulWidget {
  DateTime date;
  Expert expert;

  AddAppoitment({this.date, this.expert});

  @override
  State<AddAppoitment> createState() => _AddAppoitmentState();
}

class _AddAppoitmentState extends State<AddAppoitment> {
  TextEditingController text = TextEditingController();
  TimeOfDay time;

  selectstartTime() async {
    TimeOfDay d = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      time = d;
    });
  }

  _createAppointment() async {
    ApiResponse response = ApiResponse();
    print(widget.expert.id);
    print(widget.expert.price);
    print("${widget.date.year}-${widget.date.month}-${widget.date.day}");
    response = await createAppointment(
        widget.expert.id.toString(),
        widget.expert.price.toString(),
        "${time.hour}:${time.minute}",
        "${widget.date.year}-${widget.date.month}-${widget.date.day}");

    if (response.error == null) {
      Appointment appointment = response.data;
      Navigator.of(context).pop();
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
        title: Text('Add Appointment'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 300,
                child: TextFormField(
                  controller: text,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        selectstartTime();
                      },
                      child: Text(time == null
                          ? 'Select start Time'
                          : '${time.hour}:${time.minute} ${time.period.index == 0 ? 'AM' : 'PM'}')),
                ],
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    _createAppointment();
                  },
                  child: Text('add'))
            ],
          ),
        ),
      ),
    );
  }
}
