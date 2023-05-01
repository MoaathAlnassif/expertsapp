import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultBotton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultformfield({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function suffixPressed,
  @required Function validate,
  @required String label,
  bool isPassword = false,
  @required IconData prefix,
  IconData suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
            icon: Icon(suffix)) : null,
        border: OutlineInputBorder(),
      ),
    );
