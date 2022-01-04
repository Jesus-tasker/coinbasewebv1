// To parse this JSON data, do
//
//     final criptoResponse = criptoResponseFromJson(jsonString);

import 'dart:convert';

CriptoResponse criptoResponseFromJson(String str) =>
    CriptoResponse.fromJson(json.decode(str));

String criptoResponseToJson(CriptoResponse data) => json.encode(data.toJson());

class CriptoResponse {
  CriptoResponse({
    required this.code,
    required this.direcciones,
    required this.precios,
  });

  String code;
  Direcciones direcciones;
  Precios precios;

  factory CriptoResponse.fromJson(Map<String, dynamic> json) => CriptoResponse(
        code: json["code"],
        direcciones: Direcciones.fromJson(json["direcciones"]),
        precios: Precios.fromJson(json["precios"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "direcciones": direcciones.toJson(),
        "precios": precios.toJson(),
      };
}

class Direcciones {
  Direcciones({
    required this.ethereum,
    required this.usdc,
    required this.dai,
    required this.bitcoincash,
    required this.dogecoin,
    required this.litecoin,
    required this.bitcoin,
  });

  String ethereum;
  String usdc;
  String dai;
  String bitcoincash;
  String dogecoin;
  String litecoin;
  String bitcoin;

  factory Direcciones.fromJson(Map<String, dynamic> json) => Direcciones(
        ethereum: json["ethereum"],
        usdc: json["usdc"],
        dai: json["dai"],
        bitcoincash: json["bitcoincash"],
        dogecoin: json["dogecoin"],
        litecoin: json["litecoin"],
        bitcoin: json["bitcoin"],
      );

  Map<String, dynamic> toJson() => {
        "ethereum": ethereum,
        "usdc": usdc,
        "dai": dai,
        "bitcoincash": bitcoincash,
        "dogecoin": dogecoin,
        "litecoin": litecoin,
        "bitcoin": bitcoin,
      };
}

class Precios {
  Precios({
    required this.local,
    required this.ethereum,
    required this.usdc,
    required this.dai,
    required this.bitcoincash,
    required this.dogecoin,
    required this.litecoin,
    required this.bitcoin,
  });

  Bitcoin local;
  Bitcoin ethereum;
  Bitcoin usdc;
  Bitcoin dai;
  Bitcoin bitcoincash;
  Bitcoin dogecoin;
  Bitcoin litecoin;
  Bitcoin bitcoin;

  factory Precios.fromJson(Map<String, dynamic> json) => Precios(
        local: Bitcoin.fromJson(json["local"]),
        ethereum: Bitcoin.fromJson(json["ethereum"]),
        usdc: Bitcoin.fromJson(json["usdc"]),
        dai: Bitcoin.fromJson(json["dai"]),
        bitcoincash: Bitcoin.fromJson(json["bitcoincash"]),
        dogecoin: Bitcoin.fromJson(json["dogecoin"]),
        litecoin: Bitcoin.fromJson(json["litecoin"]),
        bitcoin: Bitcoin.fromJson(json["bitcoin"]),
      );

  Map<String, dynamic> toJson() => {
        "local": local.toJson(),
        "ethereum": ethereum.toJson(),
        "usdc": usdc.toJson(),
        "dai": dai.toJson(),
        "bitcoincash": bitcoincash.toJson(),
        "dogecoin": dogecoin.toJson(),
        "litecoin": litecoin.toJson(),
        "bitcoin": bitcoin.toJson(),
      };
}

class Bitcoin {
  Bitcoin({
    required this.amount,
    required this.currency,
  });

  String amount;
  String currency;

  factory Bitcoin.fromJson(Map<String, dynamic> json) => Bitcoin(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}
/*{
    "code": "ZV97L59V",
    "direcciones": {
        "ethereum": "d715b14e321a",
        "usdc": "0x315f81bc1af048da3bfca4781",
        "dai": "0x315f81bc1af048da3bfca41a",
        "bitcoincash": "qq4y90d78nq6du6jlrllnqpdl5qqvj",
        "dogecoin": "D5oKK8VVEeM1RSN4567h6xmJJ86",
        "litecoin": "MLcwyiR52bDdDpB1d4J3E7S7oa5dxR",
        "bitcoin": "3NbPE6FvxxPjt3fTkaFVdXqbyMcMD"
    },
    "precios": {
        "local": {
            "amount": "80.00",
            "currency": "USD"
        },
        "ethereum": {
            "amount": "0.024290000",
            "currency": "ETH"
        },
        "usdc": {
            "amount": "80.000000",
            "currency": "USDC"
        },
        "dai": {
            "amount": "79.952308448010761581",
            "currency": "DAI"
        },
        "bitcoincash": {
            "amount": "0.12996402",
            "currency": "BCH"
        },
        "dogecoin": {
            "amount": "338.83947480",
            "currency": "DOGE"
        },
        "litecoin": {
            "amount": "0.45169669",
            "currency": "LTC"
        },
        "bitcoin": {
            "amount": "0.00177328",
            "currency": "BTC"
        }
    }
} */