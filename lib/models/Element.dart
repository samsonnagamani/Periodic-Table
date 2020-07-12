import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PeriodicTable/models/grid.dart';

// ignore: camel_case_types
class mElement {
  final String name;
  final String appearance;
  final atomicMass;
  final boil;
  final String category;
  final String color;
  final density;
  final String discoveredBy;
  final melt;
  final molarHeat;
  final String namedBy;
  final int number;
  final int period;
  final String phase;
  final String summary;
  final String symbol;
  final int xpos;
  final int ypos;
  final List shells;
  final String electronConfig;
  final electronAffinity;
  final electronegativityPauling;
  final List ionizationEnergies;

  mElement({
    this.name,
    this.appearance,
    this.atomicMass,
    this.boil,
    this.category,
    this.color,
    this.density,
    this.discoveredBy,
    this.electronAffinity,
    this.electronConfig,
    this.electronegativityPauling,
    this.ionizationEnergies,
    this.melt,
    this.molarHeat,
    this.namedBy,
    this.number,
    this.period,
    this.phase,
    this.shells,
    this.summary,
    this.symbol,
    this.xpos,
    this.ypos,
  });

  factory mElement.fromJson(Map<String, dynamic> json) {
    return mElement(
      name: json["name"],
      appearance: json["appearance"],
      atomicMass: json["atomic_mass"],
      boil: json["boil"],
      category: json["category"],
      color: json["color"],
      density: json["density"],
      discoveredBy: json["discovered_by"],
      electronAffinity: json["electron_affinity"],
      electronConfig: json["electron_configuration"],
      electronegativityPauling: json["electronegativity_pauling"],
      ionizationEnergies: parseList(json["ionization_energies"]),
      melt: json["melt"],
      molarHeat: json["molar_heat"],
      namedBy: json["named_by"],
      number: json["number"],
      period: json["period"],
      phase: json["phase"],
      shells: parseList(json["shells"]),
      summary: json["summary"],
      symbol: json["symbol"],
      xpos: json["xpos"],
      ypos: json["ypos"],
    );
  }

  static mElement getElementByNum(int num, List<mElement> elements) {
    mElement elementByNum;

    for (var el in elements) {
      if (el.number == num) {
        return elementByNum = el;
      }
    }

    return elementByNum;
  }

  static Color getColorByElCat(el, List<mElement> elements) {
    Color colorByElCat;

    if (elements.contains(el)) {
      switch (el.category) {
        case 'diatomic nonmetal':
          {
            colorByElCat = Color(0xDAFFFF00);
          }
          break;

        case 'alkali metal':
          {
            colorByElCat = Color(0xFFFF0000);
          }
          break;

        case 'noble gas':
          {
            colorByElCat = Color(0xFF800080);
          }
          break;

        case 'alkaline earth metal':
          {
            colorByElCat = Color(0xFF4444E5);
          }
          break;

        case 'transition metal':
          {
            colorByElCat = Color(0xFFFFA500);
          }
          break;

        case 'post-transition metal':
          {
            colorByElCat = Color(0xFF4444E5);
          }
          break;

        case 'metalloid':
          {
            colorByElCat = Color(0xFFFF0000);
          }
          break;

        case 'polyatomic nonmetal':
          {
            colorByElCat = Color(0xDDFFFF00);
          }
          break;

        case 'halogen':
          {
            colorByElCat = Color(0xFF008000);
          }
          break;

        case 'lathanoid':
          {
            colorByElCat = Color(0xFFFF5500);
          }
          break;

        case 'actinoid':
          {
            colorByElCat = Color(0xFF008000);
          }
          break;

        default:
          {
            colorByElCat = Color(0xFFD4D4D4);
          }
      }
    }

    return colorByElCat;
  }

  static int getGroupByElement(el) {
    int groupNum;
    for (int i = 0; i < grid.length; i++) {
      for (int k = 0; k < grid[i].length; k++) {
        if (grid[i][k] == el.number.toString()) {
          return groupNum = k + 1;
        }
      }
    }

    return groupNum;
  }

  static String getIonicChargeAsString(el) {
    int groupNum = getGroupByElement(el);
    String ionicCharge;

    if (el.ypos == 9 || el.ypos == 10) {
      ionicCharge = 'varies';
    } else {
      switch (groupNum) {
        case 1:
          {
            ionicCharge = '1+';
          }
          break;

        case 2:
          {
            ionicCharge = '2+';
          }
          break;

        case 13:
          {
            ionicCharge = '3+';
          }
          break;

        case 14:
          {
            ionicCharge = '4+';
          }
          break;

        case 15:
          {
            ionicCharge = '3-';
          }
          break;

        case 16:
          {
            ionicCharge = '2-';
          }
          break;

        case 17:
          {
            ionicCharge = '1-';
          }
          break;

        case 18:
          {
            ionicCharge = '0';
          }
          break;

        default:
          {
            ionicCharge = 'varies';
          }
          break;
      }
    }

    return ionicCharge;
  }

  static List parseList(listJson) {
    List list = new List.from(listJson);
    return list;
  }
}
