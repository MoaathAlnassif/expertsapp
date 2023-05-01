import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:untitled4/AddAppoitment.dart';

import 'package:untitled4/shared/network/remote/Services/user_services.dart';
import 'package:untitled4/shared/network/remote/api_response.dart';

import 'fields_screen.dart';
import 'models/Appointment.dart';
import 'models/Expert.dart';

final Map<DateTime,List<CleanCalendarEvent>> events = {
  DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day):
  [
    CleanCalendarEvent('Event A',
        startTime: DateTime(
            DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
        endTime:  DateTime(
            DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
        description: 'A special event',
        color: Colors.blue[700]),
  ],

  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
  [
    CleanCalendarEvent('Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange),
    CleanCalendarEvent('Event C',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink),
  ],
};
addAppoitment(DateTime date,TimeOfDay starttime,TimeOfDay endtime,String name){

  if(events[DateTime(date.year, date.month, date.day)]==null){
    events.addAll({ DateTime(date.year, date.month, date.day):
       [CleanCalendarEvent(name,
        startTime: DateTime(date.year, date.month,
            date.day , starttime.hour, starttime.minute),
        endTime: DateTime(date.year, date.month,
            date.day ,endtime.hour , endtime.minute),
        color: Colors.accents[Random().nextInt(10)]),]});
  }
  else{
    events[DateTime(date.year, date.month, date.day)].add(CleanCalendarEvent(name,
        startTime: DateTime(date.year, date.month,
            date.day , starttime.hour, starttime.minute),
        endTime: DateTime(date.year, date.month,
            date.day ,endtime.hour , endtime.minute),
        color: Colors.accents[Random().nextInt(10)]),);
  }



  }
class DemoApp extends StatefulWidget {
 final Expert expert;

   DemoApp({this.expert});
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {

  DateTime selectedDay;
  List <CleanCalendarEvent> selectedEvent;



  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

List <dynamic>_appointment;
bool loading=true;
  _getAppointment() async {
    ApiResponse response = ApiResponse();

    response = await getAppointment(widget.expert.id);

    if (response.error == null) {
    setState(() {
      events.clear();
      _appointment=response.data as List;
      _appointment.map((e) {
        Appointment a=e ;
        List gg=a.time.split(':');
        List date=a.data.split('-');
        addAppoitment(DateTime(int.parse(date[0]),int.parse(date[1]),int.parse(date[2])), TimeOfDay(hour:int.parse(gg[0]),minute: int.parse(gg[1])), TimeOfDay(hour:int.parse(gg[0])+1,minute: int.parse(gg[1])), 'Appointment: ${e.id}');
      }).toList();
      loading=false;
    });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.error}"),
        backgroundColor: Colors.red,
      ));
    }
  }


List Day=['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  List dayNum=[];
splitString(){
  setState(() {
    dayNum=widget.expert.daysspace.split(',');
  });
print(dayNum.toString());
}

  @override
  void initState() {

    // TODO: implement initState
    _getAppointment();
    splitString();
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
      ),
      body:  SafeArea(
        child: Container(
          child: loading?Center(child: CircularProgressIndicator(),):Calendar(
            startOnMonday: true,
            selectedColor: Colors.blue,
            todayColor: Colors.red,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range) {
              print('selected Day ${range.from},${range.to}');
            },
            onDateSelected: (date){
              return _handleData(date);
            },
            events: events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 15,
              color: Colors.black12,
              fontWeight: FontWeight.w100,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            hideArrows: false,

            weekDays: dayNum.map<String>((e) => Day[int.parse(e)-1]).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
         onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>AddAppoitment(date:selectedDay,expert:widget.expert))).then((value) {_getAppointment();});},
      ),
    );
  }
}
