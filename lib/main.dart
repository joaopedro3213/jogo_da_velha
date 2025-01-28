import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.generate(9, (_) => ''); // Tabuleiro vazio
  bool isPlayer1Turn = true; // Definir qual jogador está fazendo a jogada

  // Função para registrar a jogada
  void makeMove(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = isPlayer1Turn ? 'X' : 'O';
        isPlayer1Turn = !isPlayer1Turn; // Alterna entre os jogadores
      });
    }
  }

  // Função para verificar se alguém ganhou
  String checkWinner() {
    // Definindo as possíveis combinações vencedoras
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Linhas
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Colunas
      [0, 4, 8], [2, 4, 6],            // Diagonais
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a != '' && a == b && a == c) {
        return a; // Retorna 'X' ou 'O' se alguém ganhou
      }
    }
    return ''; // Retorna vazio se não houver vencedor
  }

  // Função para exibir a interface
  @override
  Widget build(BuildContext context) {
    String winner = checkWinner(); // Verifica o vencedor a cada jogada

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (winner.isNotEmpty)
              Text(
                'Jogador $winner venceu!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            GridView.builder(
              shrinkWrap: true, // Para ajustar o tamanho da grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 colunas para o tabuleiro 3x3
              ),
              itemCount: 9, // Número de células no tabuleiro
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => makeMove(index), // Ao clicar, faz a jogada
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[index], // Mostra 'X' ou 'O' nas casas
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: board[index] == 'X' ? Colors.blue : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  board = List.generate(9, (_) => ''); // Reinicia o jogo
                });
              },
              child: Text('Reiniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
