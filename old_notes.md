use Northwind
go

select 'Dinçer' as Adi, 'Nalbant' as Soyadi -- istenen verileri tablo olarak geri döndürür

select * from Personeller -- tüm tabloyu seçme

select Adi, SoyAdi from Personeller -- belirli sütunları seçme

select 4 as deger -- deger sütununa 4 atadı

select * from [Satis Detaylari] -- birden fazla karakterli tablo adı

select Adi + ' ' + Soyadi as [Adi Soyadi] from Personeller -- iki sütunu birleştirip yazma

select Adi + ' ' + Soyadi + ' --- ' + cast(DogumTarihi as nvarchar) as [Adi Soyadi --- İse Baslama] from Personeller -- farklı tipte veriyi yazdırma

select * from Personeller where UnvanEki='Mr.' or Sehir = 'Seattle' -- sadece erkekleri ve seattlelıları sıralama

select * from Personeller where PersonelID > 5

select * from Personeller where PersonelID <> 5 -- idsi 5 olmayanlarıı döndürür

select * from Personeller where Year(IseBaslamaTarihi) >= 1994 -- idsi 5 olmayanlarıı döndürür

select * from Personeller where Year(DogumTarihi) between 1955 and 1960 -- between kullanımı

select * from Personeller where Sehir in('tacoma','kirkland') -- where ve or kullanımı yerine in bloğu içine alıyoruz

-- like sorguları

select Adi, SoyAdi from Personeller where adi like 'j%' or adi like '%ert' -- like sorguları ile adı j ile başlayan ya da ert ile biten personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like '%an%' -- like sorguları ile içinde an geçen personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like 'n%an%' -- like sorguları ile isminin baş harfi N olan ve içinde an geçen personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like 'a_d%' -- like sorguları ile isminin baş harfi a olan, ikinci harfi önemli değil, üçüncü harfi d olan personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like '[nmr]%' -- köşeli parantez ile isminin baş harfi n, m veya r olan personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like '%[r]%' -- köşeli parantez ile isminin içinde r olan personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like '[a-k]%' -- köşeli parantez ile isminin baş harfi a-k arasında olan personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like '[^a-m]%' -- ^ ile isminin baş harfi a-m arasında olmayan personellerin adı soyadı

select Adi, SoyAdi from Personeller where adi like 'ü_%' Escape 'ü' -- ü'yü kaçış karakteri olarak tanımlama ile _ ile başlayan isimleri bulabiliriz. _% => özel karakter

select Adi, SoyAdi from Personeller where adi like '[_]%'  -- köşeli parantez operatörü ile de özel karakterleri ifadeyi ararken kullanabiliriz

-- aggregate functions
select avg(PersonelID) from personeller
select sum(PersonelID) from personeller
select max(PersonelID) from personeller
select min(PersonelID) from personeller
select count(*) from personeller

-- string functions
select upper(adi) from Personeller
select left(adi,1) from Personeller -- sadece soldan 1 char alır(baş harfi in this case)
select soyadi, SUBSTRING(SoyAdi, 1,3) from Personeller -- 2. sıradakinden itibaren 3. sıradaki kadar karakter alır. karakter indexleri 0'dan değil 1'den başlar unutma!
select LTRIM('        IDN') -- left trim ile soldan boşluk keser
select lower(reverse(adi)) from personeller -- terse çevirir ve küçük yazar
select replace('Hello IDN', 'IDN','Mr. IDN')
select adi,CHARINDEX('r', adi) from Personeller -- hangi karakter sırasında ise onu yazdırır

--ornek substring ile sadece müşteri adını ve soyadını ayrı ayrı sütunlarda alma
select MusteriAdi as [Müşteri Adı], SUBSTRING(MusteriAdi, 1, CHARINDEX(' ', musteriadi)) as Adı, Substring(MusteriAdi, CHARINDEX (' ', MusteriAdi)+1, (LEN(MusteriAdi) - CHARINDEX(' ', MusteriAdi))) as Soyadı from Musteriler
Select RIGHT(MusteriAdi, CHARINDEX(' ', REVERSE(MusteriAdi))) from Musteriler

