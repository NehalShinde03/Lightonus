import 'package:flutter/material.dart';

class SizedConfig{

  static late double _width;
  static late double _height;

  static double _vertical=0;
  static double _horizontal=0;

  static late double txtAdjust;
  static late double imgAdjust;
  static double heightAdjust=0;
  static double widthAdjust=0;

  void init(BoxConstraints constraints, Orientation orientation){

    if(orientation==Orientation.portrait){
      _width=constraints.maxWidth;
      _height=constraints.maxHeight;
    }
    else{
      _width=constraints.maxHeight;
      _height=constraints.maxWidth;
    }

    _vertical=_height/100;
    _horizontal=_width/100;

    txtAdjust=_vertical;
    imgAdjust=_horizontal;
    heightAdjust=_vertical;
    widthAdjust=_horizontal;


    print('_vertical=$_vertical');
    print('_horizontal=$_horizontal');
    print('txtAdjust=$txtAdjust');
    print('imgAdjust=$imgAdjust');
    print('heightAdjust=${heightAdjust}');
    print('widthAdjust=${widthAdjust}');

  }

}