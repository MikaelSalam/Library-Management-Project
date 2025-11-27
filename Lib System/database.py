import psycopg2

def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="Lib",
        user="postgres",
        password="1991"
    )
if __name__ == "__main__":
    try:
        conn = get_connection()
        print("Database connected successfully!")
        conn.close()
    except Exception as e:
        print("Error:", e)