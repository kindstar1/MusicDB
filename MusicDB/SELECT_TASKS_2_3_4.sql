--Название и продолжительность самого длительного трека.
SELECT name, duration
FROM tracks 
ORDER BY duration DESC 
LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут.
SELECT name, duration
FROM tracks 
WHERE duration > 3.5;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name
FROM collections 
WHERE release_year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова.
SELECT name 
FROM artists 
WHERE name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my».
SELECT name 
FROM tracks 
WHERE name LIKE '%my%' OR name LIKE '%мой%';

--Количество исполнителей в каждом жанре.
SELECT genre.name, count(a.name) 
FROM artists a
JOIN artistsgenres ag ON a.artist_id = ag.artist_id
JOIN genre ON ag.genre_id = genre.genre_id
GROUP BY genre.name;

--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT count(*)
FROM tracks t 
JOIN albums a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому.
SELECT a.name, AVG(round(t.duration, 1))
FROM albums a
JOIN tracks t ON t.album_id = a.album_id
GROUP BY a.name;

--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT DISTINCT ar.name
FROM artists ar
JOIN albumsartists al  ON ar.artist_id = al.artist_id
JOIN albums a ON a.album_id = al.album_id
WHERE a.release_year != 2020;

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.name
FROM collections c
JOIN collectionstracks ct ON c.collection_id = ct.collection_id
JOIN tracks t ON ct.track_id = t.track_id
JOIN albums al ON t.album_id = al.album_id
JOIN albumsartists aa ON al.album_id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.artist_id
WHERE c.name LIKE 'Adele%';

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT a.name
FROM albums a
JOIN albumsartists aa ON a.album_id = aa.album_id
WHERE aa.artist_id IN (
    SELECT artist_id
    FROM artistsgenres
    GROUP BY artist_id
    HAVING COUNT(DISTINCT genre_id) > 1
);

--Наименования треков, которые не входят в сборники.
SELECT t.name
FROM tracks t
LEFT JOIN collectionstracks ct ON t.track_id = ct.track_id
WHERE ct.collection_id IS NULL;

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT ar.name
FROM artists ar
JOIN albumsartists aa ON ar.artist_id = aa.artist_id
JOIN albums al ON aa.album_id = al.album_id
JOIN tracks t ON al.album_id = t.album_id
WHERE t.duration = (SELECT MIN(duration) FROM tracks);

--Названия альбомов, содержащих наименьшее количество треков.
SELECT a.name
FROM albums a
LEFT JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.album_id, a.name
HAVING COUNT(t.track_id) = (
SELECT MIN(album_track_counts.num_tracks)
FROM (SELECT COUNT(t_inner.track_id) AS num_tracks
FROM albums a_inner
LEFT JOIN tracks t_inner ON a_inner.album_id = t_inner.album_id
GROUP BY a_inner.album_id) AS album_track_counts);

