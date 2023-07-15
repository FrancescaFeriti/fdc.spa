import 'package:flutter/material.dart';

///Class that implements a custom [StatelessWidget] that acts as a separator in a [Form].
///It can be used to separate "categories" in a [Form].
class FormSeparator extends StatelessWidget {

  final label;

  const FormSeparator({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2,
                width: 75,
                child: Container(
                  color: const Color.fromARGB(255, 50, 3, 59),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 50, 3, 59)),
              ))),
              SizedBox(
                height: 2,
                width: 75,
                child: Container(
                  color: const Color.fromARGB(255, 50, 3, 59),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  } // build

} // FormSeparator
