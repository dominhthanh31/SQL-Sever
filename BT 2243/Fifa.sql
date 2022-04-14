-- Create Tables
create table Referee (
	RefereeID int primary key identity(1,1),
	FullName nvarchar(50) not null,
	Address nvarchar(200) not null,
	Level float,
	Exp date
)
go

create table PenaltyHistory (
	PenaltyID int primary key identity(1,1),
	RefereeID int,
	LeagueName nvarchar(100) not null,
	CatchDate date,
	Rate float,
	TeamID_1 int,
	TeamID_2 int,
	Note nvarchar(500)
)
go

create table Team (
	TeamID int primary key identity(1,1),
	TeamName nvarchar(50),
	HomeTeam nvarchar(100),
	CoachName nvarchar(50)
)
go

create table PlayerInfo (
	PlayerID int primary key identity(1,1),
	FullName nvarchar(50),
	Birthday date,
	Salary money,
	LeagueJoiningDate date
)
go

create table Club_Player_Info (
	TeamID int,
	PlayerID int,
	ClubJoiningDate date,
	primary key (TeamID, PlayerID)
)
go

-- Foreign Key
alter table PenaltyHistory
add constraint FK_PenaltyHistory_Referee foreign key (RefereeID) references Referee (RefereeID)
go

alter table PenaltyHistory
add constraint FK_PenaltyHistory_Team_1 foreign key (TeamID_1) references Team (TeamID)
go

alter table PenaltyHistory
add constraint FK_PenaltyHistory_Team_2 foreign key (TeamID_2) references Team (TeamID)
go

alter table Club_Player_Info
add constraint FK_Club_Player_Info_PlayerInfo foreign key (PlayerID) references PlayerInfo (PlayerID)
go

alter table Club_Player_Info
add constraint FK_Club_Player_Info_Team foreign key (TeamID) references Team (TeamID)
go

-- Insert Into
insert into Referee(FullName, Address, Level, Exp)
values 
('Referee A', 'Adress A', 2, '2019-10-10'),
('Referee B', 'Adress B', 1, '2018-12-05'),
('Referee C', 'Adress C', 3, '2017-07-15'),
('Referee D', 'Adress D', 3, '2018-06-20'),
('Referee E', 'Adress E', 2, '2019-04-25')
go

insert into Team (TeamName, HomeTeam, CoachName)
values 
('Team 1', 'Country 1', 'Coach 1'),
('Team 2', 'Country 2', 'Coach 2'),
('Team 3', 'Country 3', 'Coach 3'),
('Team 4', 'Country 4', 'Coach 4'),
('Team 5', 'Country 5', 'Coach 5'),
('Team 6', 'Country 6', 'Coach 6')
go

insert into PlayerInfo(FullName, Birthday, Salary, LeagueJoiningDate)
values
('Player 1A', '1995-10-10', 3000.65, '2018-10-10'),
('Player 1B', '1995-10-10', 3000.65, '2018-10-10'),
('Player 1C', '1995-10-10', 3000.65, '2018-10-10'),
('Player 1D', '1995-10-10', 3000.65, '2018-10-10'),
('Player 1E', '1995-10-10', 3000.65, '2018-10-10'),
('Player 1F', '1995-10-10', 3000.65, '2018-10-10'),
('Player 2A', '1995-10-10', 3000.65, '2018-10-10'),
('Player 2B', '1995-10-10', 3000.65, '2018-10-10'),
('Player 2C', '1995-10-10', 3000.65, '2018-10-10'),
('Player 2D', '1995-10-10', 3000.65, '2018-10-10'),
('Player 2E', '1995-10-10', 3000.65, '2018-10-10'),
('Player 2F', '1995-10-10', 3000.65, '2018-10-10'),
('Player 3A', '1995-10-10', 3000.65, '2018-10-10'),
('Player 3B', '1995-10-10', 3000.65, '2018-10-10'),
('Player 3C', '1995-10-10', 3000.65, '2018-10-10'),
('Player 3D', '1995-10-10', 3000.65, '2018-10-10'),
('Player 3E', '1995-10-10', 3000.65, '2018-10-10'),
('Player 3F', '1995-10-10', 3000.65, '2018-10-10'),
('Player 4A', '1995-10-10', 3000.65, '2018-10-10'),
('Player 4B', '1995-10-10', 3000.65, '2018-10-10'),
('Player 4C', '1995-10-10', 3000.65, '2018-10-10'),
('Player 4D', '1995-10-10', 3000.65, '2018-10-10'),
('Player 4E', '1995-10-10', 3000.65, '2018-10-10'),
('Player 4F', '1995-10-10', 3000.65, '2018-10-10'),
('Player 5A', '1995-10-10', 3000.65, '2018-10-10'),
('Player 5B', '1995-10-10', 3000.65, '2018-10-10'),
('Player 5C', '1995-10-10', 3000.65, '2018-10-10'),
('Player 5D', '1995-10-10', 3000.65, '2018-10-10'),
('Player 5E', '1995-10-10', 3000.65, '2018-10-10'),
('Player 5F', '1995-10-10', 3000.65, '2018-10-10'),
('Player 6A', '1995-10-10', 3000.65, '2018-10-10'),
('Player 6B', '1995-10-10', 3000.65, '2018-10-10'),
('Player 6C', '1995-10-10', 3000.65, '2018-10-10'),
('Player 6D', '1995-10-10', 3000.65, '2018-10-10'),
('Player 6E', '1995-10-10', 3000.65, '2018-10-10'),
('Player 6F', '1995-10-10', 3000.65, '2018-10-10')
go

