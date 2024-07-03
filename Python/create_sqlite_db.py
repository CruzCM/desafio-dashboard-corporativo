import sqlite3
import os

# Ensure the current directory is writable
db_path = os.path.join(os.getcwd(), 'company.db')

# Function to read SQL file and execute it
def execute_sql_file(cursor, file_path):
    with open(file_path, 'r') as file:
        sql_script = file.read()
    cursor.executescript(sql_script)

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Enable foreign key constraint
cursor.execute('PRAGMA foreign_keys = ON;')

# Execute the schema creation script
execute_sql_file(cursor, 'script_bd_company.sql')

# Execute the data insertion script
execute_sql_file(cursor, 'insercao_de_dados_e_queries_sql.sql')

# Commit the changes and close the connection
conn.commit()
conn.close()

print(f"Database created successfully at {db_path}")
