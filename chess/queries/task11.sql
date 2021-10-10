WITH rook_clns AS (
	SELECT cln FROM chessboard JOIN chessman
	ON chessboard.id = chessman.id
	WHERE chessman.type = 'Rook'
), 
rook_rows AS (
	SELECT row FROM chessboard JOIN chessman
	ON chessboard.id = chessman.id
	WHERE chessman.type = 'Rook'
)

SELECT chessman.id
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
WHERE (
	cln IN (SELECT * FROM rook_clns)
	OR
	row IN (SELECT * FROM rook_rows)
) AND 
	type <> 'Rook'
