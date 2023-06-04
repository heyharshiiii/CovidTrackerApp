import 'dart:async';

import 'package:covid_tracker/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  
  late final AnimationController _controller=AnimationController(
    duration: Duration(seconds: 6),
    vsync: this)..repeat();
    @override
    void dispose() {
    
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 3),
    ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStatesScreen())));
  }
@override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('images/virus.png')),
                  ),
                ),
                builder: (BuildContext context , Widget? child)
                {
                  return Transform.rotate(
                    angle: _controller.value*2.0*math.pi,
                    child: child);
                }
                
                )
              ,SizedBox(height: MediaQuery.of(context).size.height*0.08,),
              Align(
                alignment: Alignment.center,
                child: Text('Covid19 Tracker App',
               
                style: GoogleFonts.kanit(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0
                ),
                ),
              ),
              SizedBox(height: 20.0,),
              Text('-By Harshita Acharya',
              style: GoogleFonts.caveat(
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              )),
        ],
      )),
    );
  }
}