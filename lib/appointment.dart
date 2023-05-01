import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DemoApp.dart';
class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime dateTime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}',
              style: TextStyle(
                  fontSize: 30.0,
              ),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async{
                DateTime newDate = await showDatePicker(
                    context: context,
                    initialDate: dateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),);
                if(newDate==null)return;
                TimeOfDay newTime = await showTimePicker(
                    context: context,
                    initialTime:TimeOfDay(
                        hour: dateTime.hour,
                        minute: dateTime.minute,
                    ) ,
                );
                if(newTime==null)return;
                final newDateTime = DateTime(
                  newDate.year,
                  newDate.month,
                  newDate.day,
                  newTime.hour,
                  newTime.minute,
                );

                setState(() {
                  dateTime = newDate;
                });
              },
              child: Text('Selet data & time',
              style: TextStyle(fontSize: 20.0,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
