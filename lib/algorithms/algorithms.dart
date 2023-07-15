import 'package:flow1_prova/database/database.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flow1_prova/database/database.dart';
import 'package:flow1_prova/Repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:flow1_prova/database/entities/Alcool.dart';
import 'package:flow1_prova/database/entities/Datahealth.dart';

List<double> alcool_grams(List<Alcool> alcool_list) {
  int num_alcool = alcool_list.length;
  List<double> sum_grams_per_type = [0,0,0,0];
  List<String> control = ["Beer", "Wine", "Cocktail", "Other"];

  for (int i = 0; i < 4; i++){
    
    //print("Control: ${control[i]}");
    double sum_grams = 0;

    for (int bev = 0; bev < num_alcool; bev++) {
      //print("bev: $bev");
      if (alcool_list[bev].type == control[i]) {
        //print(alcool_list[bev].volume);
        if (alcool_list[bev].volume != null) {
          double volume_ml = alcool_list[bev].volume! * 1000;
          //double volume_cm3 = (alcool_list[bev].volume)! * 1000; 
          double grammi = volume_ml * (alcool_list[bev].percentage! / 100) * 0.79 * alcool_list[bev].quantity;
          sum_grams = sum_grams + grammi;
        }
      }
    }
    sum_grams_per_type[i] = sum_grams;
  }

  return sum_grams_per_type;
}

double alcool_grams_sum(List<double> sum_alcool){
  double somma = 0;
  for (int i=0; i < 4; i++){
    somma = somma + sum_alcool[i];
  }
  return somma;
}

double mean_hr(List<Datahealth> hr_day ){
  int n = hr_day.length;
  double result=0;
  for (int i = 0; i<n ; i++){
    result = result + hr_day[i].value;
  }
  result=result/n;
  return result;
}
