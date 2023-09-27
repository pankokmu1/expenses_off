import 'dart:io';

import 'package:expenses_off/core/configs/dependency_injection.dart';
import 'package:expenses_off/core/utils/date_parse.dart';
import 'package:expenses_off/core/widgets/e_text_field.dart';
import 'package:expenses_off/features/expense/presentation/models/expense_update_model.dart';
import 'package:expenses_off/features/expense/presentation/state_manager/expense_detail/expense_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';

import '../../domain/entities/expense.dart';

class ExpenseDetailPage extends StatefulWidget {
  const ExpenseDetailPage({super.key, this.expense});
  final Expense? expense;

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController dateOfExpenseController = TextEditingController();
  late DateTime dateOfexpense;
  bool isUpdate = false;
  Expense? expense;
  String? paymentReceiptPath;
  ExpenseUpdateModel updateModel = const ExpenseUpdateModel();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    if (widget.expense != null) {
      expense = widget.expense;
      isUpdate = true;
      descriptionTextController.text = expense!.description;
      valueController.text = expense!.amount.toString();
      dateOfExpenseController.text = expense!.expenseDate.toString();
    }
    descriptionTextController.addListener(() {
      if (descriptionTextController.text.length > 3) {
        updateModel.copyWith(description: descriptionTextController.text);
      }
    });
    valueController.addListener(() {
      if (valueController.text.length > 1) {
        updateModel.copyWith(
            amount: double.parse(valueController.text.replaceAll(',', '.')));
      }
    });
    super.initState();
  }

  final bloc = di<ExpenseDetailCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense == null ? 'add expense' : 'Expense'),
      ),
      body: SingleChildScrollView(
        key: UniqueKey(),
        child: Column(
          key: UniqueKey(),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ETextField(
                labelText: 'Description',
                controller: descriptionTextController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ETextField(
                labelText: 'Value',
                controller: valueController,
                textInputType: TextInputType.number,
                textInputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9\.]+$')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: dateTimePickerWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final XFile? pickedFile = await _picker
                      .pickImage(
                    source: ImageSource.camera,
                  )
                      .catchError((onError) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('error when capture image'),
                      duration: Duration(seconds: 2),
                    ));
                    return null;
                  });
                  paymentReceiptPath = pickedFile?.path;
                  setState(() {});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: const Border.fromBorderSide(
                          BorderSide(width: 1.0, color: Colors.black)),
                    ),
                    child: SizedBox.square(
                      dimension: 250,
                      child: expense?.paymentReceipt != null ||
                              paymentReceiptPath != null
                          ? expense?.isItPending ?? paymentReceiptPath != null
                              ? Image.file(
                                  File(expense?.paymentReceipt ??
                                      paymentReceiptPath!),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  expense!.paymentReceipt!,
                                  fit: BoxFit.cover,
                                )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('add payment receipt'),
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: MaterialButton(
                onPressed: () {
                  if (updateModel.hasData) {
                    if (isUpdate) {
                      bloc.updateExpense(
                          expense!.id, updateModel, expense!.isItPending);
                    } else if (updateModel.isCompleted) {
                      bloc.createExpense(updateModel);
                    }
                  }
                },
                height: 45,
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  isUpdate ? "Update expense" : "Create expense",
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dateTimePickerWidget() {
    return DateTimePicker(
      type: DateTimePickerType.dateTime,
      firstDate: DateTime(1999),
      initialDate: expense?.expenseDate ?? DateTime.now(),
      lastDate: DateTime(2999),
      dateMask: 'yyyy-MM-dd hh:mm:ss.SSS',
      onSaved: (date) {
        if (date != null) dateOfExpenseController.text = date;
      },
      cursorColor: Colors.black,
      dateHintText: 'Date of expense',
      dateLabelText: 'Date of expense',
      initialValue: expense?.expenseDate != null
          ? dateTimeToStringWithZone(expense!.expenseDate)
          : null,
      decoration: InputDecoration(
        hintText: 'Date of expense',
        labelText: 'Date of expense',
        contentPadding: const EdgeInsets.all(0.0),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.key,
          color: Colors.black,
          size: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
