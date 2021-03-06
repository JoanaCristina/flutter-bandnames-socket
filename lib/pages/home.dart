import 'dart:io';
import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'System Fail Down', votes: 3),
    Band(id: '3', name: 'CPM 22', votes: 4),
    Band(id: '4', name: 'Charlie Brown', votes: 5),
    Band(id: '5', name: 'Renato Russo', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BandNames', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white,
          elevation: 1,
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: addNewBand,
          child: Icon(Icons.add),
          elevation: 2,
        ),
        body: ListView.builder(
            itemCount: bands.length, 
            itemBuilder: (_, index)=> _bandTile(bands[index])
            ));

  }


    Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left:8.0),
          color:Colors.red,
      child:Align(
        alignment: Alignment.centerLeft,
          child: Text("Delete Band",
          style: TextStyle(
            color:Colors.white
          ),),
      )),
      onDismissed: (direction){
        setState(() {
          bands.remove(band);
        });},
      confirmDismiss: (direction){
        return showDialog(
          context:context,
          child:AlertDialog(
            title:Text("Eliminar Banda..."),
            content: Text("Deseas eliminar la banda: ${band.name}"),
            actions: [
              MaterialButton(
                textColor:Colors.blue,
                onPressed:()=> Navigator.pop(context,true),
                child:Text("Confirm"),
                elevation:5
              ),

              MaterialButton(
                  textColor:Colors.red,
                  onPressed:()=> Navigator.pop(context,false),
                  child:Text("No"),
                  elevation:5
              ),


            ],
          )
        );
      },
      child: ListTile(
                leading: CircleAvatar(
                  child: Text(band.name.substring(0,2)),
                  backgroundColor: Colors.blue[100],
                ),
        title: Text(band.name),
        trailing: Text('${band.votes.toString()}',style:TextStyle(fontSize: 20)),
        onTap: ()=>print(band.name),
              ),

    );
  }

    addNewBand(){
   final textController= TextEditingController();

   if(Platform.isAndroid){
      return showDialog(
       context: context,
       builder:(context){
         return AlertDialog(
           title: Text('New Band name'),
           content:TextField(
               controller:textController
           ),
           actions: [
             MaterialButton(
                 child:Text('Add'),
                 elevation:5,
                 textColor: Colors.blue,
                 onPressed:(){
                   addBandToList(textController.text);
                 }
             ),
           ],
         );
       },
     );
   }
   showCupertinoDialog(
       context: context,
       builder: (_){
         return CupertinoAlertDialog(
           title:Text("New band name:"),
           content: CupertinoTextField(
             controller:textController,
           ),
           actions: [
             CupertinoDialogAction(
               isDefaultAction: true,
               child:Text('Add'),
               onPressed: ()=> addBandToList(textController.text),
             ),

             CupertinoDialogAction(
               isDestructiveAction: true,
               child:Text('Dismiss'),
               onPressed: ()=> Navigator.pop(context),
             )
           ],
         );

       }

   );





    }

    void addBandToList(String name){
    if(name.length>1){
      setState(() {
        this.bands.add(Band(
            id:(bands.length+1).toString() ,
            name:name,
            votes: bands.length+3));

      });
    }

    Navigator.pop(context);


    }





}
