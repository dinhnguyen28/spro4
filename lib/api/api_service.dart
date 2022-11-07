import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:login_bloc/bloc/ticket_bloc/ticket_bloc.dart';
import 'package:login_bloc/models/cancel_ticket_model/cancel_ticket_model.dart';
import 'package:login_bloc/models/get_filter_model/filter_model.dart';
import 'package:login_bloc/models/phase_detail_model/id_detail_model.dart';
import 'package:login_bloc/models/phase_detail_model/phase_detail_model.dart';

import 'package:login_bloc/models/ticket_model/ticket_model.dart';
import 'package:login_bloc/models/login_model/login_models.dart';
import 'package:login_bloc/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<Map<dynamic, dynamic>?> count() async {}

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

Future<PhaseDetailData> _____(int procInstId, String taskDefKey) async {
  final response = await http.get(
      Uri.http(_apiUri, "business-process/loadActiveTask/getDetail", {
        'procInstId': '$procInstId',
        'taskDefKey': taskDefKey,
        'user': '',
        'status': '',
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await accessToken}',
      });

  if (response.statusCode == 200) {
    return PhaseDetailData.fromJson(json.decode(response.body));
  } else {
    return PhaseDetailData();
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