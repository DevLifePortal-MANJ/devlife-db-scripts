-- DevLife Portal Sample Data - PRODUCTION READY
-- Test users and sample game data with English zodiac signs and proper VARCHAR values

-- Sample users for testing with all required fields and English zodiac signs
INSERT INTO users (username, first_name, last_name, birth_date, zodiac_sign, tech_stack, experience_level, total_points, bio, is_active, preferred_language) 
VALUES 
    ('testuser', 'Test', 'User', '1995-06-15', 'Gemini', 'Angular, .NET', 'Middle', 1500, 'Full-stack developer who loves debugging at 3 AM ☕', TRUE, 'georgian'),
    ('admin', 'Admin', 'User', '1990-01-01', 'Capricorn', 'Angular, .NET, PostgreSQL', 'Senior', 5000, 'System architect and coffee enthusiast 🚀', TRUE, 'english'),
    ('john_dev', 'John', 'Developer', '1992-03-20', 'Aries', 'React, Node.js', 'Middle', 2200, 'React wizard and pizza lover 🍕', TRUE, 'georgian'),
    ('sarah_code', 'Sarah', 'Coder', '1988-09-12', 'Virgo', '.NET, Azure', 'Senior', 3800, 'Cloud architect who codes with precision ☁️', TRUE, 'english'),
    ('alex_junior', 'Alex', 'Junior', '1998-11-30', 'Sagittarius', 'Angular, TypeScript', 'Junior', 800, 'Junior dev with big dreams 🌟', TRUE, 'georgian'),
    ('leo_developer', 'Leo', 'Developer', '1992-08-15', 'Leo', 'Python, Django', 'Senior', 2500, 'Leo developer with leadership skills ♌', TRUE, 'georgian'),
    ('scorpio_ana', 'Ana', 'Scorpio', '1988-11-05', 'Scorpio', 'C#, .NET Core', 'Senior', 3000, 'Intense Scorpio coder ♏', TRUE, 'georgian'),
    ('gemini_nick', 'Nick', 'Gemini', '1990-06-01', 'Gemini', 'JavaScript, Vue', 'Middle', 1800, 'Versatile Gemini developer 👯', TRUE, 'english'),
    ('libra_emma', 'Emma', 'Balance', '1993-10-10', 'Libra', 'Design, Frontend', 'Middle', 1600, 'Balanced Libra designer-developer ⚖️', TRUE, 'english'),
    ('pisces_alex', 'Alex', 'Creative', '1991-03-05', 'Pisces', 'Creative Coding, Art', 'Senior', 2200, 'Creative Pisces with artistic code 🎨', TRUE, 'georgian');

-- Sample sessions for testing
INSERT INTO user_sessions (user_id, session_token, expires_at, is_active)
SELECT 
    id, 
    'test-session-' || username,
    CURRENT_TIMESTAMP + INTERVAL '1 day',
    TRUE
FROM users 
WHERE username IN ('testuser', 'admin', 'john_dev');

