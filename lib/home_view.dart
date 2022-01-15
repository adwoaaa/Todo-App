import 'package:awesome_todo_app/create_todo_view.dart';
import 'package:awesome_todo_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//stl= stateless widget
//stf= stateful widget

class Homeview extends StatefulWidget {
 const Homeview ({ Key? key }) : super(key: key);

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
String selectedItem = 'todo';

  final List<Map<String,dynamic>> _unCompletedData = [];

  final List<Map<String,dynamic>> _completedData = []; 

  final List<Map<String,dynamic>> data =[
    {
    'title':'My dream home',
    'description':'The house is very beautiful',
    'date_time':'Yesterday',
    'status':true,
    },
     {
    'title':'My dream home',
    'description':'The house is very beautiful',
    'date_time':'Today',
    'status':true,
    },
     {
    'title':'My dream home',
    'description':'The house is very beautiful',
    'date_time':'Tomorrow',
    'status':false,
    },
     {
    'title':'My dream home',
    'description':'The house is very beautiful',
    'date_time':'Today',
    'status':false,
    },
     {
    'title':'My dream home',
    'description':'The house is very beautiful',
    'date_time':'Mon. 15 Nov',
    'status':false,
    }
  ];

  @override
  void initState() {   
    for(Map<String,dynamic> element in data){
    if(!element['status']) {
      _unCompletedData.add(element);
    }else{
      _completedData.add(element);
    }
  }
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       centerTitle: false,
       title: const Text('My Tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
       ),
       leading: const Center(child: FlutterLogo(size: 40,
       )),
       actions: [
         PopupMenuButton<String>(
           icon:const Icon(Icons.menu),
           onSelected: (value){
             setState(() {
               
             });
            selectedItem = value;
           },
           itemBuilder: (context){
            return[
             const PopupMenuItem(child: Text('To Do'),value:'todo'),
             const  PopupMenuItem(child: Text('Completed'),value:'completed'),
             ];
           }),
         IconButton(onPressed: (){}, icon: const Icon(Icons.search))
       ],
     ), 
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context){
           return CreateTodoView();
         }));
       },
       child: const Icon(Icons.add),
       backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
    ),
    body: ListView.separated(
      padding: const EdgeInsets.all(16),
     itemBuilder: (context,index){
       return TaskCardWidget(
         dateTime: selectedItem == 'todo'
         ? _unCompletedData[index]['date_time']
         : _completedData[index]['date_time'],
         title: selectedItem == 'todo'
         ? _unCompletedData[index]['title']
         : _completedData[index]['title'],
         description: selectedItem == 'todo'
         ? _unCompletedData[index]['description']
         : _completedData[index]['description'],
       );
     },
     separatorBuilder: (context,index){
       return const SizedBox(
         height: 10,
       );
     },
     itemCount: selectedItem == 'todo'
     ?_unCompletedData.length :
     _completedData.length),
    bottomNavigationBar:SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
        child: InkWell(
          onTap: (){
            showBarModalBottomSheet(
              context: context, 
              builder: (context){
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context,index){
                  return TaskCardWidget(
                    dateTime: _completedData[index]['date_time'],
                    description: _completedData[index]['description'],
                    title: _completedData[index]['title'],
                    );
                }, 
              separatorBuilder: (context,index){
                return const SizedBox(height: 8);
              },
               itemCount: _completedData.length);
            });
          },
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(37, 43, 103, 1),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                  size: 30,
                  color: Colors.white,),
                  const SizedBox(
                    width: 15,
                  ),
                 const  Text(
                    'Completed',
                   style:TextStyle(color: Colors.white, fontSize: 20,
                   fontWeight: FontWeight.bold),
                   ),
                  const Spacer(), 
                   Text(
                     '${_completedData.length}',
                    style: const TextStyle(fontSize: 18,color: Colors.white)),
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

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key,required this.title, required this.description, required this.dateTime}) : super(key:key);

final String title;
final String description;
final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
     padding: const EdgeInsets.all(15),
     child: Row(
       children: [
        Icon(Icons.check_circle_outline_outlined,
        size: 30,
        color: customColor(
          date: dateTime
        ),),
        const SizedBox(
          width: 10,
       ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              Text(
              title,
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: 
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color.fromRGBO(37, 43, 103, 1)),
              ),
              Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, 
              style: 
              const TextStyle(fontSize: 16, color: Colors.grey))
            ],
          ),
        ),
        const SizedBox(width: 15,),
        Row(
          children: [
            Icon(Icons.notifications_outlined,
             color: customColor()
             ),
            Text(
             dateTime,
             style: TextStyle(
               color: customColor(
                 date:dateTime)),
             ),
          ],
        )
       ],
     ),
      ),
    );
  }
}