-- tarih
select getdate()
select dateadd(day, 10, getdate())
select dateadd(year, 1, getdate())
select datediff(day, '05.04.1997', getdate()) -- önce ay sonra güne göre veriyor
select datediff(month, '09.05.2023', getdate()) -- önce ay sonra güne göre veriyor
select datepart(dw,getdate()) -- day of week, ilk gün pazar sayıyor
select datepart(day,getdate())

-- top komutu ile o tablonun ilk .... elemanı getirilir
select top 3 * from personeller

-- distinct ile bir kolundaki benzer verileri teke indirir
select distinct sehir from Personeller

-- groupby ile tedarikçi ya da kategorideki ürünleri gruplayıp sayılarını bulabiliriz
select * from urunler
select * from urunler where KategoriID = 7 -- 5 adet var => alttakinde de 5 tane bulmamız lazım
select KategoriID, COUNT(*) as [Ürun Çeşidi Adedi] from Urunler Group By KategoriID
select * from urunler where TedarikciID = 1 -- 3 adet var => alttakinde de 3 tane bulmamız lazım
select TedarikciID, COUNT(*) as [Ürun Çeşidi Adedi] from Urunler Group By TedarikciID

-- iki adet sütuna göre gruplayıp hangi ikisinden kaçar tane var onu görürürz ayrıca order by tedarikci Id ile sıralayabiliriz
select TedarikciID, KategoriID, COUNT(*) as [Ürun Çeşidi Adedi] from Urunler Group By TedarikciID, KategoriID order by tedarikciID
-- üsttekine where şartı da eklendi => normal kolona şart ekler
select TedarikciID, KategoriID, COUNT(*) as [Ürun Çeşidi Adedi] from Urunler where KategoriID > 5 Group By TedarikciID, KategoriID order by KategoriID
-- having komutu ile kaç adet satış yapıldığına da şart eklenmiş oldu => count(*) yani aggregate kolonuna şart ekler
select TedarikciID, COUNT(*) as [Ürun Çeşidi Adedi] from Urunler where TedarikciID > 5 Group By TedarikciID Having count(*) > 2 order by TedarikciID

-- hangi personel kaç satış yapmış ve nakliye ücreti ne kadar ödemiş
select personelId, count(*) as [Satis Adedi], sum(NakliyeUcreti) as [Toplam Nakliye Ücreti] from Satislar group by PersonelID

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- iki tabloyu ilkel yöntemle birleştirme(joinsiz) => ilgisiz yerlere null atanır
select * from Personeller, Satislar
-- select personelID from personeller,Satislar hata verir çünkü aynı isimde kolon ikisinde de var
select personeller.personelID, satislar.personelID from personeller, Satislar -- hata vermez çünkü belirttik
select p.personelID, s.personelID from personeller p,Satislar s order by s.PersonelID -- p ve s aliaslarını atama ve order by
select * from personeller p,Satislar s where p.PersonelID = s.PersonelID
select count(*) from personeller p,Satislar s where p.PersonelID = s.PersonelID

-- inner join ile tabloları birleştirme ile hangi personel hangi satışları yapmış onu bulabiliriz
select * from Personeller p inner join satislar s on p.PersonelID = s.PersonelID order by p.PersonelID -- iki tabloyu birleştirir önce soldaki(p in this case) sonra sağdaki, order by ile de sıralar
-- hangi ürünler hangi kategoride
select ü.UrunAdi, k.KategoriAdi from Urunler ü inner join kategoriler k on ü.KategoriID = k.KategoriID order by k.kategoriID
-- iki tabloyu birleştirdik ve beverages kategorisindeki ürünleri listeledik
select ü.UrunAdi, k.KategoriAdi from Urunler ü inner join kategoriler k on ü.KategoriID = k.KategoriID where k.KategoriAdi='beverages'
select count(*) from Urunler ü inner join kategoriler k on ü.KategoriID = k.KategoriID where k.KategoriAdi='beverages' -- beverage sayısını bulma
-- hangi satışı hangi çalışan yapmış
select p.Adi + ' ' + p.SoyAdi as Personel, s.SatisID as [Satış ID] from personeller p inner join Satislar s on p.PersonelID = s.PersonelID
select p.Adi + ' ' + p.SoyAdi as Personel, s.SatisID as [Satış ID] from personeller p inner join Satislar s on p.PersonelID = s.PersonelID

