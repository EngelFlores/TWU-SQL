-- 1
SELECT  member.name 
FROM member, checkout_item, book 
WHERE book.title="The Hobbit" 
AND member.id = member_id 
AND book.id=book_id;

-- 2
SELECT count(id) 
FROM member
WHERE member.id
NOT IN ( 
    SELECT checkout_item.member_id 
FROM checkout_item 
WHERE checkout_item.member_id = member.id
);

-- 3
SELECT book.title
FROM book
WHERE book.id
NOT IN( 
    SELECT checkout_item.book_id 
    FROM checkout_item
    WHERE  checkout_item.book_id = book.id);
SELECT movie.title
FROM movie
WHERE movie.id
NOT IN( 
    SELECT checkout_item.movie_id 
    FROM checkout_item
    WHERE  checkout_item.movie_id = movie.id);

INSERT INTO book( title ) VALUES ("The Pragmatic Programmer");
INSERT INTO member( name ) VALUES ("Engel");

INSERT INTO checkout_item( member_id, book_id ) VALUES(
(SELECT member.id FROM member WHERE member.name = "Engel"),
(SELECT book.id FROM book WHERE book.title = "The Pragmatic Programmer"));

-- 4
SELECT  member.name 
FROM member, checkout_item, book 
WHERE book.title="The Pragmatic Programmer" 
AND member.id = member_id 
AND book.id=book_id;

DELETE FROM checkout_item 
WHERE checkout_item.member_id = ( 
    SELECT member.id 
    FROM member 
    WHERE member.name = "Engel"
    );

-- 5
SELECT member.name
FROM checkout_item, member
WHERE member.id = checkout_item.member_id
GROUP BY checkout_item.member_id
HAVING COUNT(*)>1;

-- or

SELECT member.name, COUNT(member.id) as num_of_checked_out
FROM checkout_item, member
WHERE member.id = checkout_item.member_id
GROUP BY checkout_item.member_id
HAVING num_of_checked_out>1;


