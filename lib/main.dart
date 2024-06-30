import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 6 herramienta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiViewApp(),
    );
  }
}

class MultiViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea 6'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToolboxView()),
                );
              },
              child: Text('Caja de herramientas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenderPredictionView()),
                );
              },
              child: Text('Prediccion de genero'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgePredictionView()),
                );
              },
              child: Text('Prediccion de edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UniversitiesView()),
                );
              },
              child: Text('vista de universidades'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherView()),
                );
              },
              child: Text('Clima'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordPressInfoView()),
                );
              },
              child: Text('WordPress Info View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutView()),
                );
              },
              child: Text('Acerca de'),
            ),
          ],
        ),
      ),
    );
  }
}

class ToolboxView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja de herramientas'),
      ),
      body: Center(
        child: Image.asset('assets/toolbox.png'), // Reemplaza con tu imagen de caja de herramientas
      ),
    );
  }
}

class GenderPredictionView extends StatefulWidget {
  @override
  _GenderPredictionViewState createState() => _GenderPredictionViewState();
}

class _GenderPredictionViewState extends State<GenderPredictionView> {
  TextEditingController _nameController = TextEditingController();
  String _genderResult = '';
  Color _resultColor = Colors.white;

  void _predictGender() async {
    final String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String gender = data['gender'];
        setState(() {
          _genderResult = gender;
          _resultColor = gender == 'male' ? Colors.blue : Colors.pink;
        });
      } else {
        print('Failed to load gender prediction');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediccion de genero'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ingrese un nombre',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _predictGender,
                child: Text('Predecir Genero'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Resultado de prediccion:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                _genderResult,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: _resultColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgePredictionView extends StatefulWidget {
  @override
  _AgePredictionViewState createState() => _AgePredictionViewState();
}

class _AgePredictionViewState extends State<AgePredictionView> {
  TextEditingController _nameController = TextEditingController();
  String _ageGroup = '';
  String _ageNumber = '';
  String _ageImageUrl = '';

  void _predictAge() async {
    final String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        int age = data['age'];
        setState(() {
          if (age < 18) {
            _ageGroup = 'Joven';
            _ageImageUrl = 'assets/joven.png'; // Reemplaza con la imagen correspondiente
          } else if (age >= 18 && age < 60) {
            _ageGroup = 'Adulto';
            _ageImageUrl = 'assets/adulto.png'; // Reemplaza con la imagen correspondiente
          } else {
            _ageGroup = 'Viejo/a';
            _ageImageUrl = 'assets/viejo.jpg'; // Reemplaza con la imagen correspondiente
          }
          _ageNumber = age.toString();
        });
      } else {
        print('Failed to load age prediction');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediccion de edad'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ingresa un nombre',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _predictAge,
                child: Text('Predecir edad'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Resultado de predeccion de la edad:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'edad: $_ageNumber',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'grupo de edad: $_ageGroup',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              _ageImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: _ageImageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class UniversitiesView extends StatefulWidget {
  @override
  _UniversitiesViewState createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  void _searchUniversities() async {
    final String country = _countryController.text.trim();
    if (country.isNotEmpty) {
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
      if (response.statusCode == 200) {
        setState(() {
          _universities = jsonDecode(response.body);
        });
      } else {
        print('Failed to load universities');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: 'Ingrese un pais en Ingles',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _searchUniversities,
                child: Text('Buscar universidades'),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _universities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_universities[index]['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Domain: ${_universities[index]['domains'].join(', ')}'),
                          Text('Website: ${_universities[index]['web_pages'].join(', ')}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  bool _isLoading = true;
  String? _temperature;
  String? _description;
  String? _location = "Santo Domingo";

  Future<void> _fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://wttr.in/Santo%20Domingo?format=j1'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _temperature = data['current_condition'][0]['temp_C'].toString();
        _description = data['current_condition'][0]['weatherDesc'][0]['value'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Error al cargar el clima.');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Santo Domingo'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _temperature == null
                ? Text('Error al cargar el clima.')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Ubicación: $_location',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Temperatura: $_temperature°C',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Descripción: $_description',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class WordPressInfoView extends StatefulWidget {
  @override
  _WordPressInfoViewState createState() => _WordPressInfoViewState();
}

class _WordPressInfoViewState extends State<WordPressInfoView> {
  bool _isLoading = true;
  List<dynamic> _posts = [];

  Future<void> _fetchWordPressData() async {
    final response = await http.get(
      Uri.parse('https://z101digital.com/wp-json/wp/v2/posts?per_page=3'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _posts = jsonDecode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Error al cargar noticias de WordPress.');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWordPressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de WordPress'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _posts.isEmpty
                ? Text('No se encontraron noticias.')
                : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      var post = _posts[index];
                      String imageUrl = 'assets/logo.png'; // Ruta de la imagen en assets

                      return ListTile(
                        leading: Image.asset(
                          imageUrl,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error); // Mostrar un icono de error si no se puede cargar la imagen
                          },
                        ),
                        title: Text(post['title']['rendered']),
                        subtitle: Text(post['excerpt']['rendered']),
                        onTap: () {
                          // Abrir la noticia en el navegador
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(post['title']['rendered']),
                                ),
                                body: SingleChildScrollView(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imageUrl,
                                        width: 100,
                                        height: 100,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.error); // Mostrar un icono de error si no se puede cargar la imagen
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        post['excerpt']['rendered'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        post['content']['rendered'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('a.jpg'), // Reemplaza con el nombre de tu foto de perfil
            ),
            SizedBox(height: 20),
            Text(
              'Felix Manuel Sanchez De La Cruz 20220049',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Desarrollador de Software Junior',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Correo electrónico: felixs.180204@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Teléfono: +18492704165',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}