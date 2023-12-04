import Data.List

main :: IO ()

main = 
    print (x_tester2)
    --print (filter tester1 generator1)
    --print(tester ( " 123 " ," 21 " ," 123 " ," 12 " ," 123 " ))

    
generator2:: [(String, String, String, String, String)]
generator2 = [(n1, n2, n3, n4, n5)
    -- Generates numbers
    | n1 <- map show[123..987], special n1
    , n2 <- take 2 (permutations n1)
    , n3 <- permutations n1
    , n4 <- permutations n2
    , n5 <- permutations n3
    , nodups [n1, n2, n3, n4, n5]
    , first(n1,n2)
    ]
    
tester2:: (String, String, String, String, String) -> Bool
tester2 (n1, n2, n3, n4, n5) =
    (i1 - i2) == i3
    && (i3 - i4) == i5
    && (i1 + i3 + i5) < 2000
    where
        i1 = read n1
        i2 = read n2
        i3 = read n3
        i4 = read n4
        i5 = read n5


first:: (String, String) -> Bool
first (n1,n2) =
    head n1 /= head n2
    
-- checks that the number doesnt have recurring digits
special:: String -> Bool
special s = not ('0' `elem` s) && nodups s

nodups :: Eq a => [ a ] -> Bool
nodups s =
    s == nub s
    
x_generator2 :: Int
x_generator2 =
    length [ t | t <- ts , t `elem` g ]
    where
        g = generator2
        ts =
            [ ( "123" ,"21" ,"123" ,"12" ,"123" )
            , ( "162" ,"26" ,"261" ,"12" ,"621" )
            , ( "219" ,"19" ,"912" ,"21" ,"291" )
            , ( "329" ,"92" ,"932" ,"32" ,"239" )
            , ( "439" ,"94" ,"394" ,"43" ,"394" )
            , ( "549" ,"95" ,"945" ,"95" ,"945" )
            , ( "568" ,"68" ,"586" ,"56" ,"586" )
            , ( "769" ,"67" ,"679" ,"97" ,"796" )
            , ( "879" ,"79" ,"897" ,"98" ,"789" )
            , ( "987" ,"79" ,"789" ,"79" ,"789" )
            ]

x_tester2 :: Int
x_tester2 =
    length [ t | t <- ts , tester2 t ]
    where
        ts =
            [ ( "138" ,"01" ,"137" ,"50" ,"87" )
            , ( "143" ,"01" ,"142" ,"52" ,"90" )
            , ( "171" ,"02" ,"169" ,"79" ,"90" )
            , ( "152" ,"03" ,"149" ,"54" ,"95" )
            , ( "159" ,"04" ,"155" ,"61" ,"94" )
            , ( "161" ,"05" ,"156" ,"63" ,"93" )
            , ( "182" ,"06" ,"176" ,"80" ,"96" )
            , ( "151" ,"07" ,"144" ,"57" ,"87" )
            , ( "165" ,"08" ,"157" ,"64" ,"93" )
            , ( "174" ,"09" ,"165" ,"71" ,"94" )
            ]
