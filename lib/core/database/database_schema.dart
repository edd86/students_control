List<String> dataSchema = [
  '''
  CREATE TABLE teachers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    teacher_identifier TEXT,
    profile_photo TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  );
  ''',
  '''
  CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    identification_number TEXT UNIQUE,
    email TEXT,
    phone TEXT,
    grade_level TEXT,
    notes TEXT,
    profile_photo TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  );
  ''',
  '''
  CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    teacher_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    code TEXT,
    icon TEXT,
    color TEXT,
    description TEXT,
    group TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE schedules (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    day_of_week INTEGER NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT NOT NULL,
    classroom TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE enrollments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    schedule_id INTEGER NOT NULL,
    enrolled_at TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES schedules(id) ON DELETE CASCADE,
    UNIQUE(course_id, student_id)
  );
  ''',
  '''
  CREATE TABLE assessments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    percent REAL DEFAULT 0.0,
    due_date TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE grades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    assessment_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    score REAL NOT NULL,
    feedback TEXT,
    FOREIGN KEY (assessment_id) REFERENCES assessments(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
  );
  ''',
  '''
  CREATE TABLE attendance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    date DATE NOT NULL,
    status TEXT NOT NULL CHECK(status IN ('Present', 'Absent', 'Excused', 'Late')),
    note TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
  );
  ''',
];
