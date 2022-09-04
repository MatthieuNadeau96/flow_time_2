import 'package:flow_time_2/models/color.dart';
import 'package:flow_time_2/provider/preference_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PreferenceProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(CupertinoIcons.back),
          onTap: () {
            bloc.savePreferences();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: ListView(
            children: [
              SettingRow(
                name: 'Flow Duration',
                builder: StreamBuilder<Brightness>(
                  stream: bloc.brightness,
                  builder: (context, snapshot) {
                    return Text('30 min');
                  },
                ),
              ),
              SettingRow(
                name: 'Break Duration',
                builder: StreamBuilder<Brightness>(
                  stream: bloc.brightness,
                  builder: (context, snapshot) {
                    return Text('5 min');
                  },
                ),
              ),
              // SettingRow(
              //   name: 'Notifications',
              //   builder: StreamBuilder<Brightness>(
              //     stream: bloc.brightness,
              //     builder: (context, snapshot) {
              //       return Switch(
              //         value: (snapshot.data == Brightness.light) ? false : true,
              //         onChanged: (bool val) {
              //           if (val) {
              //             bloc.changeBrightness(Brightness.dark);
              //           } else {
              //             bloc.changeBrightness(Brightness.light);
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
              // SettingRow(
              //   name: 'Sound',
              //   builder: StreamBuilder<Brightness>(
              //     stream: bloc.brightness,
              //     builder: (context, snapshot) {
              //       return Switch(
              //         value: (snapshot.data == Brightness.light) ? false : true,
              //         onChanged: (bool val) {
              //           if (val) {
              //             bloc.changeBrightness(Brightness.dark);
              //           } else {
              //             bloc.changeBrightness(Brightness.light);
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
              // SettingRow(
              //   name: 'Coffee Timer',
              //   builder: StreamBuilder<Brightness>(
              //     stream: bloc.brightness,
              //     builder: (context, snapshot) {
              //       return Switch(
              //         value: (snapshot.data == Brightness.light) ? false : true,
              //         onChanged: (bool val) {
              //           if (val) {
              //             bloc.changeBrightness(Brightness.dark);
              //           } else {
              //             bloc.changeBrightness(Brightness.light);
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
              SettingRow(
                name: 'Dark Theme',
                builder: StreamBuilder<Brightness>(
                  stream: bloc.brightness,
                  builder: (context, snapshot) {
                    return Switch(
                      value: (snapshot.data == Brightness.light) ? false : true,
                      onChanged: (bool val) {
                        if (val) {
                          bloc.changeBrightness(Brightness.dark);
                        } else {
                          bloc.changeBrightness(Brightness.light);
                        }
                      },
                    );
                  },
                ),
              ),
              SettingRow(
                name: 'Primary Color',
                builder: StreamBuilder<ColorModel>(
                  stream: bloc.primaryColor,
                  builder: (context, snapshot) {
                    return Slider(
                      value: snapshot.data?.index != null
                          ? snapshot.data!.index
                          : 0.0,
                      min: 0.0,
                      max: 3.0,
                      divisions: 3,
                      label: snapshot.data?.name != null
                          ? snapshot.data!.name
                          : "color",
                      onChanged: (double val) {
                        bloc.changePrimaryColor(
                          bloc.indexToPrimaryColor(val),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  final String name;
  final Widget builder;
  const SettingRow({
    super.key,
    required this.name,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(name),
            ),
            builder,
          ],
        ),
        const Divider(
          height: 15,
        ),
      ],
    );
  }
}
