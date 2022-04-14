{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Lens
import Data.Maybe
import Data.Text (Text)
import Monomer
import qualified Monomer.Lens as L
import TextShow

type AppModel = ()

data AppEvent = AENoOp | AEEnter | AEButton
  deriving (Eq, Show)

buildUI ::
  WidgetEnv AppModel AppEvent ->
  AppModel ->
  WidgetNode AppModel AppEvent
buildUI wenv model = widgetTree
  where
    widgetTree = keystroke [("Enter", AEEnter)] $ button "Press me" AEButton

handleEvent ::
  WidgetEnv AppModel AppEvent ->
  WidgetNode AppModel AppEvent ->
  AppModel ->
  AppEvent ->
  [AppEventResponse AppModel AppEvent]
handleEvent wenv node model evt = case evt of
  AENoOp -> []
  AEEnter ->
    [ Task $ do
        putStrLn "Enter pressed"
        pure AENoOp
    ]
  AEButton ->
    [ Task $ do
        putStrLn "Button pressed"
        pure AENoOp
    ]

main :: IO ()
main = do
  startApp model handleEvent buildUI config
  where
    config =
      [ appWindowTitle "Hello world",
        appWindowIcon "./assets/images/icon.bmp",
        appTheme darkTheme,
        appFontDef "Regular" "./assets/fonts/Roboto-Regular.ttf"
      ]
    model = ()
