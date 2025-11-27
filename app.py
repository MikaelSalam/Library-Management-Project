from flask import Flask, render_template, request, redirect
from database import get_connection

app = Flask(__name__)

# ---------------- HOME ----------------
@app.route("/")
def home():
    return render_template("index.html")


# ---------------- BOOKS ----------------
@app.route("/books")
def books():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT books.bookid, books.book_title, books.isbn, books.published_year,
               categories.category_name
        FROM books
        LEFT JOIN categories ON books.categoryid = categories.categoryid
        ORDER BY books.bookid;
    """)

    books_data = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("books.html", books=books_data)


# ---------------- MEMBERS ----------------
@app.route("/members")
def members():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT memberid, member_name, email, contact_number, membership_date
        FROM members
        ORDER BY memberid;
    """)

    members_data = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("members.html", members=members_data)


# ---------------- BORROWINGS LIST ----------------
@app.route("/borrowings")
def borrowings():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT 
            borrowings.borrowid,
            members.member_name,
            books.book_title,
            borrowings.borrow_date,
            borrowings.due_date,
            borrowings.return_date,
            borrowings.status
        FROM borrowings
        LEFT JOIN members ON borrowings.memberid = members.memberid
        LEFT JOIN books ON borrowings.bookid = books.bookid
        ORDER BY borrowings.borrowid;
    """)

    borrowings_data = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("borrowings.html", borrowings=borrowings_data)


# ---------------- SHOW BORROW FORM ----------------
@app.route("/borrowings/new")
def new_borrowing():
    conn = get_connection()
    cur = conn.cursor()

    # Get members
    cur.execute("SELECT memberid, member_name FROM members ORDER BY member_name;")
    members = cur.fetchall()

    # Get books with available copies
    cur.execute("SELECT bookid, book_title FROM books WHERE copies_available > 0 ORDER BY book_title;")
    books = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("borrow_form.html", members=members, books=books)


# ---------------- PROCESS BORROW FORM ----------------
@app.route("/borrowings/create", methods=["POST"])
def create_borrowing():
    member_id = request.form["member_id"]
    book_id = request.form["book_id"]
    borrow_date = request.form["borrow_date"]
    due_date = request.form["due_date"]

    conn = get_connection()
    cur = conn.cursor()

    # Insert borrowing record
    cur.execute("""
        INSERT INTO borrowings (memberid, bookid, borrow_date, due_date, status)
        VALUES (%s, %s, %s, %s, %s)
    """, (member_id, book_id, borrow_date, due_date, "Borrowed"))

    # Reduce available copies
    cur.execute("""
        UPDATE books
        SET copies_available = copies_available - 1
        WHERE bookid = %s
    """, (book_id,))

    conn.commit()
    cur.close()
    conn.close()

    return redirect("/borrowings")

@app.route("/borrowings/return/<int:borrowid>", methods=["POST"])
def return_book(borrowid):
    conn = get_connection()
    cur = conn.cursor()

    # Get the bookid for this borrowing
    cur.execute("SELECT bookid FROM borrowings WHERE borrowid = %s", (borrowid,))
    book_id = cur.fetchone()[0]

    # Update borrowing record
    cur.execute("""
        UPDATE borrowings
        SET return_date = CURRENT_DATE,
            status = 'Returned'
        WHERE borrowid = %s
    """, (borrowid,))

    # Increase available copies
    cur.execute("""
        UPDATE books
        SET copies_available = copies_available + 1
        WHERE bookid = %s
    """, (book_id,))

    conn.commit()
    cur.close()
    conn.close()

    return redirect("/borrowings")
@app.route("/reports/overdue")
def overdue_books():
    conn = get_connection()
    cur = conn.cursor()

    # Select overdue borrowings: due_date < today AND return_date IS NULL
    cur.execute("""
        SELECT 
            b.borrowid,
            m.member_name,
            bk.book_title,
            b.borrow_date,
            b.due_date
        FROM borrowings b
        JOIN members m ON b.memberid = m.memberid
        JOIN books bk ON b.bookid = bk.bookid
        WHERE b.return_date IS NULL
        AND b.due_date < CURRENT_DATE
        ORDER BY b.due_date ASC;
    """)

    overdue_list = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("overdue.html", overdue=overdue_list)

@app.route("/members/new")
def new_member():
    return render_template("add_member.html")

@app.route("/members/create", methods=["POST"])
def create_member():
    name = request.form["member_name"]
    email = request.form["email"]
    contact_number = request.form["contact_number"]

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO members (member_name, email, contact_number)
        VALUES (%s, %s, %s)
    """, (name, email, contact_number))

    conn.commit()
    cur.close()
    conn.close()

    return redirect("/members")

@app.route("/books/new")
def new_book():
    conn = get_connection()
    cur = conn.cursor()

    # Get categories
    cur.execute("SELECT categoryid, category_name FROM categories ORDER BY category_name;")
    categories = cur.fetchall()

    # Get authors
    cur.execute("SELECT authorid, author_name FROM authors ORDER BY author_name;")
    authors = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("add_book.html", categories=categories, authors=authors)

@app.route("/books/create", methods=["POST"])
def create_book():
    title = request.form["book_title"]
    isbn = request.form["isbn"]
    year = request.form["published_year"]
    copies = request.form["copies_available"]
    categoryid = request.form["categoryid"]
    authorid = request.form["authorid"]

    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO books (book_title, isbn, published_year, copies_available, categoryid, authorid)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (title, isbn, year, copies, categoryid, authorid))

    conn.commit()
    cur.close()
    conn.close()

    return redirect("/books")

@app.route('/')
def index():
    conn = get_db_connection()
    librarians = conn.execute("SELECT * FROM librarians").fetchall()
    conn.close()
    return render_template('index.html', librarians=librarians)

# ---------------- RUN APP ----------------
if __name__ == "__main__":
    app.run(debug=True)
