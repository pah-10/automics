//
// TELA CADASTRO VEICULO
//

import 'package:automics/data/class.dart';
import 'package:flutter/material.dart';

class TelaVeiculo extends StatefulWidget {
  const TelaVeiculo({Key? key}) : super(key: key);

  @override
  _TelaVeiculoState createState() => _TelaVeiculoState();
}
  //opções do radio

class _TelaVeiculoState extends State<TelaVeiculo> {
  //lista dinâmica para armazenamento dos carros
  var listaVeiculo = <Veiculo>[];

  //retornar a tarefa adicionada pelo usuário
  var txtPlaca = TextEditingController();
  var txtModelo = TextEditingController();
  var txtMarca = TextEditingController();
  var txtAno = TextEditingController();
  var txtKm = TextEditingController();
  var txtCor = TextEditingController();

  OpcoesRadio? _character = OpcoesRadio.carro; //definição do valor inicial do radio

  @override
  void initState() {
    listaVeiculo.add(Veiculo('AFL-2223', 'Rebel', 'Honda', '2010', '500', 'Preto'/*, OpcoesRadio.moto*/));
    listaVeiculo.add(Veiculo('FUO-0754', 'Fiat Uno', 'Branco', '2000', '1000', 'Branco'/*, OpcoesRadio.carro*/ ));
    listaVeiculo.add(Veiculo('LUQ-3165', 'Davidson', 'Honda', '2021', '0', 'Cinza'/*, OpcoesRadio.moto*/));
    listaVeiculo.add(Veiculo('HVB-6010', 'Classe G SUV', 'Mercedes', '2019', '700', 'Musgo'/*, OpcoesRadio.carro*/));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),

        //
        // ListView
        //
        child: ListView.builder(
          //quantidade de elementos da lista
          itemCount: listaVeiculo.length,

          //definir a aparência dos elementos
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey.shade100,
              shadowColor: Colors.blue,
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),

              child: ListTile(
                title: Text(listaVeiculo[index].placa, style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
                subtitle: Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 10,),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.featured_play_list_outlined, color: Colors.grey.shade500),
                          Text(listaVeiculo[index].modelo)
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.featured_video_outlined , color: Colors.grey.shade500),
                          Text(listaVeiculo[index].marca),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.event_sharp, color: Colors.grey.shade500),
                          Text(listaVeiculo[index].ano),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.follow_the_signs_outlined, color: Colors.grey.shade500),
                          Text(listaVeiculo[index].km),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.format_color_fill_outlined, color: Colors.grey.shade500),
                          Text(listaVeiculo[index].cor),
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

                          content: Icon(Icons.taxi_alert, color: Theme.of(context).primaryColor, size: 50),

                          actions: [
                            TextButton(
                              child: Text('Remover'),
                              onPressed: () {
                                setState(() {
                                  listaVeiculo.removeAt(index);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Veiculo removido com sucesso'),
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
      // ADICIONAR NOVOS VEICULOS
      //

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Adicionar Veiculo', style: TextStyle(fontSize: 20,), textAlign: TextAlign.center,),

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

                      SizedBox(height: 15,),

                      Text('Qual o tipo do Veiculo?', style: TextStyle(fontSize: 15,), textAlign: TextAlign.start,),

                      RadioListTile(
                        title: const Text('Carro', style: TextStyle(fontSize: 15,),),
                        
                          value: OpcoesRadio.carro,
                          groupValue: _character,
                          onChanged: (OpcoesRadio? value) {
                            setState(() {

                              _character = value;
                            });
                          },
                        ),


                      RadioListTile(
                        title: const Text('Moto', style: TextStyle(fontSize: 15,),),
                        
                          value:  OpcoesRadio.moto,
                          groupValue: _character,
                          onChanged: (OpcoesRadio? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        
                      ),
                    ],
                  ),
                ),
          ),

                  actions: [
                    TextButton(
                      child: Text('ok'),
                      onPressed: () {
                        setState(
                          () {
                            var msg = '';
                            if (txtPlaca.text.isNotEmpty && txtModelo.text.isNotEmpty && txtMarca.text.isNotEmpty && txtAno.text.isNotEmpty && txtKm.text.isNotEmpty && txtCor.text.isNotEmpty ) {
                              listaVeiculo.add(Veiculo(txtPlaca.text, txtModelo.text, txtMarca.text, txtAno.text, txtKm.text, txtCor.text /*, OpcoesRadio.carro*/),);

                              txtPlaca.clear();
                              txtModelo.clear();
                              txtMarca.clear();
                              txtAno.clear();
                              txtKm.clear();
                              txtCor.clear();

                              msg = 'Carro adicionado com sucesso.';
                            } else {
                              msg = 'Erro: Preencha todos os campos!';
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
