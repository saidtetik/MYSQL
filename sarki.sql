

1-) Şarkı tablosundaki tüm kayıtları listeleyiniz.

MariaDB [odev]> SELECT * FROM sarki;
+---------+---------------------+---------+---------+-----------+---------+
| sarkino | adi                 | turu    | uzunluk | bestecino | yazarno |
+---------+---------------------+---------+---------+-----------+---------+
|       1 | seni yazdim kalbime | arabesk |     200 |         1 |       1 |
|       2 | garipler            | arabesk |     295 |         2 |       2 |
|       3 | gonul nedir bilene  | sanat   |     415 |         3 |       2 |
|       4 | omrum su biten      | sanat   |     353 |         1 |       3 |
|       5 | ben o zaman         | arabesk |     313 |         2 |       1 |
|       6 | toy turkusu         | halk    |     350 |         1 |       3 |
|       7 | yaylanin cimenine   | halk    |     264 |         4 |       4 |
|       8 | ruhumda sizi        | pop     |     170 |         3 |       1 |
|       9 | ayrilik saati       | pop     |     150 |         4 |       2 |
|      10 | soyleyemedim        | halk    |     190 |         1 |       4 |
+---------+---------------------+---------+---------+-----------+---------+
10 rows in set (0.000 sec)


2-) Şarkıcı tablosundaki tüm kayıtları listeleyiniz.

MariaDB [odev]> SELECT * FROM sarkici;
+-----------+----------+----------+---------+
| sarkicino | adi      | soyadi   | turu    |
+-----------+----------+----------+---------+
|         1 | orhan    | gencebay | arabesk |
|         2 | muzeyyen | senar    | sanat   |
|         3 | atakan   | celik    | halk    |
|         4 | engin    | candir   | pop     |
|         5 | cengiz   | kurtoglu | turkucu |
+-----------+----------+----------+---------+
5 rows in set (0.000 sec)


3-) Söz yazarı tablosundaki tüm kayıtları listeleyiniz.

MariaDB [odev]> SELECT * FROM sozyazari;
+---------+------------+----------+
| yazarno | adi        | soyadi   |
+---------+------------+----------+
|       1 | orhan      | gencebay |
|       2 | nejat      | buhara   |
|       3 | serafettin | ozdemir  |
|       4 | mehmet     | demir    |
+---------+------------+----------+
4 rows in set (0.000 sec)


4-) Besteci tablosundaki tüm kayıtları listeleyiniz.

MariaDB [odev]> SELECT * FROM besteci;
+-----------+--------+----------+
| bestecino | adi    | soyadi   |
+-----------+--------+----------+
|         1 | orhan  | gencebay |
|         2 | nejat  | buhara   |
|         3 | umit   | mutlu    |
|         4 | cengiz | kurtoglu |
+-----------+--------+----------+
4 rows in set (0.000 sec)


5-) İcra tablosundaki tüm kayıtları listeleyiniz.

MariaDB [odev]> SELECT * FROM icra;
+---------+-----------+
| sarkino | sarkicino |
+---------+-----------+
|       1 |         1 |
|       2 |         1 |
|       3 |         2 |
|       4 |         2 |
|       5 |         1 |
|       6 |         3 |
|       7 |         3 |
|       8 |         4 |
|       9 |         4 |
|      10 |         2 |
|       1 |         5 |
|       2 |         5 |
|       3 |         5 |
|       4 |         5 |
|       5 |         5 |
|       6 |         5 |
|       7 |         5 |
|       8 |         5 |
|       9 |         5 |
|      10 |         5 |
|       5 |         4 |
|       4 |         4 |
|       3 |         4 |
|       2 |         4 |
|       1 |         4 |
|      10 |         4 |
|       7 |         4 |
|       6 |         4 |
+---------+-----------+
28 rows in set (0.000 sec)


6-) Şarkı kayıtlarını şarkı adına göre artan sırada listeleyiniz.

