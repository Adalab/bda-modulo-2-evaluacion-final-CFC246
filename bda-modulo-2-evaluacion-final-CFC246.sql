
/*EJERCICIO FINAL MÓDULO 2 (SQL): bda-modulo-2-evaluacion-final-CFC246 */

/*Para este ejerccio utilizaremos la BBDD Sakila que hemos estado utilizando durante el repaso de SQL. 
Es una base de datos de ejemplo que simula una tienda de alquiler de películas. 
Contiene tablas como film (películas), actor (actores), customer (clientes), rental (alquileres), category (categorías), entre otras. 
Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas 
y análisis de datos en el contexto de una tienda de alquiler de películas.
*/

/* ¡¡¡ EMPEZAMOS 💪 !!! * /

/* 1.Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/

USE sakila; -- Arrancamos la base de datos que vamos a usar para este ejercicio.

SELECT *
FROM film; -- Queremos ver los atributos y registros de datos que contienr la tabla que tenemos que consultar para obtener respuesta a la priemra pregunta. En este caso, usamos FILM


SELECT DISTINCT 
title  -- Usamos "SELECT DISCTINT" para que nos devuelva los valores únicos de peliculas que contiene esta tabla
FROM film;

/*2.Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/

SELECT 
title                  -- Buscamos todos los titulos donde las peliculas sean igual a "PG-13" 
FROM film
WHERE rating = "PG-13";       -- Usamos una query con WHERE para usar el igual


/*3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción*/

SELECT *
FROM film;

SELECT title, 
description          
FROM film
WHERE description LIKE 'amazing';  -- La sintaxis de esta busqueda es ésta, pero no devulve resultado, aunque suponemos que lo hay. Así que hay algo incorrecto en ella. 

SELECT 
title, 
description          
FROM film
WHERE description LIKE '%amazing%'; -- Para obtener resultado discriminando cualquier tipo de grafia en la palabra amazing usamos % al principio y final de la palabra

/*4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

SELECT *
FROM film;

SELECT 
title           
FROM film
WHERE length <= 120;  -- De la tabla film obetenemos aquellos resultados que sean igual o mayor a 2horas, usando el campo duración.

/*5.Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame nombre_actor y contenga nombre y apellido.*/

SELECT
CONCAT (first_name, " ", last_name) AS actor_name -- Como una formula de excel, en este caso recurrimos a renombrar el resultado como "actor_name"
FROM actor;

/*6.Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/

SELECT 
first_name, 
last_name
FROM actor
WHERE last_name = 'Gibson'; -- Usamos una query con where en los que el apellido debe ser igual a Gibson


/*7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/

SELECT 
actor_id, 
first_name, 
last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20; -- Usamos una query con where en este caso con un itervalo que podemos hacer usando between


/*8.Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".*/

SELECT *
FROM film;

SELECT 
film_id, 
title
FROM film
WHERE rating != 'R' OR  rating != 'PG13'; -- Usamos una query con where de todos aquellos resultados que sean diferentes a R y PG-13


/*9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.*/

SELECT DISTINCT rating -- Primero tenemos que averiguar cuantas clasificaciones distintas tenemos. 
FROM film; -- Con esta consulta, obetenemos que son: PG, G, NC-17, PG-13, R

SELECT COUNT(title)
FROM film
WHERE rating = 'PG'; -- Así podemos obtener el total de títulos de una clasificación

SELECT 
rating, 
COUNT(title) AS total_films_rating
FROM film
GROUP BY rating; -- Así podemos obtener el total de títulos de cada clasificación

/*10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT *
FROM customer;
SELECT *
FROM rental;


SELECT
customer.customer_id, 
CONCAT (customer.first_name, " ", customer.last_name) AS customer, -- Hacemos un concact para obtener el nombre completo
COUNT(rental.rental_id) AS films_rented
FROM rental
INNER JOIN customer                         -- Usamos JOIN para relacionar las tablas
ON customer.customer_id = rental.customer_id 
GROUP BY customer.customer_id, customer              -- Agrupamos por customer_id y por la variable generada
ORDER BY films_rented ASC;                           -- Ordenamos por la cantidad de películas alquiladas en orden ascendente


/*11.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/

SELECT *
FROM rental;
SELECT *
FROM film;
SELECT *
FROM category;

SELECT
category.name AS genre,  -- ponemos un alias a category name con AS
COUNT(rental.rental_id) AS films_rented -- la misma que en el ejercicio anterior
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id   -- tenemos que construir varios inner joins en la base de que sus id en las tablas están relacionadas unas con otras
GROUP BY genre -- agrupamos por genero
ORDER BY films_rented; -- ordenamos por filmes rented 

/*12.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/

SELECT *
FROM film;

SELECT AVG(length) AS film_duration -- media de todas las peliculas
FROM film;

SELECT AVG(length) AS film_duration,  
rating
FROM film
GROUP BY rating;                   -- media de todas las peliculas agrupada por genero

/*13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

SELECT *
FROM film;
SELECT *
FROM actor;
SELECT *
FROM film_actor;


SELECT
actor.first_name, 
actor.last_name 
FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON  actor.actor_id = film_actor.actor_id  -- inner join en las id iguales que encontramos en las tablas
WHERE film.title = 'Indian Love'; -- query con where para una vez unidas buscar la coincidencia

/*14.	Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/

SELECT *
FROM film;
SELECT 
title
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

/*comprobación*/
SELECT 
title,
description -- añadimos 'description' para que nos salga tamnbién y podamos ver las palabras
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';


