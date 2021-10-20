//
// TELA LOGIN
//

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Variaveis de controle do login
  var txtUsuario = TextEditingController();
  var txtSenha = TextEditingController();
  bool manterLogado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0,),
        padding: EdgeInsets.symmetric(vertical: 10,),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset('lib/imagens/logo_desfocada.png', scale: 1.5,),

            Text('Entrar', style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),),

            SizedBox(height: 20,),

            TextField(
              controller: txtUsuario,

              decoration: InputDecoration(
                icon: Icon(Icons.person), //icon at head of input
                labelText: "Nome de Usuário",
              ),
            ),

            TextField(
              controller: txtSenha,
              decoration: InputDecoration(
                icon: Icon(Icons.lock), //icon at head of input
                labelText: "Senha",
                suffixIcon: Icon(Icons.remove_red_eye), //icon at tail of input
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              
              children: [ 
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  value: manterLogado,
                  onChanged: (value) {
                    setState(() {
                      manterLogado = !manterLogado;
                    });
                  },
                ),

                Text("Manter-me Logado", style: TextStyle(fontSize: 15),),
              ]
            ),

            SizedBox(height: 20,),

            SizedBox(
              width: 200,

              child: ElevatedButton.icon(
                label: Text('Acessar', style: TextStyle(fontSize: 20),),

                icon: Icon(Icons.arrow_right_alt, size: 40,),

                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Theme.of(context).primaryColor,
                ),

                onPressed: () {
                  setState(() {
                    var msg = '';

                    if (txtUsuario.text.isNotEmpty && txtSenha.text.isNotEmpty) {
                      msg = 'Bem vindo ' + txtUsuario.text + '!';
                      
                      Navigator.pushNamed(context, 'menu');
                    } else {
                      msg = 'Erro: Preencha todos os campos!';
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },);
                },
              ),
            ),

            SizedBox(height: 25,),

          ],
        ),
      ),
    );
  }
}