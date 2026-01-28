import sqlite3

# Connect to the database
conn = sqlite3.connect('footnote.db')
cursor = conn.cursor()

# Get all tables
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
print("Tables:", cursor.fetchall())

# Count papers
cursor.execute("SELECT count(*) FROM papers")
print(f"Total Papers: {cursor.fetchone()[0]}")

# Show first 5 titles if any
query = "SELECT title, published_date FROM papers ORDER BY published_date DESC LIMIT 5"
try:
    cursor.execute(query)
    print("\nRecent Papers:")
    rows = cursor.fetchall()
    if not rows:
        print("No papers found.")
    for row in rows:
        print(f"- {row[0]} ({row[1]})")
except Exception as e:
    print(e)

conn.close()
