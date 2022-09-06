import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lutfi_ardiansyah_test/core/utils/shared_key.dart';
import 'package:lutfi_ardiansyah_test/data/entities/local_data/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_data_event.dart';
part 'local_data_state.dart';

class LocalDataBloc extends Bloc<LocalDataEvent, LocalDataState> {
  LocalDataBloc() : super(LocalDataInitial()) {
    on<FetchLocalData>(mapFetchLocalDataToState);

    on<SubmitLocalData>(mapSubmitLocalDataToState);
  }

  void mapFetchLocalDataToState(FetchLocalData event, emit) async {
    try {
      emit(FetchLocalDataLoading());
      SharedPreferences preferences = await SharedPreferences.getInstance();

      var data = preferences.getString(SharedKey.localData);
      if (data != null) {
        final List<LocalData> localData = LocalData.decode(data.toString());
        emit(FetchLocalDataSuccess(localData: localData));
      } else {
        emit(const FetchLocalDataFailure(message: "Data is empty"));
      }
    } catch (e) {
      emit(FetchLocalDataFailure(message: e.toString()));
    }
  }

  void mapSubmitLocalDataToState(SubmitLocalData event, emit) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<LocalData> dataInput = [];
      var data = preferences.getString(SharedKey.localData);
      if (data != null) {
        var decodeData = LocalData.decode(data.toString());
        decodeData.forEach((element) {
          dataInput.add(element);
        });
      }

      dataInput.add(LocalData(name: event.name, age: event.age));

      final encodeInput = LocalData.encode(dataInput);

      preferences.setString(SharedKey.localData, encodeInput);
      emit(SubmitLocalDataSuccess());
    } catch (e) {
      emit(SubmitLocalDataFailure(message: e.toString()));
      emit(LocalDataInitial());
    }
  }
}
