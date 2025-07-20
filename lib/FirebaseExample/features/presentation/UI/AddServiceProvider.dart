import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/Entities/ServiceProviderEntity.dart';
import '../ServiceProviderBloC/service_provider_bloc.dart';

class AddServiceProvider extends StatefulWidget {
  const AddServiceProvider({super.key});

  @override
  State<AddServiceProvider> createState() => _AddServiceProviderState();
}

class _AddServiceProviderState extends State<AddServiceProvider> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _serviceNameController.dispose();
    _employeeNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _uploadServiceProvider() {
    if (_formKey.currentState?.validate() ?? false) {
      final nameOfService = _serviceNameController.text.trim();
      final nameOfEmployee = _employeeNameController.text.trim();
      final address = _addressController.text.trim();

      final serviceProviderEntity = ServiceProviderEntity(
        nameOfService: nameOfService,
        nameOfEmployee: nameOfEmployee,
        address: address,
      );

      context.read<ServiceProviderBloc>().add(
        UploadServiceProviderEvent(
          serviceProviderEntity: serviceProviderEntity,
        ),
      );
    }
  }

  void _showMessageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Service Provider'),
        backgroundColor: Colors.yellow,
      ),
      body: BlocListener<ServiceProviderBloc, ServiceProviderState>(
        listener: (context, state) {
          if (state is ServiceProviderLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Uploading service provider...')),
              );
          } else if (state is ServiceProviderSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _showMessageDialog(
              'Success',
              'Service Provider "${state.serviceProviderEntity.nameOfService}" ',
            );
            // Clear fields after success
            _serviceNameController.clear();
            _employeeNameController.clear();
            _addressController.clear();
          } else if (state is ServiceProviderError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _showMessageDialog('Upload Failed', state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _serviceNameController,
                  decoration: const InputDecoration(
                    labelText: 'Service Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter service name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _employeeNameController,
                  decoration: const InputDecoration(
                    labelText: 'Employee Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter employee name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is ServiceProviderLoading ? null : _uploadServiceProvider,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: state is ServiceProviderLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Upload Service Provider',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
