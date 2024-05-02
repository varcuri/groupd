import csv
from itertools import count

"""
The SQL files must be created in the working directory before running this script.
The following files should exist in the directory:
    imdb_top_1000.csv
    movies.sql
    items.sql 
    appearances.sql
    actors.sql
"""
def clear_all_files():
    for file_name in "actors appearances items movies".split():
        with open(f"{file_name}.sql", "w") as f:
            f.write("")

clear_all_files()


itr = count(start=1, step=1)

# Name: Actor ID
actor_dict = {}
# Actor ID: list(Movie ID)
appearance = {}

def add_actor(name, mve_id, actor_dict=actor_dict, appearance=appearance, itr=itr):
    """This function adds the actor to the dictionary if they are not in there.
    Then adds their appearance to appearance dictionary.
    """
    if actor_dict.get(name) is None:
        actor_dict[name] = next(itr)
        actor_id = actor_dict.get(name)
        appearance[actor_id] = []
    actor_id = actor_dict.get(name)
    appearance[actor_id].append(mve_id)


def write_movies(mve_id, genre, release):
    """Appends to movies.sql file must delete entries in this file before running."""
    with open("movies.sql", "a") as f:
        string = f"INSERT INTO movies (mve_id, genre, release_dt)\n"
        string += f"\tVALUES ({mve_id}, '{genre}', '{release}');\n"
        f.write(string)

def write_items(mve_id):
    """
    Appends to movies.sql file must delete entries in this file before running.
    This creates a DVD and VHS copy for each movie
    """
    for format in ["VHS", "DVD"]:
        with open("items.sql", "a") as f:
            string = f"INSERT INTO items (type_format, mve_id)\n"
            string += f"\tVALUES ('{format}', {mve_id});\n"
            f.write(string)


def write_actors(actor_dict = actor_dict):
    """Writes all actors in actors dictionary to actors.sql"""
    for name, id in actor_dict.items():
        with open("actors.sql", "a") as f:
            name_list = name.split()
            f_name, l_name = name_list[0], name_list[-1]
            string = f"INSERT INTO actors (atr_id, last_name, first_name)\n"
            string += f"\tVALUES ({id}, '{l_name}', '{f_name}');\n"
            f.write(string)

def write_appearances(appearance=appearance):
    """Writes all appearances to appearances.sql"""
    for id, movie_list in appearance.items():
        for movie in movie_list:
            with open("appearances.sql", "a") as f:
                string = f"INSERT INTO appearances (mve_id, atr_id)\n"
                string += f"\tVALUES ({movie}, {id});\n"
                f.write(string)



# Read through CSV file, add actors to dictionary, and write movies
# to items.sql and movies.sql
file = open("imdb_top_1000.csv", "r")
reader = csv.reader(file, delimiter=",")
count_rows = 0
for row in reader:
    # Skip First row
    if count_rows == 0:
        count_rows +=1
        continue
    # Set ID to the row
    mve_id = count_rows
    # Get data from CSV file
    title = row[1]
    year = row[2]
    genre = row[5].split(",")[0]
    star1 = row[10]
    star2 = row[11]
    # Add actors to dictionaries
    add_actor(star1, count_rows)
    add_actor(star2, count_rows)
    # Write to SQL files
    write_movies(mve_id, genre, year)
    write_items(mve_id)
    count_rows += 1
    # Do First 25 items
    if count_rows > 26:
        break
file.close()

# Write Actors and Appearances

write_actors()
write_appearances()
