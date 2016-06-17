{-# LANGUAGE OverloadedStrings #-}
module Main where

    import Network.HTTP.Dispatch.Core
    import qualified Data.Text.Lazy as LT
    import Data.Text.Lazy.Encoding
    import GHC.Int
    import Data.List (sortBy)

    subreddits = ["worldpolitics", "worldnews", "politics"]
    queries = ["Sanders", "Clinton", "Trump"]

    type Result = (String, Int64)

    main = 
        do
            ioXML <- mapM getRSS subreddits
            let results = [(q, sum $ map (countOccurances q) ioXML) | q <- queries]
            putStrLn $ prettify results

    prettify :: [Result] -> String
    prettify results = stringify $ sortBy order results
            where
                stringify :: [Result] -> String
                stringify [] = []
                stringify ts = ((fst $ head ts) ++ ": " ++ (show $ snd $ head ts)) ++
                               '\n' : (stringify $ tail ts)
                order = (\(_,a) (_,b) -> if a < b then GT else LT)

    getRSS :: String -> IO HTTPResponse
    getRSS subreddit = runRequest $ get ("http://www.reddit.com/r/" ++ subreddit ++ ".rss")

    countOccurances :: String -> HTTPResponse -> Int64
    countOccurances string xml = LT.count (LT.toLower $ LT.pack string) textXML
        where 
            response = respBody xml
            textXML = LT.toLower $ decodeUtf8 response
