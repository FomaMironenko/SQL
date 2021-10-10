SELECT chessman.type, count(*) as Nfigures
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
GROUP BY chessman.type
HAVING count(*) >= 2