# UAMcloudflare



Untuk mengotomatisasi Under Attack Mode Cloudflare berdasarkan  penggunaan CPU server, kamu bisa menggunakan Cloudflare API dan skrip monitoring di server. Berikut adalah langkah-langkahnya:

1. Dapatkan API Token Cloudflare
	1.	Masuk ke Cloudflare Dashboard.
	2.	Pergi ke My Profile > API Tokens.
	3.	Buat token baru dengan Zone Settings: Edit.
	4.	Simpan API Token yang didapat.


Cara Menjalankan Skrip
	1.	Simpan skrip dengan nama cloudflare_auto.sh
	2.	Beri izin eksekusi:

chmod +x cloudflare_auto.sh


	3.	Jalankan di background:

nohup ./cloudflare_auto.sh &


	4.	Untuk menjalankan otomatis saat booting, tambahkan ke crontab:

crontab -e

Tambahkan baris:

@reboot /path/to/cloudflare_auto.sh &

(path/to) adalah folder dimana anda simpan file tersebut

Bagaimana Cara Kerjanya?

✅ Skrip ini akan:
	•	Mengecek CPU load setiap 60 detik.
	•	Jika CPU ≥ 80%, maka Under Attack Mode ON.
	•	Jika CPU < 80%, maka Under Attack Mode OFF.
 set sesuka mu.. 

Kustomisasi
	•	Ganti THRESHOLD=80 untuk batas CPU yang lebih tinggi atau rendah.
	•	Ganti CHECK_INTERVAL=60 jika ingin pengecekan lebih sering atau jarang.

Ini solusi yang fleksibel dan otomatis tanpa perlu campur tangan manual!
