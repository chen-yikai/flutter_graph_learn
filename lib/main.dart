import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_graph_learn/line_chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MaterialApp(
    home: Entry(),
    debugShowCheckedModeBanner: false,
  ));
}

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final List<int> data = [50, 30, 40, 50, 200, 30, 0];
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  int _currentDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.auto_graph_outlined),
                label: Text("Line Chart"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.show_chart),
                label: Text("Bar Chart"),
              ),
            ],
            selectedIndex: _currentDestination,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                _currentDestination = index;
              });
            },
          ),
          VerticalDivider(),
          Expanded(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: _currentDestination == 0
                      ? [
                          Row(
                            children: [
                              Text(
                                "Line Chart",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purple.withAlpha(200),
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            height: 500,
                            child: CustomPaint(
                              painter: LineChartPainter(
                                  data: data,
                                  days: days,
                                  primary: Colors.white),
                            ),
                          )
                        ]
                      : [
                          Row(
                            children: [
                              Text(
                                "Bar Chart",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
