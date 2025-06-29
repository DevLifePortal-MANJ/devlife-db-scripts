// DevLife Portal MongoDB - Static Content for 6 Projects
db = db.getSiblingDB('devlife');

// 🎰 Code Casino - Code snippets 
db.code_snippets.insertMany([
  {
    language: "javascript",
    difficulty: 1,
    correct_code: `function sum(a, b) {\n  return a + b;\n}\nconsole.log(sum(2, 3)); // Output: 5`,
    buggy_code: `function sum(a, b) {\n  return a + b;\n}\nconsole.log(sum(2, 3); // Missing closing parenthesis`,
    explanation: "Missing closing parenthesis in console.log",
    tech_stacks: ["Angular", "React", "Vue", "Node.js"]
  },
  {
    language: "csharp",
    difficulty: 1,
    correct_code: `string message = "Hello World";\nConsole.WriteLine(message);`,
    buggy_code: `string message = "Hello World";\nConsole.WriteLine(message);`,
    explanation: "Correct code - no issues",
    tech_stacks: [".NET", "C#"]
  },
  {
    language: "typescript",
    difficulty: 2,
    correct_code: `interface User {\n  name: string;\n  age: number;\n}\nconst user: User = { name: "John", age: 25 };`,
    buggy_code: `interface User {\n  name: string;\n  age: number;\n}\nconst user: User = { name: "John", age: "25" };`,
    explanation: "Type mismatch: age should be number, not string",
    tech_stacks: ["Angular", "TypeScript", "React"]
  },
  {
    language: "python",
    difficulty: 2,
    correct_code: `numbers = [1, 2, 3, 4, 5]\ntotal = sum(numbers)\nprint(f"Total: {total}")`,
    buggy_code: `numbers = [1, 2, 3, 4, 5]\ntotal = sum(numbers\nprint(f"Total: {total}")`,
    explanation: "Missing closing parenthesis in sum() function",
    tech_stacks: ["Python", "Django", "Flask"]
  }
]);

// 💑 Dev Dating Room - Static profiles
db.dating_profiles.insertMany([
  {
    name: "Alex Chen",
    bio: "Full-stack developer who loves clean code and coffee ☕",
    tech_stack: ["Angular", "Node.js", "TypeScript", "MongoDB"],
    experience_level: "Middle",
    zodiac_sign: "Gemini",
    avatar: "/avatars/alex.jpg"
  },
  {
    name: "Sarah Johnson", 
    bio: "Backend wizard specializing in .NET architectures 🚀",
    tech_stack: [".NET", "Azure", "SQL Server", "Docker"],
    experience_level: "Senior", 
    zodiac_sign: "Virgo",
    avatar: "/avatars/sarah.jpg"
  },
  {
    name: "Miguel Rodriguez",
    bio: "Frontend artist who makes pixels dance 🎨",
    tech_stack: ["Angular", "CSS", "UI/UX", "Figma"],
    experience_level: "Middle",
    zodiac_sign: "Leo", 
    avatar: "/avatars/miguel.jpg"
  },
  {
    name: "Emily Davis",
    bio: "DevOps engineer automating everything 🤖",
    tech_stack: ["Docker", "Kubernetes", "AWS", "Terraform"],
    experience_level: "Senior",
    zodiac_sign: "Capricorn",
    avatar: "/avatars/emily.jpg"
  },
  {
    name: "David Kim",
    bio: "Mobile developer creating awesome apps 📱",
    tech_stack: ["React Native", "Flutter", "iOS", "Android"],
    experience_level: "Middle",
    zodiac_sign: "Aries",
    avatar: "/avatars/david.jpg"
  }
]);

// 🏃 Meeting Escape - Creative excuses
db.meeting_excuses.insertMany([
  {
    category: "technical",
    excuse: "The production server caught fire and I need to debug the flames",
    believability: 8,
    tags: ["urgent", "production", "fire"]
  },
  {
    category: "personal",
    excuse: "My cat deployed to production by walking on my keyboard",
    believability: 6,
    tags: ["pets", "deployment", "accident"]
  },
  {
    category: "creative",
    excuse: "ChatGPT gained consciousness and needs philosophical support",
    believability: 3,
    tags: ["ai", "consciousness", "philosophy"]
  },
  {
    category: "technical",
    excuse: "Our database tables are staging a rebellion and refusing to JOIN",
    believability: 7,
    tags: ["database", "sql", "rebellion"]
  },
  {
    category: "personal",
    excuse: "I'm debugging my coffee machine's API - it's returning null instead of espresso",
    believability: 5,
    tags: ["coffee", "api", "debugging"]
  },
  {
    category: "creative",
    excuse: "The code review comments achieved sentience and are demanding better variable names",
    believability: 4,
    tags: ["code-review", "sentience", "variables"]
  },
  {
    category: "technical",
    excuse: "Stack Overflow is down and I forgot how to code",
    believability: 9,
    tags: ["stackoverflow", "emergency", "coding"]
  },
  {
    category: "personal",
    excuse: "My rubber duck stopped responding to my debugging questions",
    believability: 7,
    tags: ["rubber-duck", "debugging", "crisis"]
  }
]);

