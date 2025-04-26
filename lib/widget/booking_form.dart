import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _peopleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Booking Form',
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _peopleController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Jumlah Orang',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Harap masukkan jumlah orang';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: _selectedDate == null
                      ? 'Tanggal Booking'
                      : '${_selectedDate!.toLocal()}'.split(' ')[0],
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectTime(context),
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: _selectedTime == null
                      ? 'Waktu Booking'
                      : _selectedTime!.format(context),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Lakukan sesuatu saat form valid
                print('Jumlah Orang: ${_peopleController.text}');
                print('Tanggal Booking: $_selectedDate');
                print('Waktu Booking: $_selectedTime');
                Navigator.pop(context);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
