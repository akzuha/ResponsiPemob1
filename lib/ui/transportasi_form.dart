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
        _jenisTransportasiTextboxController.text = widget.transportasi!.vehicle!;
        _perusahaanTransportasiTextboxController.text = widget.transportasi!.company!;
        _kapasitasTransportasiTextboxController.text =
            widget.transportasi!.capacity.toString();
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
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
    );
  }

  // Membuat Textbox Jenis Transportasi
  Widget _jenisTransportasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jenis Transportasi"),
      keyboardType: TextInputType.text,
      controller: _jenisTransportasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jenis Transportasi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Perusahaan Transportasi
  Widget _perusahaanTransportasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Perusahaan Transportasi"),
      keyboardType: TextInputType.text,
      controller: _perusahaanTransportasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Perusahaan Transportasi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Kapasitas Transportasi
  Widget _kapasitasTransportasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kapasitas"),
      keyboardType: TextInputType.number,
      controller: _kapasitasTransportasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kapasitas harus diisi";
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
    createTransportasi.vehicle = _jenisTransportasiTextboxController.text;
    createTransportasi.company = _perusahaanTransportasiTextboxController.text;
    createTransportasi.capacity = int.parse(_kapasitasTransportasiTextboxController.text);
    TransportasiBloc.addTransportasi(transportasi: createTransportasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransportasiPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan data gagal, silahkan coba lagi",
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
    updateTransportasi.vehicle = _jenisTransportasiTextboxController.text;
    updateTransportasi.company = _perusahaanTransportasiTextboxController.text;
    updateTransportasi.capacity = int.parse(_kapasitasTransportasiTextboxController.text);
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
