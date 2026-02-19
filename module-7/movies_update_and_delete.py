# Suresh Shrestha
# Module 7.2 Assignment

import mysql.connector
from mysql.connector import errorcode


def show_films(cursor, title):
    cursor.execute("""
        SELECT film_name, film_director, genre_name, studio_name
        FROM film
        INNER JOIN genre ON film.genre_id = genre.genre_id
        INNER JOIN studio ON film.studio_id = studio.studio_id
        ORDER BY film_id;
    """)

    films = cursor.fetchall()

    print("\n  -- {} --".format(title))

    for film in films:
        print("Film Name: {}".format(film[0]))
        print("Director: {}".format(film[1]))
        print("Genre Name ID: {}".format(film[2]))
        print("Studio Name: {}\n".format(film[3]))


def main():

    config = {
        "user": "movies_user",      
        "password": "popcorn",      
        "host": "127.0.0.1",
        "database": "movies",
        "raise_on_warnings": True
    }

    try:
        db = mysql.connector.connect(**config)
        cursor = db.cursor()

        #  DISPLAY FILMS
        show_films(cursor, "DISPLAYING FILMS")

        #  INSERT (NOT Star Wars)
        cursor.execute("""
            INSERT INTO film 
            (film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id)
            VALUES 
            ('The Matrix', '1999', 136, 'The Wachowskis', 2, 1);
        """)
        db.commit()

        show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

        #  UPDATE Alien to Horror
        cursor.execute("""
            UPDATE film
            SET genre_id = (
                SELECT genre_id FROM genre WHERE genre_name = 'Horror'
            )
            WHERE film_name = 'Alien';
        """)
        db.commit()

        show_films(cursor, "DISPLAYING FILMS AFTER UPDATE")

        #  DELETE Gladiator
        cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator';")
        db.commit()

        show_films(cursor, "DISPLAYING FILMS AFTER DELETE")

        cursor.close()
        db.close()

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("ERROR: Username or password incorrect.")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("ERROR: Database does not exist.")
        else:
            print(err)


if __name__ == "__main__":
    main()
