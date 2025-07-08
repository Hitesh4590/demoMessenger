import 'package:demo_messenger/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../providers/theme_provider.dart';


class ChatProfileScreen extends StatefulWidget{
  @override
  State<ChatProfileScreen> createState() => _ChatProfileScreenState();
}

class _ChatProfileScreenState extends State<ChatProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.getColor(context, AppColor.chatThemeColor),
        scrolledUnderElevation: 0,
        leadingWidth: 40,
        leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 20,),
              onPressed: () => Navigator.pop(context),
          ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container(),),
            IconButton(
              icon: Image.asset("assets/icons/Videocamera.png", width: 35, height: 35, color: CustomColors.getColor(context, AppColor.iconColor),),
              onPressed: () {
                // Add video call functionality
              },
            ),
            IconButton(
              icon: Image.asset("assets/icons/phone.png", width: 35, height: 35, color: CustomColors.getColor(context, AppColor.iconColor)),
              onPressed: () {
                // Add voice call functionality
              },
            ),

          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                  'assets/images/profile1.png',
                width: 160,
                height: 160,
              ),
              Text(Constants.name, style: Theme.of(context).textTheme.bodyLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Constants.number, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(width: 20,),
                  Icon(Icons.copy, color: CustomColors.getColor(context, AppColor.iconColor),size: 15,)
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Constants.number, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(width: 20,),
                  Icon(Icons.copy, color: CustomColors.getColor(context, AppColor.iconColor),size: 15,)
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}