-- inner join ile 2 tablo birleştirme => null değerleri almaz sadece mevcut eşleştirebildiği verileri alır
select * from urunler u inner join Tedarikciler t on u.TedarikciID = t.TedarikciID where t.Faks <> 'null' -- is not null da denebilirdi
-- inner join ile 3 tablo birleştirme => 1997den sonra nancynin satış yaptığı firma isimleri(önce personel sonra satış sonra musteriler) ya da (önce musteriler sonra satış sonra personel)
select p.adi as Personel, m.MusteriAdi as Müşteri, s.SatisTarihi from personeller p inner join Satislar s on p.PersonelID = s.PersonelID inner join musteriler m on s.MusteriID = m.MusteriID where p.Adi = 'nancy' and year(s.SatisTarihi)>1997
-- aynı tabloyu ilişkisel olarak birleştirme => aynı tabloda ilişkili satırları birleştirme
select p1.adi as [Personel Adı], p2.adi as [Amir Adı] from personeller p1 inner join personeller p2 on p1.BagliCalistigiKisi = p2.PersonelID

-- inner joinde group by => bir sorguda normal kolonlar ve en az 1 aggregate fonk varsa group by işlemi yapılır
-- hangi kategoride kaç adet ürün var? => group by
select kategoriID as [Kategori], count(*) as [Adet] from urunler group by KategoriID
-- hangi personel toplam kaç adet satış yapmış, satış adedi 100'den fazla olanlar ve personelin adının baş harfi m olan kayıtlar gelsin.
select p.Adi, count(*) as [Satış Adedi] from personeller p inner join satislar s on p.PersonelID = s.PersonelID where p.adi like 'm%' group by p.Adi having count(s.SatisID)>100
-- seafood kategorisindeki ürün sayısı(ürünler, kategoriler)=?
select kategoriler.KategoriAdi, count(*) as [Ürün Sayısı] from Urunler inner join Kategoriler on urunler.KategoriID = kategoriler.KategoriID where KategoriAdi = 'seafood' group by kategoriler.KategoriAdi
-- hangi personel toplam kaç adet satış yapmış?
select p.Adi + ' ' + p.SoyAdi as [Personel] , count(*) as [Satış Adedi] from Personeller p inner join satislar s on p.PersonelID = s.PersonelID group by p.Adi + ' ' + p.SoyAdi
-- en çok satış yapan personel
select top 1 p.Adi + ' ' + p.SoyAdi as [Personel] , count(*) as [Satış Adedi] from Personeller p inner join satislar s on p.PersonelID = s.PersonelID group by p.Adi + ' ' + p.SoyAdi order by count(*) desc
select s.SatisTarihi from satislar s inner join Personeller p on s.PersonelID = p.PersonelID where year(s.SatisTarihi) < 1997 and month(s.SatisTarihi)>0 order by month(s.satisTarihi)

---------------------------outer join-left right full-------------------------------------------
-- Eşleşmeyen kayıtlar da geri döner => NULL olarak
-- Left => joinin solundaki tablonun kayıtlarının hepsi gelir, rowlar ona göre düzenlenir, ikinci tablo da onun yanına gelir, eşleşmeyenler NULL gelir.
-- Right => joinin sağındaki tablonun kayıtlarının hepsi gelir, rowlar ona göre düzenlenir, ikinci tablo da onun yanına gelir, eşleşmeyenler NULL gelir.
select * from Personeller p left join satislar s on p.PersonelID = s.SatisID
select * from Personeller p right join satislar s on p.PersonelID = s.SatisID
-- Full => eşleşsin/eşleşmesin ne varsa getirir. Eşleşmeyenler NULL gelir.
select * from Personeller p full join satislar s on p.PersonelID = s.SatisID
-- Cross join =>  İki tablo arasında kartezyen çarpımıyla birleştirir => iki küme elemanlarını birbirleriyle tek tek eşleştirir, where komutu kullanılamaz
select count(*) from personeller
select count(*) from Bolge

