import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}


class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
   late final AnimationController _controller=AnimationController(
    duration: Duration(seconds: 6),
    vsync: this)..repeat();
    @override
    void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot)
            {
              if(!snapshot.hasData)
              {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                    controller: _controller,
                  ),
                );
              }
              else{
                return Column(
                  children: [
                    PieChart(
            dataMap:   
            {
              'Total':double.parse(snapshot.data!.cases!.toString()),
              'Recovered':double.parse(snapshot.data!.recovered!.toString()),
              'Deaths':double.parse(snapshot.data!.deaths!.toString()),
            },
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true
            ),
            chartRadius: MediaQuery.of(context).size.width/3.2,
            // chartRadius: MediaQuery.of(context).size.width,
             legendOptions:  const LegendOptions(
              legendPosition: LegendPosition.left
            ),
            animationDuration: const Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: const [
                   Color(0xff4285F4),
                  Color(0xff1aa260),
                   Color(0xffde5246),  
                 ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                child: Column(
                  children: [
                    ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                    ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                    ReusableRow(title: 'Recovered', value:snapshot.data!.recovered.toString()),
                    ReusableRow(title: 'Today\'s Cases', value:snapshot.data!.todayCases.toString()),
                    ReusableRow(title: 'Today\'s Recovered', value:snapshot.data!.todayRecovered.toString()),
                    ReusableRow(title: 'Today\'s Deaths', value:snapshot.data!.todayDeaths.toString()),
                    ReusableRow(title: 'Active', value:snapshot.data!.active.toString()),
                    ReusableRow(title: 'Critical', value:snapshot.data!.critical.toString()),


                  ],
                ),
              ),
            ),
             GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:((context) => CountriesList())));
              },
               child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff1aa260),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Track Countries')),
                         ),
             ),
            ],
          );
        }
            }),
           
          ],
        ),
      )),
    );
  }
}
class ReusableRow extends StatelessWidget {
  ReusableRow({super.key,required this.title,required this.value});
String title,value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
