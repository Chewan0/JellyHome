# JellyHome

**Version:** v1.0.0B

🇹🇷 Basit, tek tıkla kurulabilen Jellyfin medya sunucusu kurulumu.

🇺🇸 Simple one-click Jellyfin media server installer.

---

# 🇹🇷 Türkçe

## JellyHome Nedir?

JellyHome, Docker tabanlı bir medya sunucusunu tek tıkla kurabilmeniz için geliştirilmiş bir projedir.

Amacım, Docker komutlarıyla uğraşmadan, karmaşık CMD işlemlerine gerek kalmadan herkesin kolayca kendi medya sunucusunu kurabilmesini sağlamaktır.

Kurulum sırasında aşağıdaki servisler otomatik olarak yüklenir:

- Jellyfin
- Radarr
- Sonarr
- Prowlarr
- RDTClient

---

## Özellikler

Kurulum tamamlandıktan sonra menü üzerinden şunları yapabilirsiniz:

- ✅ Kurulum
- ▶️ Servisleri Başlat
- ⏹️ Servisleri Durdur
- 🔄 Servisleri Yeniden Başlat
- ⬆️ Tüm container'ları güncelle
- 📜 Logları görüntüle
- 🌐 Jellyfin, Radarr, Sonarr ve Prowlarr'ı tek tıkla tarayıcıda aç
- 📊 Durum kontrolü
- 🔌 Portların kullanım durumunu görüntüleme
- 🗑️ Tek tıkla kaldırma

---

## Kurulum

1. Repository'i ZIP olarak indirin.
2. ZIP'i çıkarın.
3. `install.bat` dosyasını çalıştırın.
4. Menü açıldıktan sonra `1` yazarak kurulumu başlatın.

Kurulum tamamlandıktan sonra sistem kullanıma hazır olacaktır.

⚠️ İlk kurulumdan sonra servislerin tamamen hazır olması biraz zaman alabilir.

Jellyfin ve diğer servisler sistem performansına bağlı olarak 15–40 saniye içerisinde tamamen kullanıma hazır hale gelir.

Tarayıcıda ilk açılışta sayfa gelmezse birkaç saniye bekleyip yenilemeyi deneyin.

---

# 🇺🇸 English

## What is JellyHome?

JellyHome is a simple Windows installer designed to deploy a complete Docker-based Jellyfin media server with a single click.

The goal is to make Jellyfin installation easy without requiring Docker knowledge or complex command-line usage.

Installed services:

- Jellyfin
- Radarr
- Sonarr
- Prowlarr
- RDTClient

---

## Features

- One-click installation
- Start services
- Stop services
- Restart services
- Update all containers
- View container logs
- Open services in your browser
- Port status checker
- Easy uninstall

---

## Installation

1. Download this repository as ZIP.
2. Extract the archive.
3. Run `install.bat`.
4. Press `1` to start the installation.

⚠️ After the first installation, services may take some time to become fully available.

Depending on your system performance, Jellyfin and the other services may take 15–40 seconds to start completely.

If the web page does not load immediately, wait a few seconds and refresh your browser.

---

# Feedback

🇹🇷

Karşılaştığınız hataları, önerilerinizi veya isteklerinizi aşağıdaki e-posta adresine gönderebilirsiniz.

📧 **feedback@chewan.cfd**

🇺🇸

If you encounter any bugs, have feature requests, or would like to share feedback, feel free to contact me at:

📧 **feedback@chewan.cfd**

---

# Roadmap

- [x] Windows Installer (.bat)
- [ ] Linux Installer (.sh)
- [ ] Multi-language Support
- [ ] Automatic Update Checker
- [ ] Custom Installation Options

---

# License

Copyright © CHW

This project is licensed under the MIT License.