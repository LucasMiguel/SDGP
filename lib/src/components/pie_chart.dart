/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sdgp/src/models/m_iten.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series<ItensTypes, String>> seriesList;
  final bool? animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData(List<ItensModel> listTypeItens) {
    return new DonutPieChart(
      _createSampleData(listTypeItens.map((e) => e.nameTypeItem).toList()),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart<String>(
      seriesList,
      animate: animate,
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ItensTypes, String>> _createSampleData(
      List<String?> listTypeItens) {
    ///Variable with map values
    var map = Map();
    Random rnd = new Random();

    ///Variable with data
    List<ItensTypes> data = [];

    listTypeItens.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    map.forEach((key, value) {
      data.add(ItensTypes(
          key,
          value,
          charts.Color(
              r: rnd.nextInt(255), g: rnd.nextInt(255), b: rnd.nextInt(255))));
    });

    return [
      new charts.Series<ItensTypes, String>(
        id: 'Tipos de Itens',
        domainFn: (ItensTypes typeItens, _) => typeItens.description,
        measureFn: (ItensTypes typeItens, _) => typeItens.amount,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class ItensTypes {
  final String description;
  final int amount;
  final charts.Color color;

  ItensTypes(this.description, this.amount, this.color);
}
