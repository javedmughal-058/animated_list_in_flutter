import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

   void _add() {
   items.insert(0, 'Item ${items.length+1}');
   _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }
   void _remove(int index) {
    _key.currentState!.removeItem(
        index,
            (_, animation){
              return SizeTransition(
                  sizeFactor: animation,
                child: const Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.red,
                  child: Text('Deleted',textAlign: TextAlign.center ,style: TextStyle(fontSize: 24,color: Colors.white ),),
                ),
              );
    },
        duration: const Duration(seconds: 1)
    );
    items.remove(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            Expanded(
                child: AnimatedList(
                  key: _key,
                  initialItemCount: 0,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index, animation){
                    return SizeTransition(
                        sizeFactor: animation,
                      key: UniqueKey(),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.orangeAccent,
                        child: ListTile(
                          title: Text(items[index]),
                          trailing: IconButton(onPressed: (){
                            _remove(index);
                          }, icon: const Icon(Icons.delete, color: Colors.red,)),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _add();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
