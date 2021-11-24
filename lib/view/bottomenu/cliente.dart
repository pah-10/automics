//
// TELA CADASTRO CLIENTES
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:automics/data/class.dart';
import 'package:flutter/material.dart';

class TelaCliente extends StatefulWidget {
  const TelaCliente({Key? key}) : super(key: key);

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  //lista dinâmica para armazenamento dos clientes
  
  
  var listaClientes = <Cliente>[];
  //
  // RETORNAR um ÚNICO DOCUMENTO a partir do ID
  //
  getDocumentById(id) async{
    await FirebaseFirestore.instance.collection('Clientes')
      .doc(id).get().then((doc) {
        txtCPF.text = doc.get('CPF');
        txtDtNascimento.text = doc.get('Data de Nascimento');
        txtEmail.text = doc.get('Email');
        txtCidade.text = doc.get('Endereço');
        txtNome.text = doc.get('Nome');
      });
  }

  //variaveis que receberam os valores dos inputs
  var txtNome = TextEditingController();
  var txtCPF = TextEditingController();
  var txtDtNascimento = TextEditingController();
  var txtTelefone = TextEditingController();
  var txtEmail = TextEditingController();
  var txtCidade = TextEditingController();

  //Pré-cadastro de clientes
  @override 
  void initState() {
    
    listaClientes.add(Cliente('Paola paulina de jesus santa Capita', '000.000.000-00', '07/08/2002', '(16) 99999-9999', 'paola@capita', 'Jaboticabal, SP'),);
    listaClientes.add(Cliente('Breno Murige', '000.000.000-00', '12/11/2001', '(16) 11111-1111', 'breno@murige', 'Ribeirão Preto, SP'),);
    listaClientes.add(Cliente('Lucas Silva', '000.000.000-00', '01/01/2001', '(11) 00000-0000', 'lucas@sksxkmilva', 'São Paulo, SP'),);
    listaClientes.add(Cliente('Maria Clara Costa', '000.000.000-00', '08/08/08', '(15) 77777-7777', 'maria@silva', 'Franca, SP'),);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),

        // Listagem dos clientes
        child: ListView.builder(
          //quantidade de elementos da lista
          itemCount: listaClientes.length,

          //defini a aparência dos elementos
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey.shade100,
              shadowColor: Colors.blue,
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),

              child: ListTile(
                title: Text(listaClientes[index].nome,style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
                subtitle: Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10,),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.badge_outlined,color: Colors.grey.shade500),
                          Text(listaClientes[index].cpf),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.phone_outlined,color: Colors.grey.shade500),
                          Text(listaClientes[index].telefone),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.alternate_email_outlined, color: Colors.grey.shade500),
                          Text(listaClientes[index].email),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.place_outlined,color: Colors.grey.shade500),
                          Text(listaClientes[index].endereco),
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
                                  listaClientes.removeAt(index);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Cliente removido com sucesso'),
                                      duration: Duration(seconds: 2),
                                    )
                                  );  
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
              ),
            );
          },
        ),
      ),

      //
      // Adicionar novos clientes
      //

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
                            var msg = '';
                            if (txtNome.text.isNotEmpty &&
                                txtCPF.text.isNotEmpty &&
                                txtDtNascimento.text.isNotEmpty &&
                                txtTelefone.text.isNotEmpty &&
                                txtEmail.text.isNotEmpty &&
                                txtCidade.text.isNotEmpty) {
                              listaClientes.add(Cliente(
                                  txtNome.text,
                                  txtCPF.text,
                                  txtDtNascimento.text,
                                  txtTelefone.text,
                                  txtEmail.text,
                                   txtCidade.text));

                                   FirebaseFirestore.instance.collection('Cliente').add({
                                    'CPF': txtCPF.text,
                                    'Data de Nascimento': txtDtNascimento.text,
                                    'Email': txtEmail.text,
                                    'Endereço': txtCidade.text,
                                    'Nome': txtNome.text,
                                    });

                             txtNome.clear();
                              txtCPF.clear();
                              txtDtNascimento.clear();
                              txtTelefone.clear();
                              txtEmail.clear();
                              txtCidade.clear();

                              msg = 'Cliente adicionada com sucesso.';
                            } else {
                              msg =
                                  'Erro: Preencha todos os campos!';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(msg),
                                duration: Duration(seconds: 2),
                              ),
                            );
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
              });
        },
      ),
    );
  }
}

