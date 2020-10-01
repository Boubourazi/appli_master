import 'package:flutter/material.dart';
import 'school.dart';
import 'requete.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hypperplanning'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final List<Promo> promos = <Promo>[new Promo("STEE"), new Promo("SSH")];
  final List<Color> colors = <Color>[
    Colors.blue[200],
    Colors.red[200],
    Colors.blue[200]
  ];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OptionsScreen(),
                  ))
            },
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Container(
                  child: Text(
                    widget.promos[index].name,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectScreen(
                              promo: widget.promos[index],
                            ),
                          ))
                    });
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: widget.promos.length),
    );
  }
}

class SelectScreen extends StatelessWidget {
  final Promo promo;

  SelectScreen({Key key, @required this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(promo.name),
        ),
      ),
    );
  }
}

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  bool notifOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Options"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Switch(
                  value: this.notifOn,
                  onChanged: (value) {
                    setState(() {
                      this.notifOn = value;
                    });
                  },
                ),
                Text("Notification prochain cours"),
              ],
            ),
            RequeteTest(),
          ],
        ),
      ),
    );
  }
}

//Wip widget : notify that the current section is a wip feature
class Wip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Work In Progress"),
    );
  }
}

class RequeteTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var connecter =
        new Connecter(url: "https://steeunivpau-edt2021.hyperplanning.fr/hp/");

    return Container(
      child: FutureBuilder(
        future: connecter.makeGetRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: connecter.makePostRequest(),
              builder: (context, snapshotPost) {
                if (snapshotPost.connectionState == ConnectionState.done) {
                  return Text(
                      "ResultatPost:" + snapshotPost.data.length ?? "tomate");
                } else {
                  return Text("Get ok, waiting for Post...");
                }
              },
            );
          } else {
            return Text("Connecting");
          }
        },
      ),
    );
  }
}