MariaDB [odev]> SELECT * 
	     -> FROM sarki 
	     -> ORDER BY adi ASC;
+---------+---------------------+---------+---------+-----------+---------+
| sarkino | adi                 | turu    | uzunluk | bestecino | yazarno |
+---------+---------------------+---------+---------+-----------+---------+
|       9 | ayrilik saati       | pop     |     150 |         4 |       2 |
|       5 | ben o zaman         | arabesk |     313 |         2 |       1 |
|       2 | garipler            | arabesk |     295 |         2 |       2 |
|       3 | gonul nedir bilene  | sanat   |     415 |         3 |       2 |
|       4 | omrum su biten      | sanat   |     353 |         1 |       3 |
|       8 | ruhumda sizi        | pop     |     170 |         3 |       1 |
|       1 | seni yazdim kalbime | arabesk |     200 |         1 |       1 |
|      10 | soyleyemedim        | halk    |     190 |         1 |       4 |
|       6 | toy turkusu         | halk    |     350 |         1 |       3 |
|       7 | yaylanin cimenine   | halk    |     264 |         4 |       4 |
+---------+---------------------+---------+---------+-----------+---------+
10 rows in set (0.000 sec)


7-) ‘Orhan’ ‘Gencebay’ adlı bestecinin bestelediği şarkıları icra eden şarkıcıların
  sarkicino, ad, ve soyadlarını listeleyiniz.

MariaDB [odev]> WITH getir_sarki(sarkino) 
    ->		   AS (SELECT sarkino 
    ->       	       FROM besteci,sarki 
    ->   	       WHERE besteci.adi='orhan'AND 
    ->     		     besteci.soyadi='gencebay' AND 
    ->     		     besteci.bestecino=sarki.bestecino),
    -> 		 getir_sarkici(sarkicino) 
    ->		   AS (SELECT sarkicino 
    ->      	       FROM getir_sarki,icra 
    ->   	       WHERE getir_sarki.sarkino=icra.sarkino) 
    -> 		SELECT DISTINCT sarkici.sarkicino,adi,soyadi 
    -> 		FROM sarkici,getir_sarkici  
    -> 		WHERE sarkici.sarkicino = getir_sarkici.sarkicino; 
+-----------+----------+----------+
| sarkicino | adi      | soyadi   |
+-----------+----------+----------+
|         1 | orhan    | gencebay |
|         2 | muzeyyen | senar    |
|         3 | atakan   | celik    |
|         4 | engin    | candir   |
|         5 | cengiz   | kurtoglu |
+-----------+----------+----------+
5 rows in set (0.001 sec)


8-) ‘Sanat’ türünde şarkıların söz yazarlığını yapmış veya ‘Müzeyyen’ ‘Senar’ adlı 
  şarkıcının icra ettiği (söylediği bazı/herhangi/en-az-bir) şarkıların söz 
  yazarlığını yapmış söz yazarlarının ad ve soyadlarını listeleyiniz.

MariaDB [odev]> WITH sarki_n(sarkino) 
    ->		   AS (SELECT sarkino
    ->                 FROM sarkici,icra 
    ->   	       WHERE sarkici.adi='muzeyyen' AND 
    -> 			     sarkici.soyadi='senar' AND 
    -> 			     sarkici.sarkicino= icra.sarkicino),
    -> 		yazar_n(yazarno)      
    ->			AS (SELECT yazarno 
    ->   		    FROM sarki_n,sarki 
    ->   		    WHERE sarki_n.sarkino=sarki.sarkino) 
    -> 		SELECT adi,soyadi 
    -> 		FROM yazar_n ,sozyazari 
    -> 		WHERE yazar_n.yazarno=sozyazari.yazarno 
    ->		UNION  
    -> 		SELECT sozyazari.adi,sozyazari.soyadi 
    -> 		FROM sarki,sozyazari 
    -> 		WHERE turu='sanat' AND 
    ->                sarki.yazarno = sozyazari.yazarno;
