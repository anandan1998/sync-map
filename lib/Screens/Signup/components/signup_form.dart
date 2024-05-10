import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';


import '../../../constants.dart';
import '../../Login/login_screen.dart';

import '../../Update/update_screen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}


class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  int? _numberInput;
  String? _dropdownInput;
  String? _textInput;





  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Patient number",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: SizedBox(
              width: 450,

              child: DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a disease';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dropdownInput = value;

                },
                decoration: InputDecoration(
                  labelText: '',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.health_and_safety),
                  ),

                ),
                value: 'Disease Name',
                items: [
                  DropdownMenuItem(
                    child: Text('Disease Name'),
                    value: 'Disease Name',
                  ),
                  DropdownMenuItem(
                    child: Text('Cancer'),
                    value: 'Cancer',
                  ),
                  DropdownMenuItem(
                    child: Text('Diabetes'),
                    value: 'Diabetes',
                  ),
                  DropdownMenuItem(
                    child: Text('Diabetes'),
                    value: 'Diabetes',
                  ),
                  DropdownMenuItem(
                    child: Text('Diabetes'),
                    value: 'Diabetes',
                  ),
                  DropdownMenuItem(
                    child: Text('Diabetes'),
                    value: 'Diabetes',
                  ),
                  DropdownMenuItem(
                    child: Text('Heart Disease'),
                    value: 'Heart Disease',
                  ),
                ], onChanged: (String? _dropdownInput) {  },
              ),

            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Select Zone",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_city),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Select Date",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.calendar_today),
                ),
              ),
              readOnly: true,
              onTap: () async{
                DateTime? pickedDate=await showDatePicker(context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if(pickedDate!=null){


                }else{
                  print("Not selected");
                }
              },
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return  NewScreen();
                  },
                ),
              );
            },
            child: Text("Submit".toUpperCase()),
          ),

        ],
      ),
    );



  }
}



