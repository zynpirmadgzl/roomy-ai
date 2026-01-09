 Roomy AI - Staj Değerlendirme Projesi

Bu proje, Pera Soft staj başvuru süreci kapsamında, App Store'da yer alan "Roomy AI" uygulamasından esinlenilerek geliştirilmiş teknik bir çalışmadır. Uygulama, kullanıcılara boş odalarını yapay zeka desteğiyle yeniden tasarlama imkanı sunan modern bir mimari ile inşa edilmiştir.

 Teknik Özellikler & Mimari
Mimar Yapı: Projede Stacked (MVVM) mimarisi kullanılmıştır. Bu sayede Business Logic (ViewModel) ve UI (View) katmanları birbirinden tamamen ayrıştırılarak temiz ve test edilebilir bir kod yapısı hedeflenmiştir.
State Management: Veri akışı ve ekran güncellemeleri Stacked kütüphanesinin sağladığı ReactiveService ve BaseViewModel yapıları ile yönetilmektedir.
Firebase Entegrasyonu: Uygulama, Firebase altyapısı ile entegre edilmiştir. Kullanıcı bazlı benzersiz ID üretimi ve temel konfigürasyonlar backend entegrasyonuna hazır haldedir.

 Kullanılan Teknolojiler:
Flutter & Dart
Stacked Framework
Image Picker (Galeri ve Kamera entegrasyonu için)
Dotted Border (Özel UI bileşenleri için)

 Uygulama Ekranları
Uygulama, görev tanımında belirtilen tüm temel akışları içermektedir:
Landing & Onboarding: Uygulamanın amacını anlatan, görsel derinliği yüksek giriş ekranları.
Anasayfa (Home): Popüler ve önerilen tasarımların sergilendiği, kategorize edilmiş ana ekran.
Aksiyon Ekranı (Upload & Select Room): * Kullanıcının galeriden veya kameradan fotoğraf yükleyebildiği dinamik yapı.
Örnek fotoğraflar (Example Photos) üzerinden hızlı deneme imkanı.
Step-by-step (Adım adım) ilerleyen kullanıcı dostu akış.
Paywall: Uygulamanın premium özelliklerini sunan, Save %81 gibi kullanıcı odaklı pazarlama elementleri içeren abonelik ekranı.
Profil & Ayarlar: Kullanıcı ID'sinin görüntülendiği, dil ve geri bildirim gibi opsiyonların sunulduğu yönetim ekranı.

 Kurulum ve Çalıştırma
Projeyi yerel ortamınızda çalıştırmak için:
Repoyu klonlayın: git clone (https://github.com/zynpirmadgzl/roomy-ai.git)
Bağımlılıkları yükleyin: flutter pub get
(iOS için) cd ios && pod install && cd ..
Uygulamayı çalıştırın: flutter run