-- Sample achievements
INSERT INTO achievements (achievement_key, name, description, icon, category, game_name, points_reward, rarity, requirement_type, requirement_value, requirement_data)
VALUES 
    ('first_login', 'Welcome Aboard!', 'შენი პირველი შემოსვლა DevLife Portal-ში', '🎉', 'general', 'general', 50, 'Common', 'user_registration', 1, NULL),
    ('casino_first_win', 'Lucky Beginner', 'მოიგე შენი პირველი bet Code Casino-ში', '🎰', 'casino', 'casino', 100, 'Common', 'casino_wins', 1, NULL),
    ('casino_streak_5', 'Streak Master', '5 bet-ის streak Code Casino-ში', '🔥', 'casino', 'casino', 250, 'Rare', 'casino_streak', 5, NULL),
    ('casino_high_roller', 'High Roller', 'Bet 500 points in a single game', '💰', 'casino', 'casino', 500, 'Epic', 'casino_bet', 500, NULL),
    ('bug_chase_1000', 'Bug Hunter', 'გაარბიე 1000 პიქსელი Bug Chase-ში', '🏃', 'bugchase', 'bug_chase', 150, 'Common', 'bugchase_distance', 1000, NULL),
    ('bug_chase_5000', 'Marathon Runner', 'გაარბიე 5000 პიქსელი Bug Chase-ში', '🏃‍♂️', 'bugchase', 'bug_chase', 400, 'Rare', 'bugchase_distance', 5000, NULL),
    ('points_master', 'Points Millionaire', 'მოაგროვე 10000 ქულა', '💰', 'general', 'general', 500, 'Epic', 'total_points', 10000, NULL),
    ('points_legend', 'Legend Status', 'მოაგროვე 25000 ქულა', '👑', 'general', 'general', 1000, 'Legendary', 'total_points', 25000, NULL),
    ('gemini_power', 'Gemini Power', 'ყველაზე ბედნიერი ზოდიაქოს ნიშანი დღეს', '♊', 'zodiac', 'general', 75, 'Rare', 'zodiac_sign', 1, 'Gemini'),
    ('leo_leadership', 'Leo Leadership', 'ლიდერობა კოდ რევიუში', '♌', 'zodiac', 'general', 100, 'Rare', 'zodiac_sign', 1, 'Leo'),
    ('scorpio_intensity', 'Scorpio Intensity', 'ღრმად ჩაკონცენტრირება', '♏', 'zodiac', 'general', 120, 'Epic', 'zodiac_sign', 1, 'Scorpio'),
    ('aries_speed', 'Aries Speed', 'სწრაფი კოდინგი და გადაწყვეტები', '♈', 'zodiac', 'general', 90, 'Rare', 'zodiac_sign', 1, 'Aries'),
    ('virgo_precision', 'Virgo Precision', 'ზუსტი და სუფთა კოდი', '♍', 'zodiac', 'general', 110, 'Rare', 'zodiac_sign', 1, 'Virgo'),
    ('all_games_played', 'Game Master', 'ყველა 6 თამაშის გათამაშება', '🎮', 'general', 'general', 300, 'Epic', 'games_played', 6, NULL);

-- Sample user achievements
INSERT INTO user_achievements (user_id, achievement_id, unlocked_at, is_notified, unlocked_in_game)
SELECT 
    u.id,
    a.id,
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    FALSE,
    'general'
FROM users u
CROSS JOIN achievements a
WHERE u.username = 'testuser' AND a.achievement_key = 'first_login'
UNION ALL
SELECT 
    u.id,
    a.id,
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    FALSE,
    'casino'
FROM users u
CROSS JOIN achievements a
WHERE u.username = 'john_dev' AND a.achievement_key = 'casino_first_win'
UNION ALL
SELECT 
    u.id,
    a.id,
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    FALSE,
    'general'
FROM users u
CROSS JOIN achievements a
WHERE u.username = 'leo_developer' AND a.achievement_key = 'leo_leadership';

-- Sample bug chase sessions
INSERT INTO bug_chase_sessions (user_id, score, distance, bugs_collected, power_ups_used, level, is_completed, started_at, completed_at, duration)
SELECT 
    u.id,
    1250,
    1200,
    15,
    3,
    2,
    TRUE,
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour 55 minutes',
    INTERVAL '5 minutes'
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    2100,
    2000,
    25,
    5,
    3,
    TRUE,
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '52 minutes',
    INTERVAL '8 minutes'
FROM users u WHERE u.username = 'alex_junior'
UNION ALL
SELECT 
    u.id,
    3500,
    3200,
    40,
    8,
    4,
    TRUE,
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours 50 minutes',
    INTERVAL '10 minutes'
FROM users u WHERE u.username = 'leo_developer';

-- Sample casino bets with English zodiac signs
INSERT INTO casino_bets (user_id, bet_amount, chosen_option, correct_option, is_win, points_change, snippet_id, tech_stack, placed_at, is_daily_challenge, zodiac_sign, luck_multiplier)
SELECT 
    u.id,
    100,
    1,
    1,
    TRUE,
    200,
    'js_snippet_001',
    'Angular',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    TRUE,
    u.zodiac_sign,
    1.2
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    50,
    2,
    1,
    FALSE,
    -50,
    'csharp_snippet_002',
    '.NET',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    FALSE,
    u.zodiac_sign,
    1.0
FROM users u WHERE u.username = 'john_dev'
UNION ALL
SELECT 
    u.id,
    200,
    1,
    1,
    TRUE,
    400,
    'ts_snippet_003',
    'TypeScript',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    FALSE,
    u.zodiac_sign,
    1.3
FROM users u WHERE u.username = 'leo_developer'
UNION ALL
SELECT 
    u.id,
    150,
    2,
    2,
    TRUE,
    300,
    'py_snippet_004',
    'Python',
    CURRENT_TIMESTAMP - INTERVAL '45 minutes',
    FALSE,
    u.zodiac_sign,
    1.4
