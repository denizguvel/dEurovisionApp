import 'package:eurovision_app/app/features/presentation/test/provider/cat_provider.dart';
import 'package:eurovision_app/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatView extends StatefulWidget {
  
  @override
  State<CatView> createState() => _CatViewState();
}

class _CatViewState extends State<CatView> {
   @override
  void initState() {
    super.initState();
    Future.microtask(() =>
    Provider.of<CatProvider>(context, listen: false).fetchCats());
  }

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);
    print("Cat list length: ${catProvider.cats.length}");

    if (catProvider.errorMessage != null) {
      print("Error: ${catProvider.errorMessage}");
    }
    return Scaffold(
      appBar: AppBar(title: Text('Cat Gallery')),
      body: Column(
        children: [
          Container(
            height: 600,
            child: catProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : catProvider.errorMessage != null
                    ? Center(child: Text("Error: ${catProvider.errorMessage}"))
                    : ListView.builder(
                        itemCount: catProvider.cats.length,
                        itemBuilder: (context, index) {
                          final cat = catProvider.cats[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(cat.url, fit: BoxFit.cover),
                          );
                        },
                      ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, RouteNames.test);}, 
            child: Text('TestView Button')
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => catProvider.fetchCats(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
