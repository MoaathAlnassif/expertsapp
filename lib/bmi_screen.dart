import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool ismale = true;

  double haight=120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
        ),
      ),
      body: Column(
        children:
        [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
               children:
               [
                 Expanded(
                   child: GestureDetector(
                     onTap: (){
                      setState(() {

                      });
                     },
                     child: Container(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:
                         [
                           Image(
                               image: AssetImage('assets/images/img_115993.png'),
                             height: 70.0,
                             width: 90.0,
                           ),
                           SizedBox(
                             height: 15.0,
                           ),
                           Text(
                             'MALE',
                             style: TextStyle(
                               fontSize: 25.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ],
                       ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(
                             10.0,
                         ),
                         color: ismale?Colors.blue[400]:Colors.grey,
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   width: 20.0,
                 ),
                 Expanded(
                   child: GestureDetector(
                     onTap: (){
                       setState((){
                         ismale=false;
                       });
                     },
                     child: Container(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:
                         [
                           Image(
                             image: AssetImage('assets/images/R.jpg'),
                             height: 70.0,
                             width: 90.0,
                           ),
                           SizedBox(
                             height: 15.0,
                           ),
                           Text(
                             'FAMALE',
                             style: TextStyle(
                               fontSize: 25.0,
                               fontWeight: FontWeight.bold,
                             ),
                           )
                         ],
                       ),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(
                             10.0,
                         ),
                         color: ismale?Colors.grey[400]:Colors.blue,
                       ),
                     ),
                   ),
                 ),
               ],
              ),
            ),
          ),
          Expanded(
            child:Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.grey[400],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children:
                      [
                        Text(
                          '${haight.round()}',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'CM',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                        value: haight,
                        max: 220,
                        min: 80,
                        onChanged: (value)
                        {
                          setState(() {
                          haight=value;
                          });
                        })
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '180',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){},
                                mini: true,
                                child: Icon(
                              Icons.remove,
                            ),
                          ),
                              FloatingActionButton(
                                onPressed: (){},
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.grey[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            'WAIGHT',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '180',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){},
                                mini: true,
                                child: Icon(
                              Icons.remove,
                            ),
                          ),
                              FloatingActionButton(
                                onPressed: (){},
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
                onPressed: (){},
                height: 50.0,
                child: Text(
                  'CALCULATE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }


}