// 🏠 Daily horoscopes for developers
db.horoscopes.insertMany([
  {
    zodiac_sign: "Aries",
    message: "Today your code will compile on the first try! Your aggressive debugging style pays off 🔥",
    lucky_tech: "Angular",
    coding_tip: "Trust your instincts when refactoring"
  },
  {
    zodiac_sign: "Taurus",
    message: "Slow and steady debugging wins the race today. Your methodical approach catches all bugs 🐢",
    lucky_tech: ".NET", 
    coding_tip: "Build solid foundations that last"
  },
  {
    zodiac_sign: "Gemini",
    message: "Your dual nature helps you see both frontend and backend perspectives clearly 👁️",
    lucky_tech: "TypeScript",
    coding_tip: "Switch between projects to stay creative"
  },
  {
    zodiac_sign: "Cancer",
    message: "Perfect day to mentor a junior developer. Your nurturing nature shines 🤗",
    lucky_tech: "Angular",
    coding_tip: "Focus on user experience and empathy"
  },
  {
    zodiac_sign: "Leo", 
    message: "Your leadership shines in code reviews today. Others follow your standards ⭐",
    lucky_tech: "CSS",
    coding_tip: "Showcase your elegant solutions proudly"
  },
  {
    zodiac_sign: "Virgo",
    message: "Your attention to detail catches bugs others miss. Legendary debugging session ahead 🔍",
    lucky_tech: ".NET",
    coding_tip: "Clean, documented code is worth the time"
  },
  {
    zodiac_sign: "Libra",
    message: "Perfect balance between new features and bug fixes today ⚖️",
    lucky_tech: "React",
    coding_tip: "Harmony in code architecture"
  },
  {
    zodiac_sign: "Scorpio",
    message: "Deep dive into complex algorithms today. Your intensity uncovers solutions 🕵️",
    lucky_tech: "Python",
    coding_tip: "Trust your investigative instincts"
  },
  {
    zodiac_sign: "Sagittarius",
    message: "Explore new technologies today. Your adventurous spirit leads to breakthroughs 🏹",
    lucky_tech: "Vue.js",
    coding_tip: "Don't fear trying new frameworks"
  },
  {
    zodiac_sign: "Capricorn",
    message: "Disciplined coding approach yields great results. Structure your day well 🏔️",
    lucky_tech: "Java",
    coding_tip: "Plan before you code"
  },
  {
    zodiac_sign: "Aquarius",
    message: "Revolutionary ideas flow today. Your unique approach solves old problems 💡",
    lucky_tech: "Node.js",
    coding_tip: "Think outside conventional patterns"
  },
  {
    zodiac_sign: "Pisces",
    message: "Intuitive coding session ahead. Let creativity guide your solutions 🐠",
    lucky_tech: "Flutter",
    coding_tip: "Trust your creative instincts"
  }
]);

// 🔥 Code Roasting - Challenge templates  
db.code_challenges.insertMany([
  {
    title: "FizzBuzz Classic",
    description: "Write a program that prints numbers 1-100, but 'Fizz' for multiples of 3, 'Buzz' for multiples of 5, and 'FizzBuzz' for both.",
    difficulty: 1,
    category: "algorithms",
    languages: ["javascript", "python", "csharp", "java"]
  },
  {
    title: "Palindrome Checker", 
    description: "Create a function that checks if a string reads the same forwards and backwards.",
    difficulty: 2,
    category: "string-manipulation",
    languages: ["javascript", "python", "csharp"]
  },
  {
    title: "Two Sum Problem",
    description: "Find two numbers in an array that add up to a target sum.",
    difficulty: 2,
    category: "arrays",
    languages: ["javascript", "python", "csharp", "java"]
  }
]);

// Create indexes for better performance
db.code_snippets.createIndex({ "language": 1, "difficulty": 1, "tech_stacks": 1 });
db.dating_profiles.createIndex({ "tech_stack": 1, "experience_level": 1, "zodiac_sign": 1 });
db.meeting_excuses.createIndex({ "category": 1, "believability": -1 });
db.horoscopes.createIndex({ "zodiac_sign": 1 });
db.code_challenges.createIndex({ "difficulty": 1, "category": 1, "languages": 1 });

print("✅ MongoDB collections initialized successfully!");
print("📊 Collections created:");
print("  • code_snippets: " + db.code_snippets.countDocuments() + " documents");
print("  • dating_profiles: " + db.dating_profiles.countDocuments() + " documents");  
print("  • meeting_excuses: " + db.meeting_excuses.countDocuments() + " documents");
print("  • horoscopes: " + db.horoscopes.countDocuments() + " documents");
print("  • code_challenges: " + db.code_challenges.countDocuments() + " documents");