import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class demoGrid extends StatefulWidget {
  const demoGrid({Key? key}) : super(key: key);

  @override
  State<demoGrid> createState() => _demoGridState();
}

class _demoGridState extends State<demoGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid Demo"),
      ),
      body: MasonryGridView.count(itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print("$index");
              },
              child: Container(
                height: (index%2==0) ? 192 : 152,
                width: 163,
                color: (index%2==0)?Colors.green:Colors.red,
                child: Text("$index"),
              ),
            );
          },
          crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 4,),
    );
  }
}