+------------+---------+
| adi        | soyadi  |
+------------+---------+
| nejat      | buhara  |
| serafettin | ozdemir |
| mehmet     | demir   |
+------------+---------+
3 rows in set (0.001 sec)


9-) 180 saniyeden daha uzun bir şarkı (yada şarkılar) bestelemiş fakat ‘Halk’
  türünde şarkı bestelememiş bestecilerin ad ve soyadlarını listeleyiniz.

MariaDB [odev]> SELECT besteci.adi, besteci.soyadi 
    -> 		FROM sarki,besteci 
    -> 		WHERE uzunluk>180 AND 
    ->       	      besteci.bestecino=sarki.bestecino 
    -> 		EXCEPT 
    -> 		SELECT besteci.adi, besteci.soyadi 
    -> 		FROM sarki,besteci 
    -> 		WHERE turu='halk' AND 
    ->      	      besteci.bestecino=sarki.bestecino;
+-------+--------+
| adi   | soyadi |
+-------+--------+
| nejat | buhara |
| umit  | mutlu  |
+-------+--------+
2 rows in set (0.000 sec)


10-) Tüm şarkıları icra eden şarkıcıların ad ve soyadlarını veriniz.

MariaDB [odev]> SELECT adi,soyadi 
    -> 		FROM sarkici 
    -> 		WHERE NOT EXISTS 
    ->			(SELECT sarkino 
    ->   		 FROM sarki 
    ->   		 EXCEPT 
    ->   		 SELECT sarkino 
    ->          	 FROM icra 
    ->   		 WHERE icra.sarkicino = sarkici.sarkicino);
+--------+----------+
| adi    | soyadi   |
+--------+----------+
| engin  | candir   |
| cengiz | kurtoglu |
+--------+----------+
2 rows in set (0.001 sec)


11-) ‘Orhan’ ’Gencebay’ icra ettiği şarkılardan herhangi birini icra eden
   şarkıcıların ad ve soyadlarını listeleyiniz. 

MariaDB [odev]> SELECT adi,soyadi 
    -> 		FROM sarkici 
    -> 		WHERE sarkicino IN 
    -> 		     (SELECT sarkicino 
    ->     	      FROM icra 
    ->     	      WHERE sarkino IN
    -> 			   (SELECT sarkino 
    ->      		    FROM icra,sarkici 
    ->      		    WHERE sarkici.adi='orhan' AND 
    ->    		    	  sarkici.soyadi='gencebay' AND 
    ->    		          icra.sarkicino=sarkici.sarkicino));
+--------+----------+
| adi    | soyadi   |
+--------+----------+
| orhan  | gencebay |
| engin  | candir   |
| cengiz | kurtoglu |
+--------+----------+
3 rows in set (0.001 sec)


12-) Uzunluğu ‘Ümit’,’Mutlu’nun bestelediği şarkılardan hiç birine eşit olmayan
   şarkıların adlarını listeleyiniz.

MariaDB [odev]> SELECT adi 
    -> 		FROM sarki 
    -> 		WHERE uzunluk NOT IN
    -> 		      (SELECT uzunluk 
    ->      	       FROM sarki,besteci 
    ->     	       WHERE besteci.adi='umit' AND  
    ->    		     besteci.soyadi='mutlu' AND 
    ->    		     besteci.bestecino= sarki.bestecino);
+---------------------+
| adi                 |
+---------------------+
| seni yazdim kalbime |
| garipler            |
| omrum su biten      |
| ben o zaman         |
| toy turkusu         |
| yaylanin cimenine   |
| ayrilik saati       |
| soyleyemedim        |
+---------------------+
8 rows in set (0.001 sec)


13-) ‘Halk’ müziğü türünde şarkı icra etmiş olan şarkıcıların kayıtlarını
   listeleyiniz.

