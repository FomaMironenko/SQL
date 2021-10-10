SELECT color, count(*) AS Nfigures 
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
GROUP BY color