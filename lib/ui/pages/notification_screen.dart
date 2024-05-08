import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.paylod}) : super(key: key);

  final String paylod;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _paylod = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paylod = widget.paylod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: context.theme.colorScheme.background,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon:  Icon(Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
            ),
          ),
          elevation: 0,
          title: Text(
            _paylod.toString().split('|')[0],
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    'Hello, Ahmed',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : darkGreyClr,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You have a new reminder',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                    padding:const  EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    margin:const EdgeInsets.symmetric(horizontal: 30,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primaryClr,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.text_format,
                              color: Colors.white,
                              size: 30,),
                              SizedBox(
                                width: 20,
                              ),
                               Text(
                                "Title",
                                style:
                                TextStyle(color: Colors.white,fontSize: 30),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            _paylod.toString().split('|')[0],
                            style:
                            const TextStyle(color:Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.description,
                                color: Colors.white,
                                size: 30,),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Description",
                                style:
                                TextStyle(color: Colors.white,fontSize: 30),
                              ),
                            ],
                          ),
                         const SizedBox(height: 20,),
                          Text(
                            _paylod.toString().split('|')[1],
                            style:
                            const TextStyle(color:Colors.white),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row (
                          children: [
                            Icon(Icons.calendar_today_outlined,
                              color: Colors.white,
                              size: 30,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Date",
                              style:
                              TextStyle(color: Colors.white,fontSize: 30),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                          Text(
                            _paylod.toString().split('|')[2],
                            style:
                            const TextStyle(color:Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
