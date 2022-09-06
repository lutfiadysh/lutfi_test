import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lutfi_ardiansyah_test/persentation/blocs/local_data/local_data_bloc.dart';
import 'package:lutfi_ardiansyah_test/persentation/widget/forms/text_input.dart';

class SaveDataPage extends StatefulWidget {
  const SaveDataPage({Key? key}) : super(key: key);

  @override
  State<SaveDataPage> createState() => _SaveDataPageState();
}

class _SaveDataPageState extends State<SaveDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  var localDataBloc = LocalDataBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => localDataBloc..add(FetchLocalData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Simpan Data"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: NormalTextInput(
                    error: "",
                    inputController: nameController,
                    label: "Nama",
                    onChange: (val) {}),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: NormalTextInput(
                    keyboardType: TextInputType.number,
                    error: "",
                    inputController: ageController,
                    label: "Umur",
                    onChange: (val) {}),
              ),
              ElevatedButton(
                onPressed: () {
                  localDataBloc.add(SubmitLocalData(
                      age: ageController.text, name: nameController.text));
                },
                child: Text("Simpan"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width - 30, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              BlocConsumer<LocalDataBloc, LocalDataState>(
                listener: (context, state) {
                  if (state is SubmitLocalDataSuccess) {
                    localDataBloc.add(FetchLocalData());
                    setState(() {
                      nameController.text = "";
                      ageController.text = "";
                    });
                  }
                },
                builder: (context, state) {
                  if (state is FetchLocalDataSuccess) {
                    return Column(
                      children: state.localData.map((e) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: MediaQuery.of(context).size.width - 32,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2),
                                color: Colors.black.withOpacity(.12),
                                blurRadius: 12,
                              )
                            ],
                          ),
                          child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Nama :",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    e.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Umur :",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    e.age,
                                    style: TextStyle(),
                                  ),
                                ],
                              )),
                        );
                      }).toList(),
                    );
                  }
                  if (state is FetchLocalDataFailure) {
                    return Text("No Data Found...");
                  }
                  if (state is FetchLocalDataLoading) {
                    return CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
