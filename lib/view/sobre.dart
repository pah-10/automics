import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Automics Infos', style: TextStyle(fontFamily: 'Sans Hv It', color: Colors.white),),
      ),

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Theme.of(context).primaryColor,
                  
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/66364483?v=4'),
                      radius: 50,
                    ),
                  ),

                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Theme.of(context).primaryColor,
                  
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://media-exp1.licdn.com/dms/image/C4D03AQGzB1HIOyVLVQ/profile-displayphoto-shrink_400_400/0/1581531629845?e=1639612800&v=beta&t=O2ePx8DCbvXp43itwyUHEN23jl78EKkatsEGkmTpscQ'),
                      radius: 50,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).backgroundColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Icon(Icons.code, color: Theme.of(context).primaryColor),

                        SizedBox(width: 10),

                        Column(
                          children: [
                            Text('Breno', style: TextStyle(fontSize: 20,),),
                            
                            Text('Augusto',style: TextStyle(fontSize: 20,),),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).backgroundColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.code, color: Theme.of(context).primaryColor),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text('Paola',
                                style: TextStyle(
                                    fontSize: 20,),),
                            Text(' Capita ',
                                style: TextStyle(
                                    fontSize: 20,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),

                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).backgroundColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),

                  
                    child: Row(
                      children: [
                        Icon(Icons.motorcycle, color: Theme.of(context).primaryColor),

                        SizedBox(width: 10),

                        Text(
                          'O tema do Automics está na\nrealização da centralização\ndo trabalho das oficinas\nmecânicas.',
                          style: TextStyle(fontSize: 20,),

                        ),
                       ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),

                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).backgroundColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),

                  
                    child: Row(
                      children: [
                        Icon(Icons.sports_score,color: Theme.of(context).primaryColor),

                        SizedBox(width: 10),

                        Text(
                          'O objetivo do Automics é\ncentralizar os dados dos\nclientes e dos automoveis\nde uma oficina mecânica.\nVisando facilitar o \nserviço dos funcionários.',
                          style: TextStyle(fontSize: 20,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}