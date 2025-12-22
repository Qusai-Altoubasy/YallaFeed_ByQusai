import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isClickable=true,
  IconData? suffix,
  Function? suffixPressed,
  Color textColor =Colors.white,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s){
        onSubmit!(s);
      },
      onChanged: (s){
        onChange!(s);
      },
      onTap: (){
        onTap!();
      },
      validator: (s){
        return validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        ) : null,
        border: OutlineInputBorder(),
      ),
    );


Widget defaultButton({
  double width = double.infinity,
  double height = 52,
  bool isUpperCase = true,
  double radius = 18.0,
  Color background = const Color(0xFF2F855A),
  Color textColor = Colors.white,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2F855A),
            Color(0xFF68D391),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F855A).withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: function,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );