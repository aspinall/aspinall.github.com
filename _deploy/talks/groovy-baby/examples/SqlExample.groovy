import groovy.sql.Sql

db = Sql.newInstance("jdbc:hsqldb:mem:groovy")

db.execute """
    create table PERSON (
        FIRST_NAME    varchar(30),
        SURNAME       varchar(30),
        AGE           integer
    )
"""

[
    ['Fred', 'Flintstone', 42],
    ['Barney', 'Rubble', 38],
    ['Pebbles', 'Flinstone', 1],
    ['Bam Bam', 'Rubble', 2]
].each { 
    db.execute """insert into PERSON 
                  values (${it[0]}, ${it[1]}, ${it[2]})""" 
}

results = db.rows "select * from PERSON"

db.execute "drop table PERSON"

results