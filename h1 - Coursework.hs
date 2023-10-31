import Data.List

main :: IO ()

main =
    print (  filter tester generator  )
    
generator::[(Int,Int,Int,Int)]
generator 
    = [(hr,mn,dy,mt)
    | hr <- [0..23]
    , mn <- [0..59]
    , dy <- [1..31]
    , mt <- [1..12]
    ]
    
tester:: (Int, Int, Int, Int) -> Bool
tester (hr, mn, dy, mt)
    =  isMagic hr mn dy mt
    && isMagic hr mn (dy+1) mt
    && isMagic hr (mn+1) (dy+1) mt 
    && avg (noLitSegs hr mn dy mt) (noLitSegs hr mn (dy+1) mt) == fromIntegral (noLitSegs hr (mn+1) (dy+1) mt )

isMagic:: Int -> Int -> Int -> Int -> Bool   
isMagic hr mn dy mt
    =  isPrime(noLitSegs hr mn dy mt) && noDups [hr `mod` 10, hr `div` 10, mn `mod` 10, mn `div` 10, dy `mod` 10, dy `div` 10, mt `mod` 10, mt `div` 10]
    
noDups :: Eq a => [a] -> Bool
noDups s 
    = s == nub s

    
noLitSegs::Int -> Int -> Int -> Int -> Int
noLitSegs hr mn dy mt
    = segConverter (hr `mod` 10) + segConverter (hr `div` 10) + segConverter (mn `mod` 10) + segConverter (mn `div` 10) + segConverter (dy `mod` 10) + segConverter (dy `div` 10) + segConverter (mt `mod` 10) + segConverter (mt `div` 10)

segConverter:: Int -> Int
segConverter  digit
    | digit == 0 = 6
    | digit == 1 = 2
    | digit == 2 = 5
    | digit == 3 = 5
    | digit == 4 = 4
    | digit == 5 = 5
    | digit == 6 = 6
    | digit == 7 = 4
    | digit == 8 = 7
    | digit == 9 = 6
    | otherwise = 0

isPrime:: Int -> Bool
isPrime
    = not . factorisable 2

factorisable :: Int -> Int -> Bool
factorisable f n
    | f*f <= n=n `mod` f==0 || factorisable (f+1)n
    | otherwise = False
    
avg:: Int -> Int -> Double
avg x y = fromIntegral (x + y) / 2.0
