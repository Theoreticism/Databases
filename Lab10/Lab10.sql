DROP FUNCTION PreReqsFor(integer);
CREATE FUNCTION PreReqsFor(integer) RETURNS text as $$
	SELECT name
	FROM courses c
	WHERE c.num in (
		SELECT prereqnum
		FROM prerequisites p
		WHERE p.courseNum = $1
		)
$$ LANGUAGE SQL;

DROP FUNCTION IsPreReqFor(integer);
CREATE FUNCTION IsPreReqFor(integer) RETURNS text as $$
	SELECT name
	FROM courses c
	WHERE c.num in (
		SELECT coursenum
		FROM prerequisites p
		WHERE p.prereqnum = $1
		)
$$ LANGUAGE SQL;

SELECT * FROM courses
SELECT * FROM prerequisites
SELECT IsPreReqFor(221)
SELECT PreReqsFor(308)