FROM users u WHERE u.username = 'scorpio_ana';

-- Sample code submissions
INSERT INTO code_submissions (user_id, challenge_id, code, language, score, feedback, roast_message, points_earned, submitted_at)
SELECT 
    u.id,
    'fizzbuzz_001',
    'function fizzbuzz() { for(let i=1; i<=100; i++) { console.log(i%15==0?"FizzBuzz":i%3==0?"Fizz":i%5==0?"Buzz":i); } }',
    'javascript',
    85,
    'კარგი მიდგომაა, მაგრამ კოდი შეიძლება უფრო მარტივი იყოს',
    'შენი კოდი ისე გამოიყურება, რომ ჩატჯიპიტიმ დაწერა, მაგრამ მაინც მუშაობს! 😅',
    150,
    CURRENT_TIMESTAMP - INTERVAL '3 hours'
FROM users u WHERE u.username = 'john_dev'
UNION ALL
SELECT 
    u.id,
    'palindrome_002',
    'function isPalindrome(str) { return str === str.split("").reverse().join(""); }',
    'javascript',
    92,
    'ძალიან კარგი მიდგომა! მარტივი და ეფექტური',
    'ბრავო! ეს კოდი ისე კარგია, რომ ჩემი ბებიაც დაწერდა! 👵',
    200,
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'two_sum_003',
    'def two_sum(nums, target):\n    for i in range(len(nums)):\n        for j in range(i+1, len(nums)):\n            if nums[i] + nums[j] == target:\n                return [i, j]',
    'python',
    78,
    'მუშაობს, მაგრამ O(n²) complexity არ არის ოპტიმალური',
    'ეს კოდი ისე ნელაა, რომ ჩემი ბებია უფრო სწრაფად ითვლის! 🐌',
    120,
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
FROM users u WHERE u.username = 'leo_developer';

-- Sample dating swipes
INSERT INTO dating_swipes (user_id, profile_id, is_like, swiped_at)
SELECT 
    u.id,
    'profile_alex_chen',
    TRUE,
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'profile_sarah_johnson',
    FALSE,
    CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes'
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'profile_miguel_rodriguez',
    TRUE,
    CURRENT_TIMESTAMP - INTERVAL '45 minutes'
FROM users u WHERE u.username = 'alex_junior'
UNION ALL
SELECT 
    u.id,
    'profile_emily_davis',
    TRUE,
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
FROM users u WHERE u.username = 'leo_developer';

-- Sample dating matches
INSERT INTO dating_matches (user_id, profile_id, matched_at, last_message_at, is_active)
SELECT 
    u.id,
    'profile_alex_chen',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    TRUE
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'profile_emily_davis',
    CURRENT_TIMESTAMP - INTERVAL '45 minutes',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    TRUE
FROM users u WHERE u.username = 'leo_developer';

-- Sample GitHub analyses
INSERT INTO github_analyses (user_id, github_username, repository_name, personality_type, strengths, weaknesses, celebrity_match, repos_analyzed, total_commits, dominant_language, analysis_data)
SELECT 
    u.id,
    'testuser_github',
    'awesome-project',
    'Chaotic Debugger',
    ARRAY['სწრაფი პრობლემის გადაწყვეტა', 'კრეატიული მიდგომები'],
    ARRAY['დოკუმენტაცია', 'ტესტების წერა'],
    'Linus Torvalds',
    5,
    247,
    'TypeScript',
    '{"commit_frequency": "high", "code_style": "chaotic_good", "documentation_score": 3}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'sarah_github',
    'enterprise-solution',
    'Architecture Wizard',
    ARRAY['სისტემური მიდგომა', 'სუფთა კოდი'],
    ARRAY['მიკრომენეჯმენტი', 'ტოლერანტობა legacy კოდზე'],
    'Martin Fowler',
    12,
    1056,
    'C#',
    '{"commit_frequency": "steady", "code_style": "enterprise", "documentation_score": 9}'::jsonb
FROM users u WHERE u.username = 'sarah_code'
UNION ALL
SELECT 
    u.id,
    'leo_python_guru',
    'django-masterpiece',
    'Code Artist',
    ARRAY['კრეატიული ალგორითმები', 'ლიდერული უნარები'],
    ARRAY['დროის მენეჯმენტი', 'ზედმეტი პერფექციონიზმი'],
    'Guido van Rossum',
    8,
    523,
    'Python',
    '{"commit_frequency": "creative_bursts", "code_style": "artistic", "documentation_score": 7}'::jsonb
