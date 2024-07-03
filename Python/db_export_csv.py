import sqlite3
import pandas as pd
import os

# Function to export all tables to CSV
def export_tables_to_csv(db_path, output_dir):
    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    # Connect to the SQLite database
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Query to get all table names
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()

    for table in tables:
        table_name = table[0]
        # Query to select all data from the table
        df = pd.read_sql_query(f"SELECT * FROM {table_name};", conn)
        # Export to CSV
        csv_file_path = os.path.join(output_dir, f"{table_name}.csv")
        df.to_csv(csv_file_path, index=False)
        print(f"Exported {table_name} to {csv_file_path}")

    conn.close()

# Path to the database
db_path = 'company.db'

# Directory to save CSV files
output_dir = 'csv_exports'

# Export tables to CSV
export_tables_to_csv(db_path, output_dir)
