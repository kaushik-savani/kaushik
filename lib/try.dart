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
        body: SizedBox(
          height: MediaQuery.of(context).size.height * .15,
          child: ListView.separated(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(children: const [
                  CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 32,
                    child: Icon(Icons.ac_unit),
                  ),
                  SizedBox(height: 10),
                  Text("Hello"),
                ]),
              );
            }, separatorBuilder: (_, __) => SizedBox(width: 16),
          ),
        )
        /*MasonryGridView.count(itemCount: 4,
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
      crossAxisSpacing: 4,),*/
        );
  }
}
