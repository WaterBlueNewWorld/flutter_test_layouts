import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Formulario extends StatefulWidget{

  FormularioState createState() => FormularioState();

}

class FormularioState extends State<Formulario>{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Shortcuts(
          shortcuts: {},
          child: FocusTraversalGroup(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(context)?.save();
              },
              child: Wrap(
                children: List<Widget>.generate(5, (int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(300, 50)),
                      child: TextFormField(
                        enabled: false,
                        validator: (String? value) {
                          return (value!.isEmpty) ? 'Do not use the @ char.' : null;
                        },
                        onSaved: (String? value) {
                          print('Value for field $index saved as "$value"');
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
