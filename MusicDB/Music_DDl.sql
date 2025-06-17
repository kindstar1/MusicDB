create table Genre (
genre_id SERIAL primary key,
name varchar(40) not null
);

create table Artists (
artist_id SERIAL primary key,
name varchar(255) not null
);

create table Albums (
album_id SERIAL primary key,
name varchar(255) not null,
release_year integer
);

create table Collections (
collection_id SERIAL primary key,
name varchar(255) not null,
release_year integer
);

create table Tracks (
track_id SERIAL primary key,
name varchar(255) not null,
duration numeric not null,
album_id integer REFERENCES Albums(album_id)
);

create table ArtistsGenres (
artist_id integer REFERENCES Artists(artist_id),
genre_id integer references Genre(genre_id),
primary key (artist_id, genre_id)
);

create table AlbumsArtists (
artist_id integer REFERENCES Artists(artist_id),
album_id integer REFERENCES Albums(album_id),
primary key (artist_id, album_id)
);

create table CollectionsTracks (
track_id integer REFERENCES Tracks(track_id),
collection_id integer REFERENCES Collections(collection_id),
primary key (track_id, collection_id)
);