module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import DOM (DOM)
import Nozzle.Signal (pumpFuel)
import Signal (Signal, runSignal, merge, sampleOn, filter, (~>))

main :: forall eff. Eff (dom :: DOM | eff) Unit
main = do
  signalFuel1 <- pumpFuel "nozzle1" "price1" 1.23
  signalFuel2 <- pumpFuel "nozzle2" "price2" 1.37
  signalFuel3 <- pumpFuel "nozzle3" "price3" 1.65
  runSignal $ signalFuel1 `merge` signalFuel2 `merge` signalFuel3
