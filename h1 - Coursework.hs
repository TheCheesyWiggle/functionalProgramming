import Data.List

main :: IO ()

main = 
    --print (x_generator1)
    --print (x_tester1)
    --print(avg 8 6)
    --print(tester1 (16,59,27,4))
    --print (filter tester1 generator1)
    print(testerValid(16,59,27,4))
    
x_generator1 :: Int
x_generator1 =
    length [ t | t <- ts , t `elem` g ]
    where
        g = generator1
        ts =
            [ ( 2 ,15 ,14 ,11)
            , ( 4 ,31 ,27 , 9)
            , ( 6 ,47 ,10 , 8)
            , ( 9 , 3 ,23 , 6)
            , (11 ,19 , 6 , 5)
            , (13 ,35 ,19 , 3)
            , (15 ,51 , 2 , 2)
            , (18 , 6 ,16 ,12)
            , (20 ,22 ,29 ,10)
            , (22 ,38 ,11 , 9)
            ]
            
x_tester1 :: Int
x_tester1 =
    length [ t | t <- ts , tester1 t ]
    where
        ts =
            [ ( 6 ,59 ,17 ,24)
            , ( 6 ,59 ,17 ,34)
            , ( 6 ,59 ,27 ,14)
            , ( 6 ,59 ,27 ,41)
            , ( 8 ,59 ,12 ,46)
            , (16 ,59 , 7 ,24)
            , (16 ,59 , 7 ,42)
            , (16 ,59 , 7 ,43)
            , (16 ,59 ,27 ,40)
            , (18 ,59 , 2 ,46)
            ]

    
generator1::[(Int,Int,Int,Int)]
generator1 
    = [(hr,mn,dy,mt)
    | hr <- [0..23]
    , mn <- [0..59]
    , dy <- [1..31]
    , mt <- [1..12]
    ]
-- not sure    
tester1 :: (Int, Int, Int, Int) -> Bool
tester1 (hr, mn, dy, mt)
    =  isMagic (hr, mn, dy, mt)
    && isMagic(validDate(hr, mn, dy+1, mt))
    && round(avg (noLitSegs(hr, mn, dy, mt)) (noLitSegs(validDate(hr, mn, dy+1, mt)))) == noLitSegs ( validDate(hr, mn+1, dy+1, mt))

-- works
isMagic:: (Int,Int,Int,Int) -> Bool   
isMagic (hr, mn, dy, mt)
    =  isPrime(noLitSegs (hr, mn, dy, mt)) && noDups [hr `mod` 10, hr `div` 10, mn `mod` 10, mn `div` 10, dy `mod` 10, dy `div` 10, mt `mod` 10, mt `div` 10]
-- works 
noDups :: Eq a => [a] -> Bool
noDups s 
    = s == nub s

-- works   
noLitSegs::(Int,Int,Int,Int) -> Int
noLitSegs (hr, mn, dy, mt)
    = segConverter (hr `mod` 10) + segConverter (hr `div` 10) + segConverter (mn `mod` 10) + segConverter (mn `div` 10) + segConverter (dy `mod` 10) + segConverter (dy `div` 10) + segConverter (mt `mod` 10) + segConverter (mt `div` 10)
-- works
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
--works
isPrime:: Int -> Bool
isPrime
    = not . factorisable 2
-- works
factorisable :: Int -> Int -> Bool
factorisable f n
    | f*f <= n=n `mod` f==0 || factorisable (f+1)n
    | otherwise = False
--works    
avg:: Int -> Int -> Double
avg x y = fromIntegral(x + y) / 2.0

--works
validHour:: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
validHour (hr, mn, dy, mt)
    | hr < 24 = (hr, mn, dy, mt)
    | otherwise = (hr `mod` 24, mn, dy+1, mt)

--works
validMin:: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
validMin (hr, mn, dy, mt)
    | mn < 60 = (hr, mn, dy, mt)
    | otherwise = (hr+1, mn `mod` 60, dy, mt)
    
--works
validDay:: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
validDay (hr, mn, dy, mt)
    | dy < 32 = (hr, mn, dy, mt)
    | otherwise = (hr, mn, dy `mod` 31, mt+1)

--works
validMonth:: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
validMonth (hr, mn, dy, mt)
    | mt < 13 = (hr, mn, dy, mt)
    | otherwise = (hr, mn, dy, mt `mod` 12)

--works
validDate:: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
validDate (hr, mn, dy, mt)
    = validMonth(validDay(validHour(validMin(hr, mn, dy, mt))))


    
testerValid :: (Int, Int, Int, Int) ->  Int
testerValid (hr, mn, dy, mt)
    = round (avg (noLitSegs(hr, mn, dy, mt)) (noLitSegs(validDate(hr, mn, dy+1, mt))))
    