/*15.	Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/

SELECT *
FROM actor;
SELECT *
FROM film_actor;

SELECT 
first_name, 
last_name 
FROM actor
WHERE actor_id NOT IN (
	SELECT actor_id 
    FROM film_actor); -- lanzamos la query y vemos que no hay coincidencias, por lo que todos están en ambas tablas

SELECT COUNT(*) actor_id 
FROM actor;    -- comprobación de que son 200

SELECT COUNT(DISTINCT actor_id ) 
FROM film_actor;  -- comprobación de que son 200


/*16.Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/

SELECT *
FROM film;

SELECT COUNT(*) film_id 
FROM film;

SELECT 
title,
release_year 
FROM film
WHERE release_year BETWEEN 2004 AND 2011; -- solo obtenemos que el año en el que fueron lanzadas fue el 2006

SELECT DISTINCT release_year -- comprobación porque me parece raro que solo salga 2006
FROM film
WHERE release_year BETWEEN 2004 AND 2011
ORDER BY release_year;

/*17.	Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

SELECT *
FROM film;
SELECT *
FROM category;

SELECT
title,
category.name
FROM film
INNER JOIN film_category ON film_category.film_id = film.film_id 
INNER JOIN category ON film_category.category_id = category.category_id -- unimos las tablas con elementos comunes
WHERE category.name LIKE '%Family%'; -- filtramos con query where y 'like' para obtener todas aquellas peliculas que son de la categoria Family

/*18.	Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/

SELECT *
FROM film;
SELECT *
FROM actor;
SELECT *
FROM film_actor;

SELECT
actor.first_name, 
actor.last_name 
FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id -- unimos las tablas con elementos comunes
GROUP BY actor.actor_id, actor.first_name, actor.last_name -- usamos gruop by en orden de la query correcto para ordenar los datos 
HAVING COUNT(film_actor.film_id) > 10; -- ponemos la condición que que los actores tienen concidencias en más de 10 peliculas, es decir en mas de 10 film_ids

/*19.	Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/

SELECT *
FROM film;

SELECT
title,
length,
rating
FROM film
WHERE film.length >= 120 AND film.rating = 'PG'; 


/*20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos
 y muestra el nombre de la categoría junto con el promedio de duración.*/
 
SELECT *
FROM film;
SELECT *
FROM category; 
 
SELECT
category.name, -- tenemos que localizar los nombre categorias de peliculas
AVG(film.length) AS average_duration -- nombramos la variable de duración con AS
FROM category
INNER JOIN film_category ON film_category.category_id = category.category_id
INNER JOIN film ON film_category.film_id = film.film_id    -- unimos las tablas con elementos comunes
GROUP BY category.name   -- agrupamos por la categoria de peliculas  
HAVING AVG(film.length) > 120; -- que tengan una duracion media que localizamos con AVG mas de 2 horas


/*21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/

SELECT *
FROM film;
SELECT *
FROM actor;
SELECT *
FROM film_actor;


SELECT 
CONCAT(actor.first_name, " ", actor.last_name) AS actor_name, -- usamos concat para unir los nombres
COUNT(film_actor.film_id) AS film_number                     -- nombramos la variable del numero de peliculas de los actores con AS
FROM actor 
JOIN film_actor ON film_actor.actor_id = actor.actor_id            -- unimos las tablas con elementos comunes
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) >= 5   -- Usando la condición de los actores que tienen 5 films id
ORDER BY film_number ASC;           -- usamos el orden correcto de las queries dejando order by para la última posición


/*22.	Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. 
Pista: Usamos DATEDIFF para calcular la diferencia entre una fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)*/

SELECT *
FROM film;
SELECT *
FROM inventory;
SELECT *
FROM rental;

SELECT 
DISTINCT film.title  -- bucamos con distint aquellos unicos 
FROM film 
INNER JOIN inventory  ON film.film_id = inventory.film_id
INNER JOIN rental  ON inventory.inventory_id = rental.inventory_id -- unimos las tablas con elemento común para poder realizar la consulta 
WHERE rental.rental_id IN (                         -- como nos pide el enunciado usamos una subconsulta para filtrar los datos una vez tenemos la condición join
    SELECT rental_id
    FROM rental
    WHERE DATEDIFF(return_date, rental_date) > 5  -- Usamos datediff para poder calcular la diferencia en las fechas que se han alquilado más de 5 veces 
);


/*23.	Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/

SELECT *
FROM film;
SELECT *
FROM inventory;
SELECT *
FROM rental;


SELECT 
actor.first_name, 
actor.last_name 
FROM actor 
WHERE actor.actor_id NOT IN (  -- Lanzamos subconsulta para obtener los los actor id relacionados
    SELECT film_actor.actor_id
    FROM film_actor 
    INNER JOIN film_category  ON film_actor.actor_id = film_category.film_id
    INNER JOIN category  ON film_category.category_id = category.category_id  -- unimos las tablas con paramentros comunes 
    WHERE category.name = 'Horror'    -- Filtramos las de categoria de Horror
);


/* ______BONUS____________________________________  */

/*24.	BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film con subconsultas.*/

/*25.	BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. 
La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. 
Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un alias diferente.*/




