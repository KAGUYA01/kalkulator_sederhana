import 'package:flutter/material.dart';

class Tombol extends StatelessWidget {
  final warna;
  final warnaTeks;
  final String tulisanTombol;
  final tombolDitekan;

  Tombol({this.warna, this.warnaTeks, this.tulisanTombol, this.tombolDitekan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tombolDitekan,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          child: Container(
            color: warna,
            child: Center(
              child: Text(
                tulisanTombol,
                style: TextStyle(
                  color: warnaTeks,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
