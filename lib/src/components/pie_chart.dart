/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sdgp/src/models/m_item.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series<ItensTypes, String>> seriesList;
  final bool? animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData(List<ItemsModel> listTypeItens) {
    return new DonutPieChart(
      _createSampleData(listTypeItens.map((e) => e.nameTypeItem).toList()),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color? fontColor = Colors.white;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50, bottom: 20),
          child: Text(
            "Tipos de Itens",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ),
        SizedBox(
          height: 400,
          child: charts.PieChart<String>(
            seriesList,
            animate: animate,
            // Configure the width of the pie slices to 60px. The remaining space in
            // the chart will be left as a hole in the center.
            defaultRenderer: charts.ArcRendererConfig(
              arcWidth: 50,
              // new code below
            ),
            behaviors: [
              // our title behaviour
              charts.DatumLegend(
                position: charts.BehaviorPosition.bottom,
                outsideJustification:
                    charts.OutsideJustification.middleDrawArea,
                horizontalFirst: false,
                cellPadding: new EdgeInsets.only(right: 20, bottom: 10),
                showMeasures: true,
                desiredMaxColumns: 3,
                desiredMaxRows: 2,
                legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
                entryTextStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.black,
                    fontFamily: 'Quicksand-bold',
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ],
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
        //Color of the each item. This is Random
        colorFn: (ItensTypes typeItens, _) => typeItens.color,
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
