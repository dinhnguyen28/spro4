import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:spro4/bloc/ticket_bloc/ticket_bloc.dart';
import 'dart:convert';

import 'package:spro4/main.dart';
import 'package:spro4/models/cancel_ticket_model/cancel_ticket_model.dart';
import 'package:spro4/models/count_ticket_model/count_ticket_model.dart';
import 'package:spro4/models/get_filter_model/filter_model.dart';
import 'package:spro4/models/login_model/login_models.dart';
import 'package:spro4/models/phase_detail_model/id_detail_model.dart';
import 'package:spro4/models/rating_ticket_model/rating_ticket_model.dart';
import 'package:spro4/models/ticket_model/ticket_model.dart';

const _apiUri = 'api-gateway-fis-mbf-spro4-dev.apps.xplat.fis.com.vn';

final accessToken = secureStorage.readSecureData('accessToken');

Future<LoginResponse> loginRequest(LoginRequest login) async {
  final response = await http.post(Uri.http(_apiUri, 'setting/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(login.toJson()));

  if (response.statusCode == 200) {
    return LoginResponse.fromJson(json.decode(response.body));
  } else {
    return LoginResponse();
  }
}

Future<Count> count() async {
  final response = await http
      .get(Uri.http(_apiUri, 'business-process/ticket/count'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${await accessToken}',
  });

  if (response.statusCode == 200) {
    return Count.fromJson(json.decode(response.body));
  } else {
    return Count();
  }
}

Future<Filter> getFilter() async {
  final response = await http.post(
      Uri.http(_apiUri, 'business-process/bpmProcInst/getFilter'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await accessToken}',
      });

  if (response.statusCode == 200) {
    return Filter.fromJson(json.decode(response.body));
  } else {
    return Filter();
  }
}

Future<MyTicket?> searchTicket(
  String? search,
  int? page,
  // [int limit = 100]
  // List<String>? type,
  String? ticketStatus,
  // String? sortBy,
  // String? sortType,
  List<String>? listService,
  // List<String>? listUser,
  List<TicketStatus>? listStatus,
  // String? pageType,
  String? fromDate,
  String? toDate,
  String? fromDateFinish,
  String? toDateFinish,
  String? fromDateCancel,
  String? toDateCancel,
  List<dynamic>? listDateFilter,
) async {
  try {
    final response = await http.post(
        Uri.http(_apiUri, 'business-process/bpmProcInst/search'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await accessToken}',
        },
        body: jsonEncode({
          "search": search,
          "page": page,
          "limit": "10",
          "ticketStatus": ticketStatus,
          "sortBy": "ticketCreatedTime",
          "sortType": "DESC",
          "listService": listService,
          "listUser": [],
          "listStatus": (listStatus ?? []).map((e) => e.name).toList(),
          "pageType": "ticket",
          "fromDate": fromDate,
          "toDate": toDate,
          "fromDateFinish": fromDateFinish,
          "toDateFinish": toDateFinish,
          "fromDateCompleted": "",
          "toDateCompleted": "",
          "fromDateCancel": fromDateCancel,
          "toDateCancel": toDateCancel,
          "listDateFilter": listDateFilter,
        }));

    if (response.statusCode == 200) {
      // log(response.body);
      return MyTicket.fromJson(json.decode(response.body));
    } else {
      return MyTicket();
    }
  } catch (e, trace) {
    debugPrint(e.toString());
    debugPrint(trace.toString());
  }
  return null;
}

Future<IdData> idTicket(int id) async {
  final response = await http.get(
      Uri.http(_apiUri, 'business-process/bpmProcInst/search/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await accessToken}',
      });

  if (response.statusCode == 200) {
    return IdData.fromJson(json.decode(response.body));
  } else {
    return IdData();
  }
}

Future<CancelTicket> cancelTicket(String? ticketId, String? reason) async {
  final response =
      await http.post(Uri.http(_apiUri, 'business-process/cancel/$ticketId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await accessToken}',
          },
          body: jsonEncode({
            "reason": reason,
          }));

  if (response.statusCode == 200) {
    return CancelTicket.fromJson(json.decode(response.body));
  } else {
    return CancelTicket();
  }
}

Future<RatingTicket> closeTicket(
    int? procInstId, double? rating, String? comment) async {
  final response =
      await http.post(Uri.http(_apiUri, 'business-process/closeTicket'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await accessToken}',
          },
          body: jsonEncode({
            "procInstId": procInstId,
            "rating": rating,
            "comment": comment,
          }));

  if (response.statusCode == 200) {
    return RatingTicket.fromJson(json.decode(response.body));
  } else {
    return RatingTicket();
  }
}
