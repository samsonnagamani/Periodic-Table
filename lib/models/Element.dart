import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:PeriodicTable/models/grid.dart';

// ignore: camel_case_types
class mElement {
  final String name;
  final String appearance;
  final double atomicMass;
  final double boil;
  final String category;
  final String color;
  final double density;
  final String discoveredBy;
  final double melt;
  final double molarHeat;
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
  final String electronConfigSemantic;
  final double electronAffinity;
  final double electronegativityPauling;
  final List ionizationEnergies;
  final String image;

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
    this.electronConfigSemantic,
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
    this.image,
  });

  factory mElement.fromJson(Map<String, dynamic> json) {
    return mElement(
      name: json['name'],
      appearance: json['appearance'],
      atomicMass: double.parse(json['atomic_mass'].toString()),
      boil: double.tryParse(json['boil'].toString()),
      category: json['category'],
      color: json['color'],
      density: double.tryParse(json['density'].toString()),
      discoveredBy: json['discovered_by'],
      electronAffinity: double.tryParse(json['electron_affinity'].toString()),
      electronConfig: json['electron_configuration'],
      electronConfigSemantic: json['electron_config_semantic'],
      electronegativityPauling:
          double.tryParse(json['electronegativity_pauling'].toString()),
      ionizationEnergies: parseList(json['ionization_energies']),
      melt: double.tryParse(json['melt'].toString()),
      molarHeat: json['molar_heat'],
      namedBy: json['named_by'],
      number: json['number'],
      period: json['period'],
      phase: json['phase'],
      shells: parseList(json['shells']),
      summary: json['summary'],
      symbol: json['symbol'],
      xpos: json['xpos'],
      ypos: json['ypos'],
      image: json['source'],
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

  static Color getColorByElCat(mElement el, [String category]) {
    Color colorByElCat;
    String cat;

    if (el == null) {
      cat = category;
    } else {
      cat = el.category;
    }

    switch (cat) {
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

  static String getIonicChargeAsString(mElement el) {
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

  // static String getAbbreviatedElectronConfig(
  //     List<mElement> elements, mElement el) {
  //   List<String> startElectronConfigSymbol = [];
  //   List<String> startElectronConfig = [];
  //   String startElectronConfigString = '';
  //   String endElectronConfigString = '';
  //   String electronConfig = '';

  //   elements.forEach((element) {
  //     // print(el.electronConfig.startsWith(element.electronConfig));
  //     if (el.electronConfig.startsWith(element.electronConfig)) {
  //       startElectronConfigSymbol.add(element.symbol);
  //       startElectronConfig.add(element.electronConfig);
  //     } else {
  //       electronConfig = el.electronConfig;
  //     }
  //   });

  //   startElectronConfigString = startElectronConfigSymbol
  //       .elementAt(startElectronConfigSymbol.length - 2);

  //   endElectronConfigString = el.electronConfig
  //       .split(startElectronConfig.elementAt(startElectronConfig.length - 2))
  //       .last;

  //   electronConfig = '[$startElectronConfigString]$endElectronConfigString';
  //   print(startElectronConfigSymbol);
  //   print(electronConfig);

  //   return electronConfig;
  // }

  static List parseList(listJson) {
    List list = new List.from(listJson);
    return list;
  }
}
