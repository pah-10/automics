//
// TELA CADASTRO DE USUARIOS MECANICOS
//

import 'package:automics/data/class.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //lista dinâmica para armazenamento dos usuáriosmecanicos
  var listaMecanico = <Mecanico>[];

  //Variaveis de controle do login
  var txtemailCadastro = TextEditingController();
  var txtSenhaCadastro = TextEditingController();
  var txtNomeCadastro = TextEditingController();

  @override void initState() {

    listaMecanico.add(Mecanico('paola@capita', '7', 'Paola Capita'));
    listaMecanico.add(Mecanico('breno@augusto', '123', 'Breno Augusto'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0,),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset('lib/imagens/logo_desfocada.png', scale: 2,),

            Text('Criar Conta', style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor,),),

            SizedBox(height: 20,),

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

            SizedBox(height: 25,),

            SizedBox(
              width: 200,

              child: ElevatedButton(
                child: Text('Cadastrar', style: TextStyle(fontSize: 20,),),
                style: ElevatedButton.styleFrom(shape: StadiumBorder(), primary: Theme.of(context).primaryColor,),
                
                onPressed: () {
                  setState(() {
                    var msg = '';

                    if (txtNomeCadastro.text.isNotEmpty && txtemailCadastro.text.isNotEmpty && txtSenhaCadastro.text.isNotEmpty) {
                      listaMecanico.add(Mecanico(txtemailCadastro.text, txtSenhaCadastro.text, txtNomeCadastro.text));

                      txtNomeCadastro.clear();
                      txtemailCadastro.clear();
                      txtSenhaCadastro.clear();

                      msg = 'Cadastro de usuário concluido!';

                      Navigator.pushNamed(context, 'login');
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

            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}