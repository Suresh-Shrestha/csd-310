"""
Name: Suresh Shrestha
Date: 2/13/2026
Module 6.2 Assignment: Movies - Table Queries
"""

import mysql.connector
from mysql.connector import Error


def main():
    try:
        # Connect using the credentials from db_init_2022.sql
        db = mysql.connector.connect(
            host="localhost",
            user="movies_user",
            password="popcorn",
            database="movies"
        )

        cursor = db.cursor()

       
        # DISPLAYING Studio RECORDS
     
        print("-- DISPLAYING Studio RECORDS --")
        cursor.execute("SELECT studio_id, studio_name FROM studio;")
        studios = cursor.fetchall()

        for studio in studios:
            print(f"Studio ID: {studio[0]}")
            print(f"Studio Name: {studio[1]}")
            print()

      
        # DISPLAYING Genre RECORDS
      
        print("-- DISPLAYING Genre RECORDS --")
        cursor.execute("SELECT genre_id, genre_name FROM genre;")
        genres = cursor.fetchall()

        for genre in genres:
            print(f"Genre ID: {genre[0]}")
            print(f"Genre Name: {genre[1]}")
            print()

       
        # DISPLAYING Short Film RECORDS
      
        print("-- DISPLAYING Short Film RECORDS --")
        cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 120;")
        short_films = cursor.fetchall()

        for film in short_films:
            print(f"Film Name: {film[0]}")
            print(f"Runtime: {film[1]}")
            print()

       
        # DISPLAYING Director RECORDS in Order
     
        print("-- DISPLAYING Director RECORDS in Order --")
        cursor.execute("""
            SELECT film_name, film_director
            FROM film
            ORDER BY film_director;
        """)
        directors = cursor.fetchall()

        for film in directors:
            print(f"Film Name: {film[0]}")
            print(f"Director: {film[1]}")
            print()

    except Error as e:
        print("Error:", e)

    finally:
        if db.is_connected():
            cursor.close()
            db.close()


if __name__ == "__main__":
    main()