select p.adi, b.bolgeID from personeller p cross join bolge b -- ne varsa çarpar eşleştirerek birleştimez

---------------------------DML(Data Manipulation Language) Komutları-------------------------------------------
---- Select => tablodan veri getirme
---- Insert => tabloya veri ekleme
---- Update => tabloda bulunan veriyi güncelleme
---- Delete => tablodan veri silme


--------------- Insert ---------------

-- => not nulllar kesinlikle doldurulmalıdır.
-- insert into gibi kullanılabilir
-- auto increment kolonlara değer gönderilemez

insert Personeller(Adi,SoyAdi) Values('ID', 'N')
select adi, soyadi from Personeller where adi = 'ID'
insert musteriler(musteriId, SirketAdi, adres) values('ASHD','abc','çorum')
select * from musteriler where musteriler.adres = 'çorum'

-- select ile elde edilen verileri insert ile başka bir tabloya kaydetme => kolon tipleri aynı olmalı(nvarchar in this case)
insert ornekpersoneller select adi, soyadi from personeller

-- tabloda özellliği not null olanlara veri gönderilmesi gerekir, PK(Primary Key) özelliğine sahip kolonlara veri gönderilemez
insert personeller(adi,SoyAdi) values('Dincer','Nalbant')
select * from Personeller where personeller.adi = 'dincer'

-- select sorgusu sonucu gelen verileri otomatik yeni bir tablo oluşturarak kaydetme
-- NOT: primary-foreign key eklenemez, raporlama işlemi için kullanılabilir
select adi, soyadi, ulke into OrnekPersoneller3 from personeller


--------------- Update + set + where ---------------
-- => set ile beraber kullanılır, where şartı koşulmalı yoksa tüm kolonları günceller

update top(3) OrnekPersoneller set adi='Adem' where ulke = 'uk' -- tüm adi sütununundaki isimleri mehmet yapar
select o.adi, o.soyadi, o.ulke  from ornekpersoneller as o

insert OrnekPersoneller(adi,soyadi,ulke) values('mehmet','ali','erbil')
delete OrnekPersoneller where adi = 'mehmet'

insert satislar(SatisTarihi, SevkBolgesi, SevkSehri) values(SYSDATETIME(),'abc','çorum')
update satislar SET NakliyeUcreti = '333' WHERE SatisTarihi = (SELECT MAX(SatisTarihi) FROM satislar)
select * from satislar where year(satistarihi)>2001
delete satislar where SevkSehri = 'çorum'

-- update ile joinleri beraber kullanarak birden fazla tabloda güncelleme yapmak:
update urunler set UrunAdi = k.kategoriAdi from urunler u inner join Kategoriler k on u.KategoriID = k.KategoriID
select * from urunler

--------------- Delete from ---------------
-- =>  [tablo adı] + where eklenmeli yoksa geri dönüşü olmayan silme olabilir
delete from urunler where UrunID = '3'

-- silme işleminden sonra identity kolonu sıfırlanmaz. bunun için truncate komutu gereklidir

--------------- Union ----------------
-- Birden fazla sorgu arasında kullanılır, tek bir tablo döndürür. tabloları alt alta birleştirir, join gibi dğeil kabataslak birleştirir. En üstteki kolon ismini alır. Tekrarlı kayıtları getirmez.
select adi as Adı, soyadi as Soyadı, 'Personel' as Tip from personeller
union
select MusteriAdi, SirketAdi, 'Müşteri' from musteriler

-- tekrarlı kayıtları getirmez
select adi as Adı, soyadi as Soyadı, 'Personel' as Tip from personeller
union
select adi as Adı, soyadi as Soyadı, 'Personel' as Tip from personeller

--------------- Union All ----------------
-- Tekrarlı kayıtları getirir.
select adi as Adı, soyadi as Soyadı, 'Personel' as Tip from personeller
union all
select adi as Adı, soyadi as Soyadı, 'Personel' as Tip from personeller