insert into Club_Player_Info(TeamID, PlayerID, ClubJoiningDate)
values
(1, 1, '2017-10-10'),
(1, 2, '2017-10-10'),
(1, 3, '2017-10-10'),
(1, 4, '2017-10-10'),
(1, 5, '2017-10-10'),
(1, 6, '2017-10-10'),
(2, 7, '2017-10-10'),
(2, 8, '2017-10-10'),
(2, 9, '2017-10-10'),
(2, 10, '2017-10-10'),
(2, 11, '2017-10-10'),
(2, 12, '2017-10-10'),
(3, 13, '2017-10-10'),
(3, 14, '2017-10-10'),
(3, 15, '2017-10-10'),
(3, 16, '2017-10-10'),
(3, 17, '2017-10-10'),
(3, 18, '2017-10-10'),
(4, 19, '2017-10-10'),
(4, 20, '2017-10-10'),
(4, 21, '2017-10-10'),
(4, 22, '2017-10-10'),
(4, 23, '2017-10-10'),
(4, 24, '2017-10-10'),
(5, 25, '2017-10-10'),
(5, 26, '2017-10-10'),
(5, 27, '2017-10-10'),
(5, 28, '2017-10-10'),
(5, 29, '2017-10-10'),
(5, 30, '2017-10-10'),
(6, 31, '2017-10-10'),
(6, 32, '2017-10-10'),
(6, 33, '2017-10-10'),
(6, 34, '2017-10-10'),
(6, 35, '2017-10-10'),
(6, 36, '2017-10-10')
go

insert into PenaltyHistory(RefereeID, LeagueName, CatchDate, Rate, TeamID_1, TeamID_2)
values
(1, 'League X', '2019-10-10', 7.5, 1, 2),
(1, 'League Y', '2019-10-10', 5.5, 2, 3),
(1, 'League Z', '2019-10-10', 9.0, 3, 4),
(2, 'League X', '2019-10-10', 6.5, 4, 5),
(3, 'League X', '2019-10-10', 5.0, 5, 6),
(4, 'League X', '2019-10-10', 7.5, 6, 1),
(4, 'League Y', '2019-10-10', 4.5, 2, 5),
(5, 'League X', '2019-10-10', 9.5, 6, 4),
(5, 'League Y', '2019-10-10', 8.0, 4, 3)
go

-- TEST
select * from Referee
go
select * from PenaltyHistory
go
select * from Team
go
select * from PlayerInfo
go
select * from Club_Player_Info
go

-- Xem thông tin lịch sử bắt của trọng tài - tên trọng tài, level, exp, giải bóng, đội 1, đội 2
---- Referee, PenaltyHistory, Team
select Referee.FullName, Referee.Level, Referee.Exp, PenaltyHistory.LeagueName, Team1.TeamName 'Team Name 1', Team2.TeamName 'Team Name 2'
from Referee, Team Team1, Team Team2, PenaltyHistory
where Referee.RefereeID = PenaltyHistory.RefereeID
	and PenaltyHistory.TeamID_1 = Team1.TeamID
	and PenaltyHistory.TeamID_2 = Team2.TeamID
go

create view view_referee_history
as
select Referee.FullName, Referee.Level, Referee.Exp, PenaltyHistory.LeagueName, Team1.TeamName 'Team Name 1', Team2.TeamName 'Team Name 2'
from Referee, Team Team1, Team Team2, PenaltyHistory
where Referee.RefereeID = PenaltyHistory.RefereeID
	and PenaltyHistory.TeamID_1 = Team1.TeamID
	and PenaltyHistory.TeamID_2 = Team2.TeamID
go

select * from view_referee_history
go

-- Xem danh sách cầu thủ của 1 đội bóng
---- PlayerInfo, Team, Club_Player_Info
select Team.TeamName, PlayerInfo.*
from PlayerInfo, Team, Club_Player_Info
where Team.TeamID = Club_Player_Info.TeamID
	and PlayerInfo.PlayerID = Club_Player_Info.PlayerID
	and Team.TeamName = 'Team 1'
go

-- Xem thông tin lịch sử bắt của trọng tài - tên trọng tài, level, exp, giải bóng, đội 1, đội 2 -> Tìm theo tên 1 đội bóng
---- proc
create proc proc_find_referee
	@teamId int
as
begin
	select Referee.FullName, Referee.Level, Referee.Exp, PenaltyHistory.LeagueName, Team1.TeamName 'Team Name 1', Team2.TeamName 'Team Name 2'
	from Referee, Team Team1, Team Team2, PenaltyHistory
	where Referee.RefereeID = PenaltyHistory.RefereeID
		and PenaltyHistory.TeamID_1 = Team1.TeamID
		and PenaltyHistory.TeamID_2 = Team2.TeamID
		and (Team1.TeamID = @teamId or Team2.TeamID = @teamId)
end
go

exec proc_find_referee 1
go

