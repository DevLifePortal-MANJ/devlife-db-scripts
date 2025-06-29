-- DevLife Portal Sample Data
-- Test users and sample game data

-- Sample users for testing
INSERT INTO users (username, first_name, last_name, birth_date, zodiac_sign, tech_stack, experience_level, total_points) 
VALUES 
    ('testuser', 'Test', 'User', '1995-06-15', 'Gemini', 'Angular, .NET', 'Middle', 1500),
    ('admin', 'Admin', 'User', '1990-01-01', 'Capricorn', 'Angular, .NET, PostgreSQL', 'Senior', 5000),
    ('john_dev', 'John', 'Developer', '1992-03-20', 'Aries', 'React, Node.js', 'Middle', 2200),
    ('sarah_code', 'Sarah', 'Coder', '1988-09-12', 'Virgo', '.NET, Azure', 'Senior', 3800),
    ('alex_junior', 'Alex', 'Junior', '1998-11-30', 'Sagittarius', 'Angular, TypeScript', 'Junior', 800);

-- Sample sessions for testing
INSERT INTO user_sessions (user_id, session_token, expires_at)
SELECT 
    id, 
    'test-session-' || username,
    CURRENT_TIMESTAMP + INTERVAL '1 day'
FROM users 
WHERE username IN ('testuser', 'admin');

-- Sample casino bets
INSERT INTO casino_bets (user_id, bet_amount, chosen_option, is_win, points_change, snippet_data)
SELECT 
    u.id,
    100,
    1,
    true,
    200,
    '{"language": "javascript", "correct": 1, "chosen": 1}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    50,
    2,
    false,
    -50,
    '{"language": "csharp", "correct": 1, "chosen": 2}'::jsonb
FROM users u WHERE u.username = 'john_dev';

-- Sample game scores for all 6 projects
INSERT INTO game_scores (user_id, game_name, score, points_earned, game_data)
SELECT 
    u.id,
    'casino',
    1250,
    250,
    '{"wins": 5, "losses": 2, "streak": 3}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'bug_chase',
    8500,
    150,
    '{"distance": 8500, "bugs_avoided": 25, "power_ups": 3}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'roasting',
    85,
    100,
    '{"submissions": 3, "avg_score": 85, "roasts_received": 3}'::jsonb
FROM users u WHERE u.username = 'john_dev'
UNION ALL
SELECT 
    u.id,
    'analyzer',
    92,
    200,
    '{"personality": "Chaotic Debugger", "repos_analyzed": 5, "commits": 1250}'::jsonb
FROM users u WHERE u.username = 'sarah_code'
UNION ALL
SELECT 
    u.id,
    'dating',
    12,
    50,
    '{"matches": 12, "conversations": 3, "compatibility": 85}'::jsonb
FROM users u WHERE u.username = 'alex_junior'
UNION ALL
SELECT 
    u.id,
    'escape',
    47,
    25,
    '{"excuses_generated": 47, "believability_avg": 7.2, "favorites": 5}'::jsonb
FROM users u WHERE u.username = 'admin';

-- Sample leaderboards
INSERT INTO leaderboards (user_id, game_name, best_score, total_points)
SELECT 
    u.id,
    gs.game_name,
    gs.score,
    u.total_points
FROM users u
JOIN game_scores gs ON u.id = gs.user_id
ON CONFLICT (user_id, game_name) 
DO UPDATE SET 
    best_score = GREATEST(leaderboards.best_score, EXCLUDED.best_score),
    total_points = EXCLUDED.total_points,
    updated_at = CURRENT_TIMESTAMP;

-- Update user total points based on game scores
UPDATE users 
SET total_points = (
    SELECT COALESCE(SUM(points_earned), 0) + 1000
    FROM game_scores 
    WHERE game_scores.user_id = users.id
);

COMMIT;