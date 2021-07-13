import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  PersistentBottomSheetController _controller;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentTabIndex = 0;
  TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  void toogleBottomSheet(){
    if (_controller == null){
      _controller = scaffoldKey.currentState.showBottomSheet((context) => Container(
        color: Colors.white,
        height: 200,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            ListTile(
              title: Text('Сумма'),
              leading: Icon(Icons.credit_card),
              trailing: Text('200 руб'),
            ),
            Center(child: ElevatedButton(child: Text('Оплатить'),),)
          ],
        ),
      ));
    }else{
      _controller.close();
      _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Homework example'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.person),
              onPressed: (){
                Scaffold.of(context).openEndDrawer();
              },
            )
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            child: Text('1'),
          ),
          Container(
            child: Text('2'),
          ),
          Container(
            child: Text('3'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Photo'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Albums'),
        ],
        currentIndex: _currentTabIndex,
        onTap: (index){
          setState(() {
            _tabController.index = index;
            _currentTabIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://picsum.photos/1200/520'),
            )),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person_outline),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text('Images'),
              leading: Icon(Icons.image),
              trailing: Icon(Icons.arrow_forward),
            ),
            Expanded(
              child:Column()
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(child: Text('Выход')),
                ElevatedButton(child: Text('Регистрация')),
              ],
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Center(child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://picsum.photos/1200/520'),
            ),
            Text('Username')
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: toogleBottomSheet,
      ),
    );
  }
}
