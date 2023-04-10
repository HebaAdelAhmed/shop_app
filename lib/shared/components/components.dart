import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultButton
    ({
      double width = double.infinity ,
      Color backgroundColor = Colors.blue ,
      double redius = 0.0,
      required Function() function ,
      required String text ,
}){
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(redius),
    ),
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget defaultTextFormField
({
      required TextEditingController controller,
      required TextInputType keyboardType,
      Function(String value) ? onSubmit,
      required String? Function( String ? value) validation,
      Function(String value) ? onChange,
      required String fieldName,
      required IconData prefixIcon,
      IconData ? suffixIcon,
      Function() ? onPressedSuffixIcon,
      bool obscureText = false,
      Function() ? onTap,
      int ? maxLines = 1,
      int ? minLines,
      bool isClickable = true,
}){
  return TextFormField(
    onTap: onTap,
    enabled: isClickable,
    minLines: minLines,
    maxLines: maxLines,
    obscureText: obscureText,
    controller: controller,
    keyboardType: keyboardType,
    onFieldSubmitted: onSubmit,
    validator: validation,
    onChanged: onChange,
    decoration: InputDecoration(
      labelText: fieldName,
      border: OutlineInputBorder(),
      prefixIcon: Icon(
          prefixIcon
      ),
      suffixIcon: IconButton(
        onPressed: onPressedSuffixIcon,
        icon: Icon(
            suffixIcon
        ),
      ),
    ),
  );
}

Widget buildTaskItem({required Map model}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(model['time']),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              model['data'],
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


void navigateTo({required BuildContext context , required Widget widget}){
  Navigator.push(
      context ,
      MaterialPageRoute(
          builder: (context) => widget
      ),
  );
}

void navigateAndFinish({required BuildContext context , required Widget widget}){
  Navigator.pushReplacement(
    context ,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Widget defaultTextButton ({required String text , required Function() function}){
  return TextButton(
    child: Text(
      text.toUpperCase(),
    ),
    onPressed: function,
  );
}

void showToast({
  required String text,
  required ToastStates toastStates
}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(toastStates),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates{ SUCCESS , ERROR , WARNING }

Color chooseToastColor(ToastStates toastStates){
  late Color color;
  switch(toastStates){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}