import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class calculatorDemo extends StatelessWidget{

  static List<String> textList=["C","D","%","/",
                                '7','8','9','*',
                                '4','5','6','-',
                                '3','2','1','+',
                                '-','0','.','='];

  static TextEditingController textEditingController = TextEditingController();

  static TextEditingController showText = TextEditingController();

  static var befroStr=0;
  static var lastStr=0;

  static var inputStr=0;

  static var type='';
  static var numList=List<numberBean>();

  var showT= new TextField(
    controller: showText,
    decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
        labelText: ''
    ),

  );
  var edt= new TextField(
    controller: textEditingController,
    decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
        labelText: ''
    ),

  );

  var  myGrildView =GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1.0,
    ),
    itemCount: textList.length,
    itemBuilder: (context,index){
      var myView=InkWell(
        onTap: (){
            switch(textList[index]){
              case '+':
                numList.add(new numberBean(lastStr, '+'));
                lastStr=0;
                flashText();
                break;
              case '-':
                numList.add(new numberBean(lastStr, '-'));
                lastStr=0;
                flashText();
                break;
              case '*':
                numList.add(new numberBean(lastStr, '*'));
                lastStr=0;
                flashText();
                break;
              case '/':
                numList.add(new numberBean(lastStr, '/'));
                lastStr=0;
                flashText();
                break;
              case '%':
                numList.add(new numberBean(lastStr, '%'));
                lastStr=0;
                flashText();
                break;
              case '=':
                numList.add(new numberBean(lastStr, '='));

                int temN=clut();
//                for(var i=0;i<numList.length-1;i++){
//                  clul(numList[i], numList[i+1]);
//
//                }
                lastStr=temN;
                textEditingController.text=lastStr.toString();
                numList.clear();
                showText.text="";
                break;
              case 'D':
                lastStr=0;
                numList.clear();
                textEditingController.text=lastStr.toString();
                break;
              case 'C':
                lastStr=int.parse(lastStr.toString().substring(0,lastStr.toString().length-1));
                var strlength=lastStr.toString().length;
                print('当前字符 $lastStr 字符长度： $strlength');
                textEditingController.text=lastStr.toString();
                break;
              default:
                if(lastStr!=0){
                  lastStr=int.parse(lastStr.toString()+textList[index]);
                }else{
                  lastStr=int.parse(textList[index]);
                }
                textEditingController.text=lastStr.toString();
                break;
            }
            },

        child:  new Center(child:Text(textList[index])),
      );

      return myView;
    },

  );
  static int  clulss(int num1,int num2,String type){

      int temNumber;
    switch(type){
      case'+':
        temNumber=num1+num2;
      break;
    case'-':
      temNumber=num1-num2;
      break;
    case'*':
      temNumber=num1*num2;
      break;
    case'/':
      temNumber=num1~/num2;
      break;
    case'%':
      temNumber=num1%num2;
      break;
  }
  print('clul  temNumber:  $temNumber');
  return temNumber;
  }


  static int  clut(){
    int temN=numList[0].number;
    for(var i=0;i<numList.length-1;i++){
      temN=clulss(temN, numList[i+1].number,numList[i].type);
    }
    return temN;

  }

  static void flashText(){
     var temStr="";
    for(var bean in numList){
       temStr+=bean.number.toString()+bean.type;
       print(temStr);
       showText.text=temStr;
     }
     textEditingController.text=lastStr.toString();
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(child: showT,width: 300,height: 40,),
        Container(child: edt,width: 300,height: 40,),
        Expanded(child: myGrildView,),

      ],
    ) ;
  }




}


class numberBean{
  String type;
  int number;

  numberBean(this.number, this.type);

}

void main (){
  runApp(new MaterialApp(title:'计算器',home:new Scaffold(
    appBar: AppBar(
      title: Text('计算器'),
        ) ,
      body:     new Scaffold(body: calculatorDemo(),),
  )) );
}