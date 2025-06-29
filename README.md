# DevLife Portal - Database Scripts

Database initialization scripts for PostgreSQL and MongoDB.

## 📁 Structure

```
devlife-db-scripts/
├── init/                           # PostgreSQL scripts
│   ├── 01-init-database.sql      # Schema creation
│   └── 02-sample-data.sql        # Test data
├── mongo-init/                    # MongoDB scripts
│   └── 01-init-collections.js    # Collections + static content
└── README.md                     # This file
```

## 🗄️ Database Schema

### PostgreSQL Tables
- **users** - User profiles and authentication
- **user_sessions** - Session-based auth tokens
- **game_scores** - Scores for all 6 games
- **casino_bets** - Code Casino betting history
- **leaderboards** - Game rankings

### MongoDB Collections
- **code_snippets** - Code samples for Casino game
- **dating_profiles** - Static profiles for Dating Room
- **meeting_excuses** - Excuses for Meeting Escape
- **horoscopes** - Daily zodiac messages
- **code_challenges** - Templates for Code Roasting

## 🚀 Usage

### Automatic (Docker)
Scripts run automatically when containers start:
```bash
docker-compose up -d postgres mongodb
```

### Manual Execution
```bash
# PostgreSQL
docker exec -i devlife-postgres psql -U devlife_user -d devlife < init/01-init-database.sql

# MongoDB
docker exec -i devlife-mongodb mongosh devlife < mongo-init/01-init-collections.js
```

## 🔧 Custom Ports
- **PostgreSQL**: localhost:6100
- **MongoDB**: localhost:27017

## 📊 Sample Data

### Test Users
- `testuser` / `admin` - For development
- Sample sessions and game scores included

### Static Content
- 4 code snippets for Casino game
- 5 dating profiles
- 8 meeting excuses  
- 12 zodiac horoscopes
- 3 coding challenges

## 🛠️ Development

### Adding New Data
1. Edit existing `.sql` or `.js` files
2. Restart database containers
3. Data reloads automatically

### Schema Changes
1. Update `01-init-database.sql`
2. Drop and recreate containers:
   ```bash
   docker-compose down -v
   docker-compose up -d postgres mongodb
   ```

---

Ready for the 6 DevLife Portal projects! 🎮