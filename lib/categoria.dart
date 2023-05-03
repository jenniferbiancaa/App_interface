import 'package:ecommecer/tela.dart';
import 'package:flutter/material.dart';
import 'jg_categoria.dart';
import 'lista_jogos.dart';

class WidgetCategoria extends StatefulWidget {
  @override
  _WidgetCategoriaState createState() => _WidgetCategoriaState();
}

class _WidgetCategoriaState extends State<WidgetCategoria> {
  late List<String> categorias;
  late int categoriaSelecionada;
  late bool carregando;

  @override
  void initState() {
    super.initState();
    categoriaSelecionada = -1;
    carregando = true;
    getGenres();
  }

  Future<void> getGenres() async {
    // Obter a lista de categorias da API
    // Neste exemplo, vamos apenas definir uma lista de strings para simular a API
    categorias = ['Ação', 'Simulação', 'Aventura', 'RPG', 'Estrategia', 'Terror', 'Educacional', 'Esporte', 'Luta'];
    await Future.delayed(Duration(seconds: 2)); // Simular uma chamada assíncrona
    setState(() {
      carregando = false;
    });
  }

 Widget _buildCategoriaSucesso() {
  return Column(
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List<Widget>.generate(categorias.length, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  categoriaSelecionada = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: categoriaSelecionada == index ? Colors.orange : Colors.yellow,
                      radius: 25,
                      child: Icon(
                        Icons.gamepad_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      categorias[index],
                      style: TextStyle(fontSize: 15.0),                   
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      Expanded(
            child: GameListWidget(),
      ),
    ],
  );
}


  Widget _buildCategoriaErro() {
    return Text('Erro ao obter as categorias.');
  }

  Widget _buildCategoriaCarregando() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

Widget _buildCategoriaSelecionada() {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(200.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MinhaTela()),
            );
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imagensPorCategoria[categorias[categoriaSelecionada]]![0],
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
  children: [
    Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          image: AssetImage(
            imagensPorCategoria[categorias[categoriaSelecionada]]![0],
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Positioned(
      top: 155.0,
      left: 0.0,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          categorias[categoriaSelecionada],
          style: TextStyle(
            color: Color.fromARGB(255, 255, 252, 252),
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 3.0,
                color: Colors.black,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

        ),
      ),
    ),
    body: Container(
      padding: EdgeInsets.all(0.0),
      child: Card(
        child: GameListWidget(),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (carregando) {
      child = _buildCategoriaCarregando();
    } else if (categorias != null) {
      if (categoriaSelecionada == -1) {
        child = _buildCategoriaSucesso();
      } else {
        child = _buildCategoriaSelecionada();
      }
    } else {
      child = _buildCategoriaErro();
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: child,
    );
  }
}



