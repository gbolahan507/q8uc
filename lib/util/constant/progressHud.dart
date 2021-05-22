import 'package:flutter/material.dart';

class ProgressHud extends StatelessWidget {
  
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;
 
  ProgressHud({this.child, 
  this.inAsyncCall,
   this.opacity = 0.3,
   this.valueColor,
    this.color = Colors.grey  });

  @override
  Widget build(BuildContext context) {
     List<Widget> widgetList = new List<Widget>();
     widgetList.add(child);
     if(inAsyncCall){
       final modal = new Stack(
         children: [
           Opacity(opacity:  opacity,
           child: ModalBarrier(dismissible: false, color: color,),
           ),
           Center(
             child: CircularProgressIndicator(),
           )
         ],
       );
       widgetList.add(modal);
     }
      return Stack(
        children: 
          widgetList,
        
      );
  }
}







    
 
