//
// TELA CADASTRO DE USUARIOS MECANICOS
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Variaveis de controle do login
  var txtemailCadastro = TextEditingController();
  var txtSenhaCadastro = TextEditingController();
  var txtNomeCadastro = TextEditingController();
  var txtHashCadastro = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        margin: EdgeInsets.fromLTRB(
          15,
          0,
          15,
          0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/imagens/logo_desfocada.png',
              scale: 2,
            ),
            Text(
              'Criar Conta',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtNomeCadastro,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Nome de Usuario",
              ),
            ),
            TextField(
              controller: txtemailCadastro,
              decoration: InputDecoration(
                icon: Icon(Icons.email), //icon at head of input
                labelText: "Email",
              ),
            ),
            TextField(
              controller: txtSenhaCadastro,
              decoration: InputDecoration(
                icon: Icon(Icons.lock), //icon at head of input
                labelText: "Senha", //icon at tail of input
              ),
            ),
            TextField(
              controller: txtHashCadastro,
              decoration: InputDecoration(
                icon: Icon(Icons.lock), //icon at head of input
                labelText:
                    "Código do seu Banco de Dados", //icon at tail of input
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(
                    () {
                      if (txtNomeCadastro.text.isNotEmpty &&
                          txtemailCadastro.text.isNotEmpty &&
                          txtSenhaCadastro.text.isNotEmpty &&
                          txtHashCadastro.text.isNotEmpty) {
                        criarConta(
                          txtNomeCadastro.text,
                          txtemailCadastro.text,
                          txtSenhaCadastro.text,
                          txtHashCadastro.text,
                        );

                        txtNomeCadastro.clear();
                        txtemailCadastro.clear();
                        txtSenhaCadastro.clear();
                        txtHashCadastro.clear();
                      } else {
                        exibirMensagem('ERRO: Preencha todos os campos!');
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  //
  // CRIAR CONTA no Firebase Auth
  //
  void criarConta(nome, email, senha, hash) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((value) {
      exibirMensagem('Cadastro de usuário concluido!');

      FirebaseFirestore.instance.collection('Usuarios').add({
        'Nome': nome,
        'Email': email,
        'Hash': hash,
      });

      Navigator.pushReplacementNamed(context, 'login', arguments: nome);
    }).catchError((erro) {
      if (erro.code == 'email-already-in-use') {
        exibirMensagem('ERRO: O email informado está em uso.');
      } else if (erro.code == 'invalid-email') {
        exibirMensagem('ERRO: Email inválido.');
      } else {
        exibirMensagem('ERRO: ${erro.message}');
      }
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
