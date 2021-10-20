//
// TELA INICIAL DO APP
//

import 'package:flutter/material.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key? key}) : super(key: key);

  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      body: Container(
        margin: EdgeInsets.fromLTRB(0,20,0,20),
        alignment: Alignment.center,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Image.asset('lib/imagens/logo.png', scale: 1.5,),

                Text('Banco de Dados Automotivo', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
                  
              children: [
                SizedBox(
                  width: 300,
                  height: 50,

                  child: ElevatedButton(
                    child: Text('Login', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), 
                      primary: Colors.white
                    ),

                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                  ),
                ),

                SizedBox(height: 10),
                
                Text('Ainda não tem uma conta?', style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.bold),),

                SizedBox(height: 10),

                SizedBox(
                  width: 300,
                  height: 50,
                  
                  child: ElevatedButton(
                    child: Text('Cadastre-se', style: TextStyle(fontSize: 20, color: Colors.white),),

                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(width: 2, color: Colors.white)
                    ),

                    onPressed: () {
                      Navigator.pushNamed(context, 'cadastro');
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}