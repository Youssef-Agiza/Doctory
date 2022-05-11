import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:health_monitoring_system/models/adminModel.dart';

import '../../../../constants.dart';
//import '../../../constants.dart';

class adminRegristration extends StatefulWidget {
  adminRegristration({
    Key? key,
    required this.formKey,
    required this.admins,
  }) : super(key: key);

  final GlobalKey formKey;
  final Admins admins;

  @override
  State<adminRegristration> createState() => _adminRegristrationState();
}

class _adminRegristrationState extends State<adminRegristration> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "Admin Name"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter Admin Name"),
            validator: RequiredValidator(errorText: "Admin Full name is required"),
            // Let's save our username
            onSaved: (adminname) => widget.admins.adminName = adminname!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "User Name"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter User Name"),
            validator: RequiredValidator(errorText: "User name is required"),
            // Let's save our username
            onSaved: (username) => widget.admins.userName = username!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Address"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter Address"),
            validator: RequiredValidator(errorText: "User name is required"),
            // Let's save our username
            onSaved: (username) => widget.admins.address = username!,
          ),
          const SizedBox(height: defaultPadding),
          const TextFieldName(text: "Birth Date"),
          TextFormField(
              keyboardType: TextInputType.datetime,
              // decoration: InputDecoration(hintText: "test@email.com"),
              // onTap: ()async{
              //    date = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(1900),
              //       lastDate: DateTime(2100));
              // },
              onSaved: (bod) => widget.admins.birthdate = bod!),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Phone"),
          // Same for phone number
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "+91 0123456789"),
            validator: (String? value) {
              Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
              RegExp regex = RegExp(pattern.toString());

            },
            onSaved: (phoneNumber) => widget.admins.contNo = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: const InputDecoration(hintText: "******"),
            validator: passwordValidator,
            onSaved: (password) => widget.admins.password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            onChanged: (pass) => widget.admins.password = pass,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Confirm Password"),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(hintText: "******"),
            validator: (pass) =>
                MatchValidator(errorText: "Password do not  match")
                    .validateMatch(pass!, widget.admins.password),
          ),
        ],
      ),
    );
  }

  void bookFlight(BuildContext context) {
    var alertDialog = const AlertDialog(
      title: Text("Form submitted successfully!"),
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
