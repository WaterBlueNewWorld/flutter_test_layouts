import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Informacion de usuario',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Arial'
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(image: ExactAssetImage('assets/images/Logo2'),fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Leer QR'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.delete_outline_sharp),
            title: Text("Eliminar"),
            onTap: () async{},
          ),
        ],
      ),
    );
  }

}