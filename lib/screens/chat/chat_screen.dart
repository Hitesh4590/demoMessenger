import 'package:demo_messenger/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget{
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () { Navigator.pop(context); },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
              ),
          child: Icon(Icons.arrow_back)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {  },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                ),
            child: Icon(Icons.more_horiz)),
          ),
        ],

      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: 60,

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(child: Image.network(Constants.profile_image, width: 40, height: 40,)),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Constants.name, style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 5,),
                      Text(Constants.number, style: TextStyle(
                          fontSize: 16, color: Colors.grey
                      ),)
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/Videocamera.png", width: 35, height: 35,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/phone.png", width: 35, height: 35,),
                    ],
                  ),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}