DROP SCHEMA IF EXISTS cricket;
CREATE SCHEMA cricket;
USE cricket;

--
-- Table structure for all tables in cricket schema`
--
CREATE TABLE team (
	team_id NUMERIC,
	team_country VARCHAR (20) UNIQUE,
    team_rank NUMERIC,
    team_captain VARCHAR (30),
	matches_played NUMERIC,
    matches_win NUMERIC,
    matches_loss NUMERIC,
    matches_tie NUMERIC,
	PRIMARY KEY  (team_id)
);


CREATE TABLE coach(
	coach_id NUMERIC,
    coach_name VARCHAR(30),
    coach_country VARCHAR (20),
    coach_dob date,
    join_date date,
    team_id NUMERIC ,
    PRIMARY KEY (coach_id),
    CONSTRAINT `fk_coach_team_id` FOREIGN KEY (team_id) REFERENCES team (team_id) on delete set null on update cascade
);

CREATE TABLE series(
	series_id NUMERIC,
    series_name VARCHAR(30),
    man_of_series VARCHAR(30),
    series_winner VARCHAR(30),
    start_date date,
    end_date date,
    PRIMARY KEY (series_id)
);

CREATE TABLE stadium(
	stadium_id NUMERIC,
    stadium_name VARCHAR(20),
    capacity NUMERIC,
    city VARCHAR(15),
    country VARCHAR(20),
    PRIMARY KEY (stadium_id)
);


CREATE TABLE umpire(
	umpire_id NUMERIC,
    umpire_name VARCHAR(30),
    umpire_country VARCHAR(20),
    umpire_dob date,
    matches_umpired NUMERIC,
    PRIMARY KEY (umpire_id)
);

CREATE TABLE matches(
	match_id NUMERIC,
    toss_win VARCHAR(20),
    batting_first VARCHAR(20),
    man_of_match VARCHAR(20),
    result VARCHAR(20),
    match_type VARCHAR(20),
    match_date date,
    stadium_id NUMERIC,
    series_id NUMERIC,
    umpire_id NUMERIC,
    PRIMARY KEY (match_id),
    CONSTRAINT `fk_matches_umpire_id` FOREIGN KEY (umpire_id) REFERENCES umpire (umpire_id) on delete set null on update cascade,
    CONSTRAINT `fk_matches_stadium_id` FOREIGN KEY (stadium_id) REFERENCES stadium (stadium_id) on delete set null on update cascade,
    CONSTRAINT `fk_matches_series_id` FOREIGN KEY (series_id) REFERENCES series (series_id) on delete cascade on update cascade
);


CREATE TABLE scorecard(
	scorecard_id NUMERIC,
    run_rate float,
    total_runs NUMERIC,
    total_wickets NUMERIC,
    total_overs float,
    extras NUMERIC,
    inning NUMERIC,
    team_id NUMERIC,
    match_id NUMERIC,
    PRIMARY KEY (scorecard_id),
    CONSTRAINT `fk_scorecard_match_id` FOREIGN KEY (match_id) REFERENCES matches (match_id) on delete cascade on update cascade,
    CONSTRAINT `fk_scorecard_team_id` FOREIGN KEY (team_id) REFERENCES team (team_id) on delete set null on update cascade
);

CREATE TABLE player(
	player_id NUMERIC,
    player_name VARCHAR(30),
    player_dob date,
    player_height NUMERIC,
    debut_date date,
    team_id NUMERIC,
    PRIMARY KEY(player_id),
    CONSTRAINT `fk_player_team_id` FOREIGN KEY (team_id) REFERENCES team (team_id) on delete cascade on update cascade
);

CREATE table squad(
	player_id NUMERIC,
    team_id NUMERIC,
    CONSTRAINT `fk_squad_team_id` FOREIGN KEY (team_id) REFERENCES team (team_id) on delete cascade,
    CONSTRAINT `fk_squad_player_id` FOREIGN KEY (player_id) REFERENCES player (player_id) on delete cascade
);

CREATE TABLE player_statistics(
	p_statistics_id NUMERIC,
    player_id NUMERIC,
    runs NUMERIC,
    sixers NUMERIC,
    fours NUMERIC,
    overs_bowled numeric,
    wkts_taken NUMERIC,
    maidens NUMERIC,
    match_id NUMERIC,
    scorecard_id NUMERIC,
    PRIMARY KEY (p_statistics_id),
    CONSTRAINT `fk_player_statistics_scorecard_id` FOREIGN KEY (scorecard_id) REFERENCES scorecard (scorecard_id) on delete set null on update cascade,
    CONSTRAINT `fk_player_statistics_player_id` FOREIGN KEY (player_id) REFERENCES player (player_id) on delete cascade on update cascade
);

 CREATE TABLE bowler(
	player_id NUMERIC unique,
	bowler_rank NUMERIC,
    wickets NUMERIC,
    best_figures NUMERIC,
    balls_bowled NUMERIC,
    fivers NUMERIC,
    CONSTRAINT `fk_bowler_player_id` FOREIGN KEY (player_id) REFERENCES player (player_id) on delete cascade on update cascade
    
 );
 
 CREATE TABLE batsman(
	player_id NUMERIC UNIQUE,
	batting_rank NUMERIC,
    total_runs NUMERIC,
    balls_faced NUMERIC,
    style VARCHAR (10),
    hundreds NUMERIC,
    fifties NUMERIC,
    total_sixes NUMERIC,
    total_fours NUMERIC,
    CONSTRAINT `fk_batsman_player_id` FOREIGN KEY (player_id) REFERENCES player (player_id) on delete cascade on update cascade
);
