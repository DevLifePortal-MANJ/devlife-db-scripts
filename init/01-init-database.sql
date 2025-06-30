-- DevLife Portal PostgreSQL Schema - PRODUCTION READY
-- Essential tables for the 6 projects - NO ENUMs, all VARCHAR for compatibility

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table (authentication & profiles) - Compatible with .NET Entity Framework
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    zodiac_sign VARCHAR(20) NOT NULL, -- English zodiac signs: Aries, Taurus, etc.
    tech_stack VARCHAR(200) NOT NULL,
    experience_level VARCHAR(20) NOT NULL, -- Junior, Middle, Senior
    total_points INTEGER DEFAULT 1000,
    session_token VARCHAR(100),
    bio TEXT,
    preferred_language VARCHAR(20) DEFAULT 'georgian',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP WITH TIME ZONE,
    last_activity TIMESTAMP WITH TIME ZONE
);

-- User sessions (session-based auth)
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_token VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    last_accessed_at TIMESTAMP WITH TIME ZONE,
    ip_address VARCHAR(100),
    user_agent VARCHAR(200),
    is_active BOOLEAN DEFAULT TRUE
);

-- Achievements system
CREATE TABLE achievements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    achievement_key VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    icon VARCHAR(10) NOT NULL,
    category VARCHAR(20) NOT NULL,
    game_name VARCHAR(20) NOT NULL,
    points_reward INTEGER DEFAULT 0,
    rarity VARCHAR(20) DEFAULT 'Common', -- Common, Rare, Epic, Legendary
    requirement_type VARCHAR(50),
    requirement_value INTEGER DEFAULT 0,
    requirement_data VARCHAR(200),
    is_active BOOLEAN DEFAULT TRUE,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- User achievements
CREATE TABLE user_achievements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    achievement_id UUID NOT NULL REFERENCES achievements(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    progress_value INTEGER DEFAULT 0,
    is_notified BOOLEAN DEFAULT FALSE,
    unlocked_in_game VARCHAR(20),
    context_data VARCHAR(500),
    UNIQUE(user_id, achievement_id)
);

-- Bug Chase Game Sessions
CREATE TABLE bug_chase_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    score INTEGER DEFAULT 0,
    distance INTEGER DEFAULT 0,
    bugs_collected INTEGER DEFAULT 0,
    power_ups_used INTEGER DEFAULT 0,
    level INTEGER DEFAULT 1,
    is_completed BOOLEAN DEFAULT FALSE,
    started_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP WITH TIME ZONE,
    duration INTERVAL DEFAULT '0 seconds'
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
    bet_amount INTEGER NOT NULL CHECK (bet_amount BETWEEN 1 AND 500),
    chosen_option INTEGER NOT NULL CHECK (chosen_option BETWEEN 1 AND 2),
    correct_option INTEGER NOT NULL CHECK (correct_option BETWEEN 1 AND 2),
    is_win BOOLEAN NOT NULL,
    points_change INTEGER NOT NULL,
    snippet_id VARCHAR(50) NOT NULL,
    tech_stack VARCHAR(20) NOT NULL,
    placed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_daily_challenge BOOLEAN DEFAULT FALSE,
    zodiac_sign VARCHAR(20),
    luck_multiplier DECIMAL(3,2) DEFAULT 1.0
);

-- Code Submissions (Code Roasting)
CREATE TABLE code_submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    challenge_id VARCHAR(50) NOT NULL,
    code TEXT NOT NULL,
    language VARCHAR(20) DEFAULT 'javascript',
    score INTEGER DEFAULT 0,
    feedback TEXT,
    roast_message TEXT,
    points_earned INTEGER DEFAULT 0,
    submitted_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Dating system
CREATE TABLE dating_swipes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    profile_id VARCHAR(50) NOT NULL,
    is_like BOOLEAN NOT NULL,
    swiped_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dating_matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    profile_id VARCHAR(50) NOT NULL,
    matched_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_message_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE
);

-- GitHub Analysis
CREATE TABLE github_analyses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    github_username VARCHAR(100) NOT NULL,
    repository_name VARCHAR(200) NOT NULL,
    personality_type VARCHAR(100) NOT NULL,
    strengths TEXT[],
    weaknesses TEXT[],
    celebrity_match VARCHAR(100),
    repos_analyzed INTEGER DEFAULT 0,
    total_commits INTEGER DEFAULT 0,
    dominant_language VARCHAR(50),
    analysis_data JSONB,
    analyzed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Meeting Excuse Favorites
CREATE TABLE meeting_excuse_favorites (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    excuse_id VARCHAR(50) NOT NULL,
    saved_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
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
CREATE INDEX idx_users_experience ON users(experience_level);
CREATE INDEX idx_users_session ON users(session_token);
CREATE INDEX idx_users_active ON users(is_active);
CREATE INDEX idx_sessions_token ON user_sessions(session_token);
CREATE INDEX idx_sessions_user ON user_sessions(user_id);
CREATE INDEX idx_sessions_active ON user_sessions(is_active, expires_at);
CREATE INDEX idx_achievements_key ON achievements(achievement_key);
CREATE INDEX idx_achievements_game ON achievements(game_name, is_active);
CREATE INDEX idx_achievements_rarity ON achievements(rarity);
CREATE INDEX idx_user_achievements_user ON user_achievements(user_id);
CREATE INDEX idx_user_achievements_achievement ON user_achievements(achievement_id);
CREATE INDEX idx_bug_chase_user ON bug_chase_sessions(user_id);
CREATE INDEX idx_bug_chase_score ON bug_chase_sessions(score DESC);
CREATE INDEX idx_bug_chase_completed ON bug_chase_sessions(is_completed, started_at);
CREATE INDEX idx_scores_user_game ON game_scores(user_id, game_name);
CREATE INDEX idx_scores_created ON game_scores(created_at DESC);
CREATE INDEX idx_casino_user ON casino_bets(user_id);
CREATE INDEX idx_casino_daily ON casino_bets(is_daily_challenge, placed_at);
CREATE INDEX idx_casino_zodiac ON casino_bets(zodiac_sign);
CREATE INDEX idx_code_submissions_user ON code_submissions(user_id);
CREATE INDEX idx_code_submissions_language ON code_submissions(language);
CREATE INDEX idx_dating_swipes_user ON dating_swipes(user_id);
CREATE INDEX idx_dating_matches_user ON dating_matches(user_id, is_active);
CREATE INDEX idx_github_analyses_user ON github_analyses(user_id);
CREATE INDEX idx_excuse_favorites_user ON meeting_excuse_favorites(user_id);
CREATE INDEX idx_leaderboard_game ON leaderboards(game_name, total_points DESC);

-- Constraints for data validation
ALTER TABLE users ADD CONSTRAINT chk_experience_level 
    CHECK (experience_level IN ('Junior', 'Middle', 'Senior'));

ALTER TABLE users ADD CONSTRAINT chk_zodiac_sign 
    CHECK (zodiac_sign IN (
        'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
        'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
    ));

ALTER TABLE achievements ADD CONSTRAINT chk_achievement_rarity 
    CHECK (rarity IN ('Common', 'Rare', 'Epic', 'Legendary'));

ALTER TABLE users ADD CONSTRAINT chk_preferred_language 
    CHECK (preferred_language IN ('georgian', 'english'));

COMMIT;

-- Success message
SELECT 'DevLife Portal database schema created successfully! All tables use VARCHAR for compatibility.' as status;