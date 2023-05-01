import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter =1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter',
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
           TextButton(
               onPressed: ()
               {
                 setState(()
                 {
                   counter--;
                   print(counter);
                 });

               },
               child: Text(
                 'MINUS',
               ),
           ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                  '$counter',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50.0,
                ),
              ),
            ),
            TextButton(
              onPressed: ()
              {
                setState(()
                {
                  counter++;
                  print(counter);
                });

              },
              child: Text(
             'PLUS',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
