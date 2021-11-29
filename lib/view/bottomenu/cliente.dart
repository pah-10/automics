//
// TELA DE CLIENTES
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaCliente extends StatefulWidget {
  const TelaCliente({Key? key}) : super(key: key);

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {

  //Referenciar a colecao do Firestore
  late CollectionReference clientes;

  //variaveis que receberam os valores dos inputs
  var txtNome = TextEditingController();
  var txtCPF = TextEditingController();
  var txtDtNascimento = TextEditingController();
  var txtEmail = TextEditingController();
  var txtCidade = TextEditingController();
  var txtTelefone = TextEditingController();

  getDocumentById(id) async{
    await FirebaseFirestore.instance.collection('clientes')
      .doc(id).get().then((doc) {
        txtNome.text = doc.get('nome');
      });
  }

  @override
  void initState() {
   super.initState();

    //Instancia o acesso ao banco
    clientes = FirebaseFirestore.instance.collection('clientes');
  }
  
  // Especifica a aparencia de cada elemento da lista
  exibirItemColecao(item){

    //variaveis que receberam os valores do banco
    String nome = item.data()['nome'];
    String cpf = item.data()['cpf'];
    String dataNascimento = item.data()['dataNascimento'];
    String email = item.data()['email'];
    String telefone = item.data()['telefone'];
    String endereco = item.data()['endereco'];

    return ListTile(
      title: Text(nome, style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),

      subtitle: Container(
        margin: EdgeInsets.fromLTRB(15,10,15,10),

        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.badge_outlined, color: Colors.grey.shade500),
                Text(cpf),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.grey.shade500),
                Text(dataNascimento),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email_outlined, color: Colors.grey.shade500),
                Text(email),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone_outlined, color: Colors.grey.shade500),
                Text(telefone),
              ],
            ),
            Row(
              children: [
                Icon(Icons.place_outlined, color: Colors.grey.shade500),
                Text(endereco),
              ],
            ),
          ],
        ),
      ),
      
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.red.shade500),

        onPressed: () {
          showDialog(
            context: context,

            builder: (context) {
              return AlertDialog(
                title: Text('Deseja mesmo remover este cliente?', style: TextStyle(fontSize: 20)),

                content: Icon(Icons.attribution, color: Theme.of(context).primaryColor, size: 50),

                actions: [
                  TextButton(
                    child: Text('Remover'),
                    
                    onPressed: () {
                      setState(() {
                        clientes.doc(item.id).delete();
                        
                        exibirMensagem('Cliente removido com sucesso');
                      });
                      Navigator.pop(context);
                    },
                  ),

                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),

      onTap: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Editar Cliente', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),

                content: Container(

                  child: SingleChildScrollView(

                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        TextField(
                          maxLength: 60,
                          controller: txtNome,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Nome Completo",
                          ),
                        ),
                        TextField(
                          maxLength: 14,
                          controller: txtCPF,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "CPF",
                          ),
                        ),
                        TextField(
                          maxLength: 10,
                          controller: txtDtNascimento,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Data nascimento",
                          ),
                        ),
                        TextField(
                          maxLength: 14,
                          controller: txtTelefone,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Telefone",
                          ),
                        ),
                        TextField(
                          maxLength: 30,
                          controller: txtEmail,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                        ),
                        TextField(
                          maxLength: 30,
                          controller: txtCidade,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Cidade",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                actions: [
                  TextButton(
                    child: Text('ok'),

                    onPressed: () {
                      setState(() {
                        
                          if (txtNome.text.isNotEmpty && txtCPF.text.isNotEmpty && txtDtNascimento.text.isNotEmpty && txtTelefone.text.isNotEmpty && txtEmail.text.isNotEmpty && txtCidade.text.isNotEmpty) {
                             
                            //txtNome = clientes.doc(item.id).get('nome');

                            getDocumentById(item.id);

                           editarCliente(
                              item.id,txtNome.text, txtCPF.text, txtDtNascimento.text, txtEmail.text, txtCidade.text, txtTelefone.text
                            );

                            txtNome.clear();
                            txtCPF.clear();
                            txtDtNascimento.clear();
                            txtTelefone.clear();
                            txtEmail.clear();
                            txtCidade.clear();

                            exibirMensagem('Cliente editado com sucesso.');
                          } else {
                            exibirMensagem('Erro: Preencha todos os campos!');
                          }

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                  TextButton(
                    child: Text('cancelar'),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // LISTAR DOCS DA COLECAO
      body: StreamBuilder<QuerySnapshot>(
            
            //fonte de dados (colecao)
            stream: clientes.snapshots(),

            //exibir dados retornados
            builder: (context, snapshot){

              //verificar o estado da conexao
              switch(snapshot.connectionState){

                case ConnectionState.none:
                  return const Center(child: Text('Não foi possível se conectar ao banco de dados'),);
                
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator(),);

                // se os dados foram recebidos com sucesso
                default:
                  final dados = snapshot.requireData;
                  return ListView.builder(
                    itemCount: dados.size,

                    itemBuilder: (context, index){
                      return Card(
                        color: Colors.grey.shade100,

                        shadowColor: Colors.blue,

                        elevation: 20,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),

                        child: exibirItemColecao(dados.docs[index]),
                      );
                    }
                  );
              }
            }
          ),
      
      // Adicionar novos clientes
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Adicionar Cliente', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),

                content: Container(

                  child: SingleChildScrollView(

                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        TextField(
                          maxLength: 60,
                          controller: txtNome,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Nome Completo",
                          ),
                        ),
                        TextField(
                          maxLength: 14,
                          controller: txtCPF,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "CPF",
                          ),
                        ),
                        TextField(
                          maxLength: 10,
                          controller: txtDtNascimento,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Data nascimento",
                          ),
                        ),
                        TextField(
                          maxLength: 14,
                          controller: txtTelefone,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Telefone",
                          ),
                        ),
                        TextField(
                          maxLength: 30,
                          controller: txtEmail,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                        ),
                        TextField(
                          maxLength: 30,
                          controller: txtCidade,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelText: "Cidade",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                actions: [
                  TextButton(
                    child: Text('ok'),

                    onPressed: () {
                      setState(() {
                          if (txtNome.text.isNotEmpty && txtCPF.text.isNotEmpty && txtDtNascimento.text.isNotEmpty && txtTelefone.text.isNotEmpty && txtEmail.text.isNotEmpty && txtCidade.text.isNotEmpty) {
                            criarCliente(
                              txtNome.text, txtCPF.text, txtDtNascimento.text, txtEmail.text, txtCidade.text, txtTelefone.text,
                            );

                            txtNome.clear();
                            txtCPF.clear();
                            txtDtNascimento.clear();
                            txtTelefone.clear();
                            txtEmail.clear();
                            txtCidade.clear();

                            exibirMensagem('Cliente adicionada com sucesso.');
                          } else {
                            exibirMensagem('Erro: Preencha todos os campos!');
                          }

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                  TextButton(
                    child: Text('cancelar'),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
          );
        },
      ),
    );
  }

  // CRIAR CONTA no Firebase Auth
  void criarCliente(nome, cpf, dtNascimento, email, endereco, telefone) {
    FirebaseFirestore.instance.collection('clientes').add({
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dtNascimento,
      'email': email,
      'endereco': endereco,
      'telefone': telefone,
    });
  }

  // EDITAR CONTA no Firebase Auth
  void editarCliente(id, nome, cpf, dtNascimento, email, endereco, telefone) {
    FirebaseFirestore.instance.collection('clientes').doc(id).set({
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dtNascimento,
      'email': email,
      'endereco': endereco,
      'telefone': telefone,
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