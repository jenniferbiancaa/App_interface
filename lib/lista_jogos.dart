import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GameListWidget extends StatefulWidget {
  @override
  _GameListWidgetState createState() => _GameListWidgetState();
}

class _GameListWidgetState extends State<GameListWidget> {
  List<dynamic> _games = [];

  bool _loading = true;
  bool _error = false;

  Future<void> _fetchGames() async {
    try {
      final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=928913dbebd4437596a933856ad1cc31'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final games = body['results'];

        setState(() {
          _loading = false;
          _games = games;
        });
      } else {
        throw Exception('Erro ao buscar lista de jogos');
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_error) {
      return Center(
        child: Text('Erro ao carregar a lista de jogos'),
      );
    } else {
      return ListView.builder(
        itemCount: _games.length,
        itemBuilder: (BuildContext context, int index) {
          final game = _games[index];
          return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(game['background_image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star_border),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
     }
    }
  }

