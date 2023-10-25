import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/FontStyle.dart';
import '../data/firebase_firestore.dart';

class AllRecordsPage extends StatefulWidget {
  const AllRecordsPage({Key? key}) : super(key: key);

  @override
  State<AllRecordsPage> createState() => _AllRecordsPageState();
}

class _AllRecordsPageState extends State<AllRecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Records',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: const Color(0xff293462),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.list_alt,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Daftar Barang yang anda pinjam',
                    style: GoogleFonts.roboto(textStyle: s18w600),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 15),
                width: double.infinity,
                height: 2.5,
                color: Colors.black,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: borrowedItems.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data!.docs.map((e) {
                            var data = (e.data() as dynamic)['barang dipinjam'];
                            print(data);
                            List<dynamic> list = [];
                            list.add(data);
                            print('$list halo');
                            return showData(
                              tanggal: (e.data() as dynamic)['tanggal pinjam'].toString(),
                              name: (e.data() as dynamic)['nama'].toString(),
                              npm: (e.data() as dynamic)['npm'].toString(),
                              namaBarang: data,
                            );
                          }).toList()

                          // children: snapshot.data!.docs.map((e)
                          // return {
                          // showData(
                          // tanggal: (e.data() as dynamic)['tanggal pinjam'].toString(),
                          // name: (e.data() as dynamic)['nama'].toString(),
                          // npm: (e.data() as dynamic)['npm'].toString(),
                          // namaBarang: (e.data() as dynamic)['barang dipinjam'],
                          // )).toList()
                          // }
                          //     showData(
                          //   tanggal: (e.data() as dynamic)['tanggal pinjam'].toString(),
                          //   name: (e.data() as dynamic)['nama'].toString(),
                          //   npm: (e.data() as dynamic)['npm'].toString(),
                          //   namaBarang: (e.data() as dynamic)['barang dipinjam'],
                          // )).toList(),
                          );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ]),
    );
  }

  Widget showData({
    required String tanggal,
    required String name,
    required String npm,
    required List<dynamic> namaBarang,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff6F61C0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('tanggal : $tanggal', style: GoogleFonts.roboto(textStyle: white_s16w600),),
          Text('nama : $name', style: GoogleFonts.roboto(textStyle: white_s16w600),),
          Text('npm : $npm', style: GoogleFonts.roboto(textStyle: white_s16w600),),
          Text('barang dipinjam : ', style: GoogleFonts.roboto(textStyle: white_s16w600),),
          ListView.builder(
            itemCount: namaBarang.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Text('- ${namaBarang[index]}', style: GoogleFonts.roboto(textStyle: white_s16w600),
              );
            },
          )
        ],
      ),
    );
  }
}
