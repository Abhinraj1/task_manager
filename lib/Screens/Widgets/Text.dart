import "package:flutter/material.dart";



class text{
  style(String content, double fontSize){
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        letterSpacing: 1.5
      ),
    );
  }
}