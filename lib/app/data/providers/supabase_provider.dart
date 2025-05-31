import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProvider {
  final SupabaseClient _client = Supabase.instance.client;

// Supabase Provider untuk mengelola Login
  Future<GotrueSessionResponse> login({
    required String email,
    required String password,
  }) async {
    // Melakukan login menggunakan Supabase Auth
    final response = await _client.auth.signIn(
      email: email,
      password: password,
    );
    return response;
  }
}

class AuthResponse {}

// Supabase Provider untuk mengelola Mitra
class MitraProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchMitra() async {
    final response = await _client.from('mitra').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<void> insertMitra({
    required String nama,
    required String alamat,
    required String telepon,
    required String email,
  }) async {
    final response = await _client.from('mitra').insert({
      'nama_mtr': nama,
      'alamat_mtr': alamat,
      'telepon_mtr': telepon,
      'email_mtr': email,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> updateMitra({
    required int id,
    required String nama,
    required String alamat,
    required String telepon,
    required String email,
  }) async {
    final response = await _client
        .from('mitra')
        .update({
          'nama_mtr': nama,
          'alamat_mtr': alamat,
          'telepon_mtr': telepon,
          'email_mtr': email,
        })
        .eq('id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteMitra(int id) async {
    final response =
        await _client.from('mitra').delete().eq('id', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}

// Supabase Provider untuk mengelola Suplier
class SuplierProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchSuplier() async {
    final response = await _client.from('suplier').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<void> insertSuplier({
    required String nama,
    required String alamat,
    required String telepon,
    required String email,
    String? npwp,
    required String jenisProduk,
    String status = 'aktif',
    String? tanggalBergabung,
    String? bank,
    String? noRekening,
    String? catatan,
  }) async {
    final response = await _client.from('suplier').insert({
      'nama_spr': nama,
      'alamat_spr': alamat,
      'telepon_spr': telepon,
      'email_spr': email,
      'npwp': npwp,
      'jenis_produk': jenisProduk,
      'status': status,
      'tanggal_bergabung': tanggalBergabung,
      'bank': bank,
      'no_rekening': noRekening,
      'catatan': catatan,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> updateSuplier({
    required int id,
    required String nama,
    required String alamat,
    required String telepon,
    required String email,
    String? npwp,
    required String jenisProduk,
    String status = 'aktif',
    String? tanggalBergabung,
    String? bank,
    String? noRekening,
    String? catatan,
  }) async {
    final response = await _client
        .from('suplier')
        .update({
          'nama_spr': nama,
          'alamat_spr': alamat,
          'telepon_spr': telepon,
          'email_spr': email,
          'npwp': npwp,
          'jenis_produk': jenisProduk,
          'status': status,
          'tanggal_bergabung': tanggalBergabung,
          'bank': bank,
          'no_rekening': noRekening,
          'catatan': catatan,
        })
        .eq('id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteSuplier(int id) async {
    final response =
        await _client.from('suplier').delete().eq('id', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}

// Supabase Provider untuk mengelola Produk
class ProdukProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchProduk() async {
    final response = await _client.from('produk').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data);
  }

// Supabase Provider untuk mengelola Produk_Aljazira
  Future<void> insertProduk({
    required String nama,
    required double hargaModal,
    required double hargaJual,
    int jumlahStok = 0,
    double? jumlahBarangMasuk,
    String status = 'aktif',
    String? deskripsi,
  }) async {
    final response = await _client.from('produk').insert({
      'nama_prdk': nama,
      'harga_modal': hargaModal,
      'harga_jual': hargaJual,
      'jumlah_stok': jumlahStok,
      'jumlah_barangmasuk': jumlahBarangMasuk,
      'status': status,
      'deskripsi': deskripsi,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> updateProduk({
    required int id,
    required String nama,
    required double hargaModal,
    required double hargaJual,
    int jumlahStok = 0,
    double? jumlahBarangMasuk,
    String status = 'aktif',
    String? deskripsi,
  }) async {
    final response = await _client
        .from('produk')
        .update({
          'nama_prdk': nama,
          'harga_modal': hargaModal,
          'harga_jual': hargaJual,
          'jumlah_stok': jumlahStok,
          'jumlah_barangmasuk': jumlahBarangMasuk,
          'status': status,
          'deskripsi': deskripsi,
        })
        .eq('id_prdk', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteProduk(int id) async {
    final response =
        await _client.from('produk').delete().eq('id_prdk', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}

class ProdukAljaziraProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> insertProdukAljazira({
    required String kodeProduk,
    required String namaProduk,
    int? idSpr,
    String? deskripsi,
    required double hargaBeli,
    required double hargaJual,
    int? stok,
    String? satuan,
    String? tanggalKadaluarsa,
    String? gambarProduk,
    String status = 'aktif',
  }) async {
    final response = await _client.from('produk_aljazira').insert({
      'kode_produk': kodeProduk,
      'nama_produk': namaProduk,
      'id_spr': idSpr,
      'deskripsi': deskripsi,
      'harga_beli': hargaBeli,
      'harga_jual': hargaJual,
      'stok': stok,
      'satuan': satuan,
      'tanggal_kadaluarsa': tanggalKadaluarsa,
      'gambar_produk': gambarProduk,
      'status': status,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<List<Map<String, dynamic>>> fetchProdukBySupplier(int? idSpr) async {
    if (idSpr == null) return [];
    final response = await _client
        .from('produk_aljazira')
        .select()
        .eq('id_spr', idSpr)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> fetchAllProduk() async {
    final response = await _client.from('produk_aljazira').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data);
  }
}
