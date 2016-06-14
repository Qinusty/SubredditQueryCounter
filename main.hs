{-# LANGUAGE OverloadedStrings #-}
module Main where

	import Network.HTTP.Dispatch.Core
	import qualified Data.Text.Lazy as LT
	import Data.Text.Lazy.Encoding
	import GHC.Int

	subreddits = ["worldpolitics", "worldnews", "politics"]
	queries = ["sanders", "clinton", "trump"]

	main = 
		do
			ioXML <- mapM getRSS subreddits
			let results = [(q, sum $ map (countOccurances q) ioXML) | q <- queries]
			print results

	-- prettify [] = []
	-- prettify results = (show $ fst $ head results) ++ ": " ++ (show $ snd $ head results) ++ "\n" ++ prettify $ tail results 

	getRSS :: String -> IO HTTPResponse
	getRSS subreddit = runRequest $ get ("http://www.reddit.com/r/" ++ subreddit ++ ".rss")

	countOccurances :: String -> HTTPResponse -> Int64
	countOccurances string xml = LT.count (LT.pack string) textXML
		where 
			response = respBody xml
			textXML = LT.toLower $ decodeUtf8 response
