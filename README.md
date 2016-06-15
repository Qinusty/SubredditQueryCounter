# Subreddit Query Counter

A simple script written in Haskell to count the total number of occurances of one or more queries across multiple subreddit Hot front pages.

For an example I have set it up to count the number of times the surnames of American presidential candidates appear across 3 subreddits.

```
	subreddits = ["worldpolitics", "worldnews", "politics"]
	queries = ["sanders", "clinton", "trump"]
```

All queries are searched from the rss feeds obtained from reddit and are case insensitive.

## How To
Configure the queries and subreddits by editting the main.hs file. Modify the subreddits and queries lists to fit your use purposes.

then run
```
ghc main.hs
./main
```

OR  

run the program through ghci with
```
ghci main.hs
*Main> main
```

## Dependencies
- GHC (Glasgow Haskell Compiler)
- [Dispatch](https://github.com/owainlewis/http-dispatch) - A high level HTTP client for Haskell that focuses on ease of use

## TODO: 
- Add subreddits and queries settings files for easily configurable usage.
- Search rss more effectively narrowing searches to headlines.
- Potential Graphing and data storage settings
