import 'package:finance_application/Services/Cubits/fetchData_cubit/fetch_data_cubit.dart';
import 'package:finance_application/Services/Models/finance_model.dart';
import 'package:finance_application/core/ColorsConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlusPage extends StatefulWidget {
  PlusPage({super.key, required this.isPlus, this.Model});
  final bool isPlus;
  FinanceModel? Model;
  @override
  State<PlusPage> createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController _keyPadController = TextEditingController();
  final List<String> keys = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '.',
    '0',
    '<',
  ];
  @override
  void initState() {
    if (widget.Model != null) {
      setState(() {
        titleController.text = widget.Model!.title;
        _keyPadController.text = widget.Model!.price.toString();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPlus ? 'Plus' : 'Minus'),
        leading: IconButton(
          onPressed: () async {
            await BlocProvider.of<FetchDataCubit>(context).FetchData();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<FetchDataCubit, FetchDataState>(
        listener: (context, state) {
          if (state is AddDataSuccess) {
            var snackBar =
                SnackBar(content: Text('You have been Added successfully'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          } else if (state is AddDataFalirue) {
            var snackBar = SnackBar(content: Text("We Can't Add Item For Now"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: KseconderyPurble,
                  ),
                  child: TextField(
                    controller: titleController,
                    maxLines: 1,
                    cursorColor: KBlackColor,
                    style: TextStyle(color: KBlackColor),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 16),
                        labelText: 'Title...',
                        labelStyle: TextStyle(color: KBlackColor),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.isPlus ? kSeconderyGreen : kSeconderyRed,
                  ),
                  child: Text(
                    widget.isPlus
                        ? _keyPadController.text.isEmpty
                            ? '+ 0.0'
                            : '+ ${_keyPadController.text}'
                        : _keyPadController.text.isEmpty
                            ? '- 0.0'
                            : ' ${_keyPadController.text}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.isPlus ? kPrimaryGreen : kPrimaryRed,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 1.5),
                      itemCount: keys.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              checkKeyPad(keys[index], _keyPadController);
                            });
                            print(_keyPadController.text);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: KBlackColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${keys[index]}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: KWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                        child: customButtons(
                      ontap: () {
                        if (widget.Model != null) {
                          widget.Model!.title = titleController.text;
                          widget.Model!.price = widget.Model!.isPlus
                              ? double.parse(_keyPadController.text)
                              : double.parse(_keyPadController.text) > 0
                                  ? double.parse(_keyPadController.text) * -1
                                  : double.parse(_keyPadController.text);
                          widget.Model!.save();
                          BlocProvider.of<FetchDataCubit>(context).FetchData();
                          Navigator.pop(context);
                        } else {
                          BlocProvider.of<FetchDataCubit>(context).AddData(
                              FinanceModel(
                                  isPlus: widget.isPlus,
                                  title: titleController.text,
                                  price: widget.isPlus
                                      ? double.parse(_keyPadController.text)
                                      : double.parse(_keyPadController.text) > 0
                                          ? double.parse(
                                                  _keyPadController.text) *
                                              -1
                                          : double.parse(
                                              _keyPadController.text),
                                  date: DateTime.now()));
                        }
                      },
                      child: state is AddDataLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: kPrimaryBlue,
                            ))
                          : Text(
                              textAlign: TextAlign.center,
                              widget.Model != null ? 'Edit' : 'Add',
                              style:
                                  TextStyle(fontSize: 20, color: kPrimaryBlue),
                            ),
                      borderColor: kSeconderyBlue,
                    )),
                    SizedBox(width: 10),
                    Flexible(
                        child: customButtons(
                      ontap: () async {
                        Navigator.pop(context);
                        await BlocProvider.of<FetchDataCubit>(context)
                            .FetchData();
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        'Cancel',
                        style: TextStyle(fontSize: 20, color: kPrimaryRed),
                      ),
                      borderColor: kSeconderyRed,
                    )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class customButtons extends StatelessWidget {
  const customButtons({
    super.key,
    required this.child,
    required this.borderColor,
    required this.ontap,
  });
  final Widget child;
  final Color borderColor;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child),
    );
  }
}

void checkKeyPad(String key, TextEditingController _keyPadController) {
  if (key == '<' && _keyPadController.text.isNotEmpty)
    _keyPadController.text =
        _keyPadController.text.substring(0, _keyPadController.text.length - 1);
  else if (key == '<' && _keyPadController.text.isEmpty) {
  } else if (key == '.' && _keyPadController.text.contains('.')) {
  } else
    _keyPadController.text += key;
}
