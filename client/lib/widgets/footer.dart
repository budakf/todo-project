import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade200,
      child: const Center(
        child: Text(
          'powered by flutter \n\t\t\t\t\t\t @budakf',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

}



