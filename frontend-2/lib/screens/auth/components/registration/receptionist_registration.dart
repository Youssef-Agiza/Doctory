import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:health_monitoring_system/models/receptionistModel.dart';

import '../../../../constants.dart';
//import '../../../constants.dart';

class receptionistRegristration extends StatefulWidget {
  receptionistRegristration({
    Key? key,
    required this.formKey,
    required this.receptionist,
  }) : super(key: key);

  final GlobalKey formKey;
  final Receptionist receptionist;

  @override
  State<receptionistRegristration> createState() => _receptionistRegristrationState();
}

class _receptionistRegristrationState extends State<receptionistRegristration> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(text: "Receptionist Name"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter Receptionist Name"),
            validator: RequiredValidator(errorText: "Receptionist Full name is required"),
            // Let's save our username
            onSaved: (receptionistName) => widget.receptionist.receptionistName = receptionistName!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "User Name"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter User Name"),
            validator: RequiredValidator(errorText: "User name is required"),
            // Let's save our username
            onSaved: (username) => widget.receptionist.userName = username!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Address"),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter Address"),
            validator: RequiredValidator(errorText: "User name is required"),
            // Let's save our username
            onSaved: (username) => widget.receptionist.address = username!,
          ),
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
            onSaved: (phoneNumber) => widget.receptionist.contNo = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: const InputDecoration(hintText: "******"),
            validator: passwordValidator,
            onSaved: (password) => widget.receptionist.password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            onChanged: (pass) => widget.receptionist.password = pass,
          ),
          const SizedBox(height: defaultPadding),

          const TextFieldName(text: "Confirm Password"),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(hintText: "******"),
            validator: (pass) =>
                MatchValidator(errorText: "Password do not  match")
                    .validateMatch(pass!, widget.receptionist.password),
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
