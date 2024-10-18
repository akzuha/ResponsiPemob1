import 'package:flutter/material.dart';
import '../bloc/transportasi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transportasi.dart';
import 'transportasi_page.dart';

// ignore: must_be_immutable
class TransportasiForm extends StatefulWidget {
  Transportasi? transportasi;
  TransportasiForm({super.key, this.transportasi});
  @override
  _TransportasiFormState createState() => _TransportasiFormState();
}

class _TransportasiFormState extends State<TransportasiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";
  final _jenisTransportasiTextboxController = TextEditingController();
  final _perusahaanTransportasiTextboxController = TextEditingController();
  final _kapasitasTransportasiTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.transportasi != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _jenisTransportasiTextboxController.text = widget.transportasi!.jenisTransportasi!;
        _perusahaanTransportasiTextboxController.text = widget.transportasi!.perusahaanTransportasi!;
        _kapasitasTransportasiTextboxController.text =
            widget.transportasi!.kapasitasTransportasi.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Transportasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, // Tema terang
        primaryColor: Colors.yellow, // Warna utama kuning
        fontFamily: 'Helvetica', // Font Helvetica
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow, // Warna AppBar kuning
          foregroundColor: Colors.black, // Warna teks hitam di AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna teks tombol hitam
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Warna teks body hitam
          bodyMedium: TextStyle(color: Colors.black), // Warna teks body hitam
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(judul),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _jenisTransportasiTextField(),
                  _perusahaanTransportasiTextField(),
                  _kapasitasTransportasiTextField(),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Kode Transportasi
  Widget _jenisTransportasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Kode Transportasi",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.text,
      controller: _jenisTransportasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Transportasi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Nama Transportasi
  Widget _perusahaanTransportasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Transportasi",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.text,
      controller: _perusahaanTransportasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Transportasi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Harga Transportasi
  Widget _kapasitasTransportasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.number,
      controller: _kapasitasTransportasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Warna background tombol kuning
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.transportasi != null) {
              // kondisi update transportasi
              ubah();
            } else {
              // kondisi tambah transportasi
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Transportasi createTransportasi = Transportasi(id: null);
    createTransportasi.jenisTransportasi = _jenisTransportasiTextboxController.text;
    createTransportasi.perusahaanTransportasi = _perusahaanTransportasiTextboxController.text;
    createTransportasi.kapasitasTransportasi = int.parse(_kapasitasTransportasiTextboxController.text);
    TransportasiBloc.addTransportasi(transportasi: createTransportasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransportasiPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Transportasi updateTransportasi = Transportasi(id: widget.transportasi!.id!);
    updateTransportasi.jenisTransportasi = _jenisTransportasiTextboxController.text;
    updateTransportasi.perusahaanTransportasi = _perusahaanTransportasiTextboxController.text;
    updateTransportasi.kapasitasTransportasi = int.parse(_kapasitasTransportasiTextboxController.text);
    TransportasiBloc.updateTransportasi(transportasi: updateTransportasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransportasiPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
