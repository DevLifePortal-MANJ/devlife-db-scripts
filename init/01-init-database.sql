-- DevLife Portal PostgreSQL Schema
-- Essential tables for the 6 projects

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enums
CREATE TYPE experience_level AS ENUM ('Junior', 'Middle', 'Senior');
CREATE TYPE zodiac_sign AS ENUM (
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
    'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
);

-- Users table (authentication & profiles)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    zodiac_sign zodiac_sign NOT NULL,
    tech_stack VARCHAR(200) NOT NULL,
    experience_level experience_level NOT NULL,
    total_points INTEGER DEFAULT 1000,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP WITH TIME ZONE
);

-- User sessions (session-based auth)
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_token VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Game scores (all 6 projects)
CREATE TABLE game_scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    game_name VARCHAR(50) NOT NULL, -- 'casino', 'roasting', 'bug_chase', 'analyzer', 'dating', 'escape'
    score INTEGER NOT NULL,
    points_earned INTEGER DEFAULT 0,
    game_data JSONB, -- flexible data for each game
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Casino bets (Code Casino specific)
CREATE TABLE casino_bets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    bet_amount INTEGER NOT NULL,
    chosen_option INTEGER NOT NULL, -- 1 or 2 (which snippet)
    is_win BOOLEAN NOT NULL,
    points_change INTEGER NOT NULL,
    snippet_data JSONB, -- store the snippets used
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Leaderboards (simple rankings)
CREATE TABLE leaderboards (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    game_name VARCHAR(50) NOT NULL,
    best_score INTEGER NOT NULL,
    total_points INTEGER NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, game_name)
);

-- Indexes for performance
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_zodiac ON users(zodiac_sign);
CREATE INDEX idx_sessions_token ON user_sessions(session_token);
CREATE INDEX idx_sessions_user ON user_sessions(user_id);
CREATE INDEX idx_scores_user_game ON game_scores(user_id, game_name);
CREATE INDEX idx_scores_created ON game_scores(created_at DESC);
CREATE INDEX idx_casino_user ON casino_bets(user_id);
CREATE INDEX idx_leaderboard_game ON leaderboards(game_name, total_points DESC);

COMMIT;