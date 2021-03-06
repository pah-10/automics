//
// TELA DE VEICULOS
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaVeiculo extends StatefulWidget {
  const TelaVeiculo({Key? key}) : super(key: key);

  @override
  _TelaVeiculoState createState() => _TelaVeiculoState();
}
//opções do radio

class _TelaVeiculoState extends State<TelaVeiculo> {
  //Referenciar a colecao do Firestore
  late CollectionReference veiculos;

  //Variáveis de adicao
  var txtPlaca = TextEditingController();
  var txtModelo = TextEditingController();
  var txtMarca = TextEditingController();
  var txtAno = TextEditingController();
  var txtKm = TextEditingController();
  var txtCor = TextEditingController();

  //Variaveis de edicao
  var txtPlaca2 = TextEditingController();
  var txtModelo2 = TextEditingController();
  var txtMarca2 = TextEditingController();
  var txtAno2 = TextEditingController();
  var txtKm2 = TextEditingController();
  var txtCor2 = TextEditingController();

  getDocumentById(id) async{
    await FirebaseFirestore.instance.collection('veiculos')
      .doc(id).get().then((doc) {
        txtPlaca.text = doc.get('placa');
      });
  }

  @override
  void initState() {
    super.initState();

    //Instancia o acesso ao banco
    veiculos = FirebaseFirestore.instance.collection('veiculos');
  }
  
  // Especifica a aparencia de cada elemento da lista
  exibirItemColecao(item){

    //variaveis que receberam os valores do banco
    String placa = item.data()['placa'];
    String modelo = item.data()['modelo'];
    String marca = item.data()['marca'];
    String ano = item.data()['ano'];
    String cor = item.data()['cor'];
    String km = item.data()['km'];

    return ListTile(
      title: Text(placa, style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),

      subtitle: Container(
        margin: EdgeInsets.fromLTRB(15,10,15,10),

        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.featured_play_list_outlined, color: Colors.grey.shade500),
                Text(modelo),
              ],
            ),
            Row(
              children: [
                Icon(Icons.featured_video_outlined, color: Colors.grey.shade500),
                Text(marca),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.grey.shade500),
                Text(ano),
              ],
            ),
            Row(
              children: [
                Icon(Icons.format_color_fill_outlined, color: Colors.grey.shade500),
                Text(cor),
              ],
            ),
            Row(
              children: [
                Icon(Icons.follow_the_signs_outlined, color: Colors.grey.shade500),
                Text(km),
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
                title: Text('Deseja mesmo remover este veiculo?', style: TextStyle(fontSize: 20)),

                content: Icon(Icons.attribution, color: Theme.of(context).primaryColor, size: 50),

                actions: [
                  TextButton(
                    child: Text('Remover'),
                    
                    onPressed: () {
                      setState(() {
                        veiculos.doc(item.id).delete();
                        
                        exibirMensagem('Veiculo removido com sucesso');
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
        txtPlaca2.text = placa;
        txtModelo2.text = modelo;
        txtMarca2.text = marca;
        txtAno2.text = ano;
        txtCor2.text = cor;
        txtKm2.text =  km;

          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Editar Veiculo', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),

                content: Container(

                  child: SingleChildScrollView(

                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        TextField(
                            controller: txtPlaca2,
                            maxLength: 8,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Placa",
                            ),
                          ),
                          TextField(
                            controller: txtModelo2,
                            maxLength: 30,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Modelo",
                            ),
                          ),
                          TextField(
                            controller: txtMarca2,
                            maxLength: 30,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Marca",
                            ),
                          ),
                          TextField(
                            controller: txtAno2,
                            maxLength: 4,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Ano",
                            ),
                          ),
                          TextField(
                            controller: txtKm2,
                            maxLength: 10,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "KM rodados",
                            ),
                          ),
                          TextField(
                            controller: txtCor2,
                            maxLength: 20,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Cor",
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
                        
                          if (txtPlaca2.text.isNotEmpty && txtModelo2.text.isNotEmpty && txtMarca2.text.isNotEmpty && txtAno2.text.isNotEmpty && txtCor2.text.isNotEmpty && txtKm2.text.isNotEmpty){
                           editarVeiculo(
                             item.id, txtAno2.text, txtCor2.text, txtKm2.text, txtMarca2.text, txtModelo2.text, txtPlaca2.text,
                              );

                              txtPlaca2.clear();
                              txtModelo2.clear();
                              txtMarca2.clear();
                              txtAno2.clear();
                              txtKm2.clear();
                              txtCor2.clear();

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
            stream: veiculos.snapshots(),

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
                  title: Text(
                    'Adicionar Veiculo',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            controller: txtPlaca,
                            maxLength: 8,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Placa",
                            ),
                          ),
                          TextField(
                            controller: txtModelo,
                            maxLength: 30,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Modelo",
                            ),
                          ),
                          TextField(
                            controller: txtMarca,
                            maxLength: 30,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Marca",
                            ),
                          ),
                          TextField(
                            controller: txtAno,
                            maxLength: 4,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Ano",
                            ),
                          ),
                          TextField(
                            controller: txtKm,
                            maxLength: 10,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "KM rodados",
                            ),
                          ),
                          TextField(
                            controller: txtCor,
                            maxLength: 20,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Cor",
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
                          if (txtPlaca.text.isNotEmpty && txtModelo.text.isNotEmpty && txtMarca.text.isNotEmpty && txtAno.text.isNotEmpty && txtCor.text.isNotEmpty && txtKm.text.isNotEmpty){
                           criarVeiculo(
                                txtAno.text,
                                txtCor.text,
                                txtKm.text,
                                txtMarca.text,
                                txtModelo.text,
                                txtPlaca.text,
                              );

                              txtPlaca.clear();
                              txtModelo.clear();
                              txtMarca.clear();
                              txtAno.clear();
                              txtKm.clear();
                              txtCor.clear();

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

  // criar veiculo no Firebase Auth
  void criarVeiculo(ano, cor, km, marca, modelo, placa) {
    FirebaseFirestore.instance.collection('veiculos').add({
      'ano': ano,
      'cor': cor,
      'km': km,
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
    });
  }

// editar conta no Firebase Auth
  void editarVeiculo(id, ano, cor, km, marca, modelo, placa) {
    FirebaseFirestore.instance.collection('veiculos').doc(id).set({
      'ano': ano,
      'cor': cor,
      'km': km,
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
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