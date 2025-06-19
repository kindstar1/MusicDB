INSERT INTO Genre (name) VALUES
('Soul'),
('Hip-hop'),
('Pop'),
('Alternative Rock');

INSERT INTO Artists (name) VALUES
('Adele'),
('Drake'),
('Taylor Swift'),
('Imagine Dragons');

INSERT INTO Albums (name, release_year) VALUES
('30', 2021),
('Scorpion', 2018),
('Midnights', 2022),
('Evolve', 2017);

INSERT INTO Tracks (name, duration, album_id) VALUES
('Easy On Me', 224, 1),
('Oh My God', 225, 1),
('God''s Plan', 199, 2),
('In My Feelings', 217, 2),
('Anti-Hero', 201, 3),
('Lavender Haze', 202, 3),
('Believer', 204, 4),
('Thunder', 187, 4);

INSERT INTO Tracks (name, duration, album_id) VALUES
('Epic Journey', 4.05, 1),
('Lost in Time', 3.40, 2),
('Starlight Overture', 4.40, 3),
('Mountain''s Echo', 3.35, 4),
('Ocean Deep', 5.00, 1),
('Desert Mirage', 4.10, 2);

INSERT INTO Collections (name, release_year) VALUES
('Vocal Powerhouse Collection', 2020),
('OVO Sound Anthems', 2020),
('Pop Chronicles 2014-2018', 2018),
('Stadium Anthems', 2019);

INSERT INTO Collections (name, release_year) VALUES
('Decade Anthems', 2017),
('Future Sounds', 2022),
('Retro Classics Vol. 1', 2015),
('New Wave Hits 2023', 2023);


INSERT INTO ArtistsGenres (artist_id, genre_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 3);

INSERT INTO AlbumsArtists (artist_id, album_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(2, 3);

INSERT INTO CollectionsTracks (track_id, collection_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(1, 3),
(7, 4),
(8, 4);

INSERT INTO CollectionsTracks (track_id, collection_id) VALUES
(9, 1),
(10, 2),
(11, 5),
(12, 6),
(13, 1),
(14, 5),
(1, 5),
(3, 5),
(5, 6),
(7, 6),
(2, 7),
(9, 7),
(4, 8),
(11, 8),
(13, 6);

INSERT INTO Tracks (name, duration, album_id) VALUES
('always my love', 3.25, 2),
('that''s my life', 4.10, 4),
('мой единственный шанс', 3.55, 1);


INSERT INTO CollectionsTracks (track_id, collection_id) VALUES
(15, 1),
(16, 3),
(17, 2),
(17, 5);

INSERT INTO Albums (name, release_year) VALUES
('Lover', 2019),
('Future Nostalgia', 2020);

INSERT INTO Tracks (name, duration, album_id) VALUES
('Lover (Song)', 3.41, 5),
('The Man', 3.10, 5),
('You Need To Calm Down', 2.51, 5),
('Don''t Start Now', 3.03, 6),
('Levitating', 3.23, 6);

INSERT INTO Collections (name, release_year) VALUES
('Adele''s Heartfelt Hits', 2024);

INSERT INTO CollectionsTracks (track_id, collection_id) VALUES
(1, 9),
(13, 9);

INSERT INTO albumsartists (artist_id, album_id)
VALUES (3, 5);