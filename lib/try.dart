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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCirc,
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    alignment: Alignment.center,
                    height: 70.0 ,
                    width: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amberAccent,
                    ),
                    child: Icon(
                      Icons.gamepad_outlined,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    width: 60,
                    child: Text('hello',
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => SizedBox(
            width: 16.0,
          ),
          itemCount: 4,
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
