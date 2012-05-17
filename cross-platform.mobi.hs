{-# LANGUAGE OverloadedStrings #-}

import Prelude hiding (id)
import Control.Category (id)
import Control.Arrow (arr, (>>>), (>>^), (***))
import Data.Monoid (mempty, mconcat)
import Text.Pandoc

import Data.List (sortBy, sort)
import Data.Ord (comparing)
import System.FilePath (takeBaseName)

import Hakyll

main :: IO ()
main = hakyll $ do

    -- Copy scripts
    match "scripts/*" $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy images
    match "images/**" $ do
        route   idRoute
        compile copyFileCompiler

    -- Compress CSS
    match "css/**" $ do
        route   idRoute
        compile compressCssCompiler

    -- Render documents
    match "documents/**" $ do
        route   $ setExtension ".html"
        compile $ pageCompilerWith defaultHakyllParserState myPandocOptions
            >>> applyTemplateCompiler "templates/chapter.html"
            >>> applyTemplateCompiler "templates/default.html"            
            >>> relativizeUrlsCompiler
	
    -- Render posts list
    match  "index.html" $ route idRoute
    create "index.html" $ constA mempty
        >>> arr (setField "title" "Table of Contents")
        >>> tocCompiler "documents/**"
        >>> applyTemplateCompiler "templates/index.html"
        >>> applyTemplateCompiler "templates/default.html"        
        >>> relativizeUrlsCompiler

    -- Categories
    match  "categories.html" $ route idRoute
    create "categories.html" $ constA mempty
        >>> arr (setField "title" "Table of Contents")
        >>> categoriesCompiler "documents/**"
        >>> applyTemplateCompiler "templates/index.html"
        >>> applyTemplateCompiler "templates/default.html"        
        >>> relativizeUrlsCompiler

    -- Read templates
    match "templates/*" $ compile templateCompiler

tocCompiler documents = setFieldPageList (byCategory) "templates/tocitem.html" "tocitems" documents

categoriesCompiler documents = 
	setFieldPageList (chronological) "templates/categoryitem.html" "tocitems" documents
	
-- | Auxiliary compiler: generate a post list from a list of given posts, and
-- add it to the current page under @$posts@
--
addPostList :: Compiler (Page String, [Page String]) (Page String)
addPostList = setFieldA "tocitems" $
    arr (reverse . recentFirst)
        >>> require "templates/tocitem.html" (\p t -> map (applyTemplate t) p)
        >>> arr mconcat
        >>> arr pageBody
        

-- Options
myPandocOptions :: WriterOptions
myPandocOptions = defaultHakyllWriterOptions{ writerSectionDivs = True,
                                writerStandalone = True,
                                writerTableOfContents = True,
                                writerHighlight = True,
                                writerHtml5 = False,
                                writerTemplate = "<div class=\"sidebar\">\n$toc$\n</div>\n<div class=\"content body\">\n$body$\n</div>"}


byCategory :: [Page a] -> [Page a]
-- byCategory = sortBy $ comparing $ takeBaseName . getField "category"
byCategory = sortBy $ comparing $ takeBaseName . getField "category"