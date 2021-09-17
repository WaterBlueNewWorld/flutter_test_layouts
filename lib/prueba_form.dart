import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ObservacionForm extends StatefulWidget{
  final int idFatiga;
  final String nombre;

  ObservacionForm({
    @required this.idFatiga,
    this.nombre = 'vacio'
  });

  @override
  ObservacionFormState createState() => ObservacionFormState();
}

class ObservacionFormState extends State<ObservacionForm>{
  TextEditingController _campo1;
  final GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          if(_formKey.currentState.validate()){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        },
        child: Icon(Icons.save),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Observaciones', style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.light? Colors.black : Colors.white),),
        shadowColor: Theme.of(context).shadowColor,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Form(
          key: _formKey,
          child: Wrap(
            spacing: 5.0,
            children: [
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.ac_unit_outlined)),
                controller: _campo1,
                cursorColor: Colors.purple,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Por favor llene este campo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.ac_unit_outlined)),
                cursorColor: Colors.purple,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Por favor llene este campo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.ac_unit_outlined)),
                cursorColor: Colors.purple,
                maxLines: 4,
                minLines: 1,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(200)

                ],
                validator: (value){
                  if (value == null || value.isEmpty || value.length <= 50) {
                    return 'Por favor llene este campo';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
