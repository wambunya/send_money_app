import 'package:flutter/material.dart';
import '../widgets/reusable_button.dart';

class SendMoneyPage extends StatefulWidget {
  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String _recipientName = '';
  double _amount = 0.0;
  String _selectedPaymentMethod = 'Bank Transfer';
  bool _isFavorite = false;
  bool _showSuccessMessage = false;

  final List<String> _paymentMethods = ['Bank Transfer', 'Credit Card', 'PayPal'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showSuccessMessage = true;
      });
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipient name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipientName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a valid amount greater than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              DropdownButtonFormField(
                value: _selectedPaymentMethod,
                decoration: InputDecoration(labelText: 'Payment Method'),
                items: _paymentMethods
                    .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value.toString();
                  });
                },
              ),
              SwitchListTile(
                title: Text('Mark as Favorite'),
                value: _isFavorite,
                onChanged: (value) {
                  setState(() {
                    _isFavorite = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ReusableButton(
                text: 'Send Money',
                onPressed: _submitForm,
              ),
              SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _showSuccessMessage ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Center(
                  child: Text(
                    'Transaction Successful!',
                    style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