--------------- With Rollup ----------------
-- Group by ile birlikte kullanılır, seçilen tipe göre ara toplam alınmasını sağlar
select kategoriID, urunID, sum(tedarikciID) from urunler group by kategoriID, urunID with rollup
-- having şartıyla beraber kullanılabilir
select satisID, urunID, sum(miktar) from [Satis Detaylari] group by satisID, urunID with rollup having sum(miktar)>150

--------------- With Cube ----------------
-- group by ile gruplanmış veri kümesinde teker teker toplam alınmasını sağlar
select satisID, urunID, sum(miktar) from [Satis Detaylari] group by satisID, urunID with cube



------------------------------------------------------------------------------------------------------------------------
-- case - when - else - end
select adi, soyadi from personeller

-- örn 1
select adi, soyadi,
case
when unvaneki = 'mrs.' or unvaneki = 'ms.' then 'kadın'
when unvaneki = 'mr.' then 'erkek'
else unvaneki
end
from personeller


-- örn 2
select urunID, birimfiyati from urunler

select urunID,
case
when birimfiyati < 50 then 'Çin işi'
when birimfiyati between 50 and 100 then 'Ucuz'
when birimfiyati between 100 and 150 then 'Orta'
when birimfiyati > 150 then 'Pahalı'
else 'belirsiz'
end
from urunler where birimfiyati > 80

--------------- with ties komutu ----------------
-- top ile birlikte kullanılır

-- bir yarışmada ilk 5 belirlenirken kullanılabilir => aynı puanı alanlar da sonuca dahil edilir.
select top 6 with ties  * from [satis detaylari] order by SatisID -- burada top 6 dedik ama satisid'si aynı olan 2 tane daha ürün geldi => orderby ile de bu seçilir

--------------- with +as komutu ----------------
-- anlık oalrak kullanılır, işimizi görür yok olur. mevcut kompleks sorguyu parametrik ve daha okunabilir hale getirir.
with PersonelSatis(Id, Adi, Soyadi, SatisID)
as
(
select p.PersonelID, Adi, Soyadi, SatisID from personeller p inner join satislar s on p.PersonelID = s.PersonelID
)
select * from PersonelSatis ps inner join [Satis Detaylari] sd on ps.SatisID = sd.SatisID

--------------------------- Subquery => iç içe sorgu kullanarak inner join yöntemiyle yapılanla aynı sonuca ulaştık
--inner joinli metod
select s.SatisID, s.SatisTarihi from personeller p inner join satislar s on p.PersonelID = s.PersonelID where adi = 'nancy'
--subqueryli metod
select s.SatisID, s.SatisTarihi from satislar as s where PersonelID = (select personelID from personeller where adi = 'nancy')

--örn2:
select adi from personeller where adi =(select adi from personeller where UnvanEki ='dr.') -- => sadece 1 adet satır döndüren queryler subquery olabilir. dr burada 1 tane var

--------------------------- Bulk Insert ile dışarıdan veri alma ---------------------------
Bulk Insert Kisiler -- kisiler tablosunu önceden oluşturmak lazım
from 'D\Kisilerim.txt' -- path gösterilir
with
(
	fieldterminator = '\t',
	rowterminator = '\n'
)

--------------------------- Truncate ile veri silme ve Identity kolonunu sıfırlama ---------------------------
truncate table ornekpersoneller3


--------------------------- @@Identity komutu ---------------------------
-- ilgili dbdeki en son insert işleminin idsini geri göndürür
insert Kategoriler (KategoriAdi,Tanimi) values('Y','YKategorisi')
select @@IDENTITY as id -- id no döner

--------------------------- @@RowCount komutu ---------------------------
-- yapılan işlem sonucunda kaç adet elemanın etkilendiğini ger döner
select * from personeller
select @@ROWCOUNT

--------------------------- DBCC Checkident => verisel yapıyı ozar => tavsiye edilmez ---------------------------
DBCC Checkident(personeller, reseed, 43) -- bu sayede personeller tablosuna eklenen veri id olarak 44. satıra eklenecek => maksimum değerden büyük seçilmeli ki patlamasın