FROM users u WHERE u.username = 'leo_developer';

-- Sample meeting excuse favorites
INSERT INTO meeting_excuse_favorites (user_id, excuse_id, saved_at)
SELECT 
    u.id,
    'excuse_stackoverflow_down',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'excuse_cat_deployed',
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
FROM users u WHERE u.username = 'alex_junior'
UNION ALL
SELECT 
    u.id,
    'excuse_ai_consciousness',
    CURRENT_TIMESTAMP - INTERVAL '3 hours'
FROM users u WHERE u.username = 'leo_developer';

-- Sample game scores for all 6 projects
INSERT INTO game_scores (user_id, game_name, score, points_earned, game_data)
SELECT 
    u.id,
    'casino',
    1250,
    250,
    '{"wins": 5, "losses": 2, "streak": 3, "daily_challenges": 2, "zodiac_bonus": true}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'bug_chase',
    2100,
    200,
    '{"distance": 2000, "bugs_avoided": 25, "power_ups": 5, "max_level": 3}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'roasting',
    85,
    150,
    '{"submissions": 2, "avg_score": 88.5, "roasts_received": 2, "best_score": 92}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'analyzer',
    95,
    200,
    '{"personality": "Chaotic Debugger", "repos_analyzed": 5, "commits": 247}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'dating',
    3,
    50,
    '{"matches": 1, "swipes": 3, "conversations": 1, "compatibility_avg": 85}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'escape',
    12,
    25,
    '{"excuses_generated": 12, "believability_avg": 7.2, "favorites": 2, "categories_used": 3}'::jsonb
FROM users u WHERE u.username = 'testuser'
UNION ALL
SELECT 
    u.id,
    'casino',
    1800,
    300,
    '{"wins": 8, "losses": 3, "streak": 5, "daily_challenges": 3, "zodiac_bonus": true}'::jsonb
FROM users u WHERE u.username = 'leo_developer'
UNION ALL
SELECT 
    u.id,
    'bug_chase',
    3500,
    350,
    '{"distance": 3200, "bugs_avoided": 40, "power_ups": 8, "max_level": 4}'::jsonb
FROM users u WHERE u.username = 'leo_developer'
UNION ALL
SELECT 
    u.id,
    'casino',
    800,
    100,
    '{"wins": 3, "losses": 4, "streak": 2, "daily_challenges": 1, "zodiac_bonus": false}'::jsonb
FROM users u WHERE u.username = 'john_dev'
UNION ALL
SELECT 
    u.id,
    'bug_chase',
    1750,
    150,
    '{"distance": 1600, "bugs_avoided": 18, "power_ups": 4, "max_level": 2}'::jsonb
FROM users u WHERE u.username = 'alex_junior';

-- Sample leaderboards
INSERT INTO leaderboards (user_id, game_name, best_score, total_points, updated_at)
SELECT 
    u.id,
    gs.game_name,
    gs.score,
    u.total_points,
    CURRENT_TIMESTAMP
FROM users u
JOIN game_scores gs ON u.id = gs.user_id
ON CONFLICT (user_id, game_name) 
DO UPDATE SET 
    best_score = GREATEST(leaderboards.best_score, EXCLUDED.best_score),
    total_points = EXCLUDED.total_points,
    updated_at = CURRENT_TIMESTAMP;

-- Update user total points based on game scores and achievements
UPDATE users 
SET total_points = (
    SELECT 
        1000 + -- Starting points
        COALESCE(SUM(gs.points_earned), 0) + -- Game points
        COALESCE(SUM(ua_points.points_reward), 0) -- Achievement points
    FROM users u2
    LEFT JOIN game_scores gs ON u2.id = gs.user_id
    LEFT JOIN user_achievements ua ON u2.id = ua.user_id
    LEFT JOIN achievements ua_points ON ua.achievement_id = ua_points.id
    WHERE u2.id = users.id
);

-- Update last activity for active users
UPDATE users 
SET last_activity = CURRENT_TIMESTAMP - INTERVAL '1 hour'
WHERE username IN ('testuser', 'john_dev', 'alex_junior', 'leo_developer', 'scorpio_ana');

COMMIT;

-- Success message
SELECT 'DevLife Portal sample data inserted successfully! ' || 
       COUNT(*) || ' users created with English zodiac signs.' as status
FROM users;