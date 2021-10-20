//
// TELA DO MENU
//

import 'package:automics/view/bottomenu/cliente.dart';
import 'package:automics/view/bottomenu/veiculo.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  //Índice da página que será carregada inicialmente
  var telaAtual = 0;

  //Controlador utilizado para troca das telas (páginas)
  var pageController = PageController();

  //Controlador utilizado para troca o nome da tela no appBar
  String varNomePage = " Clientes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de' + varNomePage),
        automaticallyImplyLeading: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Nome de Usuário', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('EmailText@teste.com.br'),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/66364483?v=4'),),
            ),

            ListTile(
              leading: Icon(Icons.menu_book_outlined),
              title: Text('Sobre o Automics'),
              onTap: () {
                Navigator.pushNamed(context, 'sobre');
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Deseja mesmo sair do Automics?', style: TextStyle(fontSize: 20)),
                      content: Icon(Icons.local_car_wash, color: Theme.of(context).primaryColor, size: 50),

                      actions: [
                        TextButton(
                          child: Text('Sair'),

                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil('inicio', (Route<dynamic> route) => false);
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
          ]
        ),
      ),

      body: PageView(
        controller: pageController,

        children: [
          TelaCliente(), // Index = 0
          TelaVeiculo(), // Index = 1
        ],

        onPageChanged: (index) {
          setState(() {
            telaAtual = index;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.40),

        selectedFontSize: 16,
        unselectedFontSize: 16,

        iconSize: 40,

        //Index do Botão Selecionado
        currentIndex: telaAtual,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clientes',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Veiculos',
          ),
        ],

        onTap: (index) {
          setState(() {
            telaAtual = index;

            if(index == 0){
              varNomePage = ' Clientes';
            }else{
              varNomePage = ' Veiculos';
            }
          });

          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}