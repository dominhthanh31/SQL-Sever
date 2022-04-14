-- Tao bang
create table MusicType(
	TypeId int primary key identity(1,1),
	Name_ nvarchar(50) not null,
	Description_ nvarchar(100)
)
go

create table Album(
	AlbumId varchar(20) primary key,
	Title nvarchar(100),
	TypeId int references MusicType(TypeId),
	Artists nvarchar(100),
	Rate int default 0 check(Rate<=5)
)
go

create table Song(
	SongId int primary key identity(1,1),
	AlbumId varchar(20),
	SongTitle nvarchar(200) not null,
	Artists nvarchar(50),
	Author nvarchar(50),
	Hits int check (Hits>=0)
)
go

alter table Song
add constraint Fk_Song_AlbumId foreign key(AlbumId) references Album(AlbumId)

-- Du lieu
insert into MusicType(Name_, Description_)
values
('Pop', 'Genre of popular music that produces the most hits'),
('EDM', 'EDM is also known as dance music'),
('House', 'Genre of electronic music characterized by repetitive beat')

insert into Album(AlbumId, Title, TypeId, Artists, Rate)
values
('1','Rolling in the Deep',1,'ADELE',4),
('2','In The End',2,'LinKin Park',5),
('3','Save Me',3,'Future',3)

insert into Song(AlbumId, SongTitle, Artists, Author, Hits)
values
('1','Rolling in the Deep','ADELE','ADELE',2),
('2','In The End','LinKin Park','LinKin Park',5),
('3','Save Me','Future','Future',7)

select * from MusicType
select * from Album
select * from Song

--List rate = 5
select Album.AlbumId, Album.Title, Album.Artists, Album.Rate
from Album
where Album.Rate = 5

--List Album
select Album.AlbumId, Song.SongTitle, Song.Artists, Album.Title
from Album, Song
where Song.AlbumId = Album.AlbumId 
		and Album.Title = 'Goodbye Swallow'

--View
create view v_Albums
as
select AlbumId, Title, Name_, Rate
from Album left join MusicType on MusicType.TypeId = Album.AlbumId

select * from v_Albums

create view v_TopSongs
as 
select top(10) * from Song
order by Hits desc

select * from v_TopSongs

--Proc
create proc sp_SearchByArtist
@ArtistName nvarchar(50)
as
begin
	select Song.Artists, Song.SongTitle from Song
	where Song.Artists = @ArtistName
end

exec sp_SearchByArtist 'Future'