MariaDB [odev]> SELECT * 
    -> 		FROM sarkici 
    -> 		WHERE EXISTS 
    -> 		       (SELECT * 
    ->       	  	FROM sarki,icra 
    ->      	  	WHERE sarki.turu='halk' AND 
    ->     		      icra.sarkino=sarki.sarkino AND 
    ->                        icra.sarkicino = sarkici.sarkicino);
+-----------+----------+----------+---------+
| sarkicino | adi      | soyadi   | turu    |
+-----------+----------+----------+---------+
|         2 | muzeyyen | senar    | sanat   |
|         3 | atakan   | celik    | halk    |
|         4 | engin    | candir   | pop     |
|         5 | cengiz   | kurtoglu | turkucu |
+-----------+----------+----------+---------+
4 rows in set (0.001 sec)


14-) Her şarkıcı için şarkıcıno, adı, soyadı, icra ettiği şarkıların toplam
   uzunluğu, ortalama uzunluğu, en uzunu, en kısası, şarkı sayılarını 
   listeleyiniz.

MariaDB [odev]> WITH aggr(sarkicino,top_uzunluk,ort_uzunluk,
    -> 		          max_uzunluk,min_uzunluk,sarki_sayisi) 
    ->    	   AS (SELECT sarkicino,sum(uzunluk),avg(uzunluk),
    ->       		      max(uzunluk),min(uzunluk),count(sarki.sarkino) 
    ->        	       FROM icra,sarki 
    ->        	       WHERE icra.sarkino = sarki.sarkino 
    ->        	       GROUP BY sarkicino) 
    -> 		SELECT sarkici.sarkicino,sarkici.adi,sarkici.soyadi,
    ->		       aggr.top_uzunluk,ort_uzunluk,max_uzunluk,
    ->        	       min_uzunluk,sarki_sayisi 
    -> 		FROM sarkici,aggr 
    -> 		WHERE aggr.sarkicino=sarkici.sarkicino;
+-----------+----------+----------+-------------+-------------+-------------+-------------+--------------+
| sarkicino | adi      | soyadi   | top_uzunluk | ort_uzunluk | max_uzunluk | min_uzunluk | sarki_sayisi |
+-----------+----------+----------+-------------+-------------+-------------+-------------+--------------+
|         1 | orhan    | gencebay |         808 |    269.3333 |         313 |         200 |            3 |
|         2 | muzeyyen | senar    |         958 |    319.3333 |         415 |         190 |            3 |
|         3 | atakan   | celik    |         614 |    307.0000 |         350 |         264 |            2 |
|         4 | engin    | candir   |        2700 |    270.0000 |         415 |         150 |           10 |
|         5 | cengiz   | kurtoglu |        2700 |    270.0000 |         415 |         150 |           10 |
+-----------+----------+----------+-------------+-------------+-------------+-------------+--------------+
5 rows in set (0.001 sec)


15-) Birden çok sayıda şarkı besteleyen besteciler için bestecino, adı, soyadı,
   bestelediği şarkı sayısını listeleyiniz.

MariaDB [odev]> SELECT besteci.bestecino, besteci.adi, besteci.soyadi, 
    ->        	       count(sarkino) AS sarki_sayisi 
    -> 		FROM sarki,besteci 
    -> 		WHERE besteci.bestecino = sarki.bestecino 
    -> 		GROUP BY besteci.adi 
    ->		HAVING count(sarkino)>1;
+-----------+--------+----------+--------------+
| bestecino | adi    | soyadi   | sarki_sayisi |
+-----------+--------+----------+--------------+
|         4 | cengiz | kurtoglu |            2 |
|         2 | nejat  | buhara   |            2 |
|         1 | orhan  | gencebay |            4 |
|         3 | umit   | mutlu    |            2 |
+-----------+--------+----------+--------------+
4 rows in set (0.000 sec)

MariaDB [odev]> exit
