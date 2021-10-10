WITH black_king AS (
	SELECT row, cln, chessman.id
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'Black' AND chessman.type = 'King' 
)

SELECT chessman.id
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
WHERE 
ABS(row - (SELECT row FROM black_king)) <= 2 
  AND
ABS(ASCII(cln) - (SELECT ASCII(cln) FROM black_king)) <= 2 
  AND
chessman.id <> (SELECT id FROM black_king)