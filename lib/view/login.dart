//
// TELA LOGIN
//
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isLoading = false;
  bool manterLogado = false;
  String NomeUse = "";

  @override
  Widget build(BuildContext context) {

    NomeUse = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(

      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        margin: EdgeInsets.fromLTRB(
          15,
          0,
          15,
          0,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/imagens/logo_desfocada.png',
              scale: 1.5,
            ),
            Text(
              'Entrar',
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtUsuario,
              decoration: InputDecoration(
                icon: Icon(Icons.email), //icon at head of input
                labelText: "Email",
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: manterLogado,
                onChanged: (value) {
                  setState(() {
                    manterLogado = !manterLogado;
                  });
                },
              ),
              Text(
                "Manter-me Logado",
                style: TextStyle(fontSize: 15),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                label: Text(
                  'Acessar',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(
                  Icons.arrow_right_alt,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(
                    () {
                      bool isLoading = true;

                      if (txtUsuario.text.isNotEmpty &&
                          txtSenha.text.isNotEmpty) {
                        login(txtUsuario.text, txtSenha.text);
                      } else {
                        exibirMensagem('Erro: Preencha todos os campos!');
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  //
  //LOGIN COM O FIREBASE
  //
  void login(email, senha) {
    FirebaseAuth.instance.setPersistence(Persistence.SESSION).then((value) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha)
          .then((value) {
        Navigator.pushReplacementNamed(context, 'menu');
        exibirMensagem('Bem vindo ' + NomeUse + '!');
      }).catchError((erro) {
        if (erro.code == 'user-not-found' ||
            erro.code == 'wrong-password' ||
            erro.code == 'invalid-email') {
          exibirMensagem(
              'ERRO: Credenciais de acesso incorretas ou usuário não existente!.');
        }
      });
    }).catchError((erro) {
      exibirMensagem('ERRO: ${erro.message}.');
    });
  }

  void exibirMensagem